#load dataset
bk <- read.csv("data/bk_nutrition.csv", header = TRUE, stringsAsFactors = FALSE)
names(bk) <- tolower(lapply(names(bk), function(x) gsub("[.]", "_", x)))

#check for possible duplicates in menu items
identical(length(unique(bk$menu)), nrow(bk))
bk[bk$menu %in% bk$menu[duplicated(bk$menu)],]

#dedupe dataframe
bk <- unique(bk)
bk$menu <- tolower(bk$menu)

#k-means clustering
bk_scaled <- scale(bk[,-1])
menu_list <- bk$menu

#determine the optimal number of clusters that minimizes
#the within group sum of squares
wssplot <- function(data, num.cluster = 15, seed = 13579)
{
  wss <- (nrow(data)-1)*sum(apply(data, 2, var))
  for (i in 2:num.cluster)
  {
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers = i)$withinss)
  }
  plot(1:num.cluster, wss, type = "b", 
       xlab = "Number of Clusters", ylab = "Within Group Sum of Squares")
}
wssplot(bk_scaled)
# set the number of clusters to 13
rownames(bk_scaled) <- menu_list
fit_kmeans <- kmeans(bk_scaled, 13)
cluster_data <- data.frame(menu = names(fit_kmeans$cluster), 
                           cluster_num = fit_kmeans$cluster)
cluster_list <- split(cluster_data, as.factor(cluster_data$cluster_num))

#hierarchical clustering
d <- dist(as.matrix(bk_scaled))
fit_hclust <- hclust(d, method = "ward.D2")
plot(fit_hclust)
groups <- cutree(fit_hclust, k = 13, h = 3)
cluster_hdata <- data.frame(menu = names(groups),
                            cluster_num = as.numeric(groups))
cluster_hlist <- split(cluster_hdata, as.factor(cluster_hdata$cluster_num))
rect.hclust(fit_hclust, h = 3)

#gaussian mixture model-based clustering
library(mclust)
fit_mclust <- Mclust(bk_scaled)
plot(fit_mclust)
summary(fit_mclust)
fit_mclust$z
fit_mclust$classification
cluster_mdata <- data.frame(menu = names(fit_mclust$classification), 
                            cluster_num <- map(fit_mclust$z))
cluster_mlist <- split(cluster_mdata, as.factor(cluster_mdata$cluster_num))

#spectral clustering
library(kernlab)
fit_spec <- specc(bk_scaled, centers = 13, kernel = "rbfdot", kpar = "automatic")
cluster_sdata <- data.frame(menu = names(fit_spec),
                            cluster_num = as.numeric(fit_spec))
cluster_slist <- split(cluster_sdata, as.factor(cluster_sdata$cluster_num))

#infomap graph-based community detection
library(igraph)
g <- graph.adjacency(as.matrix(d), mode = "undirected", weighted = T, diag = F)
fit_info <- cluster_infomap(g)

# example cluster plot
library(reshape2)
library(ggplot2)
bk_subset <- bk_scaled[rownames(bk_scaled) %in% as.character(cluster_hlist[[10]]$menu),]
bk_subset_melt <- melt(bk_subset, id.vars = rownames(bk_subset))
names(bk_subset_melt) <- c("menu", "nutritions", "value")
p <- ggplot(bk_subset_melt[bk_subset_melt$menu %in% c("croissan'wich sausage, egg & cheese",
                                                      "double croissan'wich w/ ham, egg, cheese",
                                                      "sausage, egg, cheese biscuit",
                                                      "country ham and egg biscuit"),],
            aes(x = nutritions, y = value, fill = nutritions)) +
  geom_bar(stat = "identity", position = "dodge") + xlab("Nutritional Variable") +
  ylab("Z-Scaled Value") + coord_flip() + guides(fill = F) + facet_wrap( ~ menu, ncol = 2) +
  theme(strip.text.x = element_text(size = 17))
plot(p)
