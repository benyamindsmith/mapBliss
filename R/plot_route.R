#' Plot Road Trip Route
#'
#' Documentation is needed
#'
#'For more information on how to integrate the MapBox API to make beautiful maps, check out [this blog](https://bensstats.wordpress.com/2021/10/25/robservations-16-using-the-mapbox-api-with-leaflet/).
#'
#'
#' @param addresses
#' @param how
#' @param colour
#' @param opacity
#' @param weight
#' @param radius
#' @param label_text
#' @param label_position
#' @param provider
#' @param font
#' @param font_weight
#' @param font_size
#' @param text_indent
#' @param saturation
#' @param MapBoxTemplate
#' @importFrom osrm osrmRoute
#' @importFrom sf st_geometry
#' @export
#' @examples
#'
#' viz<- plot_route(c("Toronto","Niagara Falls","Monsey"),
#'                   how="car",
#'                   font="Courier",
#'                   label_position="right",
#'                   weight=1.5)
#'
#' viz
#'



plot_route<-function(addresses,
                      how="car",
                      colour="black",
                      opacity=1,
                      weight=1,
                      radius=2,
                      label_text=addresses,
                      label_position="bottom",
                      provider=providers$CartoDB.PositronNoLabels,
                      font = "Lucida Console",
                      font_weight="bold",
                      font_size= "14px",
                      text_indent="15px",
                      saturation=0,
                      mapBoxTemplate= "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"){

  address_single <- tibble(singlelineaddress = addresses) %>%
    geocode(address=singlelineaddress,method = 'arcgis') %>%
    transmute(id = singlelineaddress,
              lon=long,
              lat=lat)


  trip <- list()

  for(i in 1:(nrow(address_single)-1)){
    trip[[i]] <- osrmRoute(src=address_single[i,2:3] %>% c,
                           dst=address_single[i+1,2:3] %>% c,
                           returnclass="sf",
                           overview="full",
                           osrm.profile = how )
  }
  trip<-do.call(rbind,trip)

  trip<-do.call(rbind,st_geometry(trip)) %>%
    as_tibble(.name_repair = "unique") %>%
    set_names(c("lon","lat")) %>%
    as.data.frame() %>%
    as.matrix()

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
