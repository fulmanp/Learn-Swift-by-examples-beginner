//
//  main.swift
//  ch_07
//
//  Created by Piotr Fulmański on 30/03/2022.
//

import Foundation

// === Email
// Define type of fields used to define any item in email group
var emailFields = [FieldType]()
emailFields.append(.text(name: "Name", required: true))
emailFields.append(.email(name: "Email", required: true))
emailFields.append(.text(name: "Password"))

// Create a group to store informations about emails
var groupEmails = Group(name: "Emails")
// Save informations about fields which define any item in this group
groupEmails.fieldType = emailFields

// === Credit cards
// Define type of fields used to define any item in credit cards group
var creditCardFields = [FieldType]()
creditCardFields.append(.text(name: "Name", required: true))
creditCardFields.append(.text(name: "Number", required: true))
creditCardFields.append(.text(name: "CVC code"))
creditCardFields.append(.text(name: "PIN"))
creditCardFields.append(.text(name: "Valid trough"))

// Create a group to store informations about credit cards
var groupCreditCards = Group(name: "Credit cards")
// Save informations about fields which define any item in this group
groupCreditCards.fieldType = creditCardFields

// Get some data

print("=== Informations about my email accounts:")

// Create an empty item from group emails
var emailPrivate = groupEmails.getItem()
// Ask user for input data
emailPrivate.getData()
// Save data provided by user in group emails
groupEmails.storeData(emailPrivate)

print("=== Informations about my credit cards:")

// Create an empty item from group credit cards
var credtCardVisa = groupCreditCards.getItem()
// Ask user for input data
credtCardVisa.getData()
// Save data provided by user in group credit cards
groupCreditCards.storeData(credtCardVisa)

// Print data

print("My emails:")

for email in groupEmails.data {
  email.printInformations()
  print()
}

print("My credit cards:")

for creditCard in groupCreditCards.data {
  creditCard.printInformations()
  print()
}
