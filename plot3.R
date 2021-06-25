# Find the file-path to the working directory:
path <- getwd()
# Append to the filepath the name of the text file to be used:
file <- paste(path, "/household_power_consumption.txt", sep = "")
# Read the file into a table:
my_table <- read.table(file,header=TRUE,sep=";")
# Choose only the rows corresponding to the first two days of February 2007:
tiny_table <- subset(my_table,Date == "1/2/2007" | Date == "2/2/2007")
# Turn the date strings into objects of class date:
tiny_table$betterDate <- with(tiny_table,as.Date(Date,tryFormats="%d/%m/%Y"))
# Past the date and time together, with a space between:
tiny_table$DateAndTime <- with(tiny_table,paste(betterDate,Time,sep=" "))
# Now convert the date/time into a POSIXlt object:
tiny_table$DateTime <- with(tiny_table,strptime(DateAndTime,"%Y-%m-%d %H:%M:%S"))
# Now discard the unneeded columns:
tinier_table <- subset(tiny_table,select=-c(Date,Time,betterDate,DateAndTime))

# Here is the third graph:
png(file = "plot3.png") # (opening graphics device)
plot(tinier_table$DateTime,tinier_table$Sub_metering_1,
     type="l",
     xlab="",
     ylab = "Energy sub metering"
)
lines(tinier_table$DateTime,tinier_table$Sub_metering_2,
      col="red"
)
lines(tinier_table$DateTime,tinier_table$Sub_metering_3,
      col="blue"
)
legend("topright",                # Add legend to plot
       legend = c("Sub_metering_1", 
                  "Sub_metering_2",
                  "Sub_metering_3"),
       col = 1:3,
       lty = 1
        )
dev.off() # (saving the file)