library(ProjectTemplate)
load.project()

theme_update(plot.title = element_text(hjust = 0.5))

#plot graph, showing changing viewing percentage per run
(run_plot  = ggplot(data = video_df_long, aes(x = viewed, y = value, color = factor(Run))) +  
  stat_summary(fun = mean, geom = "line") +
    labs(
      x = "% Video",
      y = "% Learners Viewing Video", 
      color = "Course Run",
      title = "% of Learners Viewing Videos for each Course Run"
    ))
  

(run_plot2= ggplot(data = filter(video_df_long,viewed ==95), aes(x = Run, y = value)) + 
  stat_summary(fun = "mean", geom = "line") +
  stat_summary(fun = "mean", geom = "point") +  
  labs(
    x = "Course Run",
    y = "% Learners Viewing Video",
    title = "% Learners that Watched 95% of all Videos for each Course Run"
  ))



#plot graph, showing changing viewing percentage per run
step_plot = ggplot(data = video_df_long, aes(x = viewed, y = value, color = factor(step_position))) +  
  stat_summary(fun = mean, geom = "line") + 
  labs(
    x = "% Video",
    y = "% Learners Viewing Video",
    color = "Video",
    title = "% Learners that Viewed Each Video"
  )


#filtered step_plot
(step_plot_filtered = ggplot(data = filter(video_df_long, step_position %in% highest_audience_drop_videos), 
                             aes(x = viewed, y = value, color = factor(step_position))) +  
  stat_summary(fun = mean, geom = "line") + 
  labs(
    x = "% Video",
    y = "% Learners Viewing Video",
    color = "Video",
    title = "% of Learners that Viewed 5 Least Watched Videos"
  ))
  
  
#plotting 

(duration_plot = ggplot(data = filter(video_df_long, viewed == 95), aes(x = video_duration, y = value)) +  
  stat_summary(fun = mean, geom = "line") + 
  stat_summary(fun = mean, geom = "point") + 
  labs(
    x = "Video Duration (seconds)",
    y = "% Learners Viewing Video",
    title = "% of Learners Viewing 95% of Videos vs Video Duration"
  ))

(lost_viewer_plot = ggplot(data = video_df, aes(x = factor(step_position), y = percentage_drop_off)) + 
  stat_summary(fun = mean, geom = "col") + 
    labs(
      x = "Video",
      y = "% Decline in Learners Viewing Video",
      title = "% Decline in Learners Viewing from 5% to 95% of each Video"
    )
)

(question_plot = ggplot(data = filter(correct_questions, Runs >= min(video_df$Run)), aes(x = Runs, y = percentage_correct)) +
  geom_point() + 
  geom_line() +
    labs(
      x = "Course Run",
      y = "% Correct Answers",
      title = "% of Questions Answered Correctly for each Course Run"
    ))
  

grid.arrange(question_plot,run_plot2,nrow = 2)


