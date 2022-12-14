% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_flights_flex.R
\name{plot_flights_flex}
\alias{plot_flights_flex}
\title{Plot Flight Paths With More Flexibility}
\usage{
plot_flights_flex(
  addresses,
  colour = "black",
  opacity = 1,
  weight = 1,
  radius = 2,
  label_text = addresses,
  label_position = c("bottom", "top", "left", "right"),
  font = "Lucida Console",
  font_weight = "bold",
  font_size = "14px",
  text_indent = "15px",
  mapBoxTemplate = "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
  nCurves = 100,
  zoomControl = c(0.1, 0.1, -0.1, -0.1)
)
}
\arguments{
\item{addresses}{The locations which you want to plot your flight route. ORDER MATTERS so be sure to list the locations in the order you want to plot the flight path.}

\item{colour}{The colour of the points and route. By default set to "black"}

\item{opacity}{Opacity of the points and route on the map}

\item{weight}{Line thickness}

\item{radius}{Point size}

\item{label_text}{Alternative text to display as the address labels.}

\item{label_position}{where to place each of the labels relative to the points}

\item{font}{font-family css property}

\item{font_weight}{font-weight css property}

\item{font_size}{font-size css property}

\item{text_indent}{text indent css property}

\item{mapBoxTemplate}{The MapBox template you want to use.}

\item{nCurves}{flight path smoothness. I have found setting this to 100 works best, but feel free to play around with it.}

\item{zoomControl}{The zoom control for your bounding box. Format is `c(lng1,lat1,lng2,lat2)`}
}
\description{
DISCLAIMER: the `_flex()` functions offer more flexibility in label placement and will offer new features under development for the `mapBliss` package. These functions will be subject to change more regularly than the standard functions.
}
\details{
DOCUMENTATION IS NEEDED

Plot multiple flights with `plot_flights_flex()`. This function produces a html object so in order to save the image as an .svg (for printable visuals) check out the `save_map_svg()`.

For more information on how to integrate the MapBox API to make beautiful maps, check out [this blog](https://bensstats.wordpress.com/2021/10/25/robservations-16-using-the-mapbox-api-with-leaflet/).
}
\examples{
plot_flights_flex(c("YYZ",
"GIG",
"CPT/FACT",
"BOM",
"TLV"),
weight = 1,
opacity = 1,
nCurves = 10,
label_position="right")

}
