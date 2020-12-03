# CSC8631 Project

This project primarily investigates data from Newcastle University
on the engagement of learners with the online material of a free course ran
by the University. For the bulk of the analysis, we looked in particular
at the video-stats files, with some additional investigation into the  question-
response files. The resulting plots from this investigation can be viewed by running the
shiny app in CSC8631 Presentation.R located in the same directory as this README
file.

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

In the munge sub-directory:

  01-A.R is the data preparation file for the video-stats data
  
  02-B.R is the data preparation file for the question-response data

  03-C.R is the calculation of missing data in the enrolments files

In the src sub-directory:

  data_understanding.R performs several checks on data files using helper functions
  
  q_vs_vid_analysis.R has plots of % of questions answered correctly compared with
  videos viewed over runs
  
  vid_analysis.R investigates video viewing statistics for each video
  
  dur_analysis.R looks at the effect of video duration on viewing statistics
  
In the lib sub-directory:

  helpers.R contains functions that make basic checks on multiple files in the data
  sub-directory
  
In the reports sub-directory:

  rmarkdown report on project and pdf file associated with this
  
In the data sub-directory:

  data files used in project
  

