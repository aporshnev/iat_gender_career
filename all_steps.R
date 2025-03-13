#list of libraries used for steps 1-5 
library(dplyr)
library(knitr)
library(psych)
library(md.log)
library(data.table)
library(tidyr)
library(lme4)
library(flexmix)
library(sjPlot)
library(stringr)
library(performance)
library(ggplot2)
library(cowplot)
setwd("C:/Alex/Maynooth/IAT/Gender-Career/Analysis/git_for_replication/S3_5_full_check")
render_report = function(path, file_name) {
  rmarkdown::render(paste0(path,file_name, ".RmD"), params = list(path = path),
  output_file = paste0(path, file_name, ".html")
  )
}

path=getwd()

analysis_structure<-c(
#  "/Step_01/01_preprocessing_year_data",
#           "/Step_01/01a_preprocessing",
#           "/Step_01/01b_split_data",
#           "/Step_02/02_mean_RT_for_stimuli_AB_sample_testing",
#           "/Step_02/02a_merge_RT",
#            "/Step_03/03_extend_RT",
#            "/Step_04/04_LDM_models",
            "/Step_05/05_summary_report"
            )
dir_structure<-c(
  "Step_01/out_1_Clean/",
  "Step_01/out_1a_Clean_noexp/",
  "Step_01/out_1b_Split/",
  "Step_01/out_1a_Stats/",
  "Step_01/out_1_Stats/",
  "Step_02/out_2_RT/",
                 "Step_02/out_2a_RT_merged/",
                 "Step_03/out_3_EXT_RT/",
                 "Step_04/out_4_Models_classic/",
                 "Step_04/out_4_Summary_classic/",
                 "Step_05/out_05_Summary_Figures_classic"
                 )
#creating directories structure 
#for (d in dir_structure){
#dir.create(file.path(path, d), showWarnings = FALSE)
#}

#render_report(path, a[1])
#file_name<-a[1]
#sessionInfo()

#main pipeline
for (a in analysis_structure){
render_report(path, a)}




