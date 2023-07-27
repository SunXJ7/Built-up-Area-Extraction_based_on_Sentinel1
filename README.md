# Sentinel-1-Datasets-for-Built-up-Area-Extraction
<p style="text-align:justify; text-justify:inter-ideograph;">

&emsp;&emsp;The project shares the datasets used in the article under submission to the ISPRS Journal of Photogrammetry and Remote Sensing, "Statistical Modeling of Hyperpixels in Polar Synthetic Aperture Radar (SAR) Data and Its Application to Built-Up Area Extraction", which is mainly applied in this paper for experimental validation of built-up area extraction.

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

&emsp;&emsp;As shown in the figure below, the total folder consists of four sub-datasets, and each dataset folder contains data for the two temporal phases, GroundTruth and extraction results for the built-up areas extraction experiments. The folder for each time-phase data contains the C-matrix folder for that data, two magnitude images of single-channels, and the Sentinel I data zip for the original image to which the data belongs, which was downloaded from the ESA official website. The Sentinel I data zip contains images of regions other than the datasets used in this paper, and which can be processed directly using SNAP.

<div align=center>
<img src="https://github.com/SunXJ7/Sentinel-1-Dataset-for-Built-up-Area-Extraction-1/blob/main/Pictures/Folder%20Structure.png" width="500px">
</div>

&emsp;&emsp;The datasets can be downloaded from the following link, [Get the Baidu Netdisk link here](https://pan.baidu.com/s/1mp2NVhcux2rYXZEMN1kQfw?pwd=cfs5 ),
Extract code: cfs5 

</p>
