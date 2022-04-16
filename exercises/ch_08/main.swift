//
//  main.swift
//  ch_07
//
//  Created by Piotr Fulmański on 30/03/2022.
//

import Foundation

// === Email
// Define fields
var emailFields = [FieldType]()
emailFields.append(.text(name: "Name", required: true))
emailFields.append(.email(name: "Email", required: true))
emailFields.append(.text(name: "Password"))

// Create a group to store informations about emails
var groupEmails = Group(name: "Emails")
groupEmails.fieldType = emailFields

// === Credit cards
// Define fields
var creditCardFields = [FieldType]()
creditCardFields.append(.text(name: "Name", required: true))
creditCardFields.append(.text(name: "Number", required: true))
creditCardFields.append(.text(name: "CVC code"))
creditCardFields.append(.text(name: "PIN"))
creditCardFields.append(.text(name: "Valid trough"))

// Create a group to store informations about credit cards
var groupCreditCards = Group(name: "Credit cards")
groupCreditCards.fieldType = creditCardFields

// Get some data

print("=== Informations about my email accounts:")

var emailPrivate = groupEmails.getItem()
emailPrivate.getData()
groupEmails.storeData(emailPrivate)

print("=== Informations about my credit cards:")

var credtCardVisa = groupCreditCards.getItem()
credtCardVisa.getData()
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
