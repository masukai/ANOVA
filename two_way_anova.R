dat_fuga1 <- read.csv("fuga1.csv", header=TRUE, fileEncoding="utf-8")
dat_fuga2 <- read.csv("fuga2.csv", header=TRUE, fileEncoding="utf-8")
dat_fuga3 <- read.csv("fuga3.csv", header=TRUE, fileEncoding="utf-8")
dir.create("./graph_two", showWarnings = F, recursive = T)

sink("./two_way_anova.txt")
setwd("./graph_two")
for (i in 2:39) {
  for (j in 1:3) {
    print("", quote=F)
  }
  print(colnames(dat_fuga1)[i], quote=F)
  data_fuga1 <- data.frame(Label=dat_fuga1$X, DAS=c(rep("fuga1", 133)), z=dat_fuga1[,i])
  data_fuga2 <- data.frame(Label=dat_fuga2$X, DAS=c(rep("fuga2", 135)), z=dat_fuga2[,i])
  data_fuga3 <- data.frame(Label=dat_fuga3$X, DAS=c(rep("fuga3", 135)), z=dat_fuga3[,i])
  buff <- merge(data_fuga1, data_fuga2, all=T)
  anova <- merge(buff, data_fuga3, all=T)
  
  name = paste(colnames(dat_fuga1)[i], ".png")
  png(name, width = 700, height = 600, res = 100)
  attach(anova)
  interaction.plot(DAS, Label, z, xlab="", ylab="mean of Intensity")
  dev.off()
  
  print(summary(aov(z~DAS*Label, data=anova)))
}
setwd("../")
sink()
