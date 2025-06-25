awk -F'\t' '{
    n = split($6, methods, ","); #it does check column 6th comma separated ; this is useful on Detettore change if necessary
    if (n >= 3) print #determine how many to filter
}' your_file.txt