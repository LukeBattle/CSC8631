#create vector of question-response files in data directory of project
question_files = dir("data",pattern = "question-response")

#store them in cache
cache('question_files')

#create empty vector of length equal to video files length
question_files_numeric = numeric(length(video_files))

#remove known patterns in file names to identify run number associated with each file in data subdirectory
for (i in 1:length(question_files)) {
  run_num = str_remove(question_files[i],"cyber-security-")
  run_num = str_remove(run_num, "_question-response.csv")
  question_files_numeric[i] = as.integer(run_num)
}

#set raw question-response data file for data understanding portion of report
question_file_raw = read.csv(paste("data/",question_files[1],sep = ""))

#store raw file in cache
cache('question_file_raw')

#initalise question-response data frame prior to data preparation
question_df = NULL

#add corresponding run number and append each file to question-response data data frame
for(i in 1:length(question_files)) {
  question_response = read.csv(paste("data/",question_files[i],sep = ""))
  Run = rep(i + min(question_files_numeric) - 1, nrow(question_response))
  question_response = cbind(question_response, Run)
  question_df = rbind(question_df,question_response)
}

#add a binary indicator of if question was answered true or false
question_df = mutate(question_df,correct_binary = ifelse(correct =="true",1,0))

#remove empty cloze_response column
question_df$cloze_response = NULL 

#store-response data frame in cache
cache('question_df')


#investigate proportion of correct answers per run
Runs = sort(unique(question_df$Run), decreasing = FALSE)

#initialise percentage correct vector with length equal to amount of runs
percentage_correct = numeric(length(Runs))

#loop through each run in quetion_df, calculate percentage questions answered correctly and store in percentage correct vector
for (i in sort(unique(question_df$Run),decreasing = FALSE)) {
  filtered_q_df = filter(question_df,Run == i)
  total = nrow(filtered_q_df)
  question_correct = sum(filtered_q_df$correct_binary)
  percentage_correct[i] = (question_correct/total) *100
  rm(filtered_q_df,total,question_correct)
}

#create data frame with runs and corresponding percentage of questions answered correctly
correct_questions = as.data.frame(cbind(Runs,percentage_correct))

#store correct questions data frame in cache
cache('correct_questions')