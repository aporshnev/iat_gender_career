
setwd("C:/Alex/Maynooth/IAT/Gender-Career/Analysis/git_for_replication/iat_gender_career/Step_05/out_Summary_classic")
dA1<- fread(paste0("Summary_table_B_llms_classic_V1.csv"))
dA2<- fread(paste0("Summary_table_B_llms_classic_V2.csv"))

fwrite(rbind(dA1, dA2), "Summary_table_B_llms_classic_full.csv")
