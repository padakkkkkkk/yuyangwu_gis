
# global gender inequality index: gii
install.packages('janitor')
install.packages('countrycode')
library(here)
library(tidyverse)
library(janitor)
library(countrycode)
HDRcsv <- read_csv(here("HDR21-22_Composite_indices_complete_time_series.csv"),
                   na="")
data_ggi <- HDRcsv  %>%
  clean_names() %>%
  dplyr::select(c(iso3,country,gii_2010,gii_2019))%>%
  mutate(difference=gii_2019-gii_2010)
WCcsv <-read_csv(here('World_Countries_(Generalized).csv'))
head(WCcsv)

WC_gii <- WCcsv %>%
  clean_names() %>%
  left_join(.,data_ggi,
            by=c('country'='country'))

#use countrycode

data_ggi2 <-data_ggi %>%
  mutate(iso_code=countrycode(country,origin = 'country.name',
                              destination='iso2c')) %>%
  mutate(iso_code2=countrycode(iso3,origin = 'iso3c',destination=
                                 'iso2c'))

