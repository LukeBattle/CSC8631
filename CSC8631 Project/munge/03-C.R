#create vector of enrolment files in data directory of project
enrolment_files = dir("data",pattern = "enrolment")

#initialise empty vector with length equivalent number of enrolment files
percentage_of_missing_enrolments = numeric(length(enrolment_files))

#for each enrolment file in directory calculate percentage of lines with all "unknown" and store in percentage_of_missing_enrolments
#vector
for (file in 1:length(enrolment_files)) {
  enrolment_df = read.csv(paste("data/",enrolment_files[file],sep = ""))
  missing_data = sum(enrolment_df$gender == "Unknown" & enrolment_df$country == "Unknown" & enrolment_df$age_range == "Unknown" &
                       enrolment_df$highest_education_level == "Unknown" & enrolment_df$employment_status =="Unknown"&
                       enrolment_df$employment_area == "Unknown", na.rm = TRUE)
  percentage_of_missing_enrolments[file] = missing_data/length(enrolment_df$learner_id) *100
}

#store percentage of missing enrolments vector in cache
cache('percentage_of_missing_enrolments')



