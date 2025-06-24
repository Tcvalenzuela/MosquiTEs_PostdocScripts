import argparse
import os

# Argument parsing
parser = argparse.ArgumentParser(description="Parser for <sname>.detettore.vcf to BED format")
parser.add_argument("--VCF", "-VCFile", help="VCF output from detettore", required=True)
args = parser.parse_args()

# Extract sample name safely
sname = os.path.basename(args.VCF).replace('.detettore.vcf', '')
output_file = f"{sname}.bed"

# Open the VCF file and write to BED file
with open(args.VCF, 'r') as vcf_file, open(output_file, 'w') as bed_file:
    for line in vcf_file:
        if line.startswith('#'):
            continue  # Skip header lines
        columns = line.strip().split('\t')
        scaffold = columns[0]
        start = int(columns[1])
        stop = start + 1  # Assuming a 1bp insertion
        insertion = columns[4].split(':')[2].rstrip('>')

        # Write to BED file
        bed_file.write(f"{scaffold}\t{start}\t{stop}\t{insertion}\t{sname}\tDetettore\n")

print(f"Conversion completed: Output saved to {output_file}")
