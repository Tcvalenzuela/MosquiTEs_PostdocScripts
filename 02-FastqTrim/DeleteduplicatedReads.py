from Bio import SeqIO
import argparse

parser = argparse.ArgumentParser(description="Look for duplication in Fastq files")
parser.add_argument("--F", "-Fq", help="Fastq file")
parser.add_argument("--o", "-output", help="Output fastq")
args = parser.parse_args()

# Open output file for writing
with open(args.o, "w") as oWriter:
    # Create a dictionary to store unique read headers and sequences
    unique_reads = {}    # Parse the input Fastq file
    for record in SeqIO.parse(args.F, "fastq"):
        # Extract read header and sequence
        read_header = str(record.id)
        sequence = str(record.seq)

        # Convert quality scores to Phred scores
        phred_scores = "".join(chr(score + 33) for score in record.letter_annotations["phred_quality"])
        if read_header not in unique_reads:
            # If not, add the read header and sequence to the dictionary
            unique_reads[read_header] = sequence
            # Write the record to the output file
            oWriter.write("@{}\n{}\n+\n{}\n".format(read_header, sequence, phred_scores))

print("Duplicates removed and output written to", args.o)
