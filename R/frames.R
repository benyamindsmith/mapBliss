#' Put Map In A Custom Frame
#'
#' Put your maps in a customized frame with `map_frame()` functions.
#'
#'
#' @param map a map you created with mapBliss or leaflet
#' @param title_text Title text
#' @param subtitle_text Subtitle text
#' @param title_font Title font
#' @param subtitle_font Subtitle font
#' @param frame_width Set by default to 100 percent. It is recommended not to change this.
#' @param frame_height Set by default to 780 so as to fill the default shiny screen. Update according to your needs.
#' @param mask The function will look in masks/ for a PNG file with the same name. Defaults to circular_mask.
#' @import shiny
#' @import magrittr
#' @import magick
#' @import mapview
#' @export
#' @examples
#'
#' plot_city_view("Jersalem, IL") |>
#'   map_frame(title_text="Jerusalem", subtitle_text="City of Gold", subtitle_font="Brush Script MT")
#'
#' plot_city_view("Amsterdam") |>
#'   map_frame(title_text="Amsterdam", mask="house_mask")

map_frame<- function(map,
                   title_text = "Title",
                   subtitle_text = "",
                   title_font = "Brush Script MT",
                   subtitle_font = "Trebuchet MS",
                   frame_width = "100%",
                   frame_height = 780,
                   mask = "circular_mask"
){
  ui <-
    fillPage(
      ## see various ways of including CSS: https://shiny.rstudio.com/articles/css.html
      tags$head(
        tags$style(HTML(paste0("
                  #greetings{
                   top:-8rem;
                   position:bottom;
                   z-index:1000;
                   background-color:#ffffff;
                   }

                  .fancy_border{border:25px solid;
                                border-color: #ffffff;
                                #background-color: #7da2d1; <- to test transparancy
                                }
                  .title_text{top:-5rem;
                              font-family:", title_font,";
                              text-align: center;}
                  .subtitle_text{
                              font-family:",subtitle_font,";
                              text-align: center;
                  }
      "))
        )
      ),
      div(class = 'fancy_border', ## set CSS class to style border
          div(imageOutput("img",
                            width= frame_width,
                            height=frame_height),
                          align = "center"),
          div(id = 'greetings',
              uiOutput('message'))

      ))



  server <- function(input, output) {
    output$img <- renderImage({

      # create a tempdir
      myDir = tempdir()

      # save map as png file
      mapshot(map,file = paste0(myDir,"map.png"))
      mymap <- image_read(paste0(myDir,"map.png"))
      img_info_mymap <- image_info(mymap)

      # load mask and resize
      if(file.exists(paste0('masks/', mask, '.png'))){
        mymask <- image_read(paste0('masks/', mask, '.png'))
      } else {
        print(paste0('Cannot find the file masks/', mask, '.png'))
        mymask <- image_read('masks/circular_mask.png')
      }
      mask_resized <- mymask %>%
                        image_resize(paste0("x",img_info_mymap$height*.9)) %>%
                        image_extent(paste0(img_info_mymap$width,"x",img_info_mymap$height),color='white')

      # create inverted mask
      mask_inv_resized <- image_negate(mask_resized)

      # get outline, to allow a border
      mask_outline <- image_canny(mask_inv_resized, geometry = "0x.5+30%+30%")  %>%
        image_blur(0, 0.6) %>%
        image_convert(type="Bilevel") %>%
        image_morphology('Dilate', "Octagon", iter=4) %>%
        image_negate() %>%
        image_transparent("white")

      # remove the masked area from the map, and add the border
      tmpfile <-
        image_channel(mask_inv_resized, "lightness") %>%
        image_composite(mymap, ., gravity='center', operator='CopyOpacity') %>%
        image_composite(mask_outline, operator='Plus') %>%
        image_write('masked_map.png', format = 'png')

      list(src = "masked_map.png", contentType = "image/png")
    }, deleteFile = TRUE)


    ## note that you can also add CSS classes here:
    output$message <- renderUI(tagList(
      h1(title_text, class='title_text'),
      h3(subtitle_text, class='subtitle_text'))
    )

  }
  shinyApp(ui, server)
}
