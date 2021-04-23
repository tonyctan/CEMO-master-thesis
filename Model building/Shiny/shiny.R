library(Orcs)
setwdOS(lin = "~/uio/", win = "M:/", ext = "pc/Dokumenter/MSc/Thesis/Model building/Shiny/")
flit <- read.csv("flit.csv", sep = ",", header = T)

# Load high resolution world map
library(rworldmap)
world <- getMap(resolution = "high") # Need package rworldxtra installed

# Combine financial literacy data with world map data
dim(flit)
flit <- cbind(world, flit[, c(2:36)])

library(tmap)

# Extract variable names I need on the interactive map
names(flit)
vars <- names(flit)[52:86]

if (require("shiny")) {

    ui <- fluidPage(
        tmapOutput("map"),
        selectInput("var", "Variable", vars)
    )

    server <- function(input, output, session) {
        output$map <- renderTmap({
            tm_shape(flit) +
                tm_polygons(vars[1], zindex = 401)
        })
        observe({
            var <- input$var
            tmapProxy("map", session, {
                tm_remove_layer(401) +
                    tm_shape(flit) +
                    tm_polygons(
                        var,
                        style = "pretty",
                        title = "Standardised coefficients",
                        textNA = "No data",
                        colorNA = "gray95",
                        zindex = 401
                    ) +
                    tm_view(
                        view.legend.position = c("left", "bottom")
                    )
            })
        })
    }

    app <- shinyApp(ui, server)
    if (interactive()) app
}# Use ctrl + c to close Shiny app
