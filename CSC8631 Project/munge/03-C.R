
enrolment_files = dir("data",pattern = "enrolment")

percentage_of_missing_enrolments = numeric(length(enrolment_files))
for (file in 1:length(enrolment_files)) {
  enrolment_df = read.csv(paste("data/",enrolment_files[file],sep = ""))
  missing_data = sum(enrolment_df$gender == "Unknown" & enrolment_df$country == "Unknown" & enrolment_df$age_range == "Unknown" &
                       enrolment_df$highest_education_level == "Unknown" & enrolment_df$employment_status =="Unknown"&
                       enrolment_df$employment_area == "Unknown", na.rm = TRUE)
  percentage_of_missing_enrolments[file] = missing_data/length(enrolment_df$learner_id) *100
}

cache('percentage_of_missing_enrolments')



