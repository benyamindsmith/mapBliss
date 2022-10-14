#' Plot A City View Map
#'
#' Plot a city view with `plot_city_view`. This essentially applies a bounding box to the MapBox template of your choosing to make a beautiful map of your favorite city!
#'
#' @param city The city you want to get a view of.
#' @param mapBoxTemplate The MapBox template you want to use.
#' @param zoomControl The zoom control for your bounding box. Format is `c(lng1,lat1,lng2,lat2)`
#' @export
#' @examples
#'
#' plot_city_view("New York City")
#'
#' plot_city_view("Paris")

plot_city_view<-function(city,
                         mapBoxTemplate= "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                         zoomControl=c(0.1,0.1,-0.1,-0.1)){
  address_single <- tibble(singlelineaddress = city) %>%
    geocode(address=singlelineaddress,method = 'arcgis') %>%
    transmute(id = singlelineaddress,
              lon=long,
              lat=lat)

  m<-leaflet(address_single,
             options = leafletOptions(zoomControl = FALSE,
                                      attributionControl=FALSE)) %>%
    addTiles(urlTemplate = mapBoxTemplate) %>%
    fitBounds(lng1 = max(address_single$lon)+zoomControl[1],
              lat1 = max(address_single$lat)+zoomControl[2],
              lng2 = min(address_single$lon)+zoomControl[3],
              lat2 = min(address_single$lat)+zoomControl[4])

  m
}
