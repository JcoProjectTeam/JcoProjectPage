# Toward an analyst-oriented polystore framework for processing JSON geo-data

### Abstract
Geo-data sets represented as JSON documents are provided by many sources over the Internet. Consequently, many
storage technologies are adopted for managing them, namely NoSQL databases such are MongoDB and ElasticSearch.
To allow analysts to effectively perform complex analysis processes, such as integration and transformations possibly
based on spatial properties, a framework that provides a unified view of different database systems based on different
technology is necessary, so that analysts are unaware of specific characteristics of different database systems. In other
words, we follow a polystore approach.
The presented framework, named J-CO, provides a query language and an execution engine that, together, enable
analysts to specify complex transformation processes on JSON geo-data sets. High-level operator natively support spatial
operations, and completely hide technical details of the integrated database systems. This way, a novel data store
component, named J-CO-DS, can be seamlessly introduced, to overcome limitations characterizing other NoSQL
database systems. The paper presents the framework and the novel features (w.r.t. our previous works); then, it shows the
effectiveness of the framework itself through an example.

## PDF
[Toward an analyst-oriented polystore framework for processing JSON geo-data.pdf](/papers/pdf/2.%20Toward%20an%20analyst-oriented%20polystore%20framework%20for%20processing%20json%20geo-data.pdf)

## DATASET
| Dataset | Description |
| -------- | ----------- | 
| [Dataset folder](/papers/dataset/2.%20Toward%20an%20analyst-oriented%20polystore%20framework%20for%20processing%JSON%20geo-data/) | Dedicated dataset folder for polystore framework examples (currently empty - datasets referenced from multiple sources) |

## SCRIPTS
| Script | Description | Last Tested |
| -------- | ----------- | ----------- |
| [1. script 1](/papers/scripts/2.%20Toward%20an%20analyst-oriented%20polystore%20framework%20for%20processing%20JSON%20geo-data/1.%20script%201) | Polystore query example demonstrating cross-database operations with J-CO-DS, MongoDB, and ElasticSearch integration for processing country boundaries data | |