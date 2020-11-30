library(ProjectTemplate)
load.project()
library(dlookr)


#plot graph, showing changing viewing percentage per run
run_plot = ggplot(data = viewing_avg_long, aes(x = viewed, y = percentage, color = factor(Run))) + 
  geom_point() +
  geom_line()  

run_plot

run_plot_TEST  = ggplot(data = video_df_long, aes(x = viewed, y = value, color = factor(Run))) +  
  stat_summary(fun = mean, geom = "line")
  

run_plot_TEST

run_plot2 = ggplot(data = filter(viewing_avg_long,viewed ==95), aes(x = Run, y = percentage)) + 
  geom_point() +
  geom_line()  + 
  labs(
    x = "Run of Course",
    y = "Percentage of Course Users",
    title = "The Percentage of Users who Watched 95% of the Course Videos for each Run of the Course"
  )

run_plot2

run_plot3_TEST = ggplot(data = filter(video_df_long,viewed ==95), aes(x = Run, y = value)) + 
  stat_summary(fun = "mean", geom = "line") +
  labs(
    x = "Run of Course",
    y = "Percentage of Course Users",
    title = "The Percentage of Users who Watched 95% of the Course Videos for each Run of the Course"
  )

run_plot3_TEST


#plot graph, showing changing viewing percentage per run
(step_plot = ggplot(data = video_df_long, aes(x = viewed, y = value, color = factor(step_position))) +  
  stat_summary(fun = mean, geom = "line")) + 
  labs(
    x = "Percentage of the Video Viewed",
    y = "Percentage of Course Users"
  )


#filtered step_plot
(step_plot_filtered = ggplot(data = filter(video_df_long, step_position %in% highest_audience_drop_videos), aes(x = viewed, y = value, color = factor(step_position))) +  
  stat_summary(fun = mean, geom = "line") + 
  labs(
    x = "Percentage of the Video Viewed",
    y = "Percentage of Course Users"
  ))
  
  
#plotting 

duration_plot = ggplot(data = filter(video_df_long, viewed == 95), aes(x = video_duration, y = value)) +  
  stat_summary(fun = mean, geom = "line") + 
  stat_summary(fun = mean, geom = "point") 

lost_viewer_plot = ggplot(data = video_df, aes(x = factor(step_position), y = percentage_drop_off)) + 
  stat_summary(fun = mean, geom = "col")


question_plot = ggplot(data = filter(correct_questions, Runs >= min(video_df$Run)), aes(x = Runs, y = percentage_correct)) +
  geom_point() + 
  geom_line()
  
question_plot

grid.arrange(question_plot,run_plot2,nrow = 2)


unique(video_df$video_duration)
