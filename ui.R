## Coursera Data Science Specialization
#  Class: Delivering Data Products
#
#  Author: Richard Ian Carpenter
#  Date Created: 14 Dec 2015
#  Data Updated: 09 Jan 2016
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

ui <- fluidPage(
      sidebarPanel(
            selectInput("dependent", "Dependent Variable:", c(names(mtcars))),
            uiOutput("independent"),
            checkboxInput("factor", "Create factor variables (am, cyl, etc.)?")
      ),
      
      mainPanel(
            tabsetPanel(
                tabPanel("Application Introduction",
                        includeMarkdown("appIntro.md")),
                tabPanel("Regression Summary", 
                        verbatimTextOutput("regSummary")),
                tabPanel("Regression Plot",
                         plotOutput("regPlot"))
                
#                tabPanel("Regression Plot",
#                        plotOutput("regPlot", click = "plot_click"),
#                        fluidRow(
#                           column(width = 8,
#                           verbatimTextOutput("vehicle")))

                )
            )
)
