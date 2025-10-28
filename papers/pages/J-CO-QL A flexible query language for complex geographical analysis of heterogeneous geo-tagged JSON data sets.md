# J-CO-QL: A flexible query language for complex geographical analysis of heterogeneous geo-tagged JSON data sets

Analysts that wish to perform geographical analysis are provided with large volumes of publicly available geo-tagged data
sets. Often, these data sets are published by public administrations as Open Data, and are formatted as JSON objects. Furthermore,
these JSON data sets are also heterogeneous, in terms of format and structure, even though they describe the same territorial entities.
So far, analysts need new powerful tool to easily perform complex geographical analysis on large collections of geo-tagged JSON data,
possibly stored in NoSQL databases.
In this paper, we introduce the J-CO-QL: it provides a set of high level operators able to operate on heterogeneous collections of JSON
objects, explicitly dealing with geometry and providing advanced spatial aggregation and comparison capabilities. J-CO-QL relies on
an intuitive execution model that permits to write complex queries; operators are designed to be high-level operator, based on a clear
database vision of the problem and suitable for non programmers.

## PDF
[J-CO-QL A flexible query language for complex geographical analysis of heterogeneous geo-tagged JSON data sets.pdf](/papers/pdf/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets.pdf) 

## DATASET
| Dataset | Description |
| -------- | ----------- | 
| [Buildings.json](/papers/dataset/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/Buildings.json) | JSON dataset containing building structures used for complex geographical analysis examples |
| [Restaurants.json](/papers/dataset/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/Restaurants.json) | JSON dataset with restaurant data for demonstrating heterogeneous geo-tagged data analysis |
| [WaterLines.json](/papers/dataset/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/WaterLines.json) | JSON dataset containing water line features for spatial analysis demonstrations |

## SCRIPTS
| Script | Description |
| -------- | ----------- | 
| [Complete Script](/papers/scripts/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/complete_script.txt) | Complete example workflow demonstrating all J-CO-QL operations in sequence |
| [1. Spatial Join Basic](/papers/scripts/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/1.%20Spatial%20Join%20Basic.txt) | Basic spatial join operation between Buildings and WaterLines collections using intersection |
| [2. Spatial Join with Generate](/papers/scripts/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/2.%20Spatial%20Join%20with%20Generate.txt) | Spatial join with custom output generation and geometry preservation |
| [3. Spatial Join Distance](/papers/scripts/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/3.%20Spatial%20Join%20Distance.txt) | Distance-based spatial join finding buildings within 50 meters of each other |
| [4. Set Intermediate](/papers/scripts/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/4.%20Set%20Intermediate.txt) | Setting intermediate result for complex query workflows |
| [5. Join Collections](/papers/scripts/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/5.%20Join%20Collections.txt) | Non-spatial join between Buildings and Restaurants based on address matching |
| [6. Filter](/papers/scripts/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/6.%20Filter.txt) | Basic filter operation using case clauses |
| [7. Get Collection and Filter with Geometry](/papers/scripts/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/7.%20Get%20Collection%20and%20Filter%20with%20Geometry.txt) | Retrieving collection and generating geometry from latitude/longitude coordinates |
| [8. Group Basic](/papers/scripts/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/8.%20Group%20Basic.txt) | Basic grouping operation partitioning WaterLines by city |
| [9. Group with Geometry Aggregate](/papers/scripts/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/9.%20Group%20with%20Geometry%20Aggregate.txt) | Grouping with geometry aggregation for spatial data consolidation |
| [10. Group Multiple Partitions](/papers/scripts/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/10.%20Group%20Multiple%20Partitions.txt) | Advanced grouping with multiple partitions for railways and roads data |
| [11. Expand and Unpack](/papers/scripts/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/11.%20Expand%20and%20Unpack.txt) | Expanding and unpacking arrays to flatten nested data structures |
| [12. Save As](/papers/scripts/1.%20J-CO-QL%20A%20flexible%20query%20language%20for%20complex%20geographical%20analysis%20of%20heterogeneous%20geo-tagged%20JSON%20data%20sets/12.%20Save%20As.txt) | Saving query results to a new collection in the database |