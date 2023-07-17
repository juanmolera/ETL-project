# Project 1: Extract, Transform and Load (ETL)

<!---
![logo](images/logo.png)
![extraction](images/extract.png)
![pandas](images/panda.png)
![pipeline](images/pipe.png)
![sql](images/load.png)
--->

This is my first project of the Ironhack data analysis bootcamp and it is focused on the analysis of the evolution of prices in a supermarket. To do this, I have started from a historical record of product data between the dates of and I have fed this record with the data of the products that are currently in the supermarket, which I have obtained from scraping their website. Subsequently, both the initial data and the extracted data have been cleaned to achieve a link between them and to be able to generate a MySQL database. Finally, a brief analysis has been carried out based on different data visualization methods from which a set of conclusions have been obtained.  

<img align="center" src=images/logo.png  width="50%" height="25%">

The supermarket chosen for this project has been DIA, although in the future I hope to expand the development to include other supermarkets. Distribuidora Internacional de Alimentación, S.A. (DIA) is a Spanish multinational hard-discount supermarket chain founded in 1979. DIA is the largest franchiser company in Spain and the fourth largest food sector franchiser in Europe.

## Challenge 1: Extract

The first challenge is to obtain a data set to enrich the starting data. For this, I have used web scraping tools to obtain the information of the products that are currently available in the supermarket.

<img align="center" src=images/extract.png  width="50%" height="25%">


## Challenge 2: Exploratory Data Analysis (EDA)

<img align="center" src=images/panda.png  width="50%" height="25%">

| id      | url                                                                                 | supermarket | category                      | name                                              | price | reference_price | reference_unit | insert_date |
|---------|-------------------------------------------------------------------------------------|-------------|-------------------------------|---------------------------------------------------|-------|-----------------|----------------|-------------|
| 978408  | [https://www.dia.es/compra-online/despensa/desa...](https://www.dia.es/compra-onl... | dia-es      | azucar_chocolates_y_caramelos | NESTLE Caja roja bombones caja 200 gr              | 4.95  | 24.75           | kg             | 2021-08-17  |
| 1500705 | [https://www.dia.es/compra-online/cuidado-del-h...](https://www.dia.es/compra-onl... | dia-es      | perfumeria_higiene_salud     | CISNE mopa microfibra recambio 1 ud                | 4.39  | 4.39            | ud             | 2021-11-21  |
| 2879450 | [https://www.dia.es/compra-online/bebidas/bebid...](https://www.dia.es/compra-onl... | dia-es      | mascotas                      | DIA bebida refrescante aromatizada cítrico zero 0.97 l | 0.97  | 0.65            | l              | 2022-07-18  |
| 657687  | [https://www.dia.es/compra-online/despensa/arro...](https://www.dia.es/compra-onl... | dia-es      | arroz_pastas_y_legumbres     | LUENGO alubia cocida frasco 400 gr                | 0.95  | 2.38            | kg             | 2021-06-21  |
| 678716  | [https://www.dia.es/compra-online/cuidado-perso...](https://www.dia.es/compra-onl... | dia-es      | perfumeria_higiene_salud     | COLORCREM tinte Violín Nº 46 caja 1 ud            | 4.25  | 4.25            | ud             | 2021-06-25  |

| id   | url | supermarket | category                     | name                                                  | price | reference_price | reference_unit | insert_date |
|------|-----|-------------|------------------------------|-------------------------------------------------------|-------|-----------------|----------------|-------------|
| 2401 | NaN | dia-es      | azucar_chocolates_y_caramelos | Golosinas sour boom mix FINI BOLSA 165 GR             | 2.25  | 13.64           | kg             | 2023-07-10  |
| 5110 | NaN | dia-es      | perfumeria_higiene_salud     | Desodorante antitranspirante efecto invisible ...     | 2.55  | 1.28            | NaN            | 2023-07-10  |
| 4526 | NaN | dia-es      | limpieza_y_hogar             | Estropajo salvauñas limpieza delicada SUPER PA...     | 0.99  | 0.33            | ud             | 2023-07-10  |
| 815  | NaN | dia-es      | yogures_y_postres            | Yogur desnatado sabor limón VITALINEA 4 unida...     | 1.89  | 3.78            | kg             | 2023-07-10  |
| 3784 | NaN | dia-es      | agua_refrescos_y_zumos       | Bebida de frutas con leche tropical ZUMOSFERA ...     | 1.25  | 1.04            | l              | 2023-07-10  |


## Challenge 3: Data Pipeline

<img align="center" src=images/pipe.png  width="50%" height="25%">

## Challenge 4: Load

<img align="center" src=images/load.png  width="50%" height="25%">

## Bonus

### Tools

### Drawbacks found and future roadmap

### Special thanks