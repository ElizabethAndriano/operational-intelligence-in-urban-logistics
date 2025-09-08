# EDA report

Dataset by Den_Kuznetz on Kaggle: [Food Delivery Time Prediction](https://www.kaggle.com/datasets/denkuznetz/food-delivery-time-prediction/data?select=Food_Delivery_Times.csv).

## Dataset description

These dataset was synthetically generated using statistical distributions and logical relationships to mimic real-world scenarios in food delivery.

Key features:

* Order_ID: `int` unique identifier for each order. 
* Distance_km: `float` delivery distance in km.
* Weather: `str` weather conditions during the delivery.
    * Categories: Clear, Rainy, Snowy, Foggy, Windy.
* Traffic_Level: `str` traffic conditions.
    * Categories: Low, Medium, High.
* Vehicle_Type: `str` type of vehicle used for delivery.
    * Categories: Bike, Scooter, Car.
* Preparation_Time_min: `int`time required to prepare the order, measured in minutes.
* Courier_Experience_yrs: `int` experience of the courier in years.
* Delivery_Time_min: `int` **Target variable** total delivery time in minutes.

## Numerical Features exploration

Exploratory analysis for numerical features. Order_ID is excluded from this analysis because it is only used as an identifier.

The correlation heatmap shows that there is no significant correlation between predictor variables, therefore no problem with multicollinearity. This affirmation is only true for numerical features at this moment, more analysis with categorical values need to be made before ruling out multicollinearity problems in the dataset.

As expected, there is significant positive correlation between delivery distance and time; weak correlation between preparation and delivery time, and almost no correlation between the couriers experience and their delivery time.

![Correlation Heatmap of Numerical Features](figures/heatmap_num.png)

Kolmogorov-Smirnov test was performed to all numerical features to check whether they follow a normal, uniform or gamma distribution. `Distance_km` and `Preparation_Time_min` features follow an uniform distribution, and even when `Courier_Experience_yrs` p-value didn't account for an uniform distribution, its histogram shows behavior similar to a uniform distribution. Meanwhile, `Delivery_Time_min` resembles a gamma distribution. 

![Distribution of Numerical Features](figures/distribution_num.png)

No predictive feature has outliers. The target variable `Delivery_Time_min` has 5 outliers greater than the upper fence that account for 0.5% of the data.

![Box Plot of Numerical Features](figures/boxplots_num.png)