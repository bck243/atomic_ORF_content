#!/usr/bin/env perl
use strict;
use warnings;
##############################
#GOALS
##############################
#go through amino acid ORF file (assembly.orf.faa) and count number of N atoms
#output tab delimited file with column for ORF id, num N atoms

##############################
#define variables for input files
##############################
my $infa = shift; #fasta file to search through (amino acid sequences)  e.g. "assembly.orf.faa"
my $outfile = shift; # e.g."translated_snps.tab";
#tab delimited output

##############################
#define remaining variables
##############################
#scalars
my $read; #1 when ORF id matches input ids
my $orf_id; #ORF id
my $faa; #fasta sequence
my $aa; #amino acid
my $aa_length;
my $n_atoms;
#arrays
my @n4 = ('R'); #list of amino acids with 4 nitrogens
my @n3 = ('H'); #list of amino acids with 3 nitrogens
my @n2 = ('N', 'Q', 'K', 'W'); #list of amino acids with 2 nitrogens
my @n1 = ('A', 'D', 'C', 'E', 'G', 'I', 'L', 'M', 'F', 'P', 'S', 'T', 'Y', 'V'); #list of amino acids with 1 nitrogen
my @orf_list;
my @aa_length_list;
#my @faa_list;
my @n_list;

##############################
#check input files
##############################
if($infa) {
} else {
  die "Usage: $0 [amino acid fasta file] [output file name] \n";
}
print "Reading input file \n";

##############################
#Open fa file and count N
##############################
#loop through fasta input
open(IN, $infa) or die "Unable to open file $infa\n";
#loop through rows of fasta file
  while(<IN>) {
    #look for >; check if it matches orf id
    if(m/^>/) { #if the line starts with a >
      my $orf_id;
      $orf_id = $_;
      $orf_id =~ s/>//;
      $orf_id =~ s/\n//;
      push @orf_list, $orf_id;
    }
    if(!/^>/) { #if $read = 1 (ID matched) AND there's no carrot (fasta only)
      #push @faa_list, $_;
      #https://www.oreilly.com/library/view/perl-cookbook/1565922433/ch01s06.html
      #print STDERR $_."\n";
      my $n_atoms;
      my $aa;
      my $aa_length;
      foreach $aa (split //, $_) {
        #print STDERR "\$aa at ".$aa."\n";
        $aa_length ++;
        if($aa ~~ @n4){
          $n_atoms = $n_atoms + 4;
        }elsif($aa ~~ @n3){
          $n_atoms = $n_atoms + 3;
        }elsif($aa ~~ @n2){
          $n_atoms = $n_atoms + 2;
        }elsif($aa ~~ @n1){
          $n_atoms = $n_atoms + 1;
        }else{
          print STDERR "Not a valid amino acid\n";
        }
      #print STDERR "atom counter at ".$n_atoms."\n";
      }
      push @n_list, $n_atoms;
      push @aa_length_list, $aa_length;
    } #end parsing fasta sequence
  }
close(IN); #finish looping through fasta

##############################
#write out
##############################
open(OUT, ">".$outfile) or die "Unable to write to file $outfile\n";
#print header
print OUT join("\t", ("orf_id", "n_atoms", "aa_length", "length_norm_n"))."\n";
#loop through ORF ids
for(my $i = 0; $i < scalar(@orf_list); $i++){
  print OUT join("\t", ($orf_list[$i], $n_list[$i], $aa_length_list[$i], ($n_list[$i]/$aa_length_list[$i])))."\n";
}
close(OUT);
print STDERR "Done. \n";
