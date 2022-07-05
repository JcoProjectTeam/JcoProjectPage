# Test datasets
All datasets are _CC-By licensed_ and  have been downloaded on the 16.06.2020 (except when differently reported) from the [Milan Municipality Open-Data Portal](https://dati.comune.milano.it/)

Code	|	Description	|	Records	|	Download	|	License	|	Link	|
----------	|	----------	|	----------	|	----------	|	----------	|	----------	|
ds32	|	Swimming pools	|	28	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds32-infogeo-centribalneari-localizzazione	)|
ds342	|	Parking	|	53	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds342-trafficotrasporti-parcheggi-pubblici-localizzazione	)|
ds51	|	Restriced Areas	|	180	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds51_trafficotrasporti_aree_pedonali_ztl	)|
ds52	|	Dog's areas	|	303	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds52_infogeo_aree_cani_localizzazione_	)|
ds522	|	Green Areas	|	12	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds522_verde-urbano-aree-naturali-ville-parchi-e-giardini-2011-2016	)|
ds532	|	Bus stop sequence	|	4117	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds532-atm-composizione-percorsi-linee-di-superficie-urbane	)|
ds533	|	Metro sequence	|	790	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds533_atm-composizione-percorsi-linee-metropolitane	)|
ds534	|	Bus stops	|	2618	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds534-atm-fermate-linee-di-superficie-urbane	)|
ds535	|	Metro stations	|	110	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds535_atm-fermate-linee-metropolitane	)|
ds538	|	Bus lanes	|	194	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds538_atm-percorsi-linee-di-superficie-urbane	)|
ds539	|	Metro lines	|	38	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds539_atm-percorsi-linee-metropolitane	)|
ds60	|	Bike lanes	|	2334	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds60_infogeo_piste_ciclabili_localizzazione_	)|
ds629	|	Sport Centers	|	407	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds629-impianti-sportivi	)|
ds632	|	Public sport parks	|	6372	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds632-street-sport-orari-parchi-comunali-per-municipio	)|
ds634	|	Civic numbers	|	63529	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds634-numeri-civici-coordinate	)|
ds65	|	Bike sharing stations	|	280	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds65_infogeo_aree_sosta_bike_sharing_localizzazione_	)|
ds699	|	Weather Stations	|	32	|	08.07.2020	|	OpenData 2.0	| [click here](	https://dati.comune.milano.it/dataset/ds699_stazioni_meteorologiche_arpa_nel_comune_di_milano	)|
ds70	|	Public bike docking stations	|	1522	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds670-trasporto-pubblico-sosta-biciclette	)|
ds710	|	Radio Antennas	|	78	|	08.07.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds710-ripetitori-radiofonici	)|
ds80	|	Train stations	|	21	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds80_infogeo_stazioni_ferroviarie_localizzazione_	)|
ds81	|	Urban-train network	|	37	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds81_infogeo_rete_ferroviaria_localizzazione_	)|
ds82	|	Restricted Areas gates	|	42	|	08.07.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds82_infogeo_varchi_elettronici_localizzazione_/resource/d0283c73-135a-4077-b66b-1e2d5479aecd	)|
ds89	|	CityParks	|	1065	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds89_infogeo_parchi_giardini_localizzazione_	)|
ds964	|	City Districts	|	88	|	16.06.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds964-nil-vigenti-pgt-2030	)|
ds379	|	Administrative zones	|	9	|	22.07.2020	|	CC-By	| [click here](	https://dati.comune.milano.it/dataset/ds379-infogeo-municipi-superficie	)|

















<br/>


# Test datasets documentation

The JSON/GeoJSON documents above presented can be used to test and understand J-CO-QL.<br/><br/>
All the GeoJSON above presented have *"FeatureCollection"* as value of *"type"* field. A documentation for each file has been written. In particular, for each GeoJSON file it is offered a description of the *"properties"* fields as well as the value of the *"geometry"* field.<br/><br/>
When specified, | in "Data value" indicates that the value is one between the presented options.<br/>When the value is "ANY", any value of the type specified in "Data type" can be used.




<br/>__*ds32.centri_balneari_milano__final.geojson*__<br/>
>GeoJSON document<br/>

Georeferenced location of the swimming pools in Milan.


Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`OBJECTID`	| Object ID |	Number | ANY |
`TIPOLOGIA`	| Swimming pool type |	String | CENTRI BALNEARI\|CENTRI SPORTIVI\|PISCINE COPERTE\|VASCHE SCOPERTE 50mt |
`DENOMINAZIONE`	| Swimming pool name |	String | ANY |
`INDIRIZZO`	| Swimming pool street address |	String | ANY |
`MUNICIPIO`	| Milan administrative zone where the swimming pool is located |	Number |	1\|2\|3\|4\|5\|6\|7\|8\|9 |
`ID_NIL`	| ID uniquely identifying a NIL |	Number | ANY |
`NIL`	| Acronym for "Nuclei di Identità Locale". It indicates the city district |	String | ANY |
`x`	| X-coordinate (longitude, WGS 84) of the swimming pool location |	Number | ANY |
`y`	| Y-coordinate (latitude, WGS 84) of the swimming pool location |	Number | ANY |
`Location`	| Round brackets containing X Y coordinates separated by a comma |	String | ANY |
`geometry`	| "type" field has "Point" value |	 |	|




<br/><br/>__*ds342.parking_pub.geojson*__<br/>
>GeoJSON document<br/>

Georeferenced location of the public car parks in Milan.

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`id`	| Object ID |	Number | ANY |
`nome`	| Car park name |	String | ANY |
`n_posti`	| Number of parking spaces |	Number | ANY |
`indirizzo`	| Street address |	String | ANY |
`comune`	| Municipality of the public car park. In this GeoJSON it can be only Milan |	String | Milan |
`tipo`	| Type of car park (e.g. public, residents etc.) | String | PUBBLICI\|RESIDENTI/PUBBLICI\|AUTORIMESSA CONVENZIONATA\|PUBBLICI/RESIDENTI |
`geometry`	| "type" field has "Point" value |	 |	|




<br/><br/>__*ds51.disciplina_aree.geojson*__<br/>
>GeoJSON document<br/>

Polygonal representation of pedestrian areas (AP), Limited Traffic Zones (ZTL) and Milan area B and area C.

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`id_amat`	| Object ID |	Number | ANY |
`tipo`	| Type of restricted area |	String | AP\|ZTL\|AREA_B\|AREA_C\|CR |
`nome`	| Street address |	String | ANY |
`gruppo_id`	| na |	Number | 0 |
`ordinanza`	| Administrative order in the format ORDER_NUMBER/YEAR |	String | ANY |
`deroghe`	| Exemption from the order specifications |	String | ANY |
`val_inizio`	| Start date and time of administrative order |	String | ANY |
`val_fine`	| End date and time of administrative order |	String | ANY |
`delibera`	| The deliberation in the format DELIBERATION_NUMBER/YEAR |	String | ANY |
`tratto`	| Additional specifications about the area street address |	String | ANY |
`note`	| Notes about the restricted area |	String | ANY |
`cartello`	| Road sign which indicates the restricted area |	String or null | AP\|DT\|PP\|ZTL\|null |
`dissuasori`	| Dissuader type |	String | ANY |
`geometry`	| "type" field has "MultiPolygon" value |	 |	|




<br/><br/>__*ds52.aree_fruizione_cani.geojson*__<br/>
>GeoJSON document<br/>

Georeferenced location of the dog parks in Milan managed by "Settore Arredo Urbano" and "Verde della Direzione Centrale Tecnica".

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`ZONA`	| Milan administrative zone where the dog park is located |	Number | 1\|2\|3\|4\|5\|6\|7\|8\|9 |
`AREA`	| ID used to represent the surface portions of the dog park (as defined in the app supplied from "Settore") |	Number | ANY |
`CODICE`	| ID used to represent the "Green Typology" (as defined in the app supplied from "Settore") |	String | S327554 |
`AREA_MQ`	| Area (m2) of the dog park |	Number | ANY |
`PERIM_M`	| Perimeter (m) of the dog park |	Number | ANY |
`PARCO`	| Name of the dog park |	String | ANY |
`geometry`	| "type" field has "Polygon" value |	 |	|




<br/><br/>__*ds522.AreeVerdi.json*__<br/>
>JSON document<br/>

Data about the size (in m2) of protected natural areas (municipal management), villas, gardens, parks and urban greenery (both municipal management and other public entities) in Milan.

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`Anno`	| Year when the data was registered |	Number | ANY |
`Tipo gestione`	| Type of management |	String | Gestione Comunale\|Gestione di altri enti pubblici |
`AREE NATURALI PROTETTE`	| Size in m2 of protected natural areas |	Number | ANY |
`VILLE GIARDINI E PARCHI`	| Size in m2 of villas, gardens and parks |	Number | ANY |
`Parchi (giardini e ville) urbani`	| Size in m2 of urban parks |	Number | ANY |
`Verde attrezzato`	| Size in m2 of public green |	Number | ANY |
`Aree di arredo urbano`	| Size in m2 of street furniture |	Number | ANY |
`Forestazione urbana`	| Size in m2 of urban greenery |	Number | ANY |
`Giardini scolastici comunali`	| Size in m2 of municipal school gardens |	Number | ANY |
`Orti botanici`	| 	Size in m2 of botanical gardens |	Number | ANY |
`Orti urbani`	| Size in m2 of urban gardens |	Number | ANY |
`Cimiteri`	| Size in m2 of cemeteries |	Number | ANY |
`Aree all'aperto sportive e a servizio ludico ricreativo`	| Size in m2 of outdoor sports areas and recreational areas |	Number | ANY |
`Altre tipologie di verde urbano`	| Size in m2 of other urban green areas |	Number | ANY |
`Totale verde urbano`	| Size in m2 of total urban green |	Number | ANY |




<br/><br/>__*ds532.tpl_sequenza.geojson*__<br/>
>GeoJSON document<br/>

Sequence of ATM bus, filobus and tram stops of the different bus lines in Milan.<br/>
>This file can be combined with "ds534.tpl_fermate.geojson" and "ds538.tpl_percorsi" in order to extract more data (e.g. starting from a bus route, you could retrieve the bus stops related to that route).


Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`percorso`	| ID uniquely identifying a bus route. This field can be combined with "percorso" values in "ds538.tpl_percorsi" |	Number | ANY |
`num`	| Number of the bus stop over the specific "percorso" (route) |	Number | ANY |
`id_ferm`	| ID uniquely identifying the bus stop. This field can be combined with "id_amat" values in "ds534.tpl_fermate.geojson" ID |	Number | ANY |
`geometry`	| The value is "null" for each data |	 |	|




<br/><br/>__*ds533.tpl_metrosequenza.geojson*__<br/>
>GeoJSON document<br/>

Sequence of ATM metro stops of the different metro lines in Milan.
>This file can be combined with "ds535.tpl_metrofermate.geojson" and "ds539.tpl_metropercorsi.geojson" in order to extract more data (e.g. starting from a metro route, you could retrieve the metro stops related to that route)

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`percorso`	| ID uniquely identifying a metro route. This field can be combined with "percorso" values in "ds539.tpl_metropercorsi.geojson" |	Number | ANY |
`num`	| Number of the metro stop over the specific "percorso" (route) |	Number | ANY |
`id_ferm`	| ID uniquely identifying the metro stop. This field can be combined with "id_amat" values in "ds535.tpl_metrofermate.geojson" |	Number | ANY |
`geometry`	| The value is "null" for each data |	 |	|




<br/><br/>__*ds534.tpl_fermate.geojson*__<br/>
>GeoJSON document<br/>

ATM bus, filobus and tram stops in Milan.
>This file can be combined with "ds538.tpl_percorsi" and "ds532.tpl_sequenza.geojson" in order to extract more data (e.g. starting from a bus route, you could retrieve the bus stops related to that route)

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`id_amat`	| ID uniquely identifying the bus stop. This field can be combined with "id_ferm" values in "ds532.tpl_sequenza.geojson" |	Number | ANY |
`ubicazione`	| Bus stop street address |	String | ANY |
`linee`	| Bus line passing through the bus stop |	Number | ANY |
`geometry`	| "type" field has "Point" value |	 |	|




<br/><br/>__*ds535.tpl_metrofermate.geojson*__<br/>
>GeoJSON document<br/>

ATM Metro stops in Milan.
>This file can be combined with "ds539.tpl_metropercorsi.geojson" and "ds533.tpl_metrosequenza.geojson" in order to extract more data (e.g. starting from a metro route, you could retrieve the metro stops related to that route)

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`id_amat`	| ID uniquely identifying the metro stop. This field can be combined with "id_ferm" values in "ds533.tpl_metrosequenza.geojson" |	Number | ANY |
`nome`	| ATM metro stop name |	String | ANY |
`linee`	| Metro line passing through the metro stop |	Number | ANY |
`geometry`	| "type" field has "Point" value |	 |	|





<br/><br/>__*ds538.tpl_percorsi.geojson*__<br/>
>GeoJSON document<br/>

ATM bus, filobus and tram routes in Milan.
>In the documentation the word "bus" is used to indicate both bus, filobus and tram.<br/>

>This file can be combined with "ds534.tpl_fermate.geojson" and "ds532.tpl_sequenza.geojson" in order to extract more data (e.g. starting from a bus route, you could retrieve the bus stops related to that route)

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`linea`	| Number of the bus line |	Number | ANY |
`mezzo`	| Type of vehicle |	String | BUS\|FILOBUS\|TRAM |
`percorso`	| ID uniquely identifying a bus route. This field can be combined with "percorso" values in "ds532.tpl_sequenza.geojson". NOTICE: given the same bus line, "percorso" may have different values (e.g. "percorso" is different given the same line, but different bus directions)|	Number | ANY |
`verso`	| Bus direction over the bus line (forward/backward) |	String | Di\|As |
`nome`	| Name associated to the specific "percorso" (route) |	String | ANY |
`tipo_perc`	| Typology of bus route |	String | Canonico\|Barrato |
`lung_km`	| Length of the bus route (km) |	Number | ANY |
`num_ferm`	| Number of bus stops over the specific bus line | Number | ANY |
`geometry`	| "type" field has "LineString" value |	 |	|




<br/><br/>__*ds539.tpl_metropercorsi.geojson*__<br/>
>GeoJSON document<br/>

ATM metro routes in Milan.
>This file can be combined with "ds535.tpl_metrofermate.geojson" and "ds533.tpl_metrosequenza.geojson" in order to extract more data (e.g. starting from a metro route, you could retrieve the metro stops related to that route)

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`percorso`	| ID uniquely identifying a metro route. This field can be combined with "percorso" values in "ds533.tpl_metrosequenza.geojson" |	Number | ANY |
`linea`	| Number of the metro line |	Number | ANY |
`mezzo`	| Type of vehicle. In this set of data it can assume only "METRO" value |	String | METRO |
`nome`	| Name associated to the specific "percorso" (route) |	String | ANY |
`lung_km`	| Length of the metro route (km) |	Number | ANY |
`num_ferm`	| Number of metro stops over the specific metro line |	Number | ANY |
`geometry`	| "type" field has "LineString" value |	 |	|





<br/><br/>__*ds60.bike_ciclabili.geojson*__<br/>
>GeoJSON document<br/>

Bike lanes in Milan.

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`id_amat`	| na |	Number | ANY |
`id_via`	| ID uniquely identifying a street address |	Number | ANY |
`anagrafica`	| Street address name |	String | ANY |
`gerarchia`	| na |	null | null |
`rete`	| na |	String | ciclabile\|urbana\|verde |
`tipologia`	| Bike lane typology (e.g. bike lane only, bike lane and pedestrian etc.) |	String | ANY |
`sede`	| Where the bike lane is phisically located (e.g. on the road, over a bridge etc.) |	String | ANY |
`marcia`	| Way in which the bike lane can be travelled (e.g. one-way/unidirectional, two-way etc.) |	String | ANY |
`norma`	| na |	String | ANY |
`lunghezza`	| Bike lane length (unit of measurement na) |	Number | ANY |
`geometry`	| "type" field has "MultiLineString" value |	 |	|




<br/><br/>__*ds629.impianti_sportivi_11_06_2020.geojson*__<br/>
>GeoJSON document<br/>

Sport centers in Milan.

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`Municipio`	| Milan administrative zone where the sport center is located |	Number |	1\|2\|3\|4\|5\|6\|7\|8\|9 |
`VIA`	| Street address |	String | ANY |
`LOCALITA`	| na |	String | ANY |
`SPECIFICA_LOCALITA`	| na |	String | ANY |
`Tipo` | Type of sport center (e.g. football sport center, tennis etc.) |	String | ANY |
`Note`	| Notes about the sport center |	String | ANY |
`Location`	| X Y coordinates separated by a comma |	String | ANY |
`Mail`	| Sport center mail |	String | ANY |
`Sito Internet`	| Sport center website |	String | ANY |
`Gestore`	| Company that run the sport center |	String | ANY |
`Codice via`	| ID uniquely identifying the street address |	Number | ANY |
`ID_NIL`	| ID uniquely identifying a NIL |	Number | ANY |
`NIL`	| Acronym for "Nuclei di Identità Locale". It indicates the city district |	String | ANY |
`Longitudine`	| X-coordinate (longitude, WGS 84) of the sport center location |	Number | ANY |
`Latitudine`	| Y-coordinate (latitude, WGS 84) of the sport center location  |	Number | ANY |
`geometry`	| "type" field has "Point" value |	 |	|





<br/><br/>__*ds632_street_sport_con_orari_v2_loc.geojson*__<br/>
>GeoJSON document<br/>

Public sport parks in Milan.

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`Municipio`	| Milan administrative zone where the sport park is located |	Number |	1\|2\|3\|4\|5\|6\|7\|8\|9 |
`Codice area`	| ID uniquely identifying the Milan zone |	Number | ANY |
`VIA`	| Type of sport park (e.g. square, park, garden etc.) |	String | ANY |
`LOCALITA`	| Name of the sport park |	String | ANY |
`SPECIFICA_LOCALITA`	| Additional notes about the type of sport park |	String | ANY |
`Tipo`	| Type of sport practised in the sport park (e.g. football, tennis etc.) |	String | ANY |
`Mese`	| Month when the sport center is open |	String | ANY |
`Orario apertura`	| Opening time of the sport center in the specific month |	Number | ANY |
`Orario chiusura`	| Closing time of the sport center in the specific month |	Number | ANY |
`Location`	| X Y coordinates separated by a comma |	String | ANY |
`Longitudine`	|  X-coordinate (longitude, WGS 84) of the sport center location |	Number | ANY |
`Latitudine`	| Y-coordinate (latitude, WGS 84) of the sport center location |	Number | ANY |
`geometry`	| "type" field has "Point" value |	 |	|




<br/><br/>__*ds634.numeri.civici.geojson*__<br/>
>GeoJSON document<br/>

Civic numbers in Milan.

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`CODICE_VIA`	| ID uniquely identifying the street address |	Number | ANY |
`NUMERO`	| Street number |	Number | ANY |
`BARRA`	| na. This field may not be in all the data. Where it is present, its value is null. |	null | null |
`BARRA2`	| na. This field may not be in all the data |	String | ANY |
`NUMEROCOMPLETO`	| Street number concatenated with the "BARRA2" value |	String | ANY |
`MUNICIPIO`	| Milan administrative zone where the civic number is located |	Number |	1\|2\|3\|4\|5\|6\|7\|8\|9 |
`RESIDENZIALE`	| Number value that acts like a boolean variable to indicate whether a civic number is residential or not |	Number | 0\|1 |
`STATOCIVICO`	| na |	String | Iter in corso\|Applicato |
`DATA_ATTIVAZIONE`	| Activation date. This field may not be in all the data | String | ANY |
`DATA_APPLICAZIONE`	| Application date. This field may not be in all the data |	String | ANY |
`DATA_SOPPRESSIONE`	| Suppression date. This field may not be in all the data |	String | ANY |
`ULTIMA_MODIFICA`	| Last update. This field may not be in all the data |	String | ANY |
`GAUSSB_X`	| X-coordinate (longitude, Roma40 Gauss-Boaga) of the civic number location |	Number | ANY |
`GAUSSB_Y`	| Y-coordinate (longitude, Roma40 Gauss-Boaga) of the civic number location |	Number | ANY |
`WGS84_X`	| X-coordinate (longitude, WGS 84) of the civic number location |	Number | ANY |
`WGS84_Y`	| Y-coordinate (longitude, WGS 84) of the civic number location |	Number | ANY |
`WEBMERC_X`	| na |	Number | ANY |
`WEBMERC_Y`	| na |	Number | ANY |
`DATA_MODFINE`	| na |	String | ANY |
`IDMASTER`	| na |	Number | ANY |
`PASSOCARRIO`	| Number value that acts like a boolean variable to indicate whether a civic number is driveway or not |	Number | 0\|1 |
`LIVELLO`	| na |	String | ANY |
`STATO`	| na |	String | ANY |
`TIPO`	| Type of street where the civic number is located (e.g. square, boulevard etc.) |	String | ANY |
`DENOMINAZIONE`	| na |	String | ANY |
`DATA_INTITOLAZIONE`	| na |	String | ANY |
`ANNO_SOPPRESSIONE`	| Suppression year. This field may not be in all the data |	String | ANY |
`DESCRITTIVO`	| na |	String | ANY |
`ANNCSU`	| na |	String | ANY |
`OPENSTREETMAP`	| na |	String | ANY |
`CAP`	| Postal code of the civic number |	Number | ANY |
`ID_NIL`	| ID uniquely identifying a NIL |	Number | ANY |
`NIL`	| Acronym for "Nuclei di Identità Locale". It indicates the city district |	String | ANY |
`Location`	| Round brackets containing X Y coordinates separated by a comma |	String | ANY |
`LONG_WGS84`	| X-coordinate (longitude, WGS 84) of the civic number location |	Number | ANY |
`LAT_WGS84`	| Y-coordinate (longitude, WGS 84) of the civic number location |	Number | ANY |
`geometry`	| "type" field has "Point" value |	 |	|




<br/>__*ds65.bikemi_areesosta.geojson*__<br/>
>GeoJSON document<br/>

Georeferenced location of "Bike Sharing BikeMI" stations in Milan.


Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`id_amat`	| ID uniquely identifying the data |	Number | ANY |
`bike_shari`	| Number followed by the street address |	String | ANY |
`indirizzo`	| Street address |	String | ANY |
`anno`	| Year when the bike station was installed |	Number | ANY |
`stalli`	| Bike sharing station max capacity |	Number | ANY |
`localizzaz`	| Where the bike sharing station is physically located (e.g. sidewalk, on the road etc.) |	String | Carreggiata\|Marciapiede\|Carregiata\|Marcipiede |
`stazione`	| Type of bike sharing station |	String | Monofacciale\|Bifacciale\|Marciapiede\|Bifaccile |
`zd_attuale`	| na |	Number | ANY |
`geometry`	| "type" field has "Point" value |	 |	|





<br/>__*ds699.stazioni-meteorologiche_arpa_mi_final.geojson*__<br/>
>GeoJSON document<br/>

Georeferenced location of ARPA weather stations in Milan.


Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`MUNICIPIO`	| Milan administrative zone where the weather station is located |	Number |	1\|2\|3\|4\|5\|6\|7\|8\|9 |
`ID_NIL`	| ID uniquely identifying a NIL |	Number | ANY |
`NIL`	| Acronym for "Nuclei di Identità Locale". It indicates the city district |	String | ANY |
`IdSensore`	| ID uniquely identifying a specific sensor in a weather station |	Number | ANY |
`Tipologia`	| Type of the sensor (e.g. wind direction, temperature etc.) |	String | ANY |
`Unità DiMisura`	| Unit of measurement |	String | ANY |
`IdStazione`	| ID uniquely identifying the weather station |	Number | ANY |
`NomeStazione`	| Name of the weather station |	String | ANY |
`Quota`	| Altitude of the weather station |	Number | ANY |
`Provincia`	| Province of where the weather station is located. In this set of data, this field can have only "MI" value |	String | ANY |
`DataStart`	| Activation date of the weather station |	String | ANY |
`DataStop`	| Stopping date of the weather station |	String or null | ANY |
`Storico`	| na | String | ANY |
`UTM_Nord`	| NORD coordinate (UTM system) |	Number | ANY |
`UTM_Est`	| EST coordinate (UTM system) |	Number | ANY |
`lng`	| X-coordinate (longitude, WGS 84) of the weather station location |	String | ANY |
`lat`	| Y-coordinate (longitude, WGS 84) of the weather station location |	String | ANY |
`location`	| Round brackets containing X Y coordinates separated by a comma |	String | ANY |
`geometry`	| "type" field has "Point" value |	 |	|




<br/><br/>__*ds70.bike_areesosta.geojson*__<br/>
>GeoJSON document<br/>

Public bike docking stations in Milan

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`id_amat`	| ID uniquely identifying the data |	Number | ANY |
`id_via`	| ID uniquely identifying the street address |	Number | ANY |
`num_civico`	| Street number |	Number | ANY |
`municipio`	| Milan administrative zone where the dog park is located |	Number |	1\|2\|3\|4\|5\|6\|7\|8\|9 |
`stato`	| Availability of the bike docking station |	String | Esistente |
`categorieveicoli`	| Type of admitted vehicle |	String | Velocipedi\|Condivisa (Velocipedi, Motocicli e Ciclomotori) |
`numero_manufatti`	| Number of docking stations at the indicated position |	Number | ANY |
`stalli_per_manufatto`	| Max capacity for each docking station at the indicated position |	Number | ANY |
`stalli_totali`	| Total max capacity (numero_manufatti*stalli_per_manufatto) |	Number | ANY |
`tipomanufatto`	| Structural properties of the docking station | String | ANY |
`ubicazione`	| Where the bike station is physically located (e.g. sidewalk, pedestrian area etc.) | String | ANY |
`geometry`	| "type" field has "Point" value |	 |	|




<br/><br/>__*ds710.coordfix_ripetitori_radiofonici_milano_160120_loc_final.geojson*__<br/>
>GeoJSON document<br/>

Georeferenced location of radio antennas in Milan.

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`municipio`	| Milan administrative zone where the radio antenna is located |	Number |	1\|2\|3\|4\|5\|6\|7\|8\|9 |
`ID_NIL`	| ID uniquely identifying a NIL |	Number | ANY |
`NIL`	| Acronym for "Nuclei di Identità Locale". It indicates the city district |	String | ANY |
`OPERATORE`	| Company that run the radio antenna |	String | ANY |
`ID IMPIANTO`	| ID uniquely identifying a radio antenna |	String | ANY |
`TIPO`	| Type of transmission |	String | FM\|RD\|TD |
`UBICAZIONE`	| Street address |	String | ANY |
`PROV`	| Province where the radio antenna is located. In this set of data the value of this field can be only "MI" |	String | MI |
`ALTITUDINE`	| Altitude of where the radio antenna is located |	Number | ANY |
`CANALE`	| Radio channel |	String or null | ANY |
`BOUQUET`	| Radio name |	String | ANY |
`ERP MAX H`	| na |	Number or null | ANY |
`ERP MAX V`	| na |	Number or null | ANY |
`FREQ. CENTRALE/PORTANTE`	| Carrier wave frequency |	Number | ANY |
`LONG._decimal`	| X-coordinate (longitude, WGS 84) of the civic number location |	Number | ANY |
`LAT._decimal`	| Y-coordinate (latitude, WGS 84) of the civic number location |	Number | ANY |
`Location`	| X Y coordinates separated by a comma |	Number | ANY |
`geometry`	| "type" field has "Point" value |	 |	|




<br/><br/>__*ds80.ferrovie_stazioni_milano.geojson*__<br/>
>GeoJSON document<br/>

Georeferenced location of train stations in Milan.

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`ID`	| ID uniquely identifying the train station |	Number | ANY |
`nome`	| Name of the train station |	String | ANY |
`gestore`	| Company that run the station |	String | FS\|FNM\|FNM-FS |
`geometry`	| "type" field has "Point" value |	 |	|




<br/><br/>__*ds81.ferrovie_milano_sdf.geojson*__<br/>
>GeoJSON document<br/>

Urban-train network in Milan.

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`ID`	| ID uniquely identifying the urban-train network. The value "0" indicates that the ID is missing. |	Number | ANY |
`nome`	| Name of the urban-train network  |	String | ANY |
`gestore`	| Company that run the network |	String or null | FNM\|FS\|FNM-FS\|PasRog\|PASSAN\|PRG\|null |
`TIPO`	| na |	Number | 0\|1\|2 |
`geometry`	| "type" field has "LineString" value |	 |	|




<br/><br/>__*ds82.ingressi_areac_varchi.geojson*__<br/>
>GeoJSON document<br/>

Georeferenced location of the restricted areas gates ("Area C") in Milan.

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`id_amat`	| ID uniquely identifying the data |	Number | ANY |
`label`	| Label associated to the restricted area gate |	String | ANY |
`geometry`	| "type" field has "Point" value |	 |	|




<br/><br/>__*ds89.parchi.geojson*__<br/>
>GeoJSON document<br/>

Georeferenced location of the city parks in Milan

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`ZONA`	| Milan zone where the city park is located |	Number |	1\|2\|3\|4\|5\|6\|7\|8\|9 |
`AREA`	| ID uniquely identifying the surface of the city park |	Number | ANY	|
`AREA_MQ`	| Area (m2) of the city park |	Number | ANY	|
`PERIM_M`	| Perimeter (m) of the city park |	Number | ANY |
`PARCO`	| Name of the city park |	String | ANY |
`geometry`	| "type" field has "Polygon" value |	 |	|




<br/><br/>__*ds964.nil_wm.geojson*__<br/>
>GeoJSON document<br/>

Georeferenced location of the Milan city districts.

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`ID_NIL`	| ID uniquely identifying a NIL |	Number | ANY |
`NIL`	| Acronym for "Nuclei di Identità Locale". It indicates the city district (name) |	String | ANY |
`Valido_dal`	| Validity starting date |	String | ANY |
`Valido_al`	| Current state of validity |	String | ANY |
`Fonte`	| Source of the data |	String | ANY |
`Shape_Length`	| Length of the shape (polygon). Measurement unit na |	Number | ANY |
`Shape_Area`	| Area of the shape (polygon). Measurement unit na |	Number | ANY |
`OBJECTID`	| ID uniquely identifying the object (data) |	Number | ANY |
`geometry`	| "type" field has "Polygon" value |	 |	|




<br/><br/>__*ds379_municipi_label.geojson*__<br/>
>GeoJSON document<br/>

Polygonal representation of Milan administrative zones (MUNICIPI). Milan is divided into 9 administrative zones.

Field|	Description	|	Data type	|	Data value	|
----------	|	----------	|	----------	|	----------	|
`OBJECTID`	| Object ID |	Number | ANY |
`MUNICIPIO`	| Number of Milan administrative zone |	Number | 1\|2\|3\|4\|5\|6\|7\|8\|9 |
`AREA`	| Area of the Milan administrative zone (unit of measurement na) |	Number | ANY |
`PERIMETRO`	| Perimeter of the Milan administrative zone (unit of measurement na) |	Number | ANY |
`Shape_Length`	| na |	Number | ANY |
`Shape_Area`	| na |	Number | ANY |
`geometry`	| "type" field has "Polygon" value |	 |	|

