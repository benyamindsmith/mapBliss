# mapBliss <a href='https://github.com/benyamindsmith/mapBliss'><img src='https://github.com/benyamindsmith/mapBliss/blob/main/mapBliss.png' align="right" height="300" /></a>

Create beautiful maps of your adventures with Leaflet in R. 

**If you want to learn how you can contribute to this project, feel free to contact me via my [website](https://bensstats.wordpress.com)**.

**Do you see have a feature idea that you think would make mapBliss better? Feel free to [open an issue](https://github.com/benyamindsmith/mapBliss/issues) and make a feature request!**

<details>
<summary>
<h2>
Table of Contents
</h2>
</summary>

* [Introduction](https://github.com/benyamindsmith/mapBliss/main/README.md#introduction)
 
* [Cronology and Updates](https://github.com/benyamindsmith/mapBliss/main/README.md#cronology-and-updates)

* [Installing This Package](https://github.com/benyamindsmith/mapBliss/blob/main/README.md#installing-this-package)

* [Dependencies](https://github.com/benyamindsmith/mapBliss/blob/main/README.md#dependencies)

* [Some Example Visuals](https://github.com/benyamindsmith/mapBliss/blob/main/README.md#some-example-visuals)
</details>

<details>
<summary>
<h2>
Introduction
</h2>
</summary>
This package is based functions I created for creating print-quality souvenir maps like the ones you can find on [Atlas.co](atlas.co/products/map).

For some background on how this package came to be and for updates. Feel free to check out my blogs on the topic [here](https://bensstats.wordpress.com/?s=atlas), or see the relevant links in [Cronology and Updates](https://github.com/benyamindsmith/mapBliss/blob/main/README.md#cronology-and-updates)
</details>

<details>
<summary>
<h2>
Cronology and Updates
<h2>
</summary>

1. [I reverse-engineered Atlas.co (well, some of it)](https://bensstats.wordpress.com/2021/10/21/robservations-15-i-reverse-engineered-atlas-co-well-some-of-it/)

2. [Using the MapBox API with Leaflet](https://bensstats.wordpress.com/2021/10/25/robservations-16-using-the-mapbox-api-with-leaflet/)

3. [Plotting Flight Paths on Leaflet Maps](https://bensstats.wordpress.com/2021/11/16/robservations-17-plotting-flight-paths-on-leaflet-maps/)

4. [**Packaging My Route Map Code! Introducing mapBliss.**](https://bensstats.wordpress.com/2022/10/28/robservations-40-packaging-my-route-map-code-introducting-mapbliss/)

5. [Control Individual Label Positions In mapBliss With `_flex()` Functions](https://bensstats.wordpress.com/2022/11/23/robservations-43-control-individual-label-positions-in-mapbliss-with-_flex-functions/)

6. [Adding Frame and Custom Title Support To mapBliss](https://bensstats.wordpress.com/2022/12/27/robservations-44-adding-frame-and-custom-title-support-to-mapbliss/)
</details>


### Installing This Package

```r
devtools::install_github("benyamindsmith/mapBliss")
```

<details>
<summary>
<h3>
Dependencies
</h3>
</summary>
This package depends on the following packages: 

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
* [shiny](https://cran.r-project.org/web/packages/shiny/index.html)

</details>

<details>
<summary>
<h3>
 Some Example Visuals
</h3>
</summary>
The following are just some screen shots of the images that can be produced. It is possible to create a map and save it as .svg file for a sharper image.


![image](https://user-images.githubusercontent.com/46410142/199815517-4da0d3f8-84a6-482c-83e7-c4e33d0dce7b.png)

![image](https://user-images.githubusercontent.com/46410142/209036056-2a80922c-485a-4fe7-af81-abf575649d8c.png)


<img src='https://user-images.githubusercontent.com/46410142/191990873-c3df1335-4875-47af-8d4e-dd06fe973f67.png' /></a>

<img src='https://user-images.githubusercontent.com/46410142/191989781-88997e6e-4aed-488a-9909-12dc883deb1a.png' /></a>

<img src='https://user-images.githubusercontent.com/46410142/191992937-7d349b59-0185-41c9-9694-84f792aaa2b5.png' /></a>

<img src='https://user-images.githubusercontent.com/46410142/197111466-3ccfe2c4-7e51-4c91-92d8-774a37c3c120.png' /></a>

</details>
