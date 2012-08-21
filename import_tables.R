#!/usr/bin/env r

sup_dirs <- list.files(path=".", pattern="Sun.*")
for (i in seq(along=sup_dirs)) {

    group_dirs <- list.files(path=sup_dirs[[i]], pattern="train.*")
    for (j in seq(along=group_dirs)) {
            full_filename <- paste(sup_dirs[[i]], group_dirs[[j]],  "table", sep='/')
            var_name <- paste(sup_dirs[[i]], group_dirs[[j]],  sep="_")
            x <- read.table (file=full_filename, sep="\t", header=F)
            assign (var_name, x);
    }

}
rm(group_dirs,sup_dirs,full_filename,i,j,var_name,x)
