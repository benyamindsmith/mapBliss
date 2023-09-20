#' Plot A City View Map
#'
#' Plot a city view with `plot_city_view`. This essentially applies a bounding box to the MapBox template of your choosing to make a beautiful map of your favorite city!
#'
#' @param city The city you want to get a view of.
#' @param mapBoxTemplate The MapBox template you want to use.
#' @param zoomControl The zoom control for your bounding box. Format is `c(lng1,lat1,lng2,lat2)`
#' @param icon A list containing details for your icon. Defaults to `list(show_icon=FALSE, icon_name="ios-close", icon_color="black", icon_library="ion", marker_color="red")`
#' @importFrom magrittr %>%
#' @importFrom tibble tibble
#' @importFrom tibble as_tibble
#' @importFrom tidygeocoder geocode
#' @importFrom dplyr transmute
#' @import leaflet
#' @export
#' @examples
#'
#' plot_city_view("New York City")
#'
#' plot_city_view("Paris", icon=list(show_icon=TRUE, icon_name="ion-heart", icon_color="white", icon_library="ion", marker_color="red"))
#'
#' plot_city_view("Amsterdam", zoomControl=c(0.01,0.01,-0.01,-0.01))

plot_city_view<-function(city,
                         mapBoxTemplate= "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                         zoomControl=c(0.1,0.1,-0.1,-0.1),
                         icon=list(show_icon=FALSE, icon_name="ios-close", icon_color="black", icon_library="ion", marker_color="red")){
  address_single <- tibble::tibble(singlelineaddress = city) %>%
    tidygeocoder::geocode(address=singlelineaddress,method = 'arcgis') %>%
    dplyr::transmute(id = singlelineaddress,
              lon=long,
              lat=lat)

  icons <- awesomeIcons(
    icon = icon$icon_name,
    iconColor = icon$icon_color,
    library = icon$icon_library,
    markerColor = icon$marker_color
  )

  m<-leaflet(address_single,
             options = leafletOptions(zoomControl = FALSE,
                                      attributionControl=FALSE)) %>%
    addTiles(urlTemplate = mapBoxTemplate) %>%
    fitBounds(lng1 = max(address_single$lon)+zoomControl[1],
              lat1 = max(address_single$lat)+zoomControl[2],
              lng2 = min(address_single$lon)+zoomControl[3],
              lat2 = min(address_single$lat)+zoomControl[4])

  if(icon$show_icon){m <- m %>%
    addAwesomeMarkers(address_single$lon, address_single$lat, icon=icons)
  }

  m
}
