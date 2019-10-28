library("shiny")
library("shinydashboard")
library("DT")
library("tidyverse")
library("stringr")
library("lubridate")
library("rsconnect")

# Bring in data
proj2 <- read_tsv("data/UMD_Services_Provided_20190719.tsv")
#proj2_meta <- read_tsv("data/UMD_Services_Provided_metadata_20190719.tsv")

# Restrict to analytic fields
proj2 <- proj2 %>%
  select(-starts_with("field")) %>%
  select(-matches("clientfilemerge")) %>%
  select(-one_of("Bus Tickets (Number of)","Notes of Service",
                 "Food Provided for", "Referrals", "Financial Support",
                 "Type of Bill Paid", "Payer of Support"))

# Create date variable
proj2 <- proj2 %>%
  mutate(date_new=mdy(proj2$Date))

# filter dates

filter_date <- function(data, date_range = "2010-01-01 to 2017-12-31") {
  date_range <- as.character(date_range)
  first_date = substr(date_range, 1, 10)
  second_date = substr(date_range, 15, 24)
  
  data = data
  data <- data %>%
    filter(between(date_new, as.Date(first_date), as.Date(second_date))) %>%
    arrange(date_new)
  return(data)
}

# Remove extreme outliers

address_outliers <- function(data, ceof_out=3) {
  data = data
  
  # Food
  sum(is.na(data$`Food Pounds`))
  outlier <- boxplot.stats(data$`Food Pounds`, coef = ceof_out)$out
  data$`Food Pounds` <- 
    ifelse(data$`Food Pounds` %in% outlier, NA, data$`Food Pounds`)
  sum(is.na(data$`Food Pounds`))
  
  # Clothing
  sum(is.na(data$`Clothing Items`))
  outlier <- boxplot.stats(data$`Clothing Items`, coef = ceof_out)$out
  data$`Clothing Items` <- 
    ifelse(data$`Clothing Items` %in% outlier, NA, data$`Clothing Items`)
  sum(is.na(data$`Clothing Items`))
  
  # School Kits
  sum(is.na(data$`School Kits`))
  outlier <- boxplot.stats(data$`School Kits`, coef = ceof_out)$out
  data$`School Kits` <- 
    ifelse(data$`School Kits` %in% outlier, NA, data$`School Kits`)
  sum(is.na(data$`School Kits` ))
  
  # Hygiene Kits
  sum(is.na(data$`Hygiene Kits`))
  outlier <- boxplot.stats(data$`Hygiene Kits`, coef = ceof_out)$out
  data$`Hygiene Kits` <- 
    ifelse(data$`Hygiene Kits` %in% outlier, NA, data$`Hygiene Kits`)
  sum(is.na(data$`Hygiene Kits`))
  
  # Diapers
  sum(is.na(data$Diapers))
  outlier <- boxplot.stats(data$Diapers, coef = ceof_out)$out
  data$Diapers<- 
    ifelse(data$Diapers %in% outlier, NA, data$Diapers)
  sum(is.na(data$Diapers))
  
  return(data)
}

# Arrange datasets

# Summarize data by client
sum_by_clients <- function(data) {
  data_clients <- data %>%
    group_by(`Client File Number`) %>%
    arrange(`Client File Number`) %>%
    mutate(services=n()) %>%
    summarise(total=max(services),
              date_started=min(date_new),
              date_last=max(date_new)) %>%
    mutate(year_started=year(date_started),
           year_ended=year(date_last)) %>%
    mutate(time_served=date_last-date_started)
  return(data_clients)
}

# Total visits per client
sum_by_client_year <- function(data) {
  data_clients_year <- data %>%
    mutate(year = year(date_new)) %>%
    arrange(`Client File Number`, date_new) %>%
    group_by(`Client File Number`, year) %>%
    mutate(services=n()) %>%
    summarise(total=max(services))
  return(data_clients_year)
}

# Summarize data by month and year
sum_by_date <- function(data) {
  data_date <- data %>%
    mutate(year = year(date_new), month = month(date_new)) %>%
    group_by(year, month) %>%
    replace_na(list(`Food Pounds` = 0, 
                    `Clothing Items` = 0, 
                    `School Kits` = 0,
                    `Hygiene Kits` = 0,
                    Diapers = 0)) %>%
    mutate(food_cumsum = cumsum(`Food Pounds`),
           cloth_cumsum = cumsum(`Clothing Items`),
           school_cumsum = cumsum(`School Kits`),
           hygiene_cumsum = cumsum(`Hygiene Kits`),
           diaper_cumsum = cumsum(Diapers)) %>%
    summarise(food_total=max(food_cumsum, na.rm = TRUE),
              cloth_total=max(cloth_cumsum, na.rm = TRUE),
              school_total=max(school_cumsum, na.rm = TRUE),
              hygiene_total=max(hygiene_cumsum, na.rm = TRUE),
              diaper_total=max(diaper_cumsum, na.rm = TRUE))
  return(data_date)
}

get_title <- function(var_name = "food_total") {
  new_title = ""
  if (identical(var_name,"food_total")) {
    new_title = "Total Amount of Food Distributed (lbs)"
  } 
  else if (identical(var_name,"cloth_total")) {
    new_title = "Total Amount of Clothes Distributed"
  } 
  else if (identical(var_name,"school_total")) {
    new_title = "Total Amount of School Kits Distributed"
  }
  else if (identical(var_name,"hygiene_total")) {
    new_title = "Total Amount of Hygiene Kits Distributed"
  } 
  else if (identical(var_name,"diaper_total")) {
    new_title = "Total Amount of Diapers Distributed"
  }
  return(new_title)
}

get_scale_title <- function(var_name = "food_total") {
  new_title = ""
  if (identical(var_name,"food_total")) {
    new_title = "Food\nDistributed (lbs)"
  } 
  else if (identical(var_name,"cloth_total")) {
    new_title = "Clothes\nDistributed"
  } 
  else if (identical(var_name,"school_total")) {
    new_title = "School Kits\nDistributed"
  }
  else if (identical(var_name,"hygiene_total")) {
    new_title = "Hygiene Kits\nDistributed"
  } 
  else if (identical(var_name,"diaper_total")) {
    new_title = "Diapers\nDistributed"
  }
  return(new_title)
}

make_graph <- function(data, var_name = "food_total") {
  title = get_title(var_name)
  scale_title = get_scale_title(var_name)
  data %>%
    ggplot(aes(x=year, y=month)) +
    geom_raster(aes(fill=get(var_name))) +
    scale_y_continuous(trans = "reverse", breaks = unique(data$month)) +
    scale_fill_distiller(palette = "YlOrRd", 
                         name=scale_title, direction = 1) +
    theme_minimal() +
    xlab("Year") +
    ylab("Calendar Month") +
    ggtitle(title)
}
