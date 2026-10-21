# download wcr data
f_wcr_download <- function(dir_out, urls){

  # create directory and define paths to save downloaded files
  if(! dir.exists(dir_out)){
    dir.create(dir_out)
  }

  # output file paths
  files_out <- file.path(dir_out, basename(urls))

  # download files
  walk2(urls, files_out, ~download.file(.x, .y))

}
