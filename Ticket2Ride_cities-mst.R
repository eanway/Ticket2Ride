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
filepath_mst = "E:/Personal/Experiments/Ticket2Ride/data/Ticket2Ride_mst.csv" # set path to tsp data file

filepath_res = "E:/Personal/Experiments/Ticket2Ride/results/Ticket2Ride_cities-mst.png" # set path to export


## Data import
mat_cities = as.matrix(read.csv(filepath_cities,header=TRUE,row.names=2)) # import cities data
mat_adjacency = as.matrix(read.csv(filepath_adjacency,header=TRUE,row.names=1)) # import adjacency data
mat_mst = as.matrix(read.csv(filepath_mst,header=TRUE,row.names = 1)) # import mst path data

## Data analysis
mat_cities[,"Y"] = 683-mat_cities[,"Y"] # rescale location data for graphing (1024 x 684 pixel original image)
mat_mst[which(mat_mst==Inf)] <- 0

#rownames(mat_adjacency) <- gsub(".", " ", rownames(mat_adjacency))
#colnames(mat_adjacency) <- gsub(".", " ", colnames(mat_adjacency))

net_T2R = graph_from_adjacency_matrix(mat_adjacency,mode="undirected",weighted=TRUE)
net_MST = graph_from_adjacency_matrix(mat_mst,mode="undirected",weighted=TRUE, diag=FALSE)

#V(net_MST)$label = rownames(mat_cities)

edges_mst = get.edgelist(net_MST) # convert the matrix into a vector by row (using transpose)

vec_mst = as.vector(t(edges_mst))

edge_mst = get.edge.ids(graph=net_T2R,vp=vec_mst)

## Plotting
png(file=filepath_res, width = 1024/72, height = 683/72, units = "in", res = 200, pointsize = 18) # width = 1024 pixels, height = 683 pixels at 72 DPI

ecol <- rep("gray80",ecount(net_T2R))
ecol[edge_mst] <- "orange"

E(net_T2R)$width = 1/E(net_T2R)$weight*15
E(net_T2R)$color = ecol
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
