## Evan Anway
## Ticket to Ride - Travelling Salesman solution
## 12/14/2016
## This code calculates the shortest route between all cities (AKA the travelling salesman problem) 
## for the cities in the US version of Ticket to Ride
## Required packages: TSP

#install.packages("TSP") # install TSP

rm(list=ls()) # reset working environment

library(TSP) # set the library as TSP

filepath_dat = "E:/Personal/Experiments/Ticket2Ride/data/Ticket2Ride.csv" # set the data file path

mat_cities = as.matrix(read.csv(filepath_dat,header=TRUE,row.names=1)) # import the adjacency matrix

mat_cities[which(mat_cities==0)] <- Inf # set the zero values to infinity

sym = isSymmetric(mat_cities) # test for matrix symmetry

tsp_cities = TSP(mat_cities) # create a tsp object of the cities matrix

i = 1 # initialize loop variable
while(i <= 5000) {
  tour_cities_tmp = solve_TSP(tsp_cities) # calculate a tour of the cities
  length_min_tmp = tour_length(tour_cities_tmp) # calculate the length of the current tour
  
  if (i == 1){
    tour_cities = tour_cities_tmp # initialize the shortest tour
  }
  
  if (length_min_tmp < tour_length(tour_cities)){ # if the current tour is shorter than the shortest tour
    tour_cities = tour_cities_tmp # set the new shortest tour
    length_min = tour_length(tour_cities) # set the new minimum length
  }
  
  i = i + 1 # step loop
}

order_cities = as.integer(tour_cities) # convert the tour to a vector

write.table(order_cities,file="E:/Personal/Experiments/Ticket2Ride/data/Ticket2Ride_tsp.csv") # export the resulting adjacency matrix
