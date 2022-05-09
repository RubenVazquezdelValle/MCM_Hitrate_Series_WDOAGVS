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
##    Constants
###############################################################################
###############################################################################


Starting_date<-as.Date("2022-03-21")


###############################################################################


# Create input folder on working directory to download source files
mydir<-getwd()
inputdir<-paste(mydir,"/Input",sep="")
# dir.create(path=inputdir,mode="0777")  Only executable the first time



#List files to upload from input dir
dw_files<-list.files(path=inputdir)


#upload n files and save them into Input_file_n  tibbles

for(i in (1:length(dw_files))){
  sufix<-paste(format(Starting_date+i*7,'%Y'),format(Starting_date+i*7,'%m'),format(Starting_date+i*7,'%d'),sep="")
  
  exp1 <- expression(paste("Input_file",sufix,sep="_"))                                              # Create name of the tibble expression
  exp2<- expression(read_delim(file=paste(inputdir,dw_files[i],sep="/"),delim=";",col_names=TRUE))   # Create read_delim expression
  z<-paste(eval(exp1),exp2,sep="<-")                                                                 # Create assignation expression as a string
  eval(parse(text=z))                                                                                # Evaluate expression
}

#Get week on wich each Input_file_n was performed

for(i in (1:length(dw_files)))
{
  sufix<-paste(format(Starting_date+i*7,'%Y'),format(Starting_date+i*7,'%m'),format(Starting_date+i*7,'%d'),sep="")
  print(sufix)
}



