//
//  main.swift
//  ch_06
//
//  Created by Piotr Fulmański on 23/03/2022.
//

import Foundation

// Define all tags
print("=== Define all tags")

let tagPDF = Tag(shortName: "pdf")
let tagProgramming = Tag(shortName: "programming")
let tagSwift = Tag(shortName: "swift")
let tagDatabase = Tag(shortName: "database")
let tagNosql = Tag(shortName: "nosql")

print(tagPDF.describe())

// Define documents
print("=== Define documents")

var checksum = ["md5": "md5ForDocument1", "sha1": "sha1ForDocument1"]
var tags: Set = [tagPDF.uuid.uuidString, tagProgramming.uuid.uuidString, tagSwift.uuid.uuidString]

let document1 = Document(path: "/doc/books/apple", checksum: checksum, tags: tags)

print(document1.describe() ?? "undefined")

checksum = ["md5": "md5ForDocument2", "sha1": "sha1ForDocument2"]
tags = [tagPDF.uuid.uuidString, tagDatabase.uuid.uuidString, tagNosql.uuid.uuidString]

let document2 = Document(path: "/doc/books/apple", checksum: checksum, tags: tags)

print(document2.describe() ?? "undefined")

// Store data in data structures
print("=== Store data in data structures")

var allDocuments = Dictionary<String, Document>()
var allTags = Dictionary<String, Set<String>>()

allDocuments[document1.uuid.uuidString] = document1
allDocuments[document2.uuid.uuidString] = document2

allTags[tagPDF.uuid.uuidString] = [document1.uuid.uuidString, document2.uuid.uuidString]
allTags[tagProgramming.uuid.uuidString] = [document1.uuid.uuidString]
allTags[tagSwift.uuid.uuidString] = [document1.uuid.uuidString]
allTags[tagDatabase.uuid.uuidString] = [document2.uuid.uuidString]
allTags[tagNosql.uuid.uuidString] = [document2.uuid.uuidString]

print("=== === Documents")
print(allDocuments)
print("=== === Tags")
print(allTags)

// Searching

// PDF documents about programming
print("=== All PDF documents about programming")

let pdf = allTags[tagPDF.uuid.uuidString]
let programming = allTags[tagProgramming.uuid.uuidString]

if let pdf = pdf, let programming = programming {
  let pdfAndProgramming = pdf.intersection(programming)
  
  for documentUUID in pdfAndProgramming {
    if let document = allDocuments[documentUUID] {
      print(document.describe() ?? "undefined")
    }
  }
}


