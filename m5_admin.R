# Commande pour générer à la main le book du module 5

bookdown::render_book("index.Rmd", "bookdown::gitbook")

creer_pdf_book_ssp <- function (chemin_book = "_book/", nom_pdf = "book_complet.pdf", 
                                pages_html = c("index", "Chapo", "evolparc", "caractparc", 
                                               "mouvmts", "dpe", "tension", "loyers", "methodo", "mentionslegales"), 
                                scale = 0.9) {
  if (!dir.exists(chemin_book)) {
    message(glue::glue("Le repertoire {chemin_book} n'existe pas, creation au prealable de la publication au format html."))
    rmarkdown::render_site(encoding = "UTF-8")
    chemin_book = "_book/"
  }
  else {
    chemin_book <- paste0(chemin_book, ("/"))
  }
  pages_html <- gsub(".html$", "", pages_html)
  pages_html <- paste0(chemin_book, pages_html, ".html")
  pages_pdf <- gsub(".html", ".pdf", pages_html)
  attempt::stop_if_any(!file.exists(pages_html), msg = glue::glue("Il manque au moins un fichier html dans {chemin_book} ou il y a probleme de nommage, revoyez l'argument 'pages_html'."))
  file.copy(from = paste0(chemin_book, "gouv_book.css"), to = paste0(chemin_book, "style.css"))
  message("Export des pages html au format PDF en cours :")
  impress <- function(page, echelle = scale) {
    message(glue::glue("- {page}"))
    pagedown::chrome_print(input = page, extra_args = c("--disable-gpu", "--no-sandbox", "--disable-dev-shm-usage"), 
                           verbose = 0, timeout = 600, options = list(transferMode = "ReturnAsStream", scale = echelle))
  }
  purrr::map(.x = pages_html, .f = impress)
  qpdf::pdf_combine(pages_pdf, output = glue::glue("{chemin_book}{nom_pdf}"))
  file.remove(pages_pdf, glue::glue("{chemin_book}style.css"))
  suppressWarnings(file.remove(glue::glue("{chemin_book}404.pdf")))
  message(glue::glue("Le fichier {nom_pdf} est disponible dans {chemin_book}."))
}

# Commande pour générer un support pdf du module 5
creer_pdf_book_ssp(
  chemin_book = "_book/", nom_pdf = "M5_dataviz.pdf",
  pages_html = c(
    "index.html",
    "bien-commencer.html",
    "package-ggplot2.html",
    "le-mapping.html",
    "les-formes-géométriques.html",
    "lhabillage-simple.html",
    "les-thèmes.html",
    "les-scales.html",
    "la-mise-en-page-de-plusieurs-graphiques.html",
    "les-facettes.html",
    "exporter-un-graphique.html",
    "créer-des-cartes-avec-ggplot2.html",
    "animer-ses-graphiques-ggplot-avec-gganimate.html",
    "créer-des-graphiques-et-cartes-pour-le-web.html",
    "créer-des-tableaux-avec-kable-et-kable-extra.html",
    "ressources.html",
    "exercices-et-corrections.html"
  ))
