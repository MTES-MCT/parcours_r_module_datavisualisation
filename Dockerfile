ARG R_VERSION=4.2.2

FROM inseefrlab/onyxia-rstudio:r${R_VERSION}
RUN apt-get update && apt-get install -y cargo
RUN apt-get install -y wget
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt-get install -y ./google-chrome-stable_current_amd64.deb
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
COPY DESCRIPTION DESCRIPTION
RUN R -e 'remotes::install_deps(dependencies = TRUE)'
