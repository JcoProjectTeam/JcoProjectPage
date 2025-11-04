# J-CO, a framework for fuzzy querying collections of json documents

This paper accompanies a live demo during which we will
show the J-COFramework, a novel framework to manage large collec-
tions of JSONdocuments stored in NoSQLdatabases. J-CO-QLis the
query language around which the framework is built; we show how it is
able to perform fuzzy queries on JSONdocuments.
This paper briefly introduces the framework and the cross-analysis
process presented during the live demo at the conference.

## PDF
[J-CO a framework for fuzzy querying collections of json documents.pdf](/papers/pdf/7.%20J-CO,%20a%20framework%20for%20fuzzy%20querying%20collections%20of%20json%20documents.pdf)

## DATASET

| Dataset | Description | 
|---------|-------------|
| [FQAS_Destination.DetectedWeatherStations.json](../dataset/7%20.J-CO,%20a%20framework%20for%20fuzzy%20querying%20collections%20of%20json%20documents/FQAS_Destination.DetectedWeatherStations.json) | Destination collection containing detected weather stations data, used as the target dataset for the cross-analysis fuzzy querying demonstration | 
| [FQAS_Source.Rain.json](../dataset/7%20.J-CO,%20a%20framework%20for%20fuzzy%20querying%20collections%20of%20json%20documents/FQAS_Source.Rain.json) | Source collection with rainfall measurements data, used to demonstrate fuzzy querying and cross-analysis capabilities | 
| [FQAS_Source.Temperatures.json](../dataset/7%20.J-CO,%20a%20framework%20for%20fuzzy%20querying%20collections%20of%20json%20documents/FQAS_Source.Temperatures.json) | Source collection with temperature measurements data, combined with rain data for the fuzzy cross-analysis process | 

## SCRIPTS

| Script | Description | Last Tested |
|--------|-------------|-------------|
| [1. J-CO-QL cross-analysis process (part 1) Fuzzy operators.txt](../scripts/7.%20J-CO,%20a%20framework%20for%20fuzzy%20querying%20collections%20of%20json%20documents/1.%20J-CO-QL%20cross-analysis%20process%20(part%201)%20Fuzzy%20operators.txt) | First part of the cross-analysis demonstration: defines fuzzy operators for evaluating weather conditions (e.g., "high temperature", "heavy rain") using linguistic variables | 11/2025 |
| [2. J-CO-QL cross-analysis process (part 2) Joining Collections.txt](../scripts/7.%20J-CO,%20a%20framework%20for%20fuzzy%20querying%20collections%20of%20json%20documents/2.%20J-CO-QL%20cross-analysis%20process%20(part%202)%20Joining%20Collections.txt) | Second part: demonstrates how to join multiple JSON collections (rain and temperature data) for integrated analysis | 11/2025 |
| [3. J-CO-QL cross-analysis process (part 3) Evaluating Fuzzy Sets](../scripts/7.%20J-CO,%20a%20framework%20for%20fuzzy%20querying%20collections%20of%20json%20documents/3.%20J-CO-QL%20cross-analysis%20process%20(part%203)%20Evaluating%20Fuzzy%20Sets) | Third part: applies fuzzy set evaluation to the joined collections, showcasing the complete fuzzy querying capabilities of the J-CO framework | 11/2025 |
