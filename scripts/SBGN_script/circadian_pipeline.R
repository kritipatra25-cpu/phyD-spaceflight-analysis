# =========================================================
# CIRCADIAN RHYTHM SBGNview PIPELINE
# =========================================================
source("03_shared_functions.R")
library(SBGNview)
library(xml2)
library(rsvg)

SBGNview(
    
    input.sbgn =
        "http___identifiers.org_reactome_R-HSA-400253.sbgn",
    
    output.file =
        "Circadian_Base"
)

svg <- read_xml(
    "Circadian_Base_http___identifiers.org_reactome_R-HSA-400253.sbgn.svg"
)

texts <- xml_find_all(
    
    svg,
    
    ".//*[local-name()='text']"
)

labels <- trimws(
    
    xml_text(texts)
)

labels <- labels[
    
    labels != ""
]


grep(
    
    "CLOCK|BMAL|PER|CRY|circadian|casein|REV|ROR|NPAS",
    
    labels,
    
    ignore.case = TRUE,
    
    value = TRUE
)


circadian_fc <- data.frame(
    
    node = c(
        
        "CLOCK",
        "BMAL1",
        "NPAS2",
        "CRY1",
        "CRY2",
        "PER1",
        "PER2",
        "RORA"
    ),
    
    fold_change = c(
        
        2.8,
        3.5,
        2.2,
        -2.1,
        -1.7,
        -3.0,
        -2.5,
        1.9
    )
)

for(i in 1:nrow(circadian_fc)){
    
    current_node <- circadian_fc$node[i]
    
    current_fc <- circadian_fc$fold_change[i]
    
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
            "20"
        )
        
        xml_set_attr(
            j,
            "font-weight",
            "bold"
        )
    }
}


master_nodes <- c(
    
    "CLOCK",
    "BMAL1",
    "PER1",
    "PER2",
    "CRY1",
    "CRY2",
    "NPAS2"
)

for(lbl in master_nodes){
    
    nodes <- xml_find_all(
        
        svg,
        
        paste0(
            
            ".//*[local-name()='text' and contains(., '",
            
            lbl,
            
            "')]"
        )
    )
    
    for(n in nodes){
        
        xml_set_attr(
            n,
            "font-size",
            "30"
        )
        
        xml_set_attr(
            n,
            "font-weight",
            "bold"
        )
    }
}


rects <- xml_find_all(
    
    svg,
    
    ".//*[local-name()='rect']"
)

if(length(rects) > 0){
    
    xml_set_attr(
        
        rects[[1]],
        
        "fill",
        
        "white"
    )
}

write_xml(
    
    svg,
    
    "Circadian_Advanced.svg"
)


rsvg_png(
    
    "Circadian_Advanced.svg",
    
    "Circadian_Advanced.png",
    
    width = 5500,
    
    height = 4500
)

cat("\nCircadian rhythm pathway rendered successfully.\n")
