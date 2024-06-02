// Scripting language

// Task: write an "Hello, world!" program

myMessage = "Hello, world!"

/*
When we want to print something inside a message that correspond
to a variable that contains an items we do an interpolation:
that is -> ${variable}
*/

println "This is my message: ${myMessage}" 

// *Map*

// A "Map" can be used to store associative arrays or dictionaries. It is an unordered collection
// of heterogeneous, named data. Map may contain elements like key and value for this thing is different from lists.

myMap = ["English":"Hello, world!", "German":"Hallo, welt!"]

println myMap["English"]
println myMap.German 

myList = [ false, 1, "hi", -3.1499392, myMessage, [1,2,3,4]]

println myList 

println myList[4]

myList[4] = "Buongiorno!" // reassigning invidual elements, "myMessage" -> "Buongiorno!"
myList.add("my new element") // append new elements to the end of the list.

println myList 

// *Conditional Execution*

/* Task: Wtite a conditional if-else block to test if a variable (e.g. "language") contains
either "German" OR "French", and print the appropriate message from myMap. Otherwise, 
to the English message. */

params.Language = "x" //when we use params we create a tag (option), that becomes available when we do nextflow run

myMap = ["German":"Hello, welt!", "French":"Bonjour, le monde!", "English":"Hello, world!"]

if (params.Language == "German"){
    println "The language is German"
} else if(params.Language == "French"){
    println "The language is French"
} else 
    println myMap.English //Here I do not need interpolation

// *Clousure*

// A Closure is a custom function which is itself defined as a first class object. It can be passed around as if it were
// e.g. a String , or an Integer, and therefore provided directly as an argument to another function.

// Closures are characterized by curly brackets, and by default make reference to a single argument "it"

square = { it *it}

println square(9) //returns 81

// We can instead refers to the single argument with any name of choosing for instance "n"

square = { n -> n * n}
println square(9) // returns 81


myList = [1,2,3,4]
println myList.collect() // returns 1,2,3,4

println myList.collect(square) // returns [1, 4, 9 ,16]

// Multiple argument

myClosure = { key, value -> // We can add multiple values in the closures
println "First name: $key, Surname: $value"}

myMap = ["Yue" : "Wu", "Mark": "Williams", "Sudha" : "Kumari" ]
myMap.each(myClosure) // Here we use the function each to apply the clouse to each of the elements of the myMap

// Another important feature is the ability to execute different code under different conditions.

// A clouse as a Boolean predicate
// Very typical purpose of a closure is to provide an evaluation criteria which is evaluated as true or false,
// within another function or method. This is akin to the conditional execution.

eval = {it == 1}
println eval(1) //returns true

eval = {it != 1}
println eval(1) //returns false

eval = { it instanceof String}
println eval(1) // false is declared as an integer
println eval('1') // true is declared as a string

// Ternary operator:
// This is a method for writing conditional if-else block, which is oftern used within a closure when a value other
// than true or false is expected.

// the question mark "?" indicates conditional execution
// the column : indicates the else clause

eval = { it > 10 ? "You win!" : "Too Low"}
println eval(11)
println eval(1)

/* Task:
Re-write the solution of the task on conditional execution now in form of a closure! */

params.language = "English"
myMap = ["German":"Hello, welt!", "French":"Bonjour, le monde!", "English":"Hello, world!"]

eval = {it == "German" || it == "French" ? myMap[it] : myMap["English"]}

println eval(params.language)

// Files and Input/Ouput:

// Typically when writing a pipeline we are interested in manipulating various different files:
// Each file can be read into a file object, using the file method

/*
myFile = file('path/to/file.txt')

We can use a limited number of wildcard characters to specify a glob pattern matcher

myFile1 = file('path/to/*.txt')          // "*" matches any character(s)
myFile2 = file('path/**.txt')            // also traverses directiories 
myFile3 = file('path/[R12].txt')         // [] to match specific characters
myFile4 = file('path/{R1,R2}.txt')       // {} to match longer patterns
myFile5 = file('path/R?.txt')            // "?" matches any 1 character

Note: if a glov pattern is used and it matches with multiple files, all files will be returned together as a list

// myFile = path("/path/to/file.txt", checkIfExists: true) // Will check if the files exists

// Basic read/write operations:

myFile = path("/path/to/file.txt")

print myFile.text            // print the entire contents of the file

myFile.text = "Hello, world" // reassign the file contents (overwrites)

To write a new content to an existing file, without overwriting existing content

myFile.append('Add this line\n')    // append one line to the end of the file
myFile << 'Add a line more\n'       // left shift operator "<<" is more idiomatic

// Reading line by line

The readLines() method reads all the file content at once and returns a list containing all lines

file('path/to/file.txt')
    .readLines()                // read all lines into a list object
    .each {println it}          // iterate thorugh each list element

file('path/to/file.txt')
    .eachLine {println it}      // read each line as a new String

// If the file is too big (fastq), if we use readLine() method this will print all the lines 
   and this will be computationally too intensive.

// If we use eachLine() that is more appropriate for big size, it is used to store only 
   individual lines in memory.


// file.text()      // re-assign a new text to the file (overwrites)
       .write()     // write a String value to a file replacing any existing content
       .append()    //append a file to the end of a file

// Being nextflow used for Bioinformatics puroposes it provides some efficient operations for counting:

myFile.countLines()         // counts all lines ina text file
      .countFasta()         // counts all tecotfs ina FASTA formatted file
      .countFastq()         // counts all recors in a FASTQ formatted file

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
