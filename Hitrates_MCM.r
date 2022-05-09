library(tidyverse)



###############################################################################
###############################################################################
##        Functions specifically created for the project
###############################################################################
###############################################################################

## substrRight function to substract n last characters on a string
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}


## substrLeft function to substract n first characters on a string
substrLeft <- function(x, n){
  substr(x, 1, n)
}


###############################################################################
###############################################################################
###############################################################################
###############################################################################


# Create input folder on working directory to download source files
mydir<-getwd()
inputdir<-paste(mydir,"/Input",sep="")
dir.create(path=inputdir,mode="0777")



#List files to upload from input dir
dw_files<-list.files(path=inputdir)