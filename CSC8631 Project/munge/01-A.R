first_question_run = 1
first_video_run = 3

video_df = NULL

video_files = dir("data",pattern = "video-stats")

for(i in 1:length(video_files)) {
  video_stats = read.csv(paste("data/",video_files[i],sep = ""))
  Run = rep(i + first_video_run - 1, nrow(video_stats))
  video_stats = cbind(video_stats, Run)
  video_df = rbind(video_df,video_stats)
}

cache('video_df')

question_df = NULL

question_files = dir("data",pattern = "question-response")



for(i in 1:length(question_files)) {
  question_response = read.csv(paste("data/",question_files[i],sep = ""))
  Run = rep(i + first_question_run - 1, nrow(question_response))
  question_response = cbind(question_response, Run)
  question_df = rbind(question_df,question_response)
}

question_df = mutate(question_df,correct_binary = ifelse(correct =="true",1,0))

question_df$cloze_response = NULL 

cache('question_df')

#group by run number and show mean viewing percentage per run
viewing_avg_long = video_df %>%
  group_by(Run) %>%
  summarise(
    viewed_5_percent = mean(viewed_five_percent),
    viewed_10_percent = mean(viewed_ten_percent),
    viewed_25_percent = mean(viewed_twentyfive_percent),
    viewed_50_percent = mean(viewed_fifty_percent),
    viewed_75_percent = mean(viewed_seventyfive_percent),
    viewed_95_percent = mean(viewed_ninetyfive_percent),
    viewed_100_percent = mean(viewed_onehundred_percent)
  ) %>%
  gather(viewed,percentage,viewed_5_percent:viewed_100_percent)

#convert viewing percentages to numbers
for(i in c(5,10,25,50,75,95,100)) {
  viewing_avg_long$viewed[viewing_avg_long$viewed == paste("viewed_",i,"_percent",sep = "")] = i
}

#convert numbered viewing percentages from character to number
viewing_avg_long$viewed = as.numeric(viewing_avg_long$viewed)

cache('viewing_avg_long')

#group by run number and show mean viewing percentage per run
step_avg_long = video_df %>%
  group_by(step_position) %>%
  summarise(
    viewed_5_percent = mean(viewed_five_percent),
    viewed_10_percent = mean(viewed_ten_percent),
    viewed_25_percent = mean(viewed_twentyfive_percent),
    viewed_50_percent = mean(viewed_fifty_percent),
    viewed_75_percent = mean(viewed_seventyfive_percent),
    viewed_95_percent = mean(viewed_ninetyfive_percent),
    viewed_100_percent = mean(viewed_onehundred_percent)
  ) %>%
  gather(viewed,percentage,viewed_5_percent:viewed_100_percent)

#convert viewing percentages to numbers
for(i in c(5,10,25,50,75,95,100)) {
  step_avg_long$viewed[step_avg_long$viewed == paste("viewed_",i,"_percent",sep = "")] = i
}

#convert numbered viewing percentages from character to number
step_avg_long$viewed = as.numeric(step_avg_long$viewed)

cache('step_avg_long')
