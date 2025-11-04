# Soft spatial querying on json data sets

JSON(JavaScript Object Notation) has become popular for
exchanging data sets over the Internet. Many data sets are “geo-tagged”,
since they represent spatial entities. As an effect, spatial analysts have
to perform spatial queries on JSONdata sets. While working with large
data sets, crisp (on/off) spatial relations could be marginally effective;
instead, soft relations and “soft spatial querying” could be the right tools,
because they reveal the extent of a given spatial relation. In this paper,
we present the recent evolution of J-CO-QL+, the query language of the
J-COFramework (under development at University of Bergamo, Italy)
towards soft spatial querying on geo-tagged JSONdata sets.

## PDF
[Soft spatial querying on json data sets.pdf](/papers/pdf/9.%20Soft%20spatial%20querying%20on%20json%20data%20sets.pdf)

## DATASET

| Dataset | Description | 
|---------|-------------|
| [AbdisDb.GeojsonLakes.json](../dataset/9.%20Soft%20spatial%20querying%20on%20json%20data%20sets/AbdisDb.GeojsonLakes.json) | GeoJSON dataset containing lake geometries and attributes, used to demonstrate soft spatial querying on geographical features | |
| [AbdisDb.NutsInfo.json](../dataset/9.%20Soft%20spatial%20querying%20on%20json%20data%20sets/AbdisDb.NutsInfo.json) | JSON dataset with NUTS (Nomenclature of Territorial Units for Statistics) regional information, used for spatial analysis and soft spatial relations | |
| [AbdisDb.RankedNuts.json](../dataset/9.%20Soft%20spatial%20querying%20on%20json%20data%20sets/AbdisDb.RankedNuts.json) | Processed NUTS dataset with rankings, representing the result of soft spatial querying operations on territorial units |

## SCRIPTS

| Script | Description | Last Tested |
|--------|-------------|-------------|
| [1. JCOQL part 1](../scripts/9.%20Soft%20spatial%20querying%20on%20json%20data%20sets/1.%20JCOQL%20part%201) | First part of the J-CO-QL+ soft spatial querying demonstration, defining fuzzy spatial operators and setting up the spatial analysis framework | |
| [2. JCOQL part 2](../scripts/9.%20Soft%20spatial%20querying%20on%20json%20data%20sets/2.%20JCOQL%20part%202) | Second part performing the actual soft spatial queries on geo-tagged JSON datasets, evaluating soft spatial relations between NUTS regions and lakes | |