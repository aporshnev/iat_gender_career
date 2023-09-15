import pandas as pd

path = "C:/Alex/Maynooth/IAT/Gender-Career/Datasets/RAW_Preprocessed/Clean_datasets/"
participant_id={}
session_count={}
for i in range(2005,2022):
    df = pd.read_csv(path+"p_"+str(i)+".csv", dtype=str, sep=";")

    print(df["user_id"])
    #print(df)
    for j in range(0,len(df["user_id"])):
        pr_id = df["user_id"][j]
        print(pr_id)
        if float(pr_id)>0:
            if participant_id.get(pr_id)==None:
                participant_id.update({pr_id: 1})
                session_count.update({df["session_id"][j]:[1, pr_id, i]})
            else:
                count = participant_id.get(pr_id)
                count = count + 1
                participant_id.update({pr_id: count})
                session_count.update({df["session_id"][j]: [count, pr_id, i]})


with open('C:/Alex/Maynooth/IAT/Gender-Career/Datasets/RAW_Preprocessed/Clean_datasets/user_ids.csv', 'w') as f:
    for row in participant_id:
        f.write(str(row)+";"+str(participant_id.get(row))+"\n")
with open('C:/Alex/Maynooth/IAT/Gender-Career/Datasets/RAW_Preprocessed/Clean_datasets/session_count.csv', 'w') as f:
    for row in session_count:
        f.write(str(row)+";"+str(session_count.get(row)[0])+";"+str(session_count.get(row)[1])+";"+str(session_count.get(row)[2])+"\n")

