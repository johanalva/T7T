library(dplyr)
library(rjson)
library(lubridate)
library(dplyr)

setwd("C:/Users/johnalva/Box Sync/IBM Finance T&T/Data Sample")
df <- read.csv("F_Form1-106.csv")

df1 <- filter(df, ID != "")

# Clean Data --------------------------------------------------------------

## Selection of IMT Canada or US
df1<- subset(df, IMT. == "US" | IMT. == "Canada")

## Change sector name, Canada:
for(i in 1:nrow(df1)){
    if(df1$IMT.[i] == "Canada"){
        df1$Sector.[i] = "Canada"
    }
}

# Account= Fleetcor, the sector is “Communications” 
for(i in 1:nrow(df1)){
    if(df1$Account.Name.[i] == "Fleetcor"){
        df1$Account.Name.[i] = "Communications"
    }
}

# Dates -------------------------------------------------------------------


df2 <- df1

dateFix <- function(d1){
    d2 <- parse_date_time(d1, "%m/%d/%y HM", tz = "America/Guatemala")
    return(d2)
}


df2$Creation.Timestamp <- dateFix(df2$Creation.Timestamp)
df2$Last.Updated.Timestamp <- dateFix(df2$Last.Updated.Timestamp)
df2$Server.Time. <- dateFix(df2$Server.Time.)
df2$TTIM.Approve.Date. <- dateFix(df2$TTIM.Approve.Date.)
df2$DPE.Approve.Date. <- dateFix(df2$DPE.Approve.Date.)

df2$Budget.End.Date. <- strptime(df2$Budget.End.Date., format = "%Y-%m-%d")
df2$Budget.Start.Date. <- strptime(df2$Budget.Start.Date., format = "%Y-%m-%d")


## Pass to same format. as.Date:
df2$Creation.Timestamp <- as.Date(df2$Creation.Timestamp)
df2$Last.Updated.Timestamp <- as.Date(df2$Last.Updated.Timestamp)
df2$Server.Time. <- as.Date(df2$Server.Time.)
df2$TTIM.Approve.Date. <- as.Date(df2$TTIM.Approve.Date.)
df2$DPE.Approve.Date. <- as.Date(df2$DPE.Approve.Date.)
df2$Estimated.Finish.Date. <- as.Date(df2$Estimated.Finish.Date.)
df2$Estimated.Start.Date. <- as.Date(df2$Estimated.Start.Date.)
df2$Budget.Start.Date. <- as.Date(df2$Budget.Start.Date.)
df2$Budget.End.Date. <- as.Date(df2$Budget.End.Date.)
df2$Date.Identified. <- as.Date(df2$Date.Identified.)
df2$Next.Approval.Date <- as.Date(df2$Next.Approval.Date)
df2$Server.Time. <- as.Date(df2$Server.Time.)
df2$TTIM.Approve.Date. <- as.Date(df2$TTIM.Approve.Date.)
df2$DPE.Backup. <- as.Date(df2$DPE.Approve.Date.)

 #df3 <- df2
 #df3$PE.Approve.Date. <- as.character(df3$PE.Approve.Date.)
# 
# for(i in 1:nrow(df3)){
#     span <- dateFix(df3$PE.Approve.Date.[i])
#     if(!is.na(span)){
#         span <- as.character.Date(span)
#     }else{
#         df3$PE.Approve.Date.[i] <- df3$PE.Approve.Date.[i]
#     }
# }


#dfT <- tryCatch({month(df3$PE.Approve.Date.)}, finally = {""})


# Month Creation -----------------------------------------------------------

df2$monthCreation.Timestamp <- month(df2$Creation.Timestamp)
df2$monthLast.Updated.Timestamp <- month(df2$Last.Updated.Timestamp)
df2$monthServer.Time. <- month(df2$Server.Time.)
df2$monthTTIM.Approve.Date. <- month(df2$TTIM.Approve.Date.)
df2$monthDPE.Approve.Date. <- month(df2$DPE.Approve.Date.)
df2$monthEstimated.Finish.Date. <- month(df2$Estimated.Finish.Date.)
df2$monthEstimated.Start.Date. <- month(df2$Estimated.Start.Date.)
df2$monthBudget.Start.Date. <- month(df2$Budget.Start.Date.)
df2$monthBudget.End.Date. <- month(df2$Budget.End.Date.)
df2$monthDate.Identified. <- month(df2$Date.Identified.)
df2$monthNext.Approval.Date <- month(df2$Next.Approval.Date)
df2$monthServer.Time. <- month(df2$Server.Time.)
df2$monthTTIM.Approve.Date. <- month(df2$TTIM.Approve.Date.)
df2$monthDPE.Backup. <- month(df2$DPE.Approve.Date.)

df2$yearCreation.Timestamp <- year(df2$Creation.Timestamp)
df2$yearLast.Updated.Timestamp <- year(df2$Last.Updated.Timestamp)
df2$yearServer.Time. <- year(df2$Server.Time.)
df2$yearTTIM.Approve.Date. <- year(df2$TTIM.Approve.Date.)
df2$yearDPE.Approve.Date. <- year(df2$DPE.Approve.Date.)
df2$yearEstimated.Finish.Date. <- year(df2$Estimated.Finish.Date.)
df2$yearEstimated.Start.Date. <- year(df2$Estimated.Start.Date.)
df2$yearBudget.Start.Date. <- year(df2$Budget.Start.Date.)
df2$yearBudget.End.Date. <- year(df2$Budget.End.Date.)
df2$yearDate.Identified. <- year(df2$Date.Identified.)
df2$yearNext.Approval.Date <- year(df2$Next.Approval.Date)
df2$yearServer.Time. <- year(df2$Server.Time.)
df2$yearTTIM.Approve.Date. <- year(df2$TTIM.Approve.Date.)
df2$yearDPE.Backup. <- year(df2$DPE.Approve.Date.)

df2$daysInProgress <- as.numeric(
    as.duration(interval(df2$TTIM.Approve.Date., Sys.Date())), "days")

write.csv(df2, "testFin.csv")



install.packages("flexdashboard", type = "source")
library(flexdashboard)
