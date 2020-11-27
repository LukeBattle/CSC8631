#convert to wide and calculate
step_avg_wide = step_avg_long %>%
  spread(viewed,percentage) %>%
  rename(c("viewed_5" = "5" , "viewed_10" = "10", "viewed_25" = "25",
           "viewed_50"="50","viewed_75"="75","viewed_95"="95","viewed_100"="100")) %>%
 mutate(percentage_drop_off = viewed_5 - viewed_95)

cache('step_avg_wide')

#investigate proportion of correct answers per run
Runs = sort(unique(question_df$Run), decreasing = FALSE)

percentage_correct = numeric(length(Runs))
for (i in sort(unique(question_df$Run),decreasing = FALSE)) {
  filtered_q_df = filter(question_df,Run == i)
  total = nrow(filtered_q_df)
  question_correct = sum(filtered_q_df$correct_binary)
  percentage_correct[i] = (question_correct/total) *100
  rm(filtered_q_df,total,question_correct)
}

correct_questions = as.data.frame(cbind(Runs,percentage_correct))


cache('correct_questions')