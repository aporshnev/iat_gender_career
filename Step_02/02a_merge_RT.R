library(data.table)
library(dplyr)

path = path = "D:\\Jul24_stage4\\"

merge_clean_data_RT<-function(year_start, year_finish, sample_name = "A"){
  RT_data = NULL
  for (year in year_start:year_finish)
  {
  t_filename = paste0(path, "\\02_RT\\RT_", year, "_", sample_name, ".csv")
  RT_data_year <- fread(t_filename) %>% select("trial_name",	"congruent_trial",	"Sum",	"N",	"country")
  names(RT_data_year)[names(RT_data_year) == 'Sum'] <- paste0("Sum_",year)
  names(RT_data_year)[names(RT_data_year) == 'N'] <- paste0("N_",year)
  
    if (is.null(RT_data)) 
    {
  RT_data <- RT_data_year
  } else  {
    print(year)
  RT_data<-left_join(RT_data, RT_data_year, by = join_by(trial_name == trial_name, congruent_trial == congruent_trial, country == country), suffix = c("", paste0("_",year)))
  }
  

}

RT_data$sum_Sum <- rowSums(RT_data %>% select(paste0("Sum_", year_start:year_finish)))
RT_data$sum_N <- rowSums(RT_data %>% select(paste0("N_", year_start:year_finish)))
RT_data$M<-RT_data$sum_Sum/RT_data$sum_N

RT_data_2a<-RT_data %>% select("trial_name",	"congruent_trial",	"M", "country")
names(RT_data_2a)[1]<-"stimuli"
names(RT_data_2a)[2]<-"congruent"
fwrite(RT_data_2a, paste0(path, "\\02a_Merge\\RT_", year_start, "_", year_finish, "_", sample_name, ".csv"))

# Creation of supplementary files for correlation analysis of distances vs mean RT in each sample, and mean for both samples
RT_data_UK<-RT_data %>% filter(country == "UK") %>% select("trial_name",	"congruent_trial",	"M")
names(RT_data_UK)[1]<-"stimuli"
names(RT_data_UK)[2]<-"congruent"
fwrite(RT_data_UK, paste0(path, "\\02a_Merge\\RT_UK_", year_start, "_", year_finish, "_", sample_name, ".csv"))


RT_data_US<-RT_data %>% filter(country == "US") %>% select("trial_name",	"congruent_trial",	"M")
names(RT_data_UK)[1]<-"stimuli"
names(RT_data_UK)[2]<-"congruent"
fwrite(RT_data_US, paste0(path, "\\02a_Merge\\RT_US_", year_start, "_", year_finish, "_", sample_name, ".csv"))

RT_data_UK_temp<-RT_data %>% filter(country == "UK") %>% select("trial_name",	"congruent_trial",	"sum_Sum", "sum_N")
RT_data_US_temp<-RT_data %>% filter(country == "US") %>% select("trial_name",	"congruent_trial","sum_Sum" , "sum_N")

RT_data_mean<-left_join(RT_data_UK_temp, RT_data_US_temp, by = join_by(trial_name == trial_name, congruent_trial == congruent_trial), suffix = c("UK", "US"))
RT_data_mean$M<-(RT_data_mean$sum_SumUK+RT_data_mean$sum_SumUS)/(RT_data_mean$sum_NUK+RT_data_mean$sum_NUS)
RT_data_mean<-RT_data_mean %>%  select("trial_name",	"congruent_trial",	"M")
names(RT_data_mean)[1]<-"stimuli"
names(RT_data_mean)[2]<-"congruent"

fwrite(RT_data_mean, paste0(path, "\\02a_Merge\\RT_mean_", year_start, "_", year_finish, "_", sample_name, ".csv"))
}

merge_clean_data_RT(2005, 2021, sample_name = "A")
merge_clean_data_RT(2005, 2021, sample_name = "B")

