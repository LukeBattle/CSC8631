context('Video file checks')

video_files = dir("data",pattern = "video-stats")

#test columns of each video stats file
for (file in 1:length(video_files)) {
  video_stats_file = read.csv(paste("data/",video_files[file],sep = ""))
  test_that("Columns are the same in each video file and as previous",
            expect_equal(colnames(video_stats_file),video_col_names))

}
  

