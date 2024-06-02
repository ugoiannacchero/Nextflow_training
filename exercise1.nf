// Exercise 3
// Refer back to the "cel235.ncrna.fa" file during the Linux introduction

// 1) How many lines are there in this file?
// 2) How many sequences entries are in this file?
// 3) Write a new file named "ncrna.copy.fasta" which contains the text contents of the old file.
// 4) Read through each line in the file, only printing to screen if the line contains a sequence id

myFile = file("/home/delo/Nextflow_course/linuxIntro/cel235.ncrna.fa", checkIfExist: true)

println myFile.countLines()

println "In my file there are: ${myFile.countFasta()} lines"

outfile = file("ncrna.copy.fasta")
outfile.text = myFile.readLines()

// Exercise 3
// Refer back to the "cel235.ncrna.fa" file during the Linux introduction

// 1) How many lines are there in this file?
// 2) How many sequences entries are in this file?
// 3) Write a new file named "ncrna.copy.fasta" which contains the text contents of the old file.
// 4) Read through each line in the file, only printing to screen if the line contains a sequence id

myFile = file("/home/delo/Nextflow_course/linuxIntro/cel235.ncrna.fa", checkIfExist: true)

println myFile.countLines()

println "In my file there are: ${myFile.countFasta()} lines"

outfile = file("ncrna.copy.fasta")
outfile.text = myFile.readLines()

myFile.eachLine({ line ->
outfile.append( line + "\n")
if( line[0] == ">"){
    print line
}
})

myFile.eachLine({ line ->
outfile.append( line + "\n")
if( line[0] == ">"){
    print line
}
})
