#' Plot Flight Paths
#'
#'
#'Plot multiple flights with `plot_flights`. This function produces a html object so in order to save the image as an .svg (for printable visuals) check out the `save_map_svg()`.
#'
#'For more information on how to integrate the MapBox API to make beautiful maps, check out [this blog](https://bensstats.wordpress.com/2021/10/25/robservations-16-using-the-mapbox-api-with-leaflet/).
#'
#' @param addresses The locations which you want to plot your flight route. ORDER MATTERS so be sure to list the locations in the order you want to plot the flight path.
#' @param colour The colour of the points and route. By default set to "black"
#' @param opacity Opacity of the points and route on the map
#' @param weight Line thickness
#' @param radius Point size
#' @param label_text Alternative text to display as the address labels.
#' @param label_position where to place the label relative to the point
#' @param font font-family css property
#' @param font_weight font-weight css property
#' @param font_size font-size css property
#' @param text_indent text indent css property
#' @param mapBoxTemplate The MapBox template you want to use.
#' @param nCurves flight path smoothness. I have found setting this to 100 works best, but feel free to play around with it.
#' @importFrom magrittr %>%
#' @importFrom tibble tibble
#' @importFrom tidygeocoder geocode
#' @importFrom dplyr transmute
#' @importFrom geosphere gcIntermediate
#' @import leaflet
#' @export
#' @examples
#' plot_flights(c("YYZ",
#' "GIG",
#' "CPT/FACT",
#' "BOM",
#' "TLV"),
#' weight = 1,
#' opacity = 1,
#' nCurves = 10,
#' label_position="right")
#'


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
