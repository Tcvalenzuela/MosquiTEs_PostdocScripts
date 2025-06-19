### How to run TEMP2

Here for each population we run TEMP2 independently

This information is also available at:

```
/beegfs/project/mosquites/aalbo1200g/TEMP2Loops/
```

and 

```
/beegfs/project/mosquites/aalbo1200g/TEMP2Loops/CombineLibrary
```

The latter contain a run of TEMP2 with the masked F5 using the combine library of MCHelper and Manually curated library


After all the population are done, we have copy the files from:

```
<Population>/<Sample>/*_NoDup_1_val_1.fq.gz.insertion.bed
```
on the folder:

```

/beegfs/project/mosquites/aalbo1200g/TEMP2Loops/All
```
Where we run Merger.sh; Merger allow us to bedtools merge all the insertions allowing only to merge those with the same TE insertion. 
To latter Run Baypass;

Nonetheless to run Baypass we first need to convert the format from bed to a Baypass readable file

as on file:
```
Merge2BaypassAlleleTEMP2v6.py
```

the other 5 itiration of this are availables at:

```
/beegfs/project/mosquites/aalbo1200g/TEMP2Loops/All
```
