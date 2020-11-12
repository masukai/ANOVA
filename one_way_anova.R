dat <- read.csv("anova.csv", header=TRUE, fileEncoding="utf-8")
dir.create("./graph_one", showWarnings = F, recursive = T)

sink("./one_way_anova.txt")
setwd("./graph_one")
for (i in 2:39) {
  for (j in 1:3) {
    print("", quote=F)
  }
  print(colnames(dat)[i], quote=F)
  anova <- data.frame(Label=dat$X, z=dat[,i])
  
  name = paste(colnames(dat)[i], ".png")
  png(name, width = 500, height = 500, res = 100)
  boxplot(z~Label, data=anova, ylab="Intensity")
  dev.off()
  
  print(summary(aov(z~Label, data=anova)))
}
setwd("../")
sink()

