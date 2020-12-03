
check_empty(dir("data",pattern = "archetype-survey-responses"))
check_empty(dir("data",pattern = "video-stats"))
check_empty(dir("data",pattern = "question-response"))
check_empty(dir("data",pattern = "leaving-survey-responses"))
check_empty(dir("data",pattern = "weekly-sentiment-survey-responses"))
check_empty(dir("data",pattern = "team-members"))
check_empty(dir("data",pattern = "enrolments"))


check_dimensions(dir("data",pattern = "video-stats"), dim(video_file_raw))
check_dimensions(dir("data",pattern = "question-response"), dim(video_file_raw))

check_variables(dir("data",pattern = "video-stats"), colnames(video_file_raw))

check_rows(dir("data",pattern = "video-stats"),video_file_raw$title,2)

check_rows(dir("data",pattern = "video-stats"),video_file_raw$step_position,1)

multiple_file_quality(video_files)
multiple_file_quality(question_files)

missing_data = numeric(length(question_files))
for (i in 1:length(question_files)) {
  temp_file = read.csv(paste("data/",question_files[i],sep = ""))
  temp_diagnosis = diagnose(temp_file$cloze_response)
  missing_data[i] = sum(temp_diagnosis$missing_count)
}
sum(missing_data)

sum(is.na(question_file_raw$cloze_response))
