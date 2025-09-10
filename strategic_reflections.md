# Strategic reflections

## Model Failure

> Your model underestimates delivery time on rainy days. Do you fix the model, the data, or the business expectations?

Before fixing the model, there should be an exploratory analysis to understand why the model underestimates on rainy days. Given the error trend is not random, the model could be optimized whether by fine-tunning the model, via feature engineering or adding new variables.

After all these process is done and model experimentation has finished, the business expectations should be adjusted according the model performance.

## Transferability

> The model performs well in Mumbai. It’s now being deployed in São Paulo. How do you ensure generalization?

First, the data from São Paulo should follow the same distribution and behaviour from the Mumbai model in order to have replicable results. Since the model is a linear regression, the predictor features should not hace multicollinearity in order to ensure that the explainability of the model and its insights are guaranteed.

## GenAI Disclosure

> Generative AI tools are a great resource that can facilitate development, what parts of this
project did you use GenAI tools for? How did you validate or modify their output?

Generative Ai was used with Github Copilot to help develop faster code by helping with format and in-code documentation. Its input did not have direct involvement in data treatment for exploration and modeling. Its output was validated by corroborating the resulting info with the actual code.

Other external tools used include `sklearn` and `plotly` web documentation for code reference and different [Medium](https://medium.com/) articles for modeling references and code best practices.

## Your Signature Insight

> What's one non-obvious insight or decision you're proud of from this project?

For the Business Understanding via SQL, I am proud of the aditional querys created to understand better the business because they include practices from business perspective by using as baseline the *Why-Why* approach. This led to better business questions that could help consider additional data to improve the model such as considering the distribution between courier-customers and high demand days for a specific customer area.

Moreover, the inclusion of an analysis for numerical-categorical correlation is something not covered by DS courses for Data Exploration, but the aproach helped guarantee the model approach is well implemented, which leads to trusted insights for the Ops team.

## Going to Production

> How would you deploy your model to production? What other components would you
need to include/develop in your codebase? Please be as detailed each step of the process, and feel free to showcase some of these components in the codebase.

1. Business Understanding: before starting deployment process for production, the developing team should have a defined project charter and clear business expectations to avoid developing a product without the desired outcome.
2. Benchmark with Business: understand if and how the business aproaches the problem at the moment and use significant insights to upgrade the model,
3. Pipeline: the data used for the model training and final result should be stored on a well maintained server that ensures data flow and preprocesing for the model.
4. Cloud based model infraestructure: although not necesary, cloud based infraestructure brings several benefits to the final model in production and helps integration with further data serving tools for easy access to the Ops team.
5. Re-traning: a re-training trigger should be stablished to ensure the best results, either by performance decay or scheduled re-trainings.
6. UAT and other software testing tools: having a testing phase during development will help to find any missing features that may have been overlooked in the development process.
7. Visualization / Final product: deliver the model results in an easy to use and undertand final product that the Ops team may access without needing any technical expertise.

Other considerations for the model deployment would be to consider further variables and create a longer POC to explore complex and composite models that could have better results according to the business needs.