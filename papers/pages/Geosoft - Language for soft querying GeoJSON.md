# Geosoft: a language for soft querying features within geojson information layers

### Abstract
GeoJSON has become one of the most popular format for represent-
ing spatial information. Its popularity is due to the fact that it relies on JSON as
hosting syntactic structure. Currently, querying in an effective way a GeoJSON
document, to extract features of interests, can be hard, for various reasons.
In this paper, we propose a domain-specific language named GeoSoft: it 
is a high-level tool that hides details of the GeoJSON format, which enables
soft querying of features, to express imprecise queries. The paper shows that a
GeoSoft query can be effectively and automatically translated into a J-CO-QL
script, which is executed by the J-CO Framework, i.e., the execution engine we
chose for GeoSoft.

## PDF
[Geosoft a language for soft querying features within geojson information layers.pdf](/papers/pdf/3.%20Geosoft%20a%20language%20for%20soft%20querying%20features%20within%20geojson%20information%20layers.pdf) 

## DATASET
| Dataset | Description | Last Tested |
| -------- | ----------- | ----------- |
| [NUTS_Info.DetectedNUTS.json](/papers/dataset/3.%20Geosoft%20a%20language%20for%20soft%20querying%20features%20within%20geojson%20information%20layers/NUTS_Info.DetectedNUTS.json) | JSON dataset containing detected NUTS (Nomenclature of Territorial Units for Statistics) regions for GeoSoft analysis | |
| [NUTS_Info.NUTSCollection.json](/papers/dataset/3.%20Geosoft%20a%20language%20for%20soft%20querying%20features%20within%20geojson%20information%20layers/NUTS_Info.NUTSCollection.json) | JSON collection of NUTS territorial units used for demonstrating GeoSoft soft querying capabilities | |

## SCRIPTS
| Script | Description | Last Tested |
| -------- | ----------- | ----------- |
| [1. Defining Fuzzy Operator](/papers/scripts/3.%20Geosoft%20a%20language%20for%20soft%20querying%20features%20within%20geojson%20information%20layers%20International%20Conference%20on%20Web/1.%20Defining%20Fuzzy%20Operator.txt) | Definition of fuzzy operators for soft spatial querying in GeoSoft language |10/2025|
| [2. Soft querying with JcoQl](/papers/scripts/3.%20Geosoft%20a%20language%20for%20soft%20querying%20features%20within%20geojson%20information%20layers%20International%20Conference%20on%20Web/2.%20Soft%20querying%20with%20JcoQl) | Examples of soft querying operations using J-CO-QL integration with GeoSoft | |
| [3. Translation of the GeoSoft query preamble](/papers/scripts/3.%20Geosoft%20a%20language%20for%20soft%20querying%20features%20within%20geojson%20information%20layers%20International%20Conference%20on%20Web/3.%20Translation%20of%20the%20GeoSoft%20query%20preamble) | Translation of GeoSoft query preamble syntax to executable J-CO-QL code | |
| [4. Translation of the GeoSoft query core](/papers/scripts/3.%20Geosoft%20a%20language%20for%20soft%20querying%20features%20within%20geojson%20information%20layers%20International%20Conference%20on%20Web/4.%20Translation%20of%20the%20GeoSoft%20query%20core) | Core query translation demonstrating main GeoSoft spatial operations | |
| [5. Translation of the GeoSoft query tail](/papers/scripts/3.%20Geosoft%20a%20language%20for%20soft%20querying%20features%20within%20geojson%20information%20layers%20International%20Conference%20on%20Web/5.%20Translation%20of%20the%20GeoSoft%20query%20tail) | Final part of GeoSoft query translation showing result processing and output formatting | |