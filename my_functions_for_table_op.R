my_plot_V1_V_ <- function(table, vlist) {
    attach(table)
    #dev.off()
    if (length(vlist) <= 1) {
        par(mfrow=c(1,1))
    } else if (length(vlist) <= 4) {
        par(mfrow=c(2,2))
    } else if (length(vlist) <= 9) {
        par(mfrow=c(3,3))
    } else if (length(vlist) <= 16) {
        par(mfrow=c(4,4))
    } else {
        par(mfrow=c(5,5))
    }
    for (i in seq(along=vlist)) {
        #v_name <- paste(deparse(substitute(table)),"$V",vlist[[i]],sep='')
        v_name <- paste("V",vlist[[i]],sep='')
        #plot(col="blue",pch="o", get(table)$V1 ~ get(table)$Vget(vlist[[i]]), xlab=(text=v_name))

        plot(col="blue",pch="o", V1 ~ get(v_name))
        # table$Vget(vlist[[i]]))
    }
    detach(table)
}
my_plot_V_V_ <- function(table, vlist) {
    attach(table)
    #dev.off()
    if (length(vlist) <= 2) {
        par(mfrow=c(1,1))
    } else if (length(vlist) <= 5) {
        par(mfrow=c(2,2))
    } else if (length(vlist) <= 10) {
        par(mfrow=c(3,3))
    } else if (length(vlist) <= 17) {
        par(mfrow=c(4,4))
    } else {
        par(mfrow=c(5,5))
    }
    for (i in seq(along=vlist)) {
        #v_name <- paste(deparse(substitute(table)),"$V",vlist[[i]],sep='')
        if (i == 1) {
            v1name <- paste("V",vlist[[i]],sep='')
        }else {
            v_name <- paste("V",vlist[[i]],sep='')
            plot(col="blue",pch="o", get(v1name) ~ get(v_name))
        }
    }
        #plot(col="blue",pch="o", get(table)$V1 ~ get(table)$Vget(vlist[[i]]), xlab=(text=v_name))

        # table$Vget(vlist[[i]]))
    detach(table)
}

my_lm_V1_V_ <- function (table, vlist, pl=FALSE) {
    attach(table)
    par(mfrow=c(2,2))
    for (i in seq(along=vlist)) {
        v_name <- paste("V",vlist[[i]],sep='')
        my_lm <-lm( V1 ~ get(v_name))
            print(summary(my_lm))
        if (pl == TRUE) {
            plot(my_lm, xlab=parse(text=v_name))
        }
    }
    detach(table)
}
my_plot_diff_V1_V_ <- function(table, vlist) {
    attach(table)
    #dev.off()
    if (length(vlist) <= 1) {
        par(mfrow=c(1,1))
    } else if (length(vlist) <= 4) {
        par(mfrow=c(2,2))
    } else if (length(vlist) <= 9) {
        par(mfrow=c(3,3))
    } else if (length(vlist) <= 16) {
        par(mfrow=c(4,4))
    } else {
        par(mfrow=c(5,5))
    }
    for (i in seq(along=vlist)) {
        v_name <- paste("V",vlist[[i]],sep='')
        v2_name <- paste("V",vlist[[i]]+1,sep='')
        #plot(col="blue",pch="o", get(table)$V1 ~ get(table)$Vget(vlist[[i]]), xlab=(text=v_name))
        diff <- get(v_name) - get(v2_name)
        plot(col="green",pch="x", V1 ~ diff)
    }
    detach(table)
}
my_lm_diff_V1_V_ <- function (table, vlist, pl=FALSE) {
    attach(table)
    par(mfrow=c(2,2))
    for (i in seq(along=vlist)) {
        v_name <- paste("V",vlist[[i]],sep='')
        v2_name <- paste("V",vlist[[i]]+1,sep='')
        diff <- get(v_name) - get(v2_name)
        my_lm <-lm( V1 ~ diff)
            print(summary(my_lm))
        if (pl == TRUE) {
            #plot(my_lm, xlab=parse(text=v_name))
            plot(my_lm)
        }
    }
    detach(table)
}

my_cat_table_rows_from_list <- function (tlist) {
        
    y <- get(tlist[[1]])
    if (length(tlist) >= 2) {
        for (i in seq(2:length(tlist))) {
            y <- rbind(y,get(tlist[[i]]))
        }
    }
    return (y)
    #t_name <- paste("allt",x[k],sep='')
    #assign(t_name, y)
}
my_cat_table_rows_by_table_name_regex <- function (regex) {
    tlist <- ls (pattern=regex, env=.GlobalEnv)
    return (my_cat_table_rows_from_list(tlist))
}

my_discretized_plot_V1_V_ <- function (file, col, ssize) {
    command <- paste("cat ", file, " | cut -f1,", col,  " > temp/columns", sep='')
    system(command)
    command <- paste("./discretize.pl temp/columns ", ssize, " > temp/discretized", sep='')
    system(command)
    command <- "cat temp/discretized | cut -f1 >temp/ruler"
    system(command)
    ruler <- scan(file="temp/ruler", 0)
    avg <- ruler
    med <- ruler
    variance <- ruler
    len <- ruler
    for (i in seq(along=ruler)) {
        command <- paste("cat temp/discretized | head -n",i, " | tail -n1 >temp/line", i, sep='')  
        system(command)
        ys <- scan(file=paste("temp/line", i, sep=''), what=0)
        ys <- ys[-1]
        #print(ys)
        avg[[i]] <- mean(ys)
        med[[i]] <- median(ys)
        variance[[i]] <- var(ys) 
        len[[i]] <- length(ys)
    }
    print((len))
    m <- cbind (avg, med)
    scale <- 1/max(len)
    len <- len*scale
    m <- cbind (m, len)
    matplot(ruler, m, type="p", col=rainbow(ncol(m)), pch="amc")
}
#command <- paste("cat ",  discretize_file, " | wc -l", sep='')
#wcl <- system(command)
my_discretized_plot_diff_V1_V_ <- function (file, col, ssize) {
    command <- paste("cat ", file, " | cut -f1,", col, ",", col+1,  " > temp/columns", sep='')
    system(command)
    command <- paste("./discretize_diff.pl temp/columns ", ssize, " > temp/discretized", sep='')
    system(command)
    command <- "cat temp/discretized | cut -f1 >temp/ruler"
    system(command)
    ruler <- scan(file="temp/ruler", 0)
    avg <- ruler
    med <- ruler
    variance <- ruler
    len <- ruler
    for (i in seq(along=ruler)) {
        command <- paste("cat temp/discretized | head -n",i, " | tail -n1 >temp/line", i, sep='')  
        system(command)
        ys <- scan(file=paste("temp/line", i, sep=''), what=0)
        ys <- ys[-1]
        #print(ys)
        avg[[i]] <- mean(ys)
        med[[i]] <- median(ys)
        variance[[i]] <- var(ys) 
        len[[i]] <- length(ys)
    }
    print(min(len))
    print(max(len))
    m <- cbind (avg, med)
    scale <- 1/max(len)
    len <- len*scale
    m <- cbind (m, len)
    matplot(ruler, m, type="p", col=rainbow(ncol(m)), pch="amc")
}
