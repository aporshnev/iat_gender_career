library(data.table)
library(dplyr)

# Be careful this function overwrite the samples!!!
split_clean_data_RT<-function(year){
  path = "D:\\Jul24_stage4\\"
  setwd(path)
  
  t_filename = paste0(path, "01a_Clean\\t_", year, ".csv")
  t_data_d <- fread(t_filename)
  
  p_filename = paste0(path, "01a_Clean\\p_", year, ".csv")
  p_data_d <- fread(p_filename)
  
  p_data_US<-p_data_d %>% filter(countryres == "US")
  
  US_ids_subsetA<-sample(x=p_data_US$session_id, size = nrow(p_data_US)/2)
  US_ids_subsetB<-p_data_US$session_id[!p_data_US$session_id %in% US_ids_subsetA]
  
  p_data_UK<-p_data_d %>% filter(countryres == "UK")
  UK_ids_subsetA<-sample(x=p_data_UK$session_id, size = nrow(p_data_UK)/2)
  UK_ids_subsetB<-p_data_UK$session_id[!p_data_UK$session_id %in% UK_ids_subsetA]
  
  ids_subsetA<-c(UK_ids_subsetA, US_ids_subsetA)
  ids_subsetB<-c(UK_ids_subsetB, US_ids_subsetB)
  
  p_data_A <- p_data_d %>% filter(session_id %in% ids_subsetA)  
  t_data_A <- t_data_d %>% filter(session_id %in% ids_subsetA)
  
  p_filenameA = paste0(path, "01b_Split\\p_",year, "_A.csv")
  t_filenameA = paste0(path, "01b_Split\\t_",year, "_A.csv")
  
  fwrite(p_data_A, p_filenameA)
  fwrite(t_data_A, t_filenameA)
  
  p_data_B <- p_data_d %>% filter(session_id %in% ids_subsetB)  
  t_data_B <- t_data_d %>% filter(session_id %in% ids_subsetB)
  
  p_filenameB = paste0(path, "01b_Split\\p_",year, "_B.csv")
  t_filenameB = paste0(path, "01b_Split\\t_",year, "_B.csv")
  
  fwrite(p_data_B, p_filenameB)
  fwrite(t_data_B, t_filenameB)
}

library(md.log)
md.log("Start splitting data", file="log_splitting.txt", append =FALSE, time = TRUE)

for (i in 2005:2021)
{
  md.log(paste0(" ", i, "year started"))
  split_clean_data_RT(i)
  md.log(paste0(" year completed"))
}

