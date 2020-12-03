
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
