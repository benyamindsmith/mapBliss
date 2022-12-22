#' Save Map as .svg
#'
#' Save map as .svg file for high quality printing!
#'
#'@param viz The viz you created with plot_route or plot_flights.
#'@param svg_name The name of the file you want to call
#'@param zoom How much you want to zoom in on your map. I find that setting `zoom=3` works best but try it out yourself to see what works.
#'@param map
#'@param delay
#'@param vwidth
#'@param vheight
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
#'
#'plot_city_view("Jersalem, IL") |>
#'  frame_1(title_text="Jerusalem", subtitle_text="City of Gold", subtitle_font="Brush Script MT")|>
#'  save_map_frame_svg()
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

save_map_frame_svg<-function(map,
                             svg_name="Rplot.svg",
                             delay=10,
                             vwidth = 992,
                             vheight = 1000){
  # Saving the html generated

  map %>%
  appshot(vwidth = 992,
          vheight = 1000,
          delay=delay,
          file = "Rplot.png") %>%
    image_read() %>%
    image_convert(format='svg') %>%
    image_write(svg_name)

  file.remove("Rplot.png")
  print(paste(svg_name,"written in",getwd()))
}
