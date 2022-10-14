#' Plot Hybrid Route
#'
#'Plot multiple stops on a route `plot_hybrid route()`. This function produces a html object so in order to save the image as an .svg (for printable visuals) check out the `save_map_svg()`. This function differs from `plot_route()`  and `plot_flights()`  as it accomidates a hybrid route where some locations are traveled via flight and others are traveled via car, bike or foot.
#'
#'@param addresses The stops on your route
#'@param how Routing profile(s) to use, e.g. "car", "bike" or "foot" (when using the routing.openstreetmap.de test server) AND "flight". n-1 routing profiles are required for for n addresses
#'@param colour  what colour you want the route line to be colored
#'@param opacity line opacity - a value between 0 and 1
#'@param weight Line thickness
#'@param radius Point size
#'@param label_text Optional. Alternative text to display as the address labels.
#'@param label_position where to place the label relative to the point ("bottom", "top", "left", "right")
#'@param font font-family css property
#'@param font_weight font-weight css property
#'@param font_size font-size css property
#'@param text_indent text indent css property
#'@param nCurves flight path smoothness. I have found setting this to 100 works best, but feel free to play around with it.
#'@importFrom osrm osrmRoute
#'@importFrom sf st_geometry
#'@importFrom magrittr %>%
#'@importFrom tibble tibble
#'@importFrom tibble as_tibble
#'@importFrom tidygeocoder geocode
#'@importFrom dplyr transmute
#'@importFrom purrr set_names
#'@importFrom geosphere gcIntermediate
#'@import leaflet
#'@export
#'@examples
#'plot_hybrid_route(c("Detroit","Toronto","MKE"),
#'                  c("car","flight"))

plot_hybrid_route<- function(addresses,
                             how=c("car","flight","bike","foot"),
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


  for(i in 1:(nrow(address_single)-1)){
    if(how[i]=="flight"){
      trip<-rbind(trip,
                  gcIntermediate(address_single[i,2:3],
                                 address_single[i+1,2:3],
                                 n=nCurves,
                                 addStartEnd = T) )
    }else{
      roadTrip<-osrmRoute(src=address_single[i,2:3] %>% c,
                            dst=address_single[i+1,2:3] %>% c,
                            returnclass="sf",
                            overview="full",
                            osrm.profile = how[i])


      roadTrip<- do.call(rbind,st_geometry(roadTrip)) %>%
        as_tibble(.name_repair = "unique") %>%
        set_names(c("lon","lat")) %>%
        as.data.frame() %>%
        as.matrix()

      trip <- rbind(trip,
                    roadTrip)
    }

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
