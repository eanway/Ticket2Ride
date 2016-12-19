## Evan Anway
## Ticket to Ride - Minimum spanning tree solution
## 12/14/2016
## This code calculates the shortest set of connections between all cities (AKA the minimum spanning trees) 
## for the cities in the US version of Ticket to Ride
## Required packages: optrees

#install.packages("optrees") # install optrees

rm(list=ls()) # reset working environment

library(optrees) # set library to optrees

filepath_dat = "E:/Personal/Experiments/Ticket2Ride/data/Ticket2Ride.csv" # set path to data file

mat_cities = as.matrix(read.csv(filepath_dat,header=TRUE,row.names=1)) # import data

mat_cities[which(mat_cities==0)] <- Inf # set all cells in the adjacency matrix with zero to infinity

sym = isSymmetric(mat_cities) # test for matrix symmetry

nodes = 1:nrow(mat_cities) # create a vector of node numbers

arc_cities = Cmat2ArcList(nodes,mat_cities,directed = FALSE) # create a list of arcs between cities (useful for sparse matrices)

mst_cities = getMinimumSpanningTree(nodes,arc_cities,algorithm = "Prim",
                                    show.data=FALSE,show.graph=FALSE) # find the minimum spanning tree

mat_cities_mst = ArcList2Cmat(mst_cities$tree.nodes,mst_cities$tree.arcs,directed=FALSE) # convert the resulting arc list to a matrix

write.table(mat_cities_mst,file="E:/Personal/Experiments/Ticket2Ride/data/Ticket2Ride_mst.csv") # export the resulting matrix
