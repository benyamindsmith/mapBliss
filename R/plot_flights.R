#' Plot Flight Paths
#'
#'
#'Plot multiple flights with `plot_flights`. This function produces a html object so in order to save the image as an .svg (for printable visuals) check out the `save_map_svg()`.
#'
#'@param addresses
#'@param color
#'@param opacity
#'@param weight
#'@param radius
#'@param label_text
#'@param label_position
#'@param font
#'@param font_weight
#'@param font_size
#'@param text_indent
#'@param mapBoxTemplate
#'@param nCurves
#'@export
#'@examples
#'plot_flights()


plot_flights<-function(addresses,
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
                       mapBoxTemplate= "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                       nCurves=100){

  address_single <- tibble(singlelineaddress = addresses) %>%
    geocode(address=singlelineaddress,method = 'arcgis') %>%
    transmute(id = singlelineaddress,
              lon=long,
              lat=lat)


  trip <- matrix(nrow=1,ncol=2)

  for(i in 2:nrow(address_single)){
    trip<-rbind(trip,
                gcIntermediate(address_single[i-1,2:3],
                               address_single[i,2:3],
                               n=nCurves,
                               addStartEnd = T) )
  }
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
                     stroke = FALSE,
                     radius = radius,
                     fillOpacity = opacity) %>%
    addPolylines(color = colour,
                 opacity=opacity,
                 weight=weight,
                 smoothFactor = 0) %>%
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
