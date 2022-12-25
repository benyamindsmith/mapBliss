#' Save Framed Map as .svg
#'
#' Save framed map as .svg file for high quality printing!
#'
#'@param map for `save_map_frame_svg()`. A framed map.
#'@param delay for `save_map_frame_svg()`. Delay (in seconds) before taking the mop screenshot. Set by default to 10 seconds.
#'@param vwidth for `save_map_frame_svg()`.
#'@param vheight for `save_map_frame_svg()`.
#'@export
#'@examples
#'plot_city_view("Jersalem, IL") |>
#'  frame_1(title_text="Jerusalem", subtitle_text="City of Gold", subtitle_font="Brush Script MT")|>
#'  save_map_frame_svg()
#'## Deleting file for package speifics
#'file.remove("Rplot.svg")


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
