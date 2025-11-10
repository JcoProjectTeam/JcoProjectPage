# Enhancing Soft Web Intelligence with User-Defined Fuzzy Aggregators

### Abstract
In our previous work, we proposed Soft Web Intelligence as the interpretation of the general notion of Web
Intelligence in the current technological panorama, in such a way JSON data sets are acquired from the Inter-
net, stored within JSON document stores and then processed and queried by means of soft computing and soft
querying methods. Specific extensions to the J-CO Framework and to its query language (named J-CO-QL+)
made possible to practically implement the concept.
However, any “data intelligence” activity does not exclude aggregating data, but J-CO-QL+ did not pro-
vide statements for defining “user-defined fuzzy aggregators”. In this paper, we present the novel constructs
introduced into J-CO-QL+ to allow users to define and use their own fuzzy aggregators, so as to evaluate
membership degrees to fuzzy sets moving from array fields within processed JSON documents. This way,
complex soft queries are enabled, so as to enhance Soft Web Intelligence

## PDF
[Enhancing Soft Web Intelligence with User-Defined Fuzzy Aggregators.pdf](/papers/pdf/17.%20Enhancing%20Soft%20Web%20Intelligence%20with%20User-Defined%20Fuzzy%20Aggregators.pdf)

## DATASET

| Dataset | Description | Last Tested |
|---------|-------------|-------------|
| [Configurations.json](../dataset/17.%20Enhancing%20Soft%20Web%20Intelligence%20with%20User-Defined%20Fuzzy%20Aggregators/Configurations.json) | Configuration parameters and settings for fuzzy aggregators used in rainfall analysis and soft web intelligence queries | |
| [MesauredRain.json](../dataset/17.%20Enhancing%20Soft%20Web%20Intelligence%20with%20User-Defined%20Fuzzy%20Aggregators/MesauredRain.json) | Measured rainfall data collected from multiple sensors/stations, used to demonstrate fuzzy aggregation techniques for weather data integration | |
| [PeaksAndLongRain.json](../dataset/17.%20Enhancing%20Soft%20Web%20Intelligence%20with%20User-Defined%20Fuzzy%20Aggregators/PeaksAndLongRain.json) | Processed dataset identifying rainfall peaks and long-duration rain events using user-defined fuzzy aggregators | |

## SCRIPTS

| Script | Description | Last Tested |
|--------|-------------|-------------|
| [Fuzzy Aggregator integrateRain.txt](../scripts/17.%20Enhancing%20Soft%20Web%20Intelligence%20with%20User-Defined%20Fuzzy%20Aggregators/Fuzzy%20Aggregator%20integrateRain.txt) | Defines the integrateRain fuzzy aggregator for combining rainfall measurements from multiple time points or sensors into a unified fuzzy evaluation | |
| [fuzzy aggregator owaRain.txt](../scripts/17.%20Enhancing%20Soft%20Web%20Intelligence%20with%20User-Defined%20Fuzzy%20Aggregators/fuzzy%20aggregator%20owaRain.txt) | Implements OWA (Ordered Weighted Averaging) aggregator specifically tailored for rainfall data, enabling soft ranking of precipitation events | |
| [retrieval and soft querying.txt](../scripts/17.%20Enhancing%20Soft%20Web%20Intelligence%20with%20User-Defined%20Fuzzy%20Aggregators/retrieval%20and%20soft%20querying.txt) | Complete J-CO-QL+ script demonstrating data retrieval from web sources and soft querying using the custom-defined fuzzy aggregators | |
| [uzzy aggregator weightedMemberships.txt](../scripts/17.%20Enhancing%20Soft%20Web%20Intelligence%20with%20User-Defined%20Fuzzy%20Aggregators/uzzy%20aggregator%20weightedMemberships.txt) | Defines weighted membership aggregator for combining multiple fuzzy set memberships with different importance weights | |