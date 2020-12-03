check_empty = function (files) {
  empty_flag = logical(length(files))
  for (i in 1:length(files)) {
    temp_file = read.csv(paste("data/",files[i],sep = ""))
    empty_flag[i] = ifelse(dim(temp_file)[1] == 0, TRUE, FALSE)
  }
  
  return(paste(sum(as.integer(empty_flag)), "out of",length(files), "files are empty"))                     
             
}
  

unique_videos = function (files) {
  video_durations = numeric(13)
  for (i in 1:length(files)) {
    video_file = read.csv(paste("data/",files[i],sep = ""))
    if (sum(video_durations) == 0) video_durations = unique(video_file$video_duration)
    
    
  }
  
}