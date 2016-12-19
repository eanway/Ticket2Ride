## Evan Anway
## Ticket to Ride - plot cities
## 12/18/2016
## This code plots the cities and connections therebetween
## for the cities in the US version of Ticket to Ride
## Required packages: igraph
#install.packages("igraph") # install igraph

## Set up
rm(list=ls()) # reset working environment

library(igraph) # set library to igraph

filepath_cities = "E:/Personal/Experiments/Ticket2Ride/data/Ticket2Ride_cities.csv" # set path to cities data file
filepath_adjacency = "E:/Personal/Experiments/Ticket2Ride/data/Ticket2Ride.csv" # set path to network adjacency matrix
filepath_res = "E:/Personal/Experiments/Ticket2Ride/results/Ticket2Ride_cities.tiff" # set path to export


## Data import
mat_cities = as.matrix(read.csv(filepath_cities,header=TRUE,row.names=2)) # import cities data
mat_adjacency = as.matrix(read.csv(filepath_adjacency,header=TRUE,row.names=1)) # import adjacency data


## Data analysis
mat_cities[,"Y"] = 683-mat_cities[,"Y"] # rescale location data for graphing (1024 x 684 pixel original image)

#rownames(mat_adjacency) <- gsub(".", " ", rownames(mat_adjacency))
#colnames(mat_adjacency) <- gsub(".", " ", colnames(mat_adjacency))

net_T2R = graph_from_adjacency_matrix(mat_adjacency,mode="undirected",weighted=TRUE)


## Plotting
tiff(file=filepath_res, width = 1024/72, height = 683/72, units = "in", res = 200, pointsize = 18) # width = 1024 pixels, height = 683 pixels at 72 DPI

E(net_T2R)$width = 1/E(net_T2R)$weight*15
V(net_T2R)$size = 8
V(net_T2R)$color = "tan"
V(net_T2R)$label.cex = 0.6
V(net_T2R)$label.color = "black"
V(net_T2R)$label.font = 2
V(net_T2R)$frame.color = "#ffffff"
V(net_T2R)$label = rownames(mat_cities)

plot(net_T2R,
     layout=mat_cities[,2:3],
     asp = 2/3, margin = c(0,0,0,0))

dev.off()
