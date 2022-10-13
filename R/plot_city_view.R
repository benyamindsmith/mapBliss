#' Plot A City View Map
#'
#' Documentation is needed
#'
#' @param city the city
#' @param mapBoxTemplate
#' @param zoomControl
#' @export
#' @examples
#'
#' plot_city_view("New York City")
#'
#' plot_city_view("Paris")

plot_city_view<-function(city,
                         mapBoxTemplate= "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                         zoomControl=0.1){
  address_single <- tibble(singlelineaddress = city) %>%
    geocode(address=singlelineaddress,method = 'arcgis') %>%
    transmute(id = singlelineaddress,
              lon=long,
              lat=lat)

  m<-leaflet(address_single,
             options = leafletOptions(zoomControl = FALSE,
                                      attributionControl=FALSE)) %>%
    addTiles(urlTemplate = mapBoxTemplate) %>%
    fitBounds(lng1 = max(address_single$lon)+zoomControl,
              lat1 = max(address_single$lat)+zoomControl,
              lng2 = min(address_single$lon)-zoomControl,
              lat2 = min(address_single$lat)-zoom_control)

  m
}
