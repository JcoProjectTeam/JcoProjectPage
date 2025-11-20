# Powering soft querying in J-CO-QL with JavaScript functions

### Abstract
The availability of large data sets represented as JSON doc-
uments is demanding for powerful tools able to integrate and query them.
The J-CO Framework is a research prototype under development at Uni-
versity of Bergamo (Italy), specifically devised to provide practical tools
to manage possibly large JSON data sets. Its query language, named
J-CO-QL, provides constructs to evaluate the belonging of documents
to fuzzy sets, so as to perform soft queries on JSON documents. In this
paper, we present a real case study that shows how a novel construct,
which enables defining JavaScript functions within J-CO-QL queries,
provides users with an even improved possibility to personalize soft oper-
ators used to evaluate membership degrees.

## PDF
[Powering soft querying in J-CO-QL with JavaScript functions.pdf](/papers/pdf/8.%20Powering%20soft%20querying%20in%20J-CO-QL%20with%20JavaScript%20functions.pdf)

## DATASET

| Dataset | Description | 
|---------|-------------|
| [SOCO_2021.CloseSensors.json](../dataset/8.%20Powering%20soft%20querying%20in%20J-CO-QL%20with%20JavaScript%20functions/SOCO_2021.CloseSensors.json) | Collection of sensor data used to demonstrate personalized soft querying capabilities powered by user-defined JavaScript functions for evaluating proximity and custom membership degrees | 

## SCRIPTS

Below are the scripts updated to version 4.0 of the JCoQL+ parser.

| Script | Description | Last Tested |
|--------|-------------|-------------|
| [1. Definitions](../scripts/8.%20Powering%20soft%20querying%20in%20J-CO-QL%20with%20JavaScript%20functions/1.%20Definitions) | Defines custom JavaScript functions including GeoKmDistance for geographical distance calculations, enabling personalized fuzzy operators in J-CO-QL queries | 11/2025 |
| [2. Data retrieval and preprocessing](../scripts/8.%20Powering%20soft%20querying%20in%20J-CO-QL%20with%20JavaScript%20functions/2.%20Data%20retrieval%20and%20preprocessing) | Retrieves sensor data and performs preprocessing operations to prepare the dataset for soft querying with JavaScript-powered fuzzy operators | 11/2025 |
| [3. Soft querying](../scripts/8.%20Powering%20soft%20querying%20in%20J-CO-QL%20with%20JavaScript%20functions/3.%20Soft%20querying) | Demonstrates the complete soft querying process using JavaScript functions to evaluate custom membership degrees for proximity-based sensor queries | 11/2025 |

---

[← Back to Papers](/papers/readme.md)
