library(shiny)
library(leaflet)

shinyUI(fluidPage(
  
  titlePanel("Belgium airports"),
  p("Here follows a map of all the airports in Belgium."),
  p("The data used for has been download from the following site with their many thanks."),
  a("HDX", "https://data.humdata.org/dataset/ourairports-bel"),
  br(),br(),
  strong(p("Two tabs have been created first is a table that can be filtered by the type of airport.")), 
  strong(p("The second is a leaflet plot of the airports in Belgium which you filter by type of airport.")),
  br(),br(),
  tabsetPanel(
    tabPanel("Airport list", 
      sidebarLayout(
        sidebarPanel(
          em(p("Select or deselect the type of airports which you want to see or not.")),
          checkboxInput(inputId = "large",
                        label = "Large", 
                        value = TRUE),
          checkboxInput(inputId = "medium",
                        label = "Medium",
                        value = TRUE),
          checkboxInput(inputId = "small",
                        label = "Small",
                        value = TRUE),
          checkboxInput(inputId = "heli",
                        label = "Heliport",
                        value = TRUE),
          checkboxInput(inputId = "closed",
                        label = strong("Closed airports"),
                        value = TRUE)       
        ),
        mainPanel(
          em(p("List of airports meaeting your criteria.")),
          tableOutput("table")
        )
    )),
    tabPanel("Leaflet airports", 
             strong("This is map with all airports in Belgium. These include international, small, heliports and closed airports."),br(),br(),
             em("Select or deselect the type of airports which you want to see."),
             leafletOutput("mymap")
    )
  )
  
))
