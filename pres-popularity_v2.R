


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
library(grid)

popularity$Type_order = factor(popularity$Type, levels=c('Presidents','PM\'s'))
popularity$Wing = factor(popularity$Wing, levels=c('Left-wing','Right-wing','It\'s complicated'))


df = data.frame(x=seq(1:10), y = seq(1:10))

p = ggplot(data = popularity) +
  aes(x = Date, y = Trust.Rating, color = Wing, fill = Person_1) +
  geom_line() +
  theme_minimal() +
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
         strip.text = element_text(size = 20))+
  theme(plot.margin=unit(c(1,1,1.5,1.2),"cm"))+
  theme(legend.position=c(0.95,1.08))+
  theme(legend.background = element_blank())+
  theme(legend.box.background = element_rect(colour = "grey"))

p

grid.text((paste("Source: TNS Sofres - Oct 1978 > Dec 2018 - dataviz:/u/pixgarden")),
          x = unit(.05, "npc"), y = unit(.03, "npc"), just = c("left", "bottom"), 
          gp = gpar(fontface = "bold", fontsize = 12, col = "grey"))
