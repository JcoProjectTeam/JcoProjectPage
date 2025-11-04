# Towards flexible retrieval, integration and analysis of JSON data sets through fuzzy sets: a language study

How to exploit the incredible variety of JSON data sets currently available on the Internet,
for example, on Open Data portals? The traditional approach would require getting them from the
portals, then storing them into some JSON document store and integrating them within the document
store. However, once data are integrated, the lack of a query language that provides flexible querying
capabilities could prevent analysts from successfully completing their analysis. In this paper, we
show how the J-CO Framework, a novel framework that we developed at the University of Bergamo
(Italy) to manage large collections of JSON documents, is a unique and innovative tool that provides
analysts with querying capabilities based on fuzzy sets over JSON data sets. Its query language,
called J-CO-QL, is continuously evolving to increase potential applications; the most recent extensions
give analysts the capability to retrieve data sets directly from web portals as well as constructs to
apply fuzzy set theory to JSON documents and to provide analysts with the capability to perform
imprecise queries on documents by means of flexible soft conditions. This paper presents a practical
case study in which real data sets are retrieved, integrated and analyzed to effectively show the
unique and innovative capabilities of the J-CO Framework.

## PDF
[Towards flexible retrieval integration and analysis of JSON data sets through fuzzy sets a language study.pdf](/papers/pdf/Towards%20flexible%20retrieval%20integration%20and%20analysis%20of%20JSON%20data%20sets%20through%20fuzzy%20sets%20a%20language%20study.pdf)

## DATASET

| Dataset | Description | 
|---------|-------------|
| [INFO_2021.DetectedEvents.json](../dataset/6.%20Towards%20Flexible%20Retrieval,%20Integration%20and%20Analysis%20of%20JSON%20Data%20Sets%20through%20Fuzzy%20Sets/INFO_2021.DetectedEvents.json) | Environmental sensor data from 2021 containing detected events from weather and air quality monitoring stations, including measurements for temperature, humidity, atmospheric pressure, and pollutant levels (nitric oxide). Used to demonstrate flexible retrieval and fuzzy integration of heterogeneous sensor data. | 

## SCRIPTS

| Script | Description | Last Tested |
|--------|-------------|-------------|
| [1. J-CO-QL script retrieving data about weather sensors.txt](../scripts/6.Towards%20Flexible%20Retrieval,%20Integration%20and%20Analysis%20of%20JSON%20Data%20Sets%20through%20Fuzzy%20Sets/1.%20J-CO-QL%20script%20retrieving%20data%20about%20weather%20sensors.txt) | Retrieves information about weather monitoring sensors from the environmental data set, extracting sensor metadata and station details | |
| [2. J-CO-QL script retrieving data about nitric-oxide sensors.txt](../scripts/6.Towards%20Flexible%20Retrieval,%20Integration%20and%20Analysis%20of%20JSON%20Data%20Sets%20through%20Fuzzy%20Sets/2.%20J-CO-QL%20script%20retrieving%20data%20about%20nitric-oxide%20sensors.txt) | Retrieves air quality sensor information, specifically focusing on nitric oxide (NO) monitoring stations | |
| [3. J-CO-QL script building virtual sensor stations.txt](../scripts/6.Towards%20Flexible%20Retrieval,%20Integration%20and%20Analysis%20of%20JSON%20Data%20Sets%20through%20Fuzzy%20Sets/3.%20J-CO-QL%20script%20building%20virtual%20sensor%20stations.txt) | Integrates data from weather and air quality sensors to create virtual sensor stations that combine heterogeneous measurements | |
| [4. J-CO-QL script retrieving data about weather measurements.txt](../scripts/6.Towards%20Flexible%20Retrieval,%20Integration%20and%20Analysis%20of%20JSON%20Data%20Sets%20through%20Fuzzy%20Sets/4.%20J-CO-QL%20script%20retrieving%20data%20about%20weather%20measurements.txt) | Extracts weather measurement values (temperature, humidity, pressure) from the sensor data set | |
| [5. J-CO-QL script retrieving data about air quality measurements.txt](../scripts/6.Towards%20Flexible%20Retrieval,%20Integration%20and%20Analysis%20of%20JSON%20Data%20Sets%20through%20Fuzzy%20Sets/5.%20J-CO-QL%20script%20retrieving%20data%20about%20air%20quality%20measurements.txt) | Extracts air quality measurement values, particularly nitric oxide concentration levels | |
| [6. J-CO-QL script building measure triplets.txt](../scripts/6.Towards%20Flexible%20Retrieval,%20Integration%20and%20Analysis%20of%20JSON%20Data%20Sets%20through%20Fuzzy%20Sets/6.%20J-CO-QL%20script%20building%20measure%20triplets.txt) | Constructs structured measurement triplets combining sensor station information with corresponding weather and air quality measurements | |
| [7. J-CO-QL script defining fuzzy operators.txt](../scripts/6.Towards%20Flexible%20Retrieval,%20Integration%20and%20Analysis%20of%20JSON%20Data%20Sets%20through%20Fuzzy%20Sets/7.%20J-CO-QL%20script%20defining%20fuzzy%20operators.txt) | Defines custom fuzzy operators for evaluating environmental conditions (e.g., "high temperature", "poor air quality") using linguistic variables | |
| [8. J-CO-QL script performing the fuzzy analysis.txt](../scripts/6.Towards%20Flexible%20Retrieval,%20Integration%20and%20Analysis%20of%20JSON%20Data%20Sets%20through%20Fuzzy%20Sets/8.%20J-CO-QL%20script%20performing%20the%20fuzzy%20analysis.txt) | Executes the complete fuzzy analysis pipeline, applying fuzzy operators to integrated sensor data to identify environmental conditions and patterns | |