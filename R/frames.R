#' Put Map In A Custom Frame
#'
#' Put your maps in a customized frame with `frame_*()` functions.
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
#' @param frame_height Set by default to 780 so as to fill the default shiny screen. Update according to your needs.
#' @import shiny
#' @export
#' @examples
#'
#' plot_city_view("Jersalem, IL") |>
#'  frame_1(title_text="Jerusalem", subtitle_text="City of Gold", subtitle_font="Brush Script MT")

frame_1 <- function(map,
                    title_text = "Title",
                    subtitle_text = "Subtitle",
                    title_font = "Brush Script MT",
                    subtitle_font = "Trebuchet MS",
                    frame_width = "100%",
                    frame_height = 780) {
  ui <-
    fillPage(## see various ways of including CSS: https://shiny.rstudio.com/articles/css.html
      tags$head(tags$style(HTML(
        paste0(
          "
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
                              font-family:",
          title_font,
          ";
                              text-align: center;}
                  .subtitle_text{
                              font-family:",
          subtitle_font,
          ";
                              text-align: center;
                  }
      "
        )
      ))),
      div(class = 'fancy_border', ## set CSS class to style border
          div(
            leafletOutput('map', width = frame_width, height = frame_height)
          ), div(id = 'greetings', uiOutput('message'))))



  server <- function(input, output) {
    output$map <- renderLeaflet({
      map
    })
    ## note that you can also add CSS classes here:
    output$message <- renderUI(tagList(
      h1(title_text, class = 'title_text'),
      h3(subtitle_text, class = 'subtitle_text')
    ))

  }
  shinyApp(ui, server)
}



frame_2 <- function(map,
                    title_text = "Title",
                    subtitle_text = "Subtitle",
                    title_font = "Brush Script MT",
                    subtitle_font = "Trebuchet MS",
                    frame_width = "100%",
                    frame_height = 780) {
  ui <-
    fillPage(## see various ways of including CSS: https://shiny.rstudio.com/articles/css.html
      tags$head(tags$style(HTML(
        css_string <- paste0(
          "
                  #greetings {
                      top: -8rem;
                      position: absolute;
                      z-index: 1000;
                      background-color: #ffffff;
                      border-radius: 50%;
                      width: 300px; /* Adjust size as needed */
                      height: 300px; /* Adjust size as needed */
                      display: flex;
                      justify-content: center;
                      align-items: center;
                      overflow: hidden;
                  }

                  .fancy_border {
                      border: 25px solid #ffffff; /* Adjust color and width as needed */
                      border-radius: 50%;
                      width: 300px; /* Match the width of #greetings */
                      height: 300px; /* Match the height of #greetings */
                      display: flex;
                      justify-content: center;
                      align-items: center;
                      overflow: hidden;
                      position: relative;
                  }

                  .title_text {
                      position: absolute;
                      top: -5rem;
                      font-family:",
          title_font,
          ";
                      text-align: center;
                      width: 100%;
                  }

                  .subtitle_text {
                      position: absolute;
                      top: 1rem; /* Adjust position as needed */
                      font-family: ",
          subtitle_font,
          ";
                      text-align: center;
                      width: 100%;
                  }

                  /* Ensure the text fits well within the circular frame */
                  .title_text, .subtitle_text {
                      padding: 0 1rem;
                  }
      "
        )
      ))),
      div(class = 'fancy_border', ## set CSS class to style border
          div(
            leafletOutput('map', width = frame_width, height = frame_height)
          ), div(id = 'greetings', uiOutput('message'))))



  server <- function(input, output) {
    output$map <- renderLeaflet({
      map
    })
    ## note that you can also add CSS classes here:
    output$message <- renderUI(tagList(
      h1(title_text, class = 'title_text'),
      h3(subtitle_text, class = 'subtitle_text')
    ))

  }
  shinyApp(ui, server)
}
