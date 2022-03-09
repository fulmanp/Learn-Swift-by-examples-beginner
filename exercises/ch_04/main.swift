//
//  main.swift
//  ch_04
//
//  Created by Piotr Fulmański on 09/03/2022.
//

import Foundation

var csvRow = "12, T , Y,A"

var result = UtilsData.split(row: csvRow, bySeparator: ",")


let validatorInteger = ValidatorIntegerInRange()
validatorInteger.set(min: 5, max: 10)

let validatorPossibleValues = ValidatorPossibleValues()
let setOfPossibleValues = ["A", "B", "C", "D", "E"]
validatorPossibleValues.defineSetOfPossibleValues(set: setOfPossibleValues)

var validators = [
  validatorInteger,
  ValidatorBoolean(),
  Validator3StateLogic(),
  validatorPossibleValues
]

print(result.count)
print(result.data)

let validateResult = UtilsData.validate(
  data: result.data,
  validators: validators
)

if let validateResult = validateResult {
  print(validateResult)
} else {
  print("Something is wrong. Check the number of data and validators.")
}



