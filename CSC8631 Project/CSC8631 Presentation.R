library(shiny)
source("src/first_analysis.R")

ui = fluidPage(
  titlePanel("CSC8631 Project"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Choose a plot from the project to display"),
      
      selectInput("plot", 
                  label = "Choose a plot to display",
                  choices = c("Run of Course by % Viewed for Users",
                              "% of Questions Answered Correctly per Run",
                              "% of Users that Viewed 95% of Videos per Run",
                              "Questions vs Video Comparison",
                              "% of Video Viewed by Users per Video",
                              "% of Video Viewed by Users per Video (Least Retention)",
                              "Drop in Viewers per Video",
                              "Video Duration vs % of Users that viewed 95%"),
                  selected = "Run of Course by % Viewed for Users"),
      
    ),
    
    mainPanel(plotOutput("chosen_plot"))
  )
)
  

server = function(input,output) {
  
  output$chosen_plot = renderPlot({
    
    which_plot = switch(input$plot, 
                        "Run of Course by % Viewed for Users" = run_plot,
                        "% of Questions Answered Correctly per Run" = question_plot,
                        "% of Users that Viewed 95% of Videos per Run" = run_plot2,
                        "Questions vs Video Comparison" = grid.arrange(question_plot,run_plot2,nrow = 2),
                        "% of Video Viewed by Users per Video" = step_plot,
                        "% of Video Viewed by Users per Video (Least Retention)" = step_plot_filtered,
                        "Drop in Viewers per Video" = lost_viewer_plot,
                        "Video Duration vs % of Users that viewed 95%" = duration_plot
                        
    )
    which_plot})
}

shinyApp(ui = ui, server = server)