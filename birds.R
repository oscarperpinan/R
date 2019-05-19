## Datos obtenidos de
## https://lifewatch.inbo.be/blog/files/bird_tracking.zip
birds <- read.csv("data/bird_tracking.csv")
birds$date_time <- as.POSIXct(birds$date_time)

nico <- subset(birds, bird_name == "Nico")
eric <- subset(birds, bird_name == "Eric")
sanne <- subset(birds, bird_name == "Sanne")

write.csv(eric, file = "data/eric.csv", row.names = FALSE)
write.csv(nico, file = "data/nico.csv", row.names = FALSE)
write.csv(sanne, file = "data/sanne.csv", row.names = FALSE)
 



