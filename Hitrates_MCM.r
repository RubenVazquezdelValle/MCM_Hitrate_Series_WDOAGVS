library(tidyverse)
rm(list = ls())


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


# Create Hitrate dataset

Hitrate<- tibble()


## Loop for uploading source files, adding each file its corresponding week and finnally append them into Hitrate dataset


for(i in (1:length(dw_files))){
  sufix<-paste(format(Starting_date+(i-1)*7,'%Y'),format(Starting_date+(i-1)*7,'%m'),format(Starting_date+(i-1)*7,'%d'),sep="")

  
#upload n files and save them into Input_file_yyymmdd  tibbles
  
  exp1 <- expression(paste("Input_file",sufix,sep="_"))                                              # Create name of the tibble expression
  exp2<- expression(read_delim(file=paste(inputdir,dw_files[i],sep="/"),delim=";",col_names=TRUE))   # Create read_delim expression
  z<-paste(eval(exp1),exp2,sep="<-")                                                                 # Create assignation expression as a string
  eval(parse(text=z))                                                                                # Evaluate expression

#Get week on each Input_file_yyyymmdd through cbind expression cbind(Input_file_sufix,week=sufix)
 
  exp3<- paste("cbind(",eval(exp1),",week=sufix)",sep="")                                            # Create cbind expression
  y<-paste(eval(exp1),eval(exp3),sep="<-")                                                           # Create assignation expression as a string
  eval(parse(text=y))                                                                                # Evaluate expression

#Append the source file to hitrate dataset
  
  x<-paste("Hitrate<-rbind(Hitrate,",eval(exp1),")",sep="")                                                                 # Create assignation expression as a string
  eval(parse(text=x))                                                                                # Evaluate expression
  
}


#Plotting the hitrate by week, segment and IS_WDO

Hitrate<-Hitrate%>% 
  mutate(IS_WDO = 
           factor(as.character(Hitrate$IS_WDO)))

Hitrate%>%ggplot(aes(week,HITRATE,group=IS_WDO,color=IS_WDO))+geom_point()+geom_line()+facet_grid(~ SEGMENT)

#Hitrate%>%filter(SEGMENT==3 & week!="20220418")%>%ggplot(aes(week,HITRATE,group=IS_WDO))+geom_point()+geom_line()

cor(Hitrate%>%filter(SEGMENT==2 & IS_WDO==1)%>%select(HITRATE),Hitrate%>%filter(SEGMENT==3 & IS_WDO==1)%>%select(HITRATE))