#################################################
# 03_photosynthesis_pipeline.R
#################################################

library(SBGNview)
library(xml2)
library(rsvg)

source("scripts/06_shared_functions.R")

dir.create(
    "outputs/photosynthesis",
    recursive = TRUE,
    showWarnings = FALSE
)

SBGNview(

    input.sbgn = "pathways/PWY-101.sbgn",

    output.file =
        "outputs/photosynthesis/Photosynthesis_Base"
)

svg <- read_xml(

    "outputs/photosynthesis/Photosynthesis_Base_PWY-101.sbgn.svg"
)

fc_map <- data.frame(

    node = c(

        "PsbA",
        "PsbB",
        "PsbC",
        "PsbD",

        "PsaA",
        "PsaB",
        "PsaC",

        "chlorophyll",

        "photosystem II",
        "photosystem I"
    ),

    fold_change = c(

        4.2,
        3.5,
        3.0,
        2.8,

        2.5,
        2.2,
        1.8,

        3.7,

        4.5,
        3.2
    )
)

for(i in 1:nrow(fc_map)){

    current_node <- fc_map$node[i]

    current_fc <- fc_map$fold_change[i]

    current_color <- fc_to_color(current_fc)

    matched_nodes <- xml_find_all(

        svg,

        paste0(

            ".//*[local-name()='text' and contains(., '",

            current_node,

            "')]"
        )
    )

    for(j in matched_nodes){

        xml_set_attr(
            j,
            "fill",
            current_color
        )

        xml_set_attr(
            j,
            "font-size",
            "18"
        )

        xml_set_attr(
            j,
            "font-weight",
            "bold"
        )
    }
}

write_xml(

    svg,

    "outputs/photosynthesis/Photosynthesis_Advanced.svg"
)

rsvg_png(

    "outputs/photosynthesis/Photosynthesis_Advanced.svg",

    "outputs/photosynthesis/Photosynthesis_Advanced.png",

    width = 6000,

    height = 5000
)

cat("Photosynthesis pipeline completed.\n")
