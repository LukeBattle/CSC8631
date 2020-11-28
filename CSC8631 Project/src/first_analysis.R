library(ProjectTemplate)
load.project()
library(dlookr)

#plot graph, showing changing viewing percentage per run
run_plot = ggplot(data = viewing_avg_long, aes(x = viewed, y = percentage, color = factor(Run))) + 
  geom_point() +
  geom_line()  

run_plot

run_plot2 = ggplot(data = filter(viewing_avg_long,viewed ==95), aes(x = Run, y = percentage, color = factor(viewed))) + 
  geom_point() +
  geom_line()  

run_plot2

#plot graph, showing changing viewing percentage per run
step_plot = ggplot(data = step_avg_long,aes(x = viewed, y = percentage, color = factor(step_position))) + 
  geom_point() +
  geom_line()

lost_viewer_plot = ggplot(data = step_avg_wide, aes(x = factor(step_position), y = percentage_drop_off)) + 
  geom_col()

lost_viewer_plot

question_plot = ggplot(data = filter(correct_questions, Runs >= min(video_df$Run)), aes(x = Runs, y = percentage_correct)) +
  geom_point() + 
  geom_line()
  
question_plot

grid.arrange(question_plot,run_plot2,nrow = 2)


unique(video_df$video_duration)
