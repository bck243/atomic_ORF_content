# atomic_ORF_content
Counting the nitrogen and sulfur atoms in translated open reading frames for biogeochemical insights

This respository contains:
* *count_N_atoms.pl*
  * takes in a fasta file of translated open reading frames (ORFs) and the name of the desired output file
  * outputs a tab delimited file with columns for: 
    * "orf_id": ID given to each ORF stripped from the fasta header
    * "n_atoms": number of nitrogen atoms in a given ORF
    * "aa_length": amino acid length of the ORF
    * "length_norm_n": length-normalized nitrogen content of the ORF
* *count_S_atoms.pl*
  * takes in a fasta file of translated open reading frames (ORFs) and the name of the desired output file
  * outputs a tab delimited file with columns for: 
    * "orf_id": ID given to each ORF stripped from the fasta header
    * "s_atoms": number of sulfur atoms in a given ORF
    * "aa_length": amino acid length of the ORF
    * "length_norm_n": length-normalized sulfur content of the ORF
