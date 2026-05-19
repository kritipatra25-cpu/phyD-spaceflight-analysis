#################################################
# 03_shared_functions.R
# Shared functions for SVG editing
#################################################

fc_to_color <- function(fc){

    if(fc >= 3){

        return("#8B0000")

    } else if(fc >= 2){

        return("#FF4500")

    } else if(fc >= 1){

        return("#FFA07A")

    } else if(fc <= -3){

        return("#00008B")

    } else if(fc <= -2){

        return("#4169E1")

    } else if(fc <= -1){

        return("#87CEFA")

    } else {

        return("black")
    }
}
