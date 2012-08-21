#!/usr/bin/env r
sup_dir <- "R_output"

files <- list.files (path=sup_dir, pattern="^big.*table",)

for (j in seq(along=files)) {
    var_name <- files[j]
    var_name <- gsub("(-double)?\\.table", "", var_name, perl=TRUE)
    x <- read.table (paste(sup_dir, c("/"), files[j], sep=''), sep="\t", header=F)
    assign (var_name, x);
}
rm(files,j,sup_dir,var_name,x)
