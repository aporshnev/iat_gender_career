import pandas as pd
import csv

path = "C:/Alex/Maynooth/IAT/Gender-Career/Datasets/RAW_Preprocessed/Clean_datasets/"
participant_id={}
participant_problematic={}
for i in range(2005,2022):
    df = pd.read_csv(path+"p_"+str(i)+".csv", dtype=str, sep=";")

    #print(df)
    #print(df)
    for j in range(0,len(df["session_id"])):
        pr_id = df["previous_session_id"][j]
        #print(pr_id)
        if str(pr_id)=="nan":
            #print("new participant")
            if participant_id.get(df["session_id"][j])==None:
                participant_id.update({df["session_id"][j]:[df["session_id"][j], 0]})
                #print(participant_id)
            else:
                print(participant_id.get(df["session_id"][j]), "Error")

        else:
            if participant_id.get(pr_id) != None:
                id, count = participant_id.get(pr_id)
                count = count + 1

                participant_id.update({df["session_id"][j]: [id, count]})
            else:
                print("Error", i, "session",pr_id, "not found",  participant_id.get(pr_id), )
                participant_id.update({df["session_id"][j]: [df["session_id"][j], 0]})
                participant_problematic.update({df["session_id"][j]: [pr_id, i]})
                #print(pr_id, participant_id.get(pr_id))


#print(list(participant_id.keys()))
#print(list(participant_id.values()))


with open('C:/Alex/Maynooth/IAT/Gender-Career/Datasets/RAW_Preprocessed/Clean_datasets/participants_ids.csv', 'w') as f:
    for row in participant_id:
        f.write(str(row)+";"+str(participant_id.get(row)[0])+";"+str(participant_id.get(row)[1])+"\n")
with open('C:/Alex/Maynooth/IAT/Gender-Career/Datasets/RAW_Preprocessed/Clean_datasets/participants_ids_problematic.csv',
                  'w') as f:
    for row in participant_problematic:
        f.write(str(row) + ";" + str(participant_problematic.get(row)[0]) + ";" + str(participant_problematic.get(row)[1]) + "\n")
