#' Save Map as .svg
#'
#' Save map as .svg file for high quality printing!
#'
#'@param viz The viz you created with plot_route or plot_flights.
#'@param svg_name The name of the file you want to call
#'@param zoom How much you want to zoom in on your map. I find that setting `zoom=3` works best but try it out yourself to see what works.
#'@import magick
#'@import webshot
#'@import htmlwidgets
#'@export
#'@examples
#'
#'
#' viz<- plot_route(c("Toronto","Niagara Falls","Monsey"),
#'                   how="car",
#'                   font="Courier",
#'                   label_position="right",
#'                   weight=1.5)
#'
#'save_map_svg(viz)
#'## Deleting file for package speifics
#'file.remove("Rplot.svg")

save_map_svg<-function(viz, svg_name="Rplot.svg", zoom=3){
  # Saving the html generated
  saveWidget(viz, "temp.html", selfcontained = FALSE)

  webshot("temp.html",
          cliprect = "viewport",
          zoom=zoom,
          file = "Rplot.png") %>%
    image_read() %>%
    image_convert(format='svg') %>%
    image_write(svg_name)

  file.remove("temp.html")
  file.remove("Rplot.png")
  print(paste(svg_name,"written in",getwd()))
}
