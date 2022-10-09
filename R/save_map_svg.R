#' Save Map as .svg
#'
#'Documentation is needed.
#'
#' Save map
#'
#'@param viz
#'@param svg_name
#'@param zoom
#'@import magick
#'@import webshot
#'@import htmlwidgets
#'@export
#'@examples
#'
#'viz<- plot_route("Toronto",
#'                  "Niagara Falls",
#'                   how="car",
#'                   font="Courier",
#'                   label_position="right",
#'                   weight=1.5)
#'
#'
#'save_map_svg(viz)


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
