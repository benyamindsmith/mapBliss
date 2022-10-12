#' Plot Hybrid Route
#'
#' Documentation is needed

plot_hybrid_route<- function(addresses,
                             how=c("car",...),
                             colour="black",
                             opacity=1,
                             weight=1,
                             radius=2,
                             label_text=addresses,
                             label_position="bottom",
                             font = "Lucida Console",
                             font_weight="bold",
                             font_size= "14px",
                             text_indent="15px",
                             mapBoxTemplate= "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"){
  message("This function is still in development")

  address_single <- tibble(singlelineaddress = addresses) %>%
    geocode(address=singlelineaddress,method = 'arcgis') %>%
    transmute(id = singlelineaddress,
              lon=long,
              lat=lat)



  m<-leaflet(trip,
             options = leafletOptions(zoomControl = FALSE,
                                      attributionControl=FALSE)) %>%
    fitBounds(lng1 = max(address_single$lon)+0.1,
              lat1 = max(address_single$lat)+0.1,
              lng2 = min(address_single$lon)-0.1,
              lat2 = min(address_single$lat)-0.1) %>%
    addTiles(urlTemplate = mapBoxTemplate) %>%
    addCircleMarkers(lat = address_single$lat,
                     lng = address_single$lon,
                     color = colour,
                     stroke = TRUE,
                     radius = radius,
                     fillOpacity = opacity) %>%
    addPolylines(lng=trip[,1],
                 lat=trip[,2],
                 color = colour,
                 opacity=opacity,
                 weight=weight) %>%
    addLabelOnlyMarkers(address_single$lon,
                        address_single$lat,
                        label =  label_text,
                        labelOptions = labelOptions(noHide = T,
                                                    direction = label_position,
                                                    textOnly = T,
                                                    style=list("font-family" = font,
                                                               "font-weight"= font_weight,
                                                               "font-size"=font_size,
                                                               "text-indent"=text_indent)))

  m
}
