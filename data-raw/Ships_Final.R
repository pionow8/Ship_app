## code to prepare `Ships_Final` dataset goes here
Ships_Final <- base::readRDS("data-raw\\Ships_Final.RDS")
usethis::use_data(Ships_Final, overwrite = TRUE)
