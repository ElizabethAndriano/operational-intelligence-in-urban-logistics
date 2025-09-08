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