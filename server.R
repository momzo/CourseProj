## Coursera Data Science Specialization
#  Class: Delivering Data Products
#
#  Author: Richard Ian Carpenter
#  Date Created: 14 Dec 2015
#  Data Updated: 16 Jan 2016
#
## NOTES: 
#
## I am repeating this course, unrolled from Dec 2015 course due to work obligations.
#
## Beyond the notes and videos for the class and the Shiny website, I used the 
#  following:
#
## This Stack Overflow question from 2013 helped with correcting my R code:
#  http://stackoverflow.com/questions/18762962/passing-variable-names-to-model-in-shiny-app
#  
## This shiny example to get the regression output to be in the same format
#  that R uses, instead of a table: https://rich.shinyapps.io/regression/
#
## My question on Stack Overflow to get help with ggplot2 plot output:
#  http://stackoverflow.com/questions/34638844/no-plot-outout-from-ggplot2-in-shiny-app
#

library(shiny)
library(ggplot2)
library(markdown)
data("mtcars")

mtcars <- mtcars    

server <- (function(input, output) {
      
        output$independent <- renderUI({
                            checkboxGroupInput(
                               "independent", "Independent Variables:",
                               names(mtcars)[!names(mtcars) %in% input$dependent],
                               
                               if(input$factor) {
                                   mtcars$cyl <- as.factor(mtcars$cyl)
                                   mtcars$vs <- as.factor(mtcars$vs)
                                   mtcars$am <- as.factor(mtcars$am)
                                   mtcars$gear <- as.factor(mtcars$gear)
                                   mtcars$carb <- as.factor(mtcars$carb)
                               }
                               
                               )
                            })
      
      regression <- reactive({
                       lm(paste(input$dependent," ~ ",
                          paste(input$independent,
                                collapse = " + ")),
                          data = mtcars)
                    })
      
      output$regPlot <- # reactive({
          
            renderPlot({
                if(!is.null(input$independent)) {
                        p <- ggplot(regression(), 
                             aes_string(x = paste(input$independent, collapse = " + "), 
                                 y = input$dependent)
                             )
                        
                        p <- p + geom_point(size = 3) +
                                    geom_smooth(method = "lm", se = FALSE) +
                                    theme(panel.grid.major = element_line("black"),
                                          panel.grid.minor = element_blank(),
                                          panel.background = element_rect("white"),
                                          axis.text = element_text(colour = "black"))
                            
                        print(p)
                        
                } else {
                    print("Please select the model's dependent and independent variables.")
                }
            }, height = 550)
      
      output$regSummary <- renderPrint({
                         if(!is.null(input$independent)){
                                    summary(regression())
                         } else {
                              print("Please select the model's dependent and independent variables.")
                         }
                        })
      
#      output$vehicle <- renderText({
#                            car_name <- row.names(mtcars)
#                            paste0("Vehicle: ", input$plot_click$car_name)
#                        })

})