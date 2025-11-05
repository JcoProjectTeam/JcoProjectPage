# Fuzzy aggregators in practice: meta-model and implementation

[Abstract to be added]

## PDF
[Fuzzy aggregators in practice meta-model and implementation.pdf](/papers/pdf/15.%20Fuzzy%20aggregators%20in%20practice%20meta-model%20and%20implementation.pdf)

## DATASET

| Dataset | Description | Last Tested |
|---------|-------------|-------------|
| [Soco2023.ProductEvaluations.json](../dataset/15.%20Fuzzy%20aggregators%20in%20practice%20meta-model%20and%20implementation/Soco2023.ProductEvaluations.json) | Product evaluation data from multiple users containing ratings for brand appeal, price (cheapness), and quality perception, used to demonstrate fuzzy aggregation techniques | |
| [Soco2023.RankedProducts.json](../dataset/15.%20Fuzzy%20aggregators%20in%20practice%20meta-model%20and%20implementation/Soco2023.RankedProducts.json) | Result dataset with products ranked using fuzzy aggregators (OWA and weighted aggregation), showing final membership degrees for the "Wanted" fuzzy set | |

## SCRIPTS

| Script | Description | Last Tested |
|--------|-------------|-------------|
| [1. JCOQL script part 1](../scripts/15.%20Fuzzy%20aggregators%20in%20practice%20meta-model%20and%20implementation/1.%20JCOQL%20script%20part%201) | First part of the J-CO-QL script defining fuzzy aggregators (OWA operator and weigher) used for combining individual product evaluations into global fuzzy sets | |
| [2. JCOQL script part 2](../scripts/15.%20Fuzzy%20aggregators%20in%20practice%20meta-model%20and%20implementation/2.%20JCOQL%20script%20part%202) | Second part applying fuzzy aggregators to evaluate products across multiple criteria (Appeal, Cheapness, Perception), computing final rankings with alpha cuts and defuzzification | |