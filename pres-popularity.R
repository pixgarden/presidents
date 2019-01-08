


#path <- file.choose()

setwd("~/Documents/R/presidents")

popularity2 <- read.csv("popularity.csv")

library(tidyverse)
library(lubridate)
library(dbplyr)

#as.POSIXct(popularity2$Date, format = "%mmm-%yy")



#popularity <- dplyr::arrange(popularity2, Date)


#popularity2 <- popularity2 %>%
#  filter(President.of.France != "1974 /1981 V. Giscard d'Estaing")


popularity <- popularity2[rev(order(as.Date(popularity2$Date, format="%mmm-%YY"))),]

#library(ggplot2)
#library(esquisse)
#esquisse::esquisser()

library(ggplot2)
library(grid)

p <- ggplot(data = popularity) +
  aes(x = Month.of.presidency, y = Trust.Rating, color =  popularity$Person) +
  geom_line() +
  theme_minimal() +
  facet_wrap(vars(President.of.France))+
  theme(panel.spacing = unit(2, "lines"))+
  guides(colour = FALSE)+
  labs(x = "Month of presidency")+
  labs(y = "Popularity ratings")+
  labs(title= "\nFrench presidents' popularity over month of presidency\n")+
  theme(plot.title = element_text(size=25))

p

gp <- ggplotGrob(p)

library(gtable)


#gtable_show_layout(gp)

empty.area <- gtable_filter(gp, "panel", trim = F)
empty.area <- empty.area$layout[sapply(empty.area$grob,
                                       function(x){class(x)[[1]]=="zeroGrob"}),]

empty.area$t <- empty.area$t - 1 #extend up by 1 cell to cover facet header
empty.area$b <- empty.area$b + 1 #extend down by 1 cell to cover x-axis

library(gridExtra)

gp0 <- gtable_add_grob(x = gp,
                       grobs = tableGrob("In 2000 France presidential term of\n office length switch from 7 to 5 years.\n\nSource: TNS Sofres \nOct 1978 > Dec 2018 \ndataviz:/u/pixgarden",
                                         theme = ttheme_minimal()),
                       t = min(empty.area$t), #16 in this case
                       l = min(empty.area$l), #8
                       b = max(empty.area$b), #18
                       r = max(empty.area$r), #12
                       name = "??")

#grid::grid.refresh(gp0)
grid::grid.draw(gp0)




#library(esquisse)
#esquisse::esquisser()
#library(ggplot2)

# SIMPLE ALTERNATIVE

ggplot(data = popularity) +
  aes(x = Month.of.presidency, y = Trust.Rating, color = Person) +
  geom_line() +
  scale_color_brewer(palette = "PuOr") +
  theme_minimal()
