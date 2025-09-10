# Model Notes

## Preprocessing

The data preprocessing process was executed by the following steps:

1. **Handling Missing Values:** based on the EDA insights, all predictor variables have no significant correlation. Thus they cannot be used to fill missing values. I decided the best aproach was to drop missing values instead of using backfill or replace with mean values to avoid leakage that could compromise the integrity of the final model.

2. **Feature encoding:** in order to use categorical features in different Machine Learning algorithms, their features were encoded into integers following two different aproaches:

    * Ordinal features were encoded using `OrdinalEncoder` function from `sklearn` that assigns natural numbers to each feature based on the provided order.
    * Nominal features used One Hot Encoding that creates a new binary column per each category were 1 means it is present and 0 means it is not.

3. **Feature scaling:** since some ML algorithms are sensitive to feature scaling, two datasets were created: one with scaled numerical features and one with all features scaled. This process is important because it prevents features with larger numerical ranges from disproportionately influencing algorithms and helps gradient descent models to converge more quickly.

Four datasets were created after preprocessing at different stages of the process in order to have all possible needs ready to implement based on the requirements of each model. Here's a brief description for each dataset:

|      name      | no missing values | feature encoding |       feature scaling       |
|:--------------:|:-----------------:|:----------------:|:---------------------------:|
| `clean_data_1` |         X         |                  |                             |
| `clean_data_2` |         X         |         X        |                             |
| `clean_data_3` |         X         |         X        | X (only numerical features) |
| `clean_data_4` |         X         |         X        |       X (all features)      |

# Modeling

All models will be evaluated with the `score` function from `sklearn` that returns the coefficient of determination (R<sup>2</sup>) for the model and five different folds for cross-validation.

## Baseline Model

For starting point in the modeling process, a Multivariable Linear Regression will be used as a baseline model to set a minimum performance threshold. A linear regression is suitable as a baseline model because of its simple an interpretable outcome and its short computing time.

        Linear Regression 
        mean cross-validation score: 0.7517 with a standard deviation of 0.0366
        test score: 0.8351

## Model comparison

Different types of models will be used to compare their score against the baseline model to choose the best ones for fine-tuning. 

Eight different regression Machine Learning Models were chosen: 
* Gamma Regression
* Bayesian Ridge
* Gradient Boosting
* Random Forest
* Decision Tree
* LightGBM
* Linear SVR
* KNeighbors

All models were trained with the same train-test split and base parameters from their corresponding python library.

**Best performance per model ordered by test score**

|               model              |    dataset   | score cv mean | score cv std | score test |
|:--------------------------------:|:------------:|:-------------:|:------------:|:----------:|
| Linear Support Vector Regression | clean_data_2 |    0.748834   |   0.031044   |  0.836097  |
|          Bayesian Ridge          | clean_data_3 |    0.751822   |   0.035869   |  0.835099  |
|         Gradient Boosting        | clean_data_4 |    0.725160   |   0.035505   |  0.770479  |
|           Random Forest          | clean_data_3 |    0.699834   |   0.053504   |  0.762628  |
|             LightGBM             | clean_data_4 |    0.717549   |   0.039740   |  0.761799  |
|         Gamma Regression         | clean_data_2 |    0.723414   |   0.034846   |  0.759337  |
|            KNeighbors            | clean_data_2 |    0.759337   |   0.061167   |  0.720834  |
|           Decision Tree          | clean_data_3 |    0.361068   |   0.111591   |  0.411825  |

Since only Linear SVR and Bayesian Ridge models have similar or better outcomes than the Linear Regression, they will be the only models that will have hyperparameter fine-tuning.