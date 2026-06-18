library(SBGNview)
library(xml2)
library(rsvg)

#################################################
# COLOR FUNCTION
#################################################

fc_to_color <- function(fc){

  if(fc >= 4){
    "#8B0000"
  } else if(fc >= 2){
    "#FF4500"
  } else if(fc >= 1){
    "#FFA07A"
  } else if(fc <= -1.5){
    "#00008B"
  } else if(fc <= -0.5){
    "#4169E1"
  } else if(fc < 0){
    "#87CEFA"
  } else {
    "black"
  }
}

#################################################
# RENDER ORIGINAL SBGN
#################################################

SBGNview(

  input.sbgn =
    "http___identifiers.org_panther.pathway_P00015.sbgn",

  output.file =
    "OSD120_Circadian"

)

#################################################
# OPEN SVG
#################################################

svg <- read_xml(
  "OSD120_Circadian_http___identifiers.org_panther.pathway_P00015.sbgn.svg"
)

#################################################
# OSD120 VALUES
#################################################

circadian_fc <- data.frame(

  node = c(

    "Cry",
    "Per",
    "Clock",
    "BMAL1",
    "bmal1",
    "Rev-erb",
    "rev-erb"

  ),

  fold_change = c(

    mean(c(-0.142,-0.487)),             # CRY1 + CRY2

    mean(c(-1.80,-0.97,-1.11,-0.44)),  # PRR5 PRR7 PRR3 TOC1

    mean(c(5.76,4.53)),                # LHY + CCA1

    mean(c(5.76,4.53)),
    mean(c(5.76,4.53)),

    -1.82,                             # GI
    -1.82

  )
)

#################################################
# COLOR NODES
#################################################

for(i in 1:nrow(circadian_fc)){

  current_node <- circadian_fc$node[i]

  current_fc <- circadian_fc$fold_change[i]

  current_color <- fc_to_color(current_fc)

  matched_nodes <- xml_find_all(

    svg,

    paste0(
      ".//*[local-name()='text' and normalize-space(text())='",
      current_node,
      "']"
    )
  )

  cat(
    current_node,
    " -> ",
    length(matched_nodes),
    " matches\n"
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
      "24"
    )

    xml_set_attr(
      j,
      "font-weight",
      "bold"
    )
  }
}

#################################################
# EMPHASIZE KEY NODES
#################################################

master_nodes <- c(

  "Cry",
  "Per",
  "Clock",
  "BMAL1"

)

for(lbl in master_nodes){

  nodes <- xml_find_all(

    svg,

    paste0(
      ".//*[local-name()='text' and normalize-space(text())='",
      lbl,
      "']"
    )
  )

  for(n in nodes){

    xml_set_attr(
      n,
      "font-size",
      "34"
    )

    xml_set_attr(
      n,
      "font-weight",
      "bold"
    )
  }
}

#################################################
# SAVE SVG
#################################################

write_xml(

  svg,

  "OSD120_Circadian_Colored.svg"

)

#################################################
# CONVERT TO PNG
#################################################

rsvg_png(

  "OSD120_Circadian_Colored.svg",

  "OSD120_Circadian_Colored.png",

  width = 5000,

  height = 4000

)

cat(
  "\nOSD120 Circadian pathway rendered successfully.\n"
)
