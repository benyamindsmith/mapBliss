#' Put Map In A Custom Frame
#'
#' Put your maps in a customized frame with `frame_*()`.
#'
#' DOCUMENTATION IS NEEDED
#'
#' `frame_1()` is a basic white square frame.
#'
#' @param map a map you created with mapBliss or leaflet
#' @param title_text Title text
#' @param subtitle_text Subtitle text
#' @param title_font Title font
#' @param subtitle_font Subtitle font
#' @param frame_width Set by default to 100 percent. It is recommended not to change this.
#' @param frame_height Set by default to 790 so as to fill the default shiny screen. Update according to your needs.
#' @import shiny
#' @export
#' @examples
#'
#' plot_city_view("Jersalem, IL") |>
#'  frame_1(title_text="Jerusalem", subtitle_text="City of Gold", subtitle_font="Brush Script MT")

frame_1<- function(map,
                   title_text="Title",
                   subtitle_text = "Subtitle",
                   title_font="Brush Script MT",
                   subtitle_font = "Trebuchet MS",
                   frame_width = "100%",
                   frame_height = 780
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
          div(leafletOutput('map',width= frame_width, height=frame_height)),
          div(id = 'greetings',
              uiOutput('message'))

      ))



  server <- function(input, output) {
    output$map <- renderLeaflet({
      map
    })
    ## note that you can also add CSS classes here:
    output$message <- renderUI(tagList(
      h1(title_text, class='title_text'),
      h3(subtitle_text, class='subtitle_text'))
    )

  }
  shinyApp(ui, server)
}
