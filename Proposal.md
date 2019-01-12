# Wine Review Proposal
## 1. Overview

When costumers filter products based on specified preferences on the website of a large liquor supply chain, they often receive pages and pages of product recommendations. One example of this can be found in [Liquor Control Board of Ontario](http://www.lcbo.com/lcbo/catalog/red-wine/11025)product search which is not good at presenting large amount of products. This can cause costumer frustration and discourage them from continuing their search for products from the company. To address this challenge and help large liquor supply chains maintain their customer base, we propose building a data visualization app that can be deployed by liquor supply chains for their costumers to visually explore and navigate a large inventory. The app will show: 1) the count distributions of recommended wines based on the factors selected by the user, 2) a mapping of wine recommendations on an interactive world map, and 3) a summary with the average price, average rating, and wine counts for each country based on the selected variables.

## 2. Dataset

We will be visualizing a [dataset]( https://www.kaggle.com/zynicide/wine-reviews/data) of 130,000 wine reviews. Each review has 12 variables that describe the wine being reviewed (description, rating, price, wine title, variety), the origin of the wine (country, province, vineyard designation, vineyard region, winery) and information about the reviewer (taster name, taster twitter handle).

## 3: Usage scenario & tasks  

The typical user as mentioned in the Overview would be a customer looking for a wine they may have not come across. Whether the user is an institutional customer (Restaurant, Bar owner etc.. ) they would use the tool in the same way. They would select the price range of the wine they would like to look at, and could select the __Minimum Rating__ for the wine they would like to look at and a __Price range__. To drill down the data they can select a particular __wine type__ to look at and/or the __Wine Country__. The map would be updated and would show the highlight the countries that have wines that fit the parameters. Hovering over the country would show the individual wines that fit the criteria and the inclusion of a map would hopefully highlight some wine producing regions the user may not have considered initially.

 The table below would show a summary of the price and rating average for each country based on the selected variables to give an overall summary by country.


## 4. Description of your app & sketch

The app contains three distinct regions. The region on the left would contain the various options the user would be using in order to subdivide the wines according to the metrics they are interested in. Using the sliders the __Price range__ and the __Minimum Rating__ can be set. For further details, the dropdown list can be used to look at specific  __wine type__ and __Wine Country__. The choises would be reflected in the table and the map.

![dashBoard](/img/Design_proposal.png "App Sketch")
