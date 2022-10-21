# mapBliss <a href='https://github.com/benyamindsmith/mapBliss'><img src='https://github.com/benyamindsmith/mapBliss/blob/main/mapBliss.png' align="right" height="300" /></a>

Create beautiful maps of your adventures with Leaflet and the MapBox API in R. 

## Introduction

This package is based functions I created for creating print-quality souvenir maps like the ones you can find on [Atlas.co](atlas.co/products/map). Feel free to check out my blogs on the topic [here](https://bensstats.wordpress.com/?s=atlas) for more information.

## Table of Contents

* [Installing This Package](https://github.com/benyamindsmith/mapBliss/blob/main/README.md#installing-this-package)
* [Dependencies](https://github.com/benyamindsmith/mapBliss/blob/main/README.md#dependencies)
* [Basic Functionality](https://github.com/benyamindsmith/mapBliss/blob/main/README.md#basic-functionality)
* [Some Example Visuals](https://github.com/benyamindsmith/mapBliss/blob/main/README.md#some-example-visuals)

### Installing This Package

```r
devtools::install_github("benyamindsmith/mapBliss")
```

### Dependencies

This package depends requires the following packages: 

* [dplyr](https://dplyr.tidyverse.org)
* [purrr](https://purrr.tidyverse.org)
* [magrittr](https://magrittr.tidyverse.org)
* [tibble](https://tibble.tidyverse.org)
* [rlang](https://rlang.r-lib.org)
* [sf](https://r-spatial.github.io/sf/)
* [geosphere](http://uribo.github.io/rpkg_showcase/spatial/geosphere.html)
* [tidygeocoder](https://jessecambon.github.io/tidygeocoder/)
* [leaflet](https://rstudio.github.io/leaflet/)
* [osrm](https://github.com/riatelab/osrm)
* [webshot](https://wch.github.io/webshot/articles/intro.html)
* [htmlwidgets](https://github.com/ramnathv/htmlwidgets)
* [magick](https://github.com/ropensci/magick)

### Basic Functionality

This package presently has three functions: 

1. `plot_route()` - for plotting road trips
2. `plot_flights()` - for plotting flight routes
3. `save_map_svg()` - for saving the map that you make as a vector graphics file which can be used for printing high resoultion post cards and posters. 

(In progress)

### Some Example Visuals


The following are just some screen shots of the images that can be produced. It is possible to create a map and save it as .svg file for a sharper image.

<img src='https://user-images.githubusercontent.com/46410142/191990637-8d24eb7d-a96d-4f68-83a3-ba9f4240dfb4.png' /></a>

<img src='https://user-images.githubusercontent.com/46410142/191990873-c3df1335-4875-47af-8d4e-dd06fe973f67.png' /></a>

<img src='https://user-images.githubusercontent.com/46410142/191989781-88997e6e-4aed-488a-9909-12dc883deb1a.png' /></a>

<img src='https://user-images.githubusercontent.com/46410142/191992937-7d349b59-0185-41c9-9694-84f792aaa2b5.png' /></a>

<img src='https://user-images.githubusercontent.com/46410142/197111466-3ccfe2c4-7e51-4c91-92d8-774a37c3c120.png /></a>

