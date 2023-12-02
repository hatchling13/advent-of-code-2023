open Belt
open Belt.Array

let sumInt = (nums: array<int>) =>
  nums->reduce(0, (accumulator: int, currentValue: int) => accumulator + currentValue)

let isStringNumeric = number => number->Js.Float.fromString->Js.Float.isNaN == false

let reverseLetters = letters => letters->reverse

let removeCarriageReturn = letters => letters->keep(letter => letter !== "\r")

let splitToLetters = s => s |> Js.String.split("")
