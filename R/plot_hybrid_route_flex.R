#' Plot Hybrid Route With More Flexibility
#'
#'DISCLAIMER: the `_flex()` functions offer more flexibility in label placement and will offer new features under development for the `mapBliss` package. These functions will be subject to change more regularly than the standard functions.
#'
#'DOCUMENTATION IS NEEDED
#'
#'Plot multiple stops on a route `plot_hybrid route_flex()`. This function produces a html object so in order to save the image as an .svg (for printable visuals) check out the `save_map_svg()`. This function differs from `plot_route_flex()`  and `plot_flights_flex()`  as it accommodates a hybrid route where some locations are traveled via flight and others are traveled via car, bike or foot.
#'
#'@param addresses The stops on your route
#'@param how Routing profile(s) to use, e.g. "car", "bike" or "foot" (when using the routing.openstreetmap.de test server) AND "flight". n-1 routing profiles are required for for n addresses
#'@param colour  what colour you want the route line to be colored
#'@param opacity line opacity - a value between 0 and 1
#'@param weight Line thickness
#'@param radius Point size
#'@param label_text Optional. Alternative text to display as the address labels.
#'@param label_position where to place each of the labels relative to the points ("bottom", "top", "left", "right")
#'@param font font-family css property
#'@param font_weight font-weight css property
#'@param font_size font-size css property
#'@param text_indent text indent css property
#'@param mapBoxTemplate The MapBox template you want to use.
#'@param nCurves flight path smoothness. I have found setting this to 100 works best, but feel free to play around with it.
#'@param zoomControl The zoom control for your bounding box. Default Format is `c(lng1,lat1,lng2,lat2)`
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
#'
#'@examples
#'viz_1<-plot_hybrid_route_flex(addresses=c("Amsterdam","London","Newcastle upon Tyne"),
#'                         how=c("car","car"),
#'                         weight=3,
#'                         colour="red",
#'                         label_position = c("left","left","left"),
#'                         text_indent= c("-6em","-5em","-13em"),
#'                         mapBoxTemplate="//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
#'                         )
#'viz_1

plot_hybrid_route_flex<- function(addresses,
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
                             nCurves=100,
                             zoomControl=c(0.1,0.1,-0.1,-0.1)){

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
      roadTrip<-osrmRoute(src=address_single[i,2:3] %>% c  %>% unlist,
                            dst=address_single[i+1,2:3] %>% c  %>% unlist,
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
    fitBounds(lng1 = max(address_single$lon)+zoomControl[1],
              lat1 = max(address_single$lat)+zoomControl[2],
              lng2 = min(address_single$lon)+zoomControl[3],
              lat2 = min(address_single$lat)+zoomControl[4]) %>%
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
                 weight=weight)

  for(i in 1:nrow(address_single)){

    m <- m %>%
      addLabelOnlyMarkers(
        address_single$lon[i],
        address_single$lat[i],
        label =  label_text[i],
        labelOptions =labelOptions(
          noHide = T,
          direction = label_position[i],
          textOnly = T,
          style =
            list(
              "font-family" = font,
              "font-weight" = font_weight,
              "font-size" = font_size,
              "padding" = text_indent[i],
              "color" = colour
            )
        )
      )
  }

  m
}


