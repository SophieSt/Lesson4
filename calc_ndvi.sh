#!/bin/bash
echo "teamname: Kraftfahrzeug-Haftpflichtversicherung"
echo "authors: Felten, Bettina; Stuhler, Sophie C."
echo "date: 12-01-2017"
echo "Assignment 4"
echo "Calculate NDVI from Landsat 7 Image"
echo "Resample NDVI Image to 60 m Resolution"

fn=$(ls data/LE*.tif)
echo "input file: $fn"
ndvi="data/NDVI.tif"
fntemp="data/NDVI60m.tif"
fnout="data/NDVI60mLatLong.tif"

echo "calculate Normalized Difference Vegetation Index"
echo "NDVI is a ratio calculated from the difference between NIR and RED reflectance"
echo "NIR: band 4; RED: band 3"
gdal_calc.py -A $fn --A_band=4 -B $fn --B_band=3 --outfile=$ndvi --calc="(A.astype(float)-B)/(A.astype(float)+B)" --type='Float32'

echo "resample to 60 m"
echo "units are meters"
gdal_translate -tr 60 60 $ndvi $fntemp

echo "finally, reproject to Lat/Long WGS84"
gdalwarp -t_srs EPSG:4326 $fntemp $fnout