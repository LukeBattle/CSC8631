check_empty = function (files) {
  empty_flag = logical(length(files))
  for (i in 1:length(files)) {
    temp_file = read.csv(paste("data/",files[i],sep = ""))
    empty_flag[i] = ifelse(dim(temp_file)[1] == 0, TRUE, FALSE)
  }
  
  return(paste(sum(as.integer(empty_flag)), "out of",length(files), "files are empty"))                     
             
}
  
check_dimensions = function (files, dimensions) {
  dims_equal = logical(length(files))
  for (i in 1:length(files)) {
    temp_file = read.csv(paste("data/",files[i],sep = ""))
    dims_equal[i] = ifelse(all(dim(temp_file) == dimensions),TRUE,FALSE)
  }
  return_string = ifelse(all(dims_equal), "All files have same dimensions", "Not all files have same dimensions")
  return(return_string)
  
}

check_variables = function (files, variables) {
  variables_equal = logical(length(files))
  for (i in 1:length(files)) {
    temp_file = read.csv(paste("data/",files[i],sep = ""))
    variables_equal[i] = ifelse(all(colnames(temp_file)==variables),TRUE,FALSE)
  }
  return_string = ifelse(all(variables_equal), "All files have same variables", "Not all files have same variables")
  return(return_string)
}

check_rows = function (files, rows, column_number){
  rows_equal = logical(length(files))
  for (i in 1:length(files)) {
    temp_file = read.csv(paste("data/",files[i],sep = ""))
    rows_equal[i] = ifelse(all(temp_file[,column_number]==rows),TRUE,FALSE)
  }
  return_string = ifelse(all(rows_equal), "All files have same rows", "Not all files have same rows")
  return(return_string)
}


