% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_route.R
\name{plot_route}
\alias{plot_route}
\title{Plot Road Trip Route}
\usage{
plot_route(
  addresses,
  how = c("car", "bike", "foot"),
  colour = "black",
  opacity = 1,
  weight = 1,
  radius = 2,
  label_text = addresses,
  label_position = "bottom",
  font = "Lucida Console",
  font_weight = "bold",
  font_size = "14px",
  text_indent = "15px",
  mapBoxTemplate = "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
  zoomControl = c(0.1, 0.1, -0.1, -0.1)
)
}
\arguments{
\item{addresses}{the stops on your route}

\item{how}{routing profile(s) to use, e.g. "car", "bike" or "foot" (when using the routing.openstreetmap.de test server). n-1 routing profiles are required for for n addresses}

\item{colour}{what colour you want the route line to be colored}

\item{opacity}{line opacity - a value between 0 and 1}

\item{weight}{Line thickness}

\item{radius}{Point size}

\item{label_text}{Optional. Alternative text to display as the address labels.}

\item{label_position}{where to place the label relative to the point ("bottom", "top", "left", "right")}

\item{font}{font-family css property}

\item{font_weight}{font-weight css property}

\item{font_size}{font-size css property}

\item{text_indent}{text indent css property}

\item{mapBoxTemplate}{the MapBox template you want to use.}

\item{zoomControl}{The zoom control for your bounding box. Default format is `c(lng1,lat1,lng2,lat2)`}
}
\description{
Plot multiple stops on a route `plot_route`. This function produces a html object so in order to save the image as an .svg (for printable visuals) check out the `save_map_svg()`.
}
\details{
For more information on how to integrate the MapBox API to make beautiful maps, check out [this blog](https://bensstats.wordpress.com/2021/10/25/robservations-16-using-the-mapbox-api-with-leaflet/).
}
\examples{

viz<- plot_route(c("Toronto","Niagara Falls","Monsey"),
                  how="car",
                  font="Courier",
                  label_position="right",
                  weight=1.5)

viz

}
