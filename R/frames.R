#' Put Map In A Custom Frame
#'
#' NEED TO ADD DESCRIPTION


frame_1<- function(map,
                   title_text="Title",
                   subtitle_text = "Subtitle",
                   title_font="Brush Script MT",
                   subtitle_font = "Trebuchet MS"
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
                   background-color:#f0f0f099;
                   }

                  .fancy_border{border:25px solid;
                                border-color: #f0f0f099;}
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
          div(leafletOutput('map')),
          div(id = 'greetings',
              uiOutput('message'))
      )
    )



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
