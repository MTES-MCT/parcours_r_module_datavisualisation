
#!usr/bin/bash
cd /home/rstudio
git clone https://github.com/MTES-MCT/savoirfR.git
R -e "install.packages('devtools')"
R -e "devtools::install_local('./savoirfR')"
R -e "lapply(X = c('cowplot', 'htmlwidgets', 'ggiraph', 'gganimate', 'ggspatial', 'gifski', 'glue', 'highcharter', 'hrbrthemes', 'kableExtra', 'knitr', 'mapview', 'leaflet', 'scales', 'sf', 'tidyverse', 'tmap', 'tmaptools', 'viridis'), FUN = install.packages)"
R -e "lapply(X = c('dreamRs/apexcharter', 'spyrales/gouvdown', 'spyrales/gouvdown.fonts'), FUN = devtools::install_github)"
			 
chown -R rstudio:rstudio /home/rstudio/*