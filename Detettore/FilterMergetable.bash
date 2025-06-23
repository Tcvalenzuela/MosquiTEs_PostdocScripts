#This is to filter tab separated column 6 and filter the comma separeted markers if there are less than 3

awk -F'\t' '{
    n = split($6, methods, ",");
    if (n >= 3) print
}' your_file.txt
