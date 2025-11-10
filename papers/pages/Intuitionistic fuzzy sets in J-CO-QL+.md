# Intuitionistic fuzzy sets in J-CO-QL+?

### Abstract
Intuitionistic Fuzzy Sets extend the classical notion of Fuzzy
Sets, so as to represent “hesitation”: indeed, an item has both a member-
ship degree and a non-membership degree, whose sum could be less than
1; the difference denotes the “hesitation” about the fact that the item
belongs or not to the fuzzy set. Similarly, Intuitionistic Fuzzy Relations
involve two domains.
Supposing that Intuitionistic Fuzzy Sets and Relations are provided as
JSON data sets, is there a stand-alone tool to process them? This paper
studies if the constructs currently provided by J-CO-QL+ (the query
language of the J-CO Framework) for managing fuzzy sets can actually
deal with Intuitionistic Fuzzy Sets and Relations. The results will sug-
gest how to extend J-CO-QL+ to deal with classical and Intuitionistic
Fuzzy Sets in an integrated way.

## PDF
[Intuitionistic fuzzy sets in J-CO-QL+.pdf](/papers/pdf/11.%20Intuitionistic%20fuzzy%20sets%20in%20J-CO-QL+.pdf)

## DATASET

| Dataset | Description | 
|---------|-------------|
| [Diseases_Of_Patients.json](../dataset/11.Intuitionistic%20Fuzzy%20Sets%20in%20J-CO-QL+/Diseases_Of_Patients.json) | JSON dataset containing patient-disease associations with intuitionistic fuzzy membership and non-membership degrees, representing diagnostic certainty and hesitation | 
| [PatientsSymptoms.json](../dataset/11.Intuitionistic%20Fuzzy%20Sets%20in%20J-CO-QL+/PatientsSymptoms.json) | JSON dataset with intuitionistic fuzzy relations between patients and their symptoms, including membership, non-membership, and hesitation degrees | 
| [SymptomsDiseases.json](../dataset/11.Intuitionistic%20Fuzzy%20Sets%20in%20J-CO-QL+/SymptomsDiseases.json) | Intuitionistic fuzzy dataset mapping symptoms to diseases with degrees expressing certainty, uncertainty, and hesitation in diagnostic relations | 

## SCRIPTS

| Script | Description | Last Tested|
|--------|-------------|--------|
| [1.JCOQL+ script](../scripts/11.%20Intuitionistic%20fuzzy%20sets%20in%20J-CO-QL+/1.JCOQL+%20script) | First J-CO-QL+ script demonstrating how to process intuitionistic fuzzy sets, handling membership and non-membership degrees for patient-symptom-disease analysis | 11/2025 |
| [2.JCOQL+ script](../scripts/11.%20Intuitionistic%20fuzzy%20sets%20in%20J-CO-QL+/2.JCOQL+%20script) | Second J-CO-QL+ script showing advanced operations on intuitionistic fuzzy relations, including composition and reasoning with hesitation degrees | 11/2025 |
