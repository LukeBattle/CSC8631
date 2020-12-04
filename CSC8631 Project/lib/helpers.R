#loop through multiple files to check if they are empty, only requiring vector
#of filenames in data sub-directory as input
check_empty = function (files) {
  empty_flag = logical(length(files))
  for (i in 1:length(files)) {
    temp_file = read.csv(paste("data/",files[i],sep = ""))
    empty_flag[i] = ifelse(dim(temp_file)[1] == 0, TRUE, FALSE)
  }
  
  return(paste(sum(as.integer(empty_flag)), "out of",length(files), "files are empty"))                     
             
}

#loop through multiple files to check if they are have the same dimensions as the "dimensions" input, requiring vector
#of filenames in data sub-directory and dimensions to check against as input
check_dimensions = function (files, dimensions) {
  dims_equal = logical(length(files))
  for (i in 1:length(files)) {
    temp_file = read.csv(paste("data/",files[i],sep = ""))
    dims_equal[i] = ifelse(all(dim(temp_file) == dimensions),TRUE,FALSE)
  }
  return_string = ifelse(all(dims_equal), "All files have same dimensions", "Not all files have same dimensions")
  return(return_string)
  
}

#loop through multiple files to check if they are have the same variables as the "variables" input, requiring vector
#of filenames in data sub-directory and variables to check against as input
check_variables = function (files, variables) {
  variables_equal = logical(length(files))
  for (i in 1:length(files)) {
    temp_file = read.csv(paste("data/",files[i],sep = ""))
    variables_equal[i] = ifelse(all(colnames(temp_file)==variables),TRUE,FALSE)
  }
  return_string = ifelse(all(variables_equal), "All files have same variables", "Not all files have same variables")
  return(return_string)
}

#loop through multiple files to check if they are have the same rows as the "rows" input, requiring vector
#of filenames in data sub-directory, rows to check against and column number of comparison as input
check_rows = function (files, rows, column_number){
  rows_equal = logical(length(files))
  for (i in 1:length(files)) {
    temp_file = read.csv(paste("data/",files[i],sep = ""))
    rows_equal[i] = ifelse(all(temp_file[,column_number]==rows),TRUE,FALSE)
  }
  return_string = ifelse(all(rows_equal), "All files have same rows", "Not all files have same rows")
  return(return_string)
}

#loop through multiple files to check if they to count missing data,only requiring vector
#of filenames in data sub-directory as input
multiple_file_quality = function (files) {
  missing_data = numeric(length(files))
  for (i in 1:length(files)) {
    temp_file = read.csv(paste("data/",files[i],sep = ""))
    temp_diagnosis = diagnose(temp_file)
    missing_data[i] = sum(temp_diagnosis$missing_count)
  }
  return(paste("Total Missing Count:", sum(missing_data)))
}
  
