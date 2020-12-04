
#align plot titles in centre
theme_update(plot.title = element_text(hjust = 0.5))

#plot graph, showing changing viewing percentage per run
(run_plot  = ggplot(data = video_df_long, aes(x = viewed, y = value, color = factor(Run))) +  
  stat_summary(fun = mean, geom = "line") +
    stat_summary(fun = mean, geom = "point") +
    labs(
      x = "% Video",
      y = "% Learners Viewing Video", 
      color = "Course Run",
      title = "% of Learners Viewing Videos for each Course Run"
    ))
  
#plot viewing percentage per run for 95% of video viewed
(run_plot2= ggplot(data = filter(video_df_long,viewed ==95), aes(x = Run, y = value)) + 
  stat_summary(fun = "mean", geom = "line") +
  stat_summary(fun = "mean", geom = "point") +  
  labs(
    x = "Course Run",
    y = "% Learners Viewing Video",
    title = "% Learners that Watched 95% of all Videos for each Course Run"
  ))

  
#plotting variation in percentage of questions answered correctly over course runs
(question_plot = ggplot(data = filter(correct_questions, Runs >= min(video_df$Run)), aes(x = Runs, y = percentage_correct)) +
  geom_point() + 
  geom_line() +
    labs(
      x = "Course Run",
      y = "% Correct Answers",
      title = "% of Questions Answered Correctly for each Course Run"
    ))
  



