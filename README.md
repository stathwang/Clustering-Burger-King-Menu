# bk_menu
Clustering Burger King Menu

Clustering is an unsupervised learning technique to find structure in data; informally, it is a way to find natural groupings among objects of interest. Here I use various clustering techniques to cluster Burger King menu items based on their nutritional values such as K-Means and Hierarchical Clustering, Gaussian Mixture and Dirichlet Process Mixture Model-Based Clustering, Spectral Clustering and Graph-Based Community Detection with Infomap.

I downloaded the recent version of full Burger King menu in PDF at its website which you can find [here](img/bk_nutrition.pdf) and converted it to an Excel [file](data/bk_nutrition.csv).

As you can see, each and every item on the menu is already grouped under its predefined category. For example, all the Whopper sandwiches are classified as "Whopper Sandwiches" and all the kids meal related menu items such as apple slices and kids oatmeal are under the "Kids Meals" category. But this kind of grouping is really not helpful, especially if you are one of the health-conscious who want to choose a menu item that is considerably healthier. It also makes more sense to group apple slices under fruits and oatmeal under breakfast instead of just lumping them all in kids meal section. 

Clustering Burger King menu items by nutritional values may reveal a different kind of groups with perhaps new surprising insights that may be more valuable for the ever growing health-conscious public. I want to know if there are menu items to certainly avoid without having to manually go through every item and analyze its nutritinoal value. Ideally I want the resulting clusters to be clear and robust, keeping in mind the number of clusters can grow with the size of the data, the number of menu items.

Please refer to my [blog](http://www.thedatalogical.com) for more information about the process and results of clustering. In the blog, I came up with 7 robust clusters using Dirichlet Process Mixture Model-Based Clustering in Python that were identified as follows:

* **Cluster 1**: Breakfast
* _Cluster 2_: Chicken Burgers and Crispy Food
* _Cluster 3_: Large Size Burgers
* _Cluster 4_: Sauces, Coffees and Less Sugary Drinks
* _Cluster 5_: The Ultimate Breakfast Platter (1 Item Cluster)
* _Cluster 6_: Desserts and Sugary Drinks
* _Cluster 7_: Milkshakes

For the other clustering techniques, written here in R, I came up with around 13 clusters. K-Means and Hierarchical Clustering are fast and simple to implement but the clusters are not as robust and rather static. Gaussian Mixture Model-Based Clustering does not really give coherent clusters because Gaussian assumption does not fit well to the data. Infomap returns one huge cluster of all menu items because the adjacency matrix created from the scaled data is a network of menu items that are all too closely related which is not helpful. It's also an algorithm that attempts to find communities within a network of graphs, a sort of different problem than clustering.

After cluster generation, I create a bar graph of select representative menu items from each cluster such as the Breakfast cluster here:

![ScreenShot](/img/sample_ggplot.png)
