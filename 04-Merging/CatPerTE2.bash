#!/bin/bash

# Define the input folder containing files
Folder="/beegfs/project/mosquites/aalbo1200g/Detettore/BedFiles"

# Temporary and final output folder
OutputFolder="/beegfs/project/mosquites/aalbo1200g/Detettore/BedFiles/AllTogether"
mkdir -p "$OutputFolder"

# Step 1: Add sample names to each file

for file in "$Folder"/*.bed; do
   if  [ -e "${OutputFolder}/Final_merged_All.bed" ]; then
        continue
    fi

# Step 2: Merge all files into a single sorted file
bedops --everything "${Folder}"/*.bed | sort -k1,1 -k2,2n > "${OutputFolder}/All_cat.bed"

# Step 3: Process each unique element (Transposon)
# Extract the fourth column (Transposon IDs) and deduplicate
cut -f 4 "${OutputFolder}/All_cat.bed" | sort | uniq | while read -r ele; do
    # Filter rows belonging to the current Transposon
    grep -w "$ele" "${OutputFolder}/All_cat.bed" > "${OutputFolder}/${ele}_cat.bed"

    # Merge overlapping regions and collapse relevant columns
    mergeBed -i "${OutputFolder}/${ele}_cat.bed" -c 4,5,6 -o collapse,collapse,collapse > "${OutputFolder}/${ele}_Merged.bed"
    #rm "${OutputFolder}/${ele}_cat.bed"
done

# Step 4: Combine all merged files into a final file
bedops --everything "${OutputFolder}"/*_Merged.bed > ${OutputFolder}/tmp 
awk 'NR == 1 {prev=""; print; next} {current = $1 FS $2 FS $3 FS $4 FS $5 FS $6} current != prev {print} {prev = current}' ${OutputFolder}/tmp > "${OutputFolder}/Final_merged_All.bed"

#rm *_Merged.bed tmp
echo "Processing complete. Final merged file is located at: ${OutputFolder}/Final_merged_All.bed"
done
