# Model Notes

## Preprocessing

The data preprocessing process was executed by the following steps:

1. **Handling Missing Values**: based on the EDA insights, all predictor variables have no significant correlation. Thus they cannot be used to fill missing values. I decided the best aproach was to drop missing values instead of using backpropagation or filling with mean values to avoid leakage that could compromise the integrity of the final model.

2. **Feature encoding**: in order to use categorical features in different Machine Learning algorithms, their features were encoded into integers following two different aproaches:

    * Ordinal features were encoded using `OrdinalEncoder` function from `sklearn` that assigns natural numbers to each feature based on the provided order.
    * Nominal features used One Hot Encoding that creates a new binary column per each category were 1 means it is present and 0 means it is not.

3. **Feature scaling**: since some ML algorithms are sensitive to feature scaling, two datasets were created: one with scaled numerical features and one with all features scaled. This process is important because it prevents features with larger numerical ranges from disproportionately influencing algorithms and helps gradient descent models to converge more quickly.

Four datasets were created after preprocessing at different stages of the process in order to have all possible needs ready to implement based on the requirements of each model. Here's a brief description for each dataset:

|      name      | no missing values | feature encoding |       feature scaling       |
|:--------------:|:-----------------:|:----------------:|:---------------------------:|
| `clean_data_1` |         X         |                  |                             |
| `clean_data_2` |         X         |         X        |                             |
| `clean_data_3` |         X         |         X        | X (only numerical features) |
| `clean_data_4` |         X         |         X        |       X (all features)      |