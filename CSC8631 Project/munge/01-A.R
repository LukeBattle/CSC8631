#manually update these for the data sets uploaded
first_question_run = 1
first_video_run = 3

video_col_names = c("step_position","title","video_duration","total_views","total_downloads","total_caption_views","total_transcript_views",
              "viewed_hd","viewed_five_percent","viewed_ten_percent","viewed_twentyfive_percent","viewed_fifty_percent",
              "viewed_seventyfive_percent","viewed_ninetyfive_percent","viewed_onehundred_percent","console_device_percentage",
              "desktop_device_percentage","mobile_device_percentage","tv_device_percentage","tablet_device_percentage",
              "unknown_device_percentage","europe_views_percentage","oceania_views_percentage","asia_views_percentage",
              "north_america_views_percentage","south_america_views_percentage","africa_views_percentage",
              "antarctica_views_percentage")

video_names = c(1.10,1.14,1.17,1.19,1.50,2.10,2.11,2.17,2.40,3.10,3.14,3.15,3.20)

video_df = NULL

video_files = dir("data",pattern = "video-stats")

cache('video_files')

for(i in 1:length(video_files)) {
  video_stats = read.csv(paste("data/",video_files[i],sep = ""))
  #if (identical(colnames(video_stats),video_col_names)==FALSE) stop(paste("Column Names have changed for", video_files[i]))
  #if (identical(video_stats$step_position,video_names)==FALSE) stop(paste("The videos have changed for", video_files[i]))
  Run = rep(i + first_video_run - 1, nrow(video_stats))
  video_stats = cbind(video_stats, Run)
  video_df = rbind(video_df,video_stats)
}

cache('video_df')

video_file_raw = read.csv(paste("data/",video_files[1],sep = ""))

cache('video_file_raw')


question_df = NULL

question_files = dir("data",pattern = "question-response")

cache('question_files')


for(i in 1:length(question_files)) {
  question_response = read.csv(paste("data/",question_files[i],sep = ""))
  Run = rep(i + first_question_run - 1, nrow(question_response))
  question_response = cbind(question_response, Run)
  question_df = rbind(question_df,question_response)
}

question_df = mutate(question_df,correct_binary = ifelse(correct =="true",1,0))

question_df$cloze_response = NULL 

cache('question_df')


question_file_raw = read.csv(paste("data/",question_files[1],sep = ""))

cache('question_file_raw')


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
