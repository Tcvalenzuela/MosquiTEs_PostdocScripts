# Running TEFlon

To start TEFlon requiere to map the read to a special reference file that need to me created priory to the analysis. 


## Prepararion of library

The following are the instrutions from:
```
https://github.com/jradrion/TEFLoN
```


Data prep
Step 1a) If you have a reference TE annotation in BED6 format, use teflon_prep_annotation.py to prepare your reference genome for mapping.

IMPORTANT NOTES: Using the -f option will append a user-provided set of consensus sequences to your reference prior to mapping, helping TEFLoN identify sequences that may not correspond to those in the reference TE annotation. A unique identifier must be used for each entry in the annotation BED file (column 4). An example annotation file is provided in TEFLoN/test_files. TEFLoN also required a "TE hierarchy" file, which includes a line corresponding to every TE in the reference annotation and at least one label for that TE (ideally this label would indicate the family/order/class for each TE instance, but you can use any label you like.) TEFLoN will either group or split TEs by their respective labels provided in this file. The first line of this tab-separated TE hierarchy file must include identifying headers (the header for column one must be "id", but the other header labels are chosen by the user). A good example of a properly formatted TE hierarchy file is provided in the test files.
```
usage: python /usr/local/teflon_prep_annotation.py <required> [optional] 
    -wd [full path to working directory]
    -a <full path to reference TE annotation in BED6 format> 
    -t <full path to user generated TE hierarchy>
    -f [canonical TE sequences in fasta format]
    -g <full path to reference genome in fasta format>
    -p <prefix for all newly created files>
```
Step 1b) If you do not have an existing TE annotation in BED6 format, use teflon_prep_custom.py to prepare your reference genome for mapping.

#### We did 1a, do to the unreliability of RepeatMasker and Blast on our server

## Runnning TEFlon on the cluster

By now 24/06/25, teflon is runnning with care and on the entry node, I have not manage to make it run on the cluster fully. We need to run step 1 twice, on the first run it calculate the st of the fragment lenght, but fail to continue. On a second step we put manually the sd per sample and run.
the first run is scriopt _3 and the second is _4. There where other iterations that did not work either.

