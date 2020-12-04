
#align plot titles in centre
theme_update(plot.title = element_text(hjust = 0.5))

#plot graph, showing changing viewing percentage per run
(step_plot = ggplot(data = video_df_long, aes(x = viewed, y = value, color = factor(step_position))) +  
    stat_summary(fun = mean, geom = "line") + 
    labs(
      x = "% Video",
      y = "% Learners Viewing Video",
      color = "Video",
      title = "% Learners that Viewed Each Video"
    ))


#filtered step_plot for 5 videos with highest audience drop from 5% to 95% of video
(step_plot_filtered = ggplot(data = filter(video_df_long, step_position %in% highest_audience_drop_videos), 
                             aes(x = viewed, y = value, color = factor(step_position))) +  
    stat_summary(fun = mean, geom = "line") + 
    stat_summary(fun = mean, geom = "point") +
    labs(
      x = "% Video",
      y = "% Learners Viewing Video",
      color = "Video",
      title = "% of Learners that Viewed 5 Least Watched Videos"
    ))

#plotting column chart showing largest drop off in audience per video
(lost_viewer_plot = ggplot(data = video_df, aes(x = factor(step_position), y = percentage_drop_off)) + 
    stat_summary(fun = mean, geom = "col") + 
    labs(
      x = "Video",
      y = "% Decline in Learners Viewing Video",
      title = "% Decline in Learners Viewing from 5% to 95% of each Video"
    )
)