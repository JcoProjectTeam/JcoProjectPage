# Soft querying powered by user-defined functions in J-CO-QL+

### Abstract
[Abstract to be added]

## PDF
[Soft querying powered by user-defined functions in J-CO-QL+.pdf](/papers/pdf/14.%20Soft%20querying%20powered%20by%20user-defined%20functions%20in%20J-CO-QL+.pdf)

## DATASET

| Dataset | Description | Last Tested |
|---------|-------------|-------------|
| [NeuroComputingDb.FacebookDescriptors.json](../dataset/14.%20Soft%20querying%20powered%20by%20user-defined%20functions%20in%20J-CO-QL+/NeuroComputingDb.FacebookDescriptors.json) | Descriptor collection extracted from Facebook-like place profiles used for soft matching and similarity-based integration | |
| [NeuroComputingDb.GoogleDescriptors.json](../dataset/14.%20Soft%20querying%20powered%20by%20user-defined%20functions%20in%20J-CO-QL+/NeuroComputingDb.GoogleDescriptors.json) | Descriptor collection extracted from Google Places-like profiles used to demonstrate cross-source fuzzy matching and ranking | |
| [NeuroComputingDb.RankedPlaces.json](../dataset/14.%20Soft%20querying%20powered%20by%20user-defined%20functions%20in%20J-CO-QL+/NeuroComputingDb.RankedPlaces.json) | Result dataset with ranked places after applying similarity functions and fuzzy aggregators, used as example output | |

## SCRIPTS

| Script | Description | Last Tested |
|--------|-------------|-------------|
| [1. JavaScript function named GeoKmDistance](../scripts/14.%20Soft%20querying%20powered%20by%20user-defined%20functions%20in%20J-CO-QL+/1.%20JavaScript%20function%20named%20GeoKmDistance) | JavaScript implementation of GeoKmDistance to compute haversine distance in kilometers, used within J-CO-QL+ user-defined functions | |
| [2.  JavaScript function named JaroWinklerSimilarity](../scripts/14.%20Soft%20querying%20powered%20by%20user-defined%20functions%20in%20J-CO-QL+/2.%20%20JavaScript%20function%20named%20JaroWinklerSimilarity) | JavaScript implementation of Jaro-Winkler string similarity for fuzzy name matching between place descriptors | |
| [3. Java function named GeoKmDistance](../scripts/14.%20Soft%20querying%20powered%20by%20user-defined%20functions%20in%20J-CO-QL+/3.%20Java%20function%20named%20GeoKmDistance) | Java implementation of GeoKmDistance (alternative to JS) for environments using Java-based UDFs | |
| [4. Defining Fuzzy operators](../scripts/14.%20Soft%20querying%20powered%20by%20user-defined%20functions%20in%20J-CO-QL+/4.%20Defining%20Fuzzy%20operators) | Script that defines fuzzy operators leveraging the user-defined functions (distance and similarity) for matching and ranking | |
| [5. Processing Data](../scripts/14.%20Soft%20querying%20powered%20by%20user-defined%20functions%20in%20J-CO-QL+/5.%20Processing%20Data) | End-to-end processing script that applies UDFs, joins collections, and produces the ranked output dataset | |