#List of all packages used on steps 1 - 5
packages_setup<-c("dplyr",
                  "knitr",
                  "psych",
                  "md.log",
                  "data.table",
                  "tidyr",
                  "lme4",
		              "nloptr",
		              "phyr",
                  "flexmix",
                  "sjPlot",
                  "stringr",
                  "performance",
                  "ggplot2",
                  "cowplot",
                  "patchwork",
                  "ggpubr",
                  "rmarkdown")

options(repos = c(CRAN = "https://cloud.r-project.org"))

#Check if packages are installed and install if needed
# for (p in packages_setup){
#   if (!requireNamespace(p)) {
#     install.packages(p)
#   }
# }

# Initialize a list to track failed installs
failed_packages <- c()

# Check if packages are installed and install if needed
for (p in packages_setup) {
  if (!requireNamespace(p, quietly = TRUE)) {
    message("Installing package: ", p)
    tryCatch({
      install.packages(p, dependencies = TRUE)
      # Re-check if it’s installed after installation
      if (!requireNamespace(p, quietly = TRUE)) {
        failed_packages <- c(failed_packages, p)
      }
    }, error = function(e) {
      failed_packages <- c(failed_packages, p)
    })
  }
}

# Print the list of failed packages
if (length(failed_packages) > 0) {
  message("The following packages failed to install: ", paste(failed_packages, collapse = ", "))
} else {
  message("All packages installed successfully!")
}


library("rmarkdown")

#Constants for years of analysis
start_year<-2005
finish_year<-2021
path<-getwd()  
model_type="classic" 
#[TBD] check RmD files and replace variables with params$start_year & params$finish_year, params$path, params$model_type

#Main report function
render_report = function(path, file_name) {
  rmarkdown::render(paste0(path, file_name, ".RmD"), params = list(path = path, start_year, finish_year, model_type="classic"),
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



