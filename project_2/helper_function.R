library("shiny")
library("tidyverse")
library("stringr")
library("lubridate")
library("rsconnect")

# Bring in data
proj2 <- read_tsv("data/UMD_Services_Provided_20190719.tsv")
proj2_meta <- read_tsv("data/UMD_Services_Provided_metadata_20190719.tsv")

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

filter_date <- function(data = proj2, date_range = "2010-01-01 to 2017-12-31") {
  first_date = substr(date_range, 1, 10)
  second_date = substr(date_range, 15, 24)
  data_new <- data %>%
    filter(between(date_new, as.Date(first_date), as.Date(second_date))) %>%
    arrange(date_new)
  retrun(data_new)
}

# Remove extreme outliers

address_outliers <- function(data = proj2, ceof_out=3) {
  # Food
  sum(is.na(data$`Food Pounds`))
  outlier <- boxplot.stats(data$`Food Pounds`, coef = ceof_out)$out
  proj2$`Food Pounds` <- 
    ifelse(data$`Food Pounds` %in% outlier, NA, data$`Food Pounds`)
  sum(is.na(data$`Food Pounds`))
  
  # Clothing
  sum(is.na(data$`Clothing Items`))
  outlier <- boxplot.stats(data$`Clothing Items`, coef = ceof_out)$out
  proj2$`Clothing Items` <- 
    ifelse(data$`Clothing Items` %in% outlier, NA, data$`Clothing Items`)
  sum(is.na(data$`Clothing Items`))
  
  # School Kits
  sum(is.na(data$`School Kits`))
  outlier <- boxplot.stats(data$`School Kits`, coef = ceof_out)$out
  proj2$`School Kits` <- 
    ifelse(data$`School Kits` %in% outlier, NA, data$`School Kits`)
  sum(is.na(data$`School Kits` ))
  
  # Hygiene Kits
  sum(is.na(data$`Hygiene Kits`))
  outlier <- boxplot.stats(data$`Hygiene Kits`, coef = ceof_out)$out
  proj2$`Hygiene Kits` <- 
    ifelse(data$`Hygiene Kits` %in% outlier, NA, data$`Hygiene Kits`)
  sum(is.na(data$`Hygiene Kits`))
  
  # Diapers
  sum(is.na(data$Diapers))
  outlier <- boxplot.stats(data$Diapers, coef = ceof_out)$out
  proj2$Diapers<- 
    ifelse(data$Diapers %in% outlier, NA, data$Diapers)
  sum(is.na(data$Diapers))
}

# Arrange datasets

# Summarize data by client
sum_by_clients <- function() {
  proj2_clients <- proj2 %>%
    group_by(`Client File Number`) %>%
    arrange(`Client File Number`) %>%
    mutate(services=n()) %>%
    summarise(total=max(services),
              date_started=min(date_new),
              date_last=max(date_new)) %>%
    mutate(year_started=year(date_started),
           year_ended=year(date_last)) %>%
    mutate(time_served=date_last-date_started)
  return(proj2_clients)
}

# Total visits per client
sum_by_client_year <- function() {
  proj2_clients_year <- proj2 %>%
    mutate(year = year(date_new)) %>%
    arrange(`Client File Number`, date_new) %>%
    group_by(`Client File Number`, year) %>%
    mutate(services=n()) %>%
    summarise(total=max(services))
  return(proj2_clients_year)
}

# Summarize data by month and year
sum_by_date <- function() {
  proj2_date <- proj2 %>%
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
  return(proj2_date)
}

make_graph <- function(data = proj2, var_name = "food_total") {
  data <- filter_date(data)
  data <- address_outliers(data)
  data_clients <- sum_by_clients(data)
  data_client_year <- sum_by_client_year(data)
  data_date <- sum_by_date(data)
  data_date %>%
    ggplot(aes(x=year, y=month)) +
    geom_raster(aes(fill=get(var_name))) +
    scale_y_continuous(trans = "reverse", breaks = unique(data_date$month)) +
    scale_fill_distiller(palette = "YlOrRd", name="Food\nDistributed (lbs)", direction = 1) +
    theme_minimal() +
    xlab("Year") +
    ylab("Calendar Month") +
    ggtitle("Total Amount of Food Distributed (lbs)")
}
