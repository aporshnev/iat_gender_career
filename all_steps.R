#List of all packages used on steps 1 - 5
packages_setup<-c("dplyr",
                  "knitr",
                  "psych",
                  "md.log",
                  "data.table",
                  "tidyr",
                  "lme4",
                  "flexmix",
                  "sjPlot",
                  "stringr",
                  "performance",
                  "ggplot2",
                  "cowplot",
                  "patchwork",
                  "ggpubr") 

#Check if packages are installed and install if needed
for (p in packages_setup){
  if (!requireNamespace(p)) {
    install.packages(p)
  }
}

#Constants for years of analysis

start_year<-2005
finish_year<-2021

#setwd("C:/Alex/Maynooth/IAT/Gender-Career/Analysis/git_for_replication/S3_5_full_check")
#path<-"C:/Alex/Maynooth/IAT/Gender-Career/Analysis/git_for_replication/S3_5_full_check"

#Main report function
render_report = function(path, file_name) {
  rmarkdown::render(paste0(path,file_name, ".RmD"), params = list(path = path, start_year, finish_year, model_type="classic"),
  output_file = paste0(path, file_name, "_",start_year,"-", finish_year,".html")
  )
}

#List of reports to create
analysis_structure<-c(
#  "/Step_01/01_preprocessing_year_data",
#           "/Step_01/01a_preprocessing",
#           "/Step_01/01b_split_data",
#           "/Step_02/02_mean_RT_for_stimuli_AB_sample_testing",
#           "/Step_02/02a_merge_RT",
            "/Step_03/03_extend_RT",
            "/Step_04/04_LDM_models",
            "/Step_05/05_summary_report"
            )


sessionInfo()

#main pipeline
for (a in analysis_structure){
render_report(path, a)}


#additional pipeline for robustness check & Figures, mean RT for one year only
# years<-c(2009, 2014, 2019)
# for (y in years){
# start_year<-y
# finish_year<-y 
# render_report(path, "/Step_04/04_LDM_models")
# render_report(path, "/Step_05/05_summary_report")
# }


#additional pipeline for Figure smean RT for 2005-2021 years
# start_year<-2005
# finish_year<-2021
# render_report(path, "/Step_04/04_LDM_models")
# render_report(path, "/Step_05/05_summary_report")



