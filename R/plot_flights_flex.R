#' Plot Flight Paths With More Flexibility
#'
#'DISCLAIMER: the `_flex()` functions offer more flexibility in label placement and will offer new features under development for the `mapBliss` package. These functions will be subject to change more regularly than the standard functions.
#'
#'DOCUMENTATION IS NEEDED
#'
#'Plot multiple flights with `plot_flights_flex()`. This function produces a html object so in order to save the image as an .svg (for printable visuals) check out the `save_map_svg()`.
#'
#'For more information on how to integrate the MapBox API to make beautiful maps, check out [this blog](https://bensstats.wordpress.com/2021/10/25/robservations-16-using-the-mapbox-api-with-leaflet/).
#'
#' @param addresses The locations which you want to plot your flight route. ORDER MATTERS so be sure to list the locations in the order you want to plot the flight path.
#' @param colour The colour of the points and route. By default set to "black"
#' @param opacity Opacity of the points and route on the map
#' @param weight Line thickness
#' @param radius Point size
#' @param label_text Alternative text to display as the address labels.
#' @param label_position where to place each of the labels relative to the points
#' @param font font-family css property
#' @param font_weight font-weight css property
#' @param font_size font-size css property
#' @param text_indent text indent css property
#' @param mapBoxTemplate The MapBox template you want to use.
#' @param nCurves flight path smoothness. I have found setting this to 100 works best, but feel free to play around with it.
#' @param zoomControl The zoom control for your bounding box. Format is `c(lng1,lat1,lng2,lat2)`
#' @importFrom magrittr %>%
#' @importFrom tibble tibble
#' @importFrom tidygeocoder geocode
#' @importFrom dplyr transmute
#' @importFrom geosphere gcIntermediate
#' @import leaflet
#' @export
#' @examples
#' plot_flights_flex(c("YYZ",
#' "GIG",
#' "CPT/FACT",
#' "BOM",
#' "TLV"),
#' weight = 1,
#' opacity = 1,
#' nCurves = 10,
#' label_position="right")
#'


plot_flights_flex<-function(addresses,
                       colour="black",
                       opacity=1,
                       weight=1,
                       radius=2,
                       label_text=addresses,
                       label_position=c("bottom","top","left","right"),
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
    fitBounds(lng1 = max(address_single$lon)+zoomControl[1],
              lat1 = max(address_single$lat)+zoomControl[2],
              lng2 = min(address_single$lon)+zoomControl[3],
              lat2 = min(address_single$lat)+zoomControl[4]) %>%
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
                 smoothFactor = 0)

  for(i in 1:nrow(address_single)){

    m <- m %>%
      addLabelOnlyMarkers(
        address_single$lon[i],
        address_single$lat[i],
        label =  label_text[i],
        labelOptions = labelOptions(
          noHide = T,
          direction = label_position[i],
          textOnly = T,
          style =
            list(
              "font-family" = font,
              "font-weight" = font_weight,
              "font-size" = font_size,
              "padding" = text_indent[i]
            )
        )
      )
  }


  m
}


