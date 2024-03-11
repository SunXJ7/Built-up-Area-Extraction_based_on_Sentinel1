# Built-up-Area-Extraction_based_on_Sentinel1
<p style="text-align:justify; text-justify:inter-ideograph;">

&emsp;&emsp;The project shares the codes used in the article "Superpixel-wise Likelihood-ratio Test Statistic in PolSAR Data and Its Application to Built-Up Area Extraction", which is mainly applied in this paper for experimental validation of built-up area extraction.

&emsp;&emsp;There are the main codes.
'Distribution_Fitting.m' is used for distribution curve fitting to verify model validity.
'main.m' is the main program section for extracting built-up areas.
'aux_funcitons' folder contains the auxiliary functions to be called by the above code.

&emsp;&emsp;The selected PolSAR datasets cover different areas of Heilongjiang Province, China. The following figure shows the geographic location of the four study areas. It contains various surface features such as building, and vegetation.

<div align=center>
<img src="https://github.com/SunXJ7/Sentinel-1-Dataset-for-Built-up-Area-Extraction-1/blob/main/Pictures/Study%20Areas.png" width="800px">
</div>

&emsp;&emsp;1) Mudanjiang Dataset: The first dataset covers the areas of Mudanjiang city, southeastern part of Heilongjiang Province. The arable land area accounts for about 14% of the total land area. The main crops are maize and rice, and their growing seasons are from May to mid-September. The built-up areas are surrounded by forest, herbaceous vegetation, cropland, and permanent water bodies.

&emsp;&emsp;2) Suiling Dataset: The second area is selected from Suiling County in the central part of Heilongjiang, where the topography is dominated by hills and mountains. The forest coverage reaches 51%. The farmlands here are mainly planted with rice, soybeans and wheat. Meanwhile, there are nearly 770 km<sup>2</sup> of pasture.

&emsp;&emsp;3) Suihua Dataset: The third area is located in Suihua City, in central Heilongjiang. We encounter also a diversity of land cover with dense built-up areas surrounded by forest, cropland, and permanent water bodies. This area has mid-temperate continental monsoon climate with significant seasonal changes. Therefore, the scattering mechanism of crops varies significantly with the seasons. 

&emsp;&emsp;4) Lindian Dataset: The fourth dataset is in the central and western part of Heilongjiang, around Lindian County, Daqing City. This region locates in the northern part of the Songnen Plain and belongs to the north temperate continental monsoon climate, so that the temperature difference between the four seasons is relatively large. The main crops in this area are corn, soybeans, rice, potatoes and sunflowers.

&emsp;&emsp;The above four datasets were obtained from the Sentinel-1 dual time-phase imagery downloaded from the official website of ESA after preprocessing with correction, multi-look, scattering matrix conversion and cropping. Both images have a spatial resolution of 2.33m×13.91m and data in VV co-pol and VH cross-pol channels. They are acquired in late August, 2021 and early December, 2021, respectively. Detailed information of the four sets about the time phase is shown in the following figure.  

<div align=center>
<img src="https://github.com/SunXJ7/Sentinel-1-Dataset-for-Built-up-Area-Extraction-1/blob/main/Pictures/Detailed%20Information%20of%20The%20Four%20Sets.png" width="500px">
</div>

&emsp;&emsp;This project provides example data, which can be downloaded from the 'data' folder

</p>
