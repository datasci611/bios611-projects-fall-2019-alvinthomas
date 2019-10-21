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

filter_date <- function(date_range = "2010-01-01 to 2017-12-31") {
  first_date = substr(date_range, 1, 10)
  second_date = substr(date_range, 15, 24)
  proj2 <- proj2 %>%
    filter(between(date_new, as.Date(first_date), as.Date(second_date))) %>%
    arrange(date_new)
}

# Remove extreme outliers

address_outliers <- function(ceof_out=3) {
  # Food
  sum(is.na(proj2$`Food Pounds`))
  outlier <- boxplot.stats(proj2$`Food Pounds`, coef = ceof_out)$out
  proj2$`Food Pounds` <- 
    ifelse(proj2$`Food Pounds` %in% outlier, NA, proj2$`Food Pounds`)
  sum(is.na(proj2$`Food Pounds`))
  
  # Clothing
  sum(is.na(proj2$`Clothing Items`))
  outlier <- boxplot.stats(proj2$`Clothing Items`, coef = ceof_out)$out
  proj2$`Clothing Items` <- 
    ifelse(proj2$`Clothing Items` %in% outlier, NA, proj2$`Clothing Items`)
  sum(is.na(proj2$`Clothing Items`))
  
  # School Kits
  sum(is.na(proj2$`School Kits`))
  outlier <- boxplot.stats(proj2$`School Kits`, coef = ceof_out)$out
  proj2$`School Kits` <- 
    ifelse(proj2$`School Kits` %in% outlier, NA, proj2$`School Kits`)
  sum(is.na(proj2$`School Kits` ))
  
  # Hygiene Kits
  sum(is.na(proj2$`Hygiene Kits`))
  outlier <- boxplot.stats(proj2$`Hygiene Kits`, coef = ceof_out)$out
  proj2$`Hygiene Kits` <- 
    ifelse(proj2$`Hygiene Kits` %in% outlier, NA, proj2$`Hygiene Kits`)
  sum(is.na(proj2$`Hygiene Kits`))
  
  # Diapers
  sum(is.na(proj2$Diapers))
  outlier <- boxplot.stats(proj2$Diapers, coef = ceof_out)$out
  proj2$Diapers<- 
    ifelse(proj2$Diapers %in% outlier, NA, proj2$Diapers)
  sum(is.na(proj2$Diapers))
}

# Arrange datasets
sum_by_client <- function() {
  # Summarize data by client
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
  
  # Total visits per client
  proj2_clients_year <- proj2 %>%
    mutate(year = year(date_new)) %>%
    arrange(`Client File Number`, date_new) %>%
    group_by(`Client File Number`, year) %>%
    mutate(services=n()) %>%
    summarise(total=max(services))
  
  # Summarize data by month and year
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
}

make_graph <- function(var_name = "food_total") {
  proj2_date %>%
    ggplot(aes(x=year, y=month)) +
    geom_raster(aes(fill=get(var_name))) +
    scale_y_continuous(trans = "reverse", breaks = unique(proj2_date$month)) +
    scale_fill_distiller(palette = "YlOrRd", name="Food\nDistributed (lbs)", direction = 1) +
    theme_minimal() +
    xlab("Year") +
    ylab("Calendar Month") +
    ggtitle("Total Amount of Food Distributed (lbs)")
}
