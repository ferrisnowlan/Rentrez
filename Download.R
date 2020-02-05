install.packages("rentrez")

library(rentrez)

ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")
#this creates a character vector of these labels

Bburg<- entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta") 
#this asks the NCBI website for data from the "nuccore" database, with the ncbi_ids labels, in fasta format and saves it as the object Bburg 

#separate the three sequences
Sequences <- strsplit(Bburg, "\n\n", fixed  = TRUE )

Sequences<-unlist(Sequences)

header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences<-data.frame(Name=header,Sequence=seq)

Sequences$Sequence <- gsub("\n", "", Sequences$Sequence)


write.csv(Sequences,"~/Sequences.csv", row.names = FALSE)




