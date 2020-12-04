
#align plot titles in centre
theme_update(plot.title = element_text(hjust = 0.5))

#plotting video duration against percentage of course learners who viewed 95% of video
(duration_plot = ggplot(data = filter(video_df_long, viewed == 95), aes(x = video_duration, y = value)) +  
    stat_summary(fun = mean, geom = "line") + 
    stat_summary(fun = mean, geom = "point") + 
    labs(
      x = "Video Duration (seconds)",
      y = "% Learners Viewing Video",
      title = "% of Learners Viewing 95% of Videos vs Video Duration"
    ))
