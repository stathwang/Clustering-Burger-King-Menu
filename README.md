---
output: html_document
---
# bk_menu
Clustering Burger King Menu

Clustering is an unsupervised learning technique to find structure in data; informally, it is a way to find natural groupings among objects of interest. Here I use various clustering techniques to cluster Burger King menu items based on their nutritional values such as K-Means and Hierarchical Clustering, Dirichlet Process Mixture Model-Based Clustering, Spectral Clustering and Graph-Based Community Detection with Infomap.

Each and every item on the menu is already grouped under its predefined category. For example, all the Whopper sandwiches are classified as "Whopper Sandwiches" and all the kids meal related menu items such as apple slices and kids oatmeal are under the "Kids Meals" category. But this kind of grouping is really not helpful, especially if you are one of the health-conscious who want to choose a menu item that is considerably healthier. It also makes more sense to group apple slices under fruits and oatmeal under breakfast instead of just lumping them all in kids meal section. Clustering Burger King menu items by nutritional values may reveal a different kind of groups with perhaps new surprising insights that may be more valuable for the ever growing health-conscious public. I want to know if there are menu items to certainly avoid without having to manually go through every item and analyze its nutritinoal value. Ideally I want the resulting clusters to be clear and robust, keeping in mind the number of clusters can grow with the size of the data, the number of menu items.
