# Soft Querying GeoJSON Documents within the J-CO Framework

GeoJSON documents have become important sources of information over the Web, because they describe
geographical information layers. Supposing to have such documents stored in some JSON store, the problem
of querying them in a flexible and easy way arises.
In this paper, we propose a soft-querying model to easily express queries on features (i.e., data items) within
GeoJSON documents, based on linguistic predicates. These are fuzzy predicates that evaluate the membership
degree to fuzzy sets; this way, imprecise conditions can be expressed and features can be ranked, accordingly.
The paper presents a rewriting technique that translates soft queries on GeoJSON documents into fuzzy J-
CO-QL queries: this is the query language of the J-CO Framework, an Internet-based framework able to get,
manipulate and save collections of JSON documents in a way totally independent of the source JSON store.

## PDF
[Soft Querying GeoJSON Documents within the J-CO Framework.pdf](/papers/pdf/4.%20Soft%20Querying%20GeoJSON%20Documents%20within%20the%20J-CO%20Framework.pdf)

## DATASET
| Dataset | Description | Last Tested |
| -------- | ----------- | ----------- |
| [Dataset folder](/papers/dataset/4.%20Soft%20querying%20GeoJSON%20documents%20within%20the%20J-CO%20framework/) | Dedicated dataset folder for soft GeoJSON querying examples (currently empty - uses GeoJSON documents from various sources) | |

## SCRIPTS
| Script | Description | Last Tested |
| -------- | ----------- | ----------- |
| [1. J-CO-QL query that selects features from a GeoJSON document](/papers/scripts/4.%20Soft%20querying%20GeoJSON%20documents%20within%20the%20J-CO%20framework/1.%20J-CO-QL%20query%20that%20selects%20features%20from%20a%20Geo-%20JSON%20document) | Basic J-CO-QL query for selecting features from GeoJSON documents within the framework | |
| [2. Definition of the Fuzzy Operators](/papers/scripts/4.%20Soft%20querying%20GeoJSON%20documents%20within%20the%20J-CO%20framework/2.%20Definition%20of%20the%20Fuzzy%20Operators) | Definition and implementation of fuzzy operators for soft querying of GeoJSON features | |
| [3. Fuzzy J-CO-QL Query (preamble)](/papers/scripts/4.%20Soft%20querying%20GeoJSON%20documents%20within%20the%20J-CO%20framework/3.Fuzzy%20J-CO-QL%20Query%20(preamble)) | Preamble section of fuzzy J-CO-QL queries showing setup and initialization for soft GeoJSON querying | |
| [4. Fuzzy J-CO-QL Query (core)](/papers/scripts/4.%20Soft%20querying%20GeoJSON%20documents%20within%20the%20J-CO%20framework/4.%20Fuzzy%20J-CO-QL%20Query%20(core)) | Core logic of fuzzy J-CO-QL queries demonstrating soft spatial operations and linguistic predicates | |
| [5. Fuzzy J-CO-QL Query (tail)](/papers/scripts/4.%20Soft%20querying%20GeoJSON%20documents%20within%20the%20J-CO%20framework/5.%20Fuzzy%20J-CO-QL%20Query%20(tail)) | Final section of fuzzy J-CO-QL queries showing result processing and ranking based on membership degrees | |