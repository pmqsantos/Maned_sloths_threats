#Title: Sankey chart 
#Author: Paloma M Santos
#Data: 01/22/2024
#From: From paper - What, where, and how: a spatiotemporally explicit analysis of the drivers of habitat loss within the range of maned three-toed sloths (Bradypus torquatus and Bradypus crinitus)
#https://onlinelibrary.wiley.com/doi/full/10.1111/mam.12342


library(networkD3) #to create Sankeychart
library (gridExtra) #Miscellaneous Functions for "Grid" Graphics 
library(htmlwidgets) #add graph title
library(htmltools) #add graph title

# Select the corresponding sheet in the excel spreadsheet
SankeyTrans <- DriversTable[[7]]

# Create a dataset for Bradypus torquatus
nodes_Bradypustorquatus <- data.frame(name = unique(c(as.character
                                                      (SankeyTrans$FirstYear
                                                        [SankeyTrans$Species == "Bradypus torquatus"]),
                                                      as.character
                                                      (SankeyTrans$LastYear
                                                        [SankeyTrans$Species == "Bradypus torquatus"]))))
links_Bradypustorquatus <- data.frame(
  source = match(SankeyTrans$FirstYear[SankeyTrans$Species == "Bradypus torquatus"], nodes_Bradypustorquatus$name) - 1,
  target = match(SankeyTrans$LastYear[SankeyTrans$Species == "Bradypus torquatus"], nodes_Bradypustorquatus$name) - 1,
  value = SankeyTrans$ha[SankeyTrans$Species == "Bradypus torquatus"]
)

colorJS <- paste('d3.scaleOrdinal().range(["#458B00", "#A2CD5A", 
"#8B0000","#FF7F50", "#7FCD9A", "#B8860B",                        "#009ACD", "#9BCD9B"])')

# Criar um conjunto de dados para a Bradypus crinitus
nodes_Bradypuscrinitus <- data.frame(name = unique(c(as.character
                                                      (SankeyTrans$FirstYear
                                                        [SankeyTrans$Species == "Bradypus crinitus"]),
                                                      as.character
                                                      (SankeyTrans$LastYear
                                                        [SankeyTrans$Species == "Bradypus crinitus"]))))
links_Bradypuscrinitus <- data.frame(
  source = match(SankeyTrans$FirstYear[SankeyTrans$Species == "Bradypus crinitus"], nodes_Bradypuscrinitus$name) - 1,
  target = match(SankeyTrans$LastYear[SankeyTrans$Species == "Bradypus crinitus"], nodes_Bradypuscrinitus$name) - 1,
  value = SankeyTrans$ha[SankeyTrans$Species == "Bradypus crinitus"]
)

colorJS <- paste('d3.scaleOrdinal().range(["#458B00", "#A2CD5A", 
"#8B0000","#FF7F50", "#7FCD9A", "#B8860B",                        "#009ACD", "#9BCD9B"])')

# Create the Sankey diagram 
Bt <- sankeyNetwork(
  Links = links_Bradypustorquatus,
  Nodes = nodes_Bradypustorquatus,
  Source = "source",
  Target = "target",
  Value = "value",
  NodeID = "name",
  fontSize = 0,
  nodeWidth = 25,
  nodePadding = 30,
  sinksRight = FALSE,
  colourScale = colorJS,
  iterations = 0
)

Bc <- sankeyNetwork(
  Links = links_Bradypuscrinitus,
  Nodes = nodes_Bradypuscrinitus,
  Source = "source",
  Target = "target",
  Value = "value",
  NodeID = "name",
  fontSize = 0,
  nodeWidth = 25,
  nodePadding = 30,
  sinksRight = FALSE,
  colourScale = colorJS,
  iterations = 0
)

sankey_BT <- htmlwidgets::prependContent(Bt, htmltools::tags$h1("Bradypus torquatus"))
sankey_BC <- htmlwidgets::prependContent(Bc, htmltools::tags$h1("Bradypus crinitus"))
