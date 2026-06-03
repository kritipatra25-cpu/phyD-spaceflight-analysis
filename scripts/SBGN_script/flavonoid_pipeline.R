# =========================================================
# FLAVONOID BIOSYNTHESIS SBGNview PIPELINE
# =========================================================

library(SBGNview)
library(xml2)
library(rsvg)
source("03_shared_functions.R")

SBGNview(
    
    input.sbgn = "PWY1F-FLAVSYN.sbgn",
    
    output.file = "Flavonoid_Base"
)

svg <- read_xml(
    "Flavonoid_Base_PWY1F-FLAVSYN.sbgn.svg"
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
    
    "chalcone|naringenin|flav|anthocyan|kaempferol|quercetin|CHS|CHI|F3H|DFR|ANS",
    
    labels,
    
    ignore.case = TRUE,
    
    value = TRUE
)


fc_map <- data.frame(
    
    node = c(
        
        "chalcone",
        "CHS_H1",
        "naringenin",
        "flavonol",
        "dihydrokaempferol",
        "flavanone"
    ),
    
    fold_change = c(
        
        4.2,
        3.8,
        2.5,
        3.1,
        -1.8,
        -2.5
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
            "20"
        )
        
        xml_set_attr(
            j,
            "font-weight",
            "bold"
        )
    }
}

important_nodes <- c(
    
    "chalcone",
    "naringenin",
    "flavonol",
    "dihydrokaempferol"
)

for(lbl in important_nodes){
    
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
            "28"
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
    
    "Flavonoid_Advanced.svg"
)


rsvg_png(
    
    "Flavonoid_Advanced.svg",
    
    "Flavonoid_Advanced.png",
    
    width = 5000,
    
    height = 4000
)

cat( "\nFlavonoid pathway rendered successfully.\n")
