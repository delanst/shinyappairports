library(shiny)
library(leaflet)
library(plyr)

airports <- read.csv("be-airports.csv", header = T)

shinyServer(function(input, output) {
  airportMarkers <- airports[-1,]
  airportMarkers[colSums(!is.na(airportMarkers)) > 0]
  airportMarkers <- rename(airportMarkers, c("latitude_deg"="lat", "longitude_deg"="lng", "name"="popup"))
  
  output$table <- renderTable({
    selectedData <- subset(airportMarkers,
      (airportMarkers$type == "large_airport" & input$large) |
      (airportMarkers$type == "medium_airport" & input$medium) |
      (airportMarkers$type == "small_airport" & input$small) |
      (airportMarkers$type == "heliport" & input$heli) |
      (airportMarkers$type == "closed" & input$closed) 
    )
    selectedData
  })
  
  output$mymap <- renderLeaflet({
    large <- airportMarkers[airportMarkers$type == "large_airport", ]
    medium <- airportMarkers[airportMarkers$type == "medium_airport", ] 
    small <- airportMarkers[airportMarkers$type == "small_airport", ]
    heli <- airportMarkers[airportMarkers$type == "heliport", ]
    closed <- airportMarkers[airportMarkers$type == "closed", ]
    
     leaflet() %>%
      addProviderTiles("Esri.WorldImagery") %>%
      addMarkers(data = large, popup = large$popup, group = "Large", icon = greenLeafIcon) %>% 
      addMarkers(data = medium, popup = medium$popup, group = "Medium") %>%
      addMarkers(data = small, popup = small$popup, group = "Small") %>%
      addMarkers(data = heli, popup = heli$popup, group = "Heliport") %>%
      addMarkers(data = closed, popup = closed$popup, group = "Closed") %>%
      setView(lat=50.901401519800004, lng=4.48443984985, zoom=7) %>%
       addLayersControl(
         overlayGroups = c("Large", "Medium", "Small", "Heliport", "Closed"),
         options = layersControlOptions(collapsed = FALSE)
       )
  })
})