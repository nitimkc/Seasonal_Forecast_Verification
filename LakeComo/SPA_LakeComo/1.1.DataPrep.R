# DATA PREP FOR SPA TEST

# exp
exp <- readRDS("/Users/peaceforlives/DATASCIENCE/PRACTICUM/Seasonal_Forecast_Verification/Data/tas/JJA.exp.rds")
Glosea5 <- exp[1,1:24,,46,26]
ECMWF   <- exp[2,,,46,26]
NCEP    <- exp[3,1:24,,46,26]
MF      <- exp[4,1:15,,46,26]

finalDF <- rbind(Glosea5, ECMWF, NCEP, MF)

# benchmark
MM <- apply(finalDF, 2,  mean)


# final exp data
finalDF <- rbind(MM, Glosea5, ECMWF, NCEP, MF)
saveRDS(finalDF, "/Users/peaceforlives/DATASCIENCE/PRACTICUM/SPA/finalDF.rds")


# diff
diff <- t(apply(finalDF, 1, function(x) x-obs))
saveRDS(diff, "/Users/peaceforlives/DATASCIENCE/PRACTICUM/SPA/diff.rds")





