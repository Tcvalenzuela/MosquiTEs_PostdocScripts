import pandas as pd
from collections import defaultdict
import argparse
# Argument parsing
parser = argparse.ArgumentParser(description="Parser for <file>_merged.bed to Adegenet")
parser.add_argument("--M", "-MergeFile", help="Merger file out of Bedtools Merge", required=True)
args = parser.parse_args()

# Load merged TE data
input_file = args.M  # 
data = []

with open(input_file, "r") as f:
    for line in f:
        chrom, start, end, markers, samples, methods = line.strip().split("\t")
        marker_id = f"{chrom}_{start}_{end}"
        sample_list = samples.split(",")
        method_list = methods.split(",")
        
        # Repeat marker info for each sample
        for sample, method in zip(sample_list, method_list):
            data.append((marker_id, sample, method))

# Create presence/absence matrix and store methods per marker
marker_sample = defaultdict(set)
marker_method = defaultdict(list)
samples_set = set()

for marker, sample, method in data:
    marker_sample[marker].add(sample)
    marker_method[marker].append(method)
    samples_set.add(sample)

# Unique samples and markers
samples_list = sorted(samples_set)
markers_list = sorted(marker_sample.keys())

# Create binary matrix
matrix = pd.DataFrame(0, index=samples_list, columns=markers_list)

for marker in markers_list:
    for sample in marker_sample[marker]:
        matrix.loc[sample, marker] = 1

# Add population info from sample name (format: Pop_Country_ID)
matrix["pop"] = matrix.index.str.extract(r"^([A-Za-z]+_[A-Za-z]+)")[0]

# Save matrix
matrix.to_csv("genotype_matrix_with_methods.csv")

# Save marker metadata (method info)
marker_metadata = pd.DataFrame({
    "marker": markers_list,
    "method": [",".join(set(marker_method[m])) for m in markers_list]
})
marker_metadata.to_csv("marker_metadata.csv", index=False)
