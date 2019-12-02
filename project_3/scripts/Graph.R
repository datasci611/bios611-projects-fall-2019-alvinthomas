list.of.packages <- c("tidyverse", "stringr", "lubridate", "readxl",
  "RColorBrewer", "treemapify", "patchwork")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library("tidyverse")
library("stringr")
library("lubridate")
library("readxl")
library("RColorBrewer")
library("treemapify")
library("patchwork")

proj3 <- read_csv("data/for_r.csv")

proj3_race <- proj3 %>%
  drop_na(`Total Nights`) %>%
  drop_na(`Client Primary Race`) %>%
  filter(!`Client Primary Race` %in% c("Client refused (HUD)",
                                       "Client doesn't know (HUD)",
                                       "Data not collected (HUD)")) %>%
  group_by(`Client Primary Race`, `Reason for Leaving`) %>%
  summarise(count = n(), stay_length = sum(`Total Nights`))

colourCount = length(unique(proj3_race$`Reason for Leaving`))
getPalette = colorRampPalette(brewer.pal(9, "Set1"))

p1 <- ggplot(proj3_race,
       aes(area = count,
           fill = `Client Primary Race`,
           label = `Client Primary Race`)) +
  geom_treemap() +
  geom_treemap_text(colour = "white", place = "topleft", reflow = T) +
  scale_fill_manual(name = "Client Primary Race", values = getPalette(colourCount)) +
  theme(legend.position="bottom")
ggsave(filename = "results/race_count.png")

p2 <- ggplot(proj3_race,
       aes(area = stay_length,
           fill = `Client Primary Race`,
           label = `Client Primary Race`)) +
  geom_treemap() +
  geom_treemap_text(colour = "white", place = "topleft", reflow = T) +
  scale_fill_manual(name = "Client Primary Race", values = getPalette(colourCount))
ggsave(filename = "results/race_stay.png")

p1 + p2
ggsave(filename = "results/race_combined.png")
