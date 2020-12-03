# CSC8631 Project

This project primarily investigates data from Newcastle University
on the engagement of learners with the online material of a free course ran
by the University. For the bulk of the analysis, we will look in particular
at the video-stats files, with some additional investigation into the  question-
response files.

To load this project, you'll first need to `setwd()` into the directory
where this README file is located. Then you need to run the following two
lines of R code:

	library('ProjectTemplate')
	load.project()

If you want to reload the cache, you can delete what is currently in there
and in the config file in the config sub-directory, set munge = TRUE before
using load.project().

If you want to add any new video-stats or question-response files to this data 
analysis pipeline, please ensure that the both the file name is in the same
format and the variables are the same as they are in the files currently in the
data sub-directory, 