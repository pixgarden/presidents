


#path <- file.choose()

setwd("~/Documents/R/presidents")

popularity <- read.csv("popularity_v2.csv")

#install.packages("splitstackshape")

library(tidyverse)
library(lubridate)
library(dbplyr)
#library(splitstackshape)

#as.POSIXct(popularity2$Date, format = "%mmm-%yy")

#popularity <- cSplit(popularity2, 'Person', sep="|", type.convert=FALSE)
#

#popularity <- dplyr::arrange(popularity2, Date)


#popularity2 <- popularity2 %>%
#  filter(President.of.France != "1974 /1981 V. Giscard d'Estaing")


#popularity$Date <- 
  

  
popularity$Date <-  as.Date(paste("01-",popularity$Date), format="%d- %b-%y")
  

#library(ggplot2)
#library(esquisse)
#esquisse::esquisser()

library(ggplot2)
#install.packages("directlabels")
library(directlabels)


popularity$Type_order = factor(popularity$Type, levels=c('Presidents','PM\'s'))
popularity$Wing = factor(popularity$Wing, levels=c('Left-wing','Right-wing','It\'s complicated'))

ggplot(data = popularity) +
  aes(x = Date, y = Trust.Rating, color = Wing, fill = Person_1) +
  geom_line() +
  theme_minimal() +
  facet_wrap(vars(Type))+
  facet_grid(rows = vars(Type))+
  expand_limits(y=c(15,90))+
  scale_color_manual(values=c( "#e20040","#000080","#8A2BE2"))+
  geom_dl(aes(label = Person_2), method = list(dl.trans(y = y+ 1.2), dl.trans(x = x + 1.2), dl.combine("first.bumpup"), cex = 0.8)) +
  facet_grid(rows = vars(Type_order))+
  labs(x = "Time")+
  labs(y = "Popularity ratings")+
  labs(title= "\nFrench presidents' popularity ratings compare to PM's\n")+
  labs(color = "Political spectrum")+
  theme(plot.title = element_text(size=25, face = "bold"))+
  theme(axis.text = element_text( size = 14 ),
         #axis.text.x = element_text( size = 20),
         #axis.title = element_text( size = 14 ),
         #legend.position="top",
         # The new stuff
         strip.text = element_text(size = 20))+
  theme(plot.margin=unit(c(1,1,1.5,1.2),"cm"))+
  theme(legend.position=c(0.95,1.08))+
  theme(legend.background = element_blank())+
  theme(legend.box.background = element_rect(colour = "grey"))
  #theme(legend.direction="horizontal")

  #      legend.justification=c(0, 0),
  #      legend.direction="horizontal")
  #theme(face = element_text(size=35)
  #
#
#facet_grid(.~Type)
#geom_dl(aes(label = Person), method = list(dl.combine("first.points", "last.points"), cex = 0.8)) 

#  


