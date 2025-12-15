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

for (p in packages_setup){
  if (!requireNamespace(p)) {
  install.packages(p)
}
}

