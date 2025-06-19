#!/bin/bash

# Define the input folder containing files
Folder="/beegfs/project/mosquites/aalbo1200g/TEMP2Loops/All"

# Temporary and final output folder
OutputFolder="/beegfs/project/mosquites/aalbo1200g/TEMP2Loops/All"
mkdir -p "$OutputFolder"

# Step 1: Add sample names to each file

for file in "$Folder"/*_NoDup_1_val_1.fq.gz.insertion.bed; do
    # Extract sample name
    sname=$(basename "$file" | sed 's/_NoDup_1_val_1.fq.gz.insertion.bed//g')
    
    # Filter lines starting with NC or NW and append the sample name to each valid line
    awk -v sname="$sname" '
        $1 ~ /^(NC|NW)/ { print $0 "\t" sname }
    ' "$file" > "${OutputFolder}/${sname}_snamed.bed"
done


# Step 2: Merge all files into a single sorted file
bedops --everything "${OutputFolder}"/*_snamed.bed | sort -k1,1 -k2,2n > "${OutputFolder}/$(basename "$Folder")_cat.bed"

# Step 3: Process each unique element (Transposon)
# Extract the fourth column (Transposon IDs) and deduplicate
cut -f 4 "${OutputFolder}/$(basename "$Folder")_cat.bed" |cut -f 1 -d ':' | sort | uniq | while read -r ele; do
    # Filter rows belonging to the current Transposon
    grep -w "$ele" "${OutputFolder}/$(basename "$Folder")_cat.bed" > "${OutputFolder}/${ele}_cat.bed"

    # Merge overlapping regions and collapse relevant columns
    mergeBed -i "${OutputFolder}/${ele}_cat.bed" -c 4,5,7,16 -o collapse,collapse,collapse,collapse > "${OutputFolder}/${ele}_Merged.bed"
    #rm "${OutputFolder}/${ele}_cat.bed"
done

# Step 4: Combine all merged files into a final file
bedops --everything "${OutputFolder}"/*_Merged.bed > tmp 
awk 'NR == 1 {prev=""; print; next} {current = $1 FS $2 FS $3 FS $4 FS $5 FS $6} current != prev {print} {prev = current}' tmp > "${OutputFolder}/Final_merged_$(basename "$Folder").bed"

#rm *_Merged.bed tmp
echo "Processing complete. Final merged file is located at: ${OutputFolder}/Final_merged_$(basename "$Folder").bed"