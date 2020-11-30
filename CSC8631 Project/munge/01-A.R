#recall previous column names for data checks
video_col_names = c("step_position","title","video_duration","total_views","total_downloads","total_caption_views","total_transcript_views",
              "viewed_hd","viewed_five_percent","viewed_ten_percent","viewed_twentyfive_percent","viewed_fifty_percent",
              "viewed_seventyfive_percent","viewed_ninetyfive_percent","viewed_onehundred_percent","console_device_percentage",
              "desktop_device_percentage","mobile_device_percentage","tv_device_percentage","tablet_device_percentage",
              "unknown_device_percentage","europe_views_percentage","oceania_views_percentage","asia_views_percentage",
              "north_america_views_percentage","south_america_views_percentage","africa_views_percentage",
              "antarctica_views_percentage")

#recall previous video step_position for checks
video_names = c(1.10,1.14,1.17,1.19,1.50,2.10,2.11,2.17,2.40,3.10,3.14,3.15,3.20)

#create vector of video-stats files in data directory of project
video_files = dir("data",pattern = "video-stats")

#create empty vector of length equal to video files length
video_files_numeric = numeric(length(video_files))

#remove known patterns in file names to identify run number associated with each file in data subdirectory
for (i in 1:length(video_files)) {
  run_num = str_remove(video_files[i],"cyber-security-")
  run_num = str_remove(run_num, "_video-stats.csv")
  video_files_numeric[i] = as.integer(run_num)
}

#cache the list
cache('video_files')

#set raw video-stats data file for data understanding portion of report
video_file_raw = read.csv(paste("data/",video_files[1],sep = ""))

#cache raw video-stats file
cache('video_file_raw')

#initialise data frame for video-stats data preparation
video_df = NULL

#loop through files in video_files vector, add Run number of course and append columns used in analysis to video_df data frame 
for(i in 1:length(video_files)) {
  video_stats = read.csv(paste("data/",video_files[i],sep = ""))
  #if (identical(colnames(video_stats),video_col_names)==FALSE) stop(paste("Column Names have changed for", video_files[i]))
  #if (identical(video_stats$step_position,video_names)==FALSE) stop(paste("The videos have changed for", video_files[i]))
  Run = rep(i + min(video_files_numeric) - 1, nrow(video_stats))
  video_stats = cbind(video_stats, Run)
  video_df = rbind(video_df,video_stats[,c("Run", "title", "step_position", "video_duration","viewed_five_percent",
                                           "viewed_ten_percent","viewed_twentyfive_percent","viewed_fifty_percent",
                                           "viewed_seventyfive_percent", "viewed_ninetyfive_percent","viewed_onehundred_percent")])
}

video_df = video_df %>%
  mutate(percentage_drop_off = viewed_five_percent - viewed_ninetyfive_percent)

#cache video_df
cache('video_df')

#convert video_df to long format for plotting
video_df_long = video_df %>%
  pivot_longer(viewed_five_percent:viewed_onehundred_percent, 
               names_to = "viewed")

#convert viewed variable to integer for plotting
  video_df_long$viewed[video_df_long$viewed == "viewed_five_percent"] = 5
  video_df_long$viewed[video_df_long$viewed == "viewed_ten_percent"] = 10 
  video_df_long$viewed[video_df_long$viewed == "viewed_twentyfive_percent"] = 25
  video_df_long$viewed[video_df_long$viewed == "viewed_fifty_percent"] = 50 
  video_df_long$viewed[video_df_long$viewed == "viewed_seventyfive_percent"] = 75 
  video_df_long$viewed[video_df_long$viewed == "viewed_ninetyfive_percent"] = 95
  video_df_long$viewed[video_df_long$viewed == "viewed_onehundred_percent"] = 100
  video_df_long$viewed = as.integer(video_df_long$viewed)

#cache long form video_df data frame
cache('video_df_long')

#arrange video_df in descending order by percentage drop off per video
highest_audience_drop = video_df %>%
  group_by(step_position, title) %>%
  summarise(percentage_drop_off = mean(percentage_drop_off)) %>%
  arrange(desc(percentage_drop_off))

#store resulting data frame in cache
cache('highest_audience_drop')

#save 5 videos with highest percentage drop off in viewers
highest_audience_drop_videos = highest_audience_drop[1:5,]$step_position

#store 5 videos as vector in cache
cache('highest_audience_drop_videos')