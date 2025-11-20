# Soft Integration of Geo-Tagged Data Sets in J-CO-QL+

### Abstract
The possibility offered by the current technology to collect and store data sets regarding
public places located on the Earth globe is posing new challenges, as far as the integration of these
data sets is concerned. Analysts usually need to perform such an integration from scratch, without
performing complex and long preprocessing or data-cleaning tasks, as well as without performing
training activities that require tedious and long labeling of data; furthermore, analysts now have to
deal with the popular JSON format and with data sets stored within JSON document stores. This
paper demonstrates that a methodology based on soft integration (i.e., data integration performed
through soft computing and fuzzy sets) can now be effectively applied from scratch, through the
J-CO Framework, which is a stand-alone tool devised to process JSON data sets stored within JSON
document stores, possibly by performing soft querying on data sets. Specifically, the paper provides
the following contributions: (1) It presents a soft-computing technique for integrating data sets
describing public places, without any preliminary pre-processing, cleaning and training, which
can be applied from scratch; (2) it presents current capabilities for soft integration of JSON data
sets, provided by the J-CO Framework; (3) it demonstrates the effectiveness of the soft integration
technique; (4) it shows how a stand-alone tool able to support soft computing (as the J-CO Framework)
can be effective and efficient in performing data-integration tasks from scratch.


## PDF
[IJGI2022-SoftIntegrationofGeo-TaggedDataSetsinJ-CO-QL+.pdf](/papers/pdf/10.%20SoftIntegrationofGeo-TaggedDataSetsinJ-CO-QL+.pdf) 


## DATASET
| Dataset | Description |
| -------- | ----------- | 
| [FacebookDescriptors.json](/papers/dataset/10.ijgi2022/FacebookDescriptors.json) | JSON dataset containing Facebook place descriptors used for geo-tagged data integration experiments |
| [FacebookDescriptorsGold.json](/papers/dataset/10.ijgi2022/FacebookDescriptorsGold.json) | Gold standard reference dataset for Facebook place descriptors |
| [GoogleDescriptors.json](/papers/dataset/10.ijgi2022/GoogleDescriptors.json) | JSON dataset containing Google place descriptors for comparison and integration with Facebook data |
| [GoogleDescriptorsGold.json](/papers/dataset/10.ijgi2022/GoogleDescriptorsGold.json) | Gold standard reference dataset for Google place descriptors |
| [SamePlaces.json](/papers/dataset/10.ijgi2022/SamePlaces.json) | Dataset containing matched places between different data sources |
| [SamePlacesGold.json](/papers/dataset/10.ijgi2022/SamePlacesGold.json) | Gold standard reference for place matching validation |

## SCRIPTS

Below are the scripts updated to version 4.0 of the JCoQL+ parser.

| Script | Description | Last Tested|
| -------- | ----------- |-------------|
| [1. Fuzzy Operators](/papers/scripts/10.%20IJGI%202022%20-%20Soft%20Integration%20of%20Geo-Tagged%20Data%20Sets%20in%20J-CO-QL+/1.%20Fuzzy%20Operators.txt) | Definition of fuzzy operators used for soft integration of geo-tagged data | 11/2025 |
| [2. Retrieving and joining collections](/papers/scripts/10.%20IJGI%202022%20-%20Soft%20Integration%20of%20Geo-Tagged%20Data%20Sets%20in%20J-CO-QL+/2.%20Retrieving%20and%20joining%20collections.txt) | Scripts for data retrieval and collection joining operations | 11/2025 |
| [3. Matching places](/papers/scripts/10.%20IJGI%202022%20-%20Soft%20Integration%20of%20Geo-Tagged%20Data%20Sets%20in%20J-CO-QL+/3.%20matching%20places.txt) | Implementation of place matching algorithms using fuzzy logic | 11/2025 | 
| [4. Selecting best pairs](/papers/scripts/10.%20IJGI%202022%20-%20Soft%20Integration%20of%20Geo-Tagged%20Data%20Sets%20in%20J-CO-QL+/4.%20Selecting%20best%20pairs.txt) | Script for selecting optimal place pairs from integration results | 11/2025 |

---

[← Back to Papers](/papers/readme.md)
