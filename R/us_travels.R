#' U.S. Travels Data
#'
#' This dataset contains information about a series of travel destinations across the United States, including the mode of transportation used to reach each location. It is designed to be used with the \code{mapBliss} R package for visualizing and mapping journeys across the U.S.
#'
#' The \code{us_travels} data provides a wide-ranging set of U.S. cities, towns, and states visited during a journey. The data is particularly suitable for creating geographic visualizations or analyzing travel patterns.
#'
#' The majority of the destinations were reached by car, with a few requiring flights for longer distances. The dataset's diverse geographic spread ensures representation of a variety of regions, from urban centers to rural areas.
#'
#' If you'd like to know more about mapping journeys with this dataset, consider checking out the \code{mapBliss} package documentation or exploring other travel-related datasets for comparison.
#'
#' @name us_travels
#' @docType data
#' @usage
#' us_travels
#' @format
#' A data frame with 85 rows and 2 columns:
#' \describe{
#'   \item{location}{Character vector indicating the city, state, and country of each travel destination (e.g., "Los Angeles, California, USA").}
#'   \item{how}{Character vector indicating the mode of transportation used (\code{"car"} or \code{"flight"}).}
#' }
#'
#'   This dataset was prepared for R by [your name or source].
#' @source User-provided travel data
#' @keywords datasets
NULL
