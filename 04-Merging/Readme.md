# Merging out of each pipeline


### For Detettore we first do VCF -> bed, to then concatenate all the bed from all the samples. We separated them by TE, merge using 'bedtools merge'