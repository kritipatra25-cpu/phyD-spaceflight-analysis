library(xml2)
library(rsvg)

#################################################
# LOAD EXISTING FLAVONOID SVG
#################################################

svg <- read_xml(
"./SBGN_Project/Flavonoid_Base_PWY1F-FLAVSYN.sbgn.svg"
)

#################################################
# COLOR FUNCTION
#################################################

fc_to_color <- function(fc){

if(fc >= 5){

```
"#8B0000"
```

} else if(fc >= 2){

```
"#FF4500"
```

} else if(fc >= 1){

```
"#FFA07A"
```

} else if(fc <= -2){

```
"#00008B"
```

} else if(fc <= -1){

```
"#4169E1"
```

} else {

```
"black"
```

}
}

#################################################
# OSD120 FLAVONOID FOLD CHANGES
#################################################

fc_map <- data.frame(

node = c(

```
"4CL3",
"4CL2",
"TT4",
"TT5",
"TT6",

"chalcone",
"flavanone",
"naringenin",
"dihydrokaempferol",
"flavonol"
```

),

fold_change = c(

```
2.21,   # 4CL3
```

-0.11,   # 4CL2

```
9.52,   # TT4 / CHS
1.98,   # TT5 / CHI
5.07,   # TT6 / F3H

9.52,   # chalcone
1.98,   # flavanone
1.98,   # naringenin
5.07,   # dihydrokaempferol
5.07    # flavonol
```

)
)

#################################################
# COLOR PATHWAY NODES
#################################################

for(i in 1:nrow(fc_map)){

current_node <- fc_map$node[i]

current_fc <- fc_map$fold_change[i]

current_color <- fc_to_color(current_fc)

matched_nodes <- xml_find_all(

```
svg,

paste0(
  ".//*[local-name()='text' and normalize-space(text())='",
  current_node,
  "']"
)
```

)

cat(
current_node,
" -> ",
length(matched_nodes),
" matches\n"
)

for(j in matched_nodes){

```
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
```

}
}

#################################################
# HIGHLIGHT IMPORTANT NODES
#################################################

important_nodes <- c(

"4CL3",
"TT4",
"TT5",
"TT6",

"chalcone",
"naringenin",
"dihydrokaempferol",
"flavonol"

)

for(lbl in important_nodes){

nodes <- xml_find_all(

```
svg,

paste0(
  ".//*[local-name()='text' and normalize-space(text())='",
  lbl,
  "']"
)
```

)

for(n in nodes){

```
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
```

}
}

#################################################
# SAVE SVG
#################################################

write_xml(

svg,

"OSD120_Flavonoid_Colored.svg"

)

#################################################
# CONVERT TO PNG
#################################################

rsvg_png(

"OSD120_Flavonoid_Colored.svg",

"OSD120_Flavonoid_Colored.png",

width = 5000,

height = 4000

)

cat(
"\nOSD120 Flavonoid pathway rendered successfully.\n"
)
