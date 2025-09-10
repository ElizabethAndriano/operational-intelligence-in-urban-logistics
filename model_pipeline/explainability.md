# Explainability

Insights for the selected model: Linear Regression.

The Linear Regression model is not affected by the scale of each feature, although the coefficients vary depending if the model feeds from different scales for the same data.

Using the raw data only with feature encoding allows to have linear relationships between the predictor numerical features and the target variable. However, the scaled model coefficents show which variables have a higher impact in the target.

For numerical features:

* `Distance_km`: for each km the delivery person has to travel, the delivery time increases almost 3 min.
* `Preparation_Time_min`: as expected, the time taken to prepare the food at the restaurant is almost linearly proportional to the delivery time.
* `Courier_Experience_yrs`: the delivery person experience has a negative impact in the delivery time, meaning that the most experienced couriers have better performance for the same order.

For categorical features:

* `Traffic_Level`: the traffic level is encoded in 3 different categories (low: 0, medium: 1, high: 2). Each level has 6 times the impact in the delivery time than ther predecesor.
* `Time_of_Day`: the time of day the order is placed has little impact on the final delivery time, but the later it is placed, the delivery time increases.
* `Weather`: each weather type has a different impact in the delivery time. As expected, worst climate conditions worsen the delivery time delaying up to aprox 4 minutes and clear weather can seed up the delivery for almost 5 min. That implies about a 10 min delay for the same delivery on bad weather days.
* `Vehicle_Type`: the vehicle used for the delivery has no great impact in the final delivery time, although it can have delays for bigger (car) or slow (bike) vehicles. The fastest delivery method is by scooter.

## Impact on the target variable

The variables that influence most of the final delivery time are `Distance_km`, `Preparation_Time_min`, `Traffic_Level`, `Weather` and `Courier_Experience_yrs`. 

Eventhough `Distance_km`, `Traffic_Level` and `Weather` are variables out of control for the team, the following systematic measures can be implemented:
* Examine the algorithm that assigns a restaurant from the same chain to ensure the nearest one available is selected in order to reduce distance impact.
* Traffic level impacts the most on bigger vehicles, so choosing couriers with scooters (or bikes if scooters are not available) on days with heavy traffic may relieve slightly the delays.
* Climate delays cannot be countered with any measures taken by the ops team, but a good delivery time estimate and a disclaimer about bad weather can help adjust the customer's expectations.

As for the courier experience, the Ops team may bechmark with experienced delivery people to get some recomendations that may help newbies perform better.