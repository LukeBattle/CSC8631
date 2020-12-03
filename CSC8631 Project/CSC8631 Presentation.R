library(shiny)
source("src/q_vs_vid_analysis.R")
source("src/vid_analysis.R")
source("src/dur_analysis.R")


ui = tabsetPanel(
    tabPanel("Motivation",fluidPage(splitLayout(cellWidths = c("50%","50%"),
                                      plotOutput("Run_Plot_1"),plotOutput("Question_Plot")))),
        
    tabPanel("Video Analysis", fluidPage(fluidRow(plotOutput("video_plots"))),
             fluidRow(column(5,offset = 3, tableOutput("table")))),
                                      
    tabPanel("Duration Analysis", fluidPage(plotOutput("duration_plot")))
             
)
  
     
  

server = function(input,output) {
  
  output$Run_Plot_1 = renderPlot(run_plot)
  output$Question_Plot = renderPlot({grid.arrange(question_plot,run_plot2,nrow = 2)})
  output$video_plots = renderPlot({grid.arrange(lost_viewer_plot,step_plot_filtered,ncol = 2)})
  output$duration_plot = renderPlot(duration_plot)
  output$table = renderTable(highest_audience_drop_shiny)

}

shinyApp(ui = ui, server = server)