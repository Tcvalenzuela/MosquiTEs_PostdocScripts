#!/bin/bash

# Define the input folder containing population folders
Folder="/beegfs/project/mosquites/aalbo1200g/TEMP2Loops/CombineLibrary"
OutputFolder="${Folder}/Merged"
mkdir -p "$OutputFolder"

# Step 1 & 2: Process each population
for Population in "$Folder"/*/; do
    pop_name=$(basename "$Population")
     if [[ "$Folder" == "Merged" ]]; then
        continue
     fi
    echo "Processing population: $pop_name"

    for file in "$Population"/*/*_NoDup_1_val_1.fq.gz.insertion.bed; do
        [[ -e "$file" ]] || continue

        sname=$(basename "$file" | sed 's/_NoDup_1_val_1.fq.gz.insertion.bed//g')

        awk -v sname="$sname" '
            $1 ~ /^(NC|NW)/ { print $0 "\t" sname "\tTEMP2" }
        ' "$file" > "${OutputFolder}/${sname}_snamed.bed"
    done

    # Concatenate and sort all files
    cat "${OutputFolder}"/*_snamed.bed >> "${OutputFolder}/All_cat.bed"
    rm "${OutputFolder}"/*_snamed.bed
done

sort -k1,1 -k2,2n "${OutputFolder}/All_cat.bed" -o "${OutputFolder}/All_cat.bed"

# Step 3: Split by element
cut -f 4 "${OutputFolder}/All_cat.bed" | cut -d ':' -f 1 | sort | uniq | while read -r ele; do
    awk -v ele="$ele" -F'\t' '
        $4 ~ "^"ele":" {
            split($4, a, ":");
            $4 = a[1];
            print $0;
        }
    ' OFS='\t' "${OutputFolder}/All_cat.bed" > "${OutputFolder}/All_${ele}_cat.bed"

    mergeBed -i "${OutputFolder}/All_${ele}_cat.bed" -c 4,16,17 -o collapse,collapse,collapse > "${OutputFolder}/All_${ele}_Merged.bed"
    rm "${OutputFolder}/All_${ele}_cat.bed"
done

# Step 4: Merge all into final file
bedops --everything "${OutputFolder}"/*_Merged.bed > "${OutputFolder}/tmp_All.bed"

# Remove duplicates 
awk '!seen[$0]++' "${OutputFolder}/tmp_All.bed" > "${OutputFolder}/Final_merged_All.bed"

# Cleanup
rm "${OutputFolder}"/*_Merged.bed "${OutputFolder}/tmp_All.bed"

echo "Finished processing. Output: ${OutputFolder}/Final_merged_All.bed"