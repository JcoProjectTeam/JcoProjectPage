# Soft web intelligence with the j-co framework

### Abstract
In the last two decades a plethora of approaches have been proposed
to perform Web Intelligence to discover useful knowledge over the World-Wide
Web. However, variety and vastness of the Web are still making this task a hard
challenge.
Nonetheless, the Web is evolving. An example is the advent of the JSON for-
mat as the practical standard for exchanging data over the Internet.
In our previous work, we proposed the concept of Soft Web Intelligence: it
is a modern interpretation of Web Intelligence based on the current technologi-
cal panorama, in which JSON data sets can be gathered and stored within JSON
document stores and processed by means of Soft Computing so as to Soft Query-
ing them. Soft Web Intelligence is enabled by the J-CO Framework, a software
tool that is natively able to manage, soft-query and transform collections of JSON
documents, located either in NoSQL repositories or over the Internet. The paper
illustrates our vision by presenting a plausible case study based on a weekly-
updated data set that reports COVID-19 cases in European Countries

## PDF
[Soft web intelligence with the j-co framework.pdf](/papers/pdf/13.%20Soft%20web%20intelligence%20with%20the%20j-co%20framework.pdf)

## DATASET

| Dataset | Description | Last Tested |
|---------|-------------|-------------|
| [euOfficialCovidData.json](../dataset/13.%20Soft%20web%20intelligence%20with%20the%20j-co%20framework/euOfficialCovidData.json) | Weekly-updated JSON dataset containing COVID-19 case data for European countries, used to demonstrate Soft Web Intelligence capabilities for analyzing pandemic data with fuzzy operators | |

## SCRIPTS

Below are the scripts updated to version 4.0 of the JCoQL+ parser.

| Script | Description | Last Tested |
|--------|-------------|-------------|
| [1. JCOQL+ Script preprocessing EU COVID 19 data](../scripts/13.%20Soft%20web%20intelligence%20with%20the%20j-co%20framework/1.%20JCOQL+%20Script%20preprocessing%20EU%20COVID%2019%20data) | First preprocessing script that retrieves and unpacks the European COVID-19 official data, preparing it for analysis | |
| [2. JCOQL+ Script preprocessing EU COVID 19 data](../scripts/13.%20Soft%20web%20intelligence%20with%20the%20j-co%20framework/2.%20JCOQL+%20Script%20preprocessing%20EU%20COVID%2019%20data) | Second preprocessing script that further processes and saves the most recent COVID-19 data into the soft intelligence database | |
| [3. Soft querying EU COVID 19 data](../scripts/13.%20Soft%20web%20intelligence%20with%20the%20j-co%20framework/3.%20Soft%20querying%20EU%20COVID%2019%20data) | Demonstrates soft querying using fuzzy operators (covidAlertFO) to evaluate COVID risk levels across European countries, applying alpha cuts and computing membership degrees for risk assessment | |

---

[← Back to Papers](/papers/readme.md)