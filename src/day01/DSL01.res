open Belt
open Belt.Array

let digits = {
  "one": 1,
  "two": 2,
  "three": 3,
  "four": 4,
  "five": 5,
  "six": 6,
  "seven": 7,
  "eight": 8,
  "nine": 9,
}

let getFirstNumericalDigitFromStrings = array => array |> Js.Array.find(Util.isStringNumeric)

let joinTwoNumbersInOption = ((first, second): (option<Js.String.t>, option<Js.String.t>)) => {
  switch first {
  | Some(firstNum) =>
    switch second {
    | Some(secondNum) => Some(firstNum ++ secondNum)
    | None => None
    }
  | None => None
  }
}

let parseNumberInOption = (num: option<Js.String.t>) =>
  switch num {
  | Some(n) => Js.Float.fromString(n)->Int.fromFloat
  | None => 0
  }

let sumOfCalibrationValues = (lines: array<Js.String.t>) => {
  let lettersInLines = lines->map(Util.splitToLetters)

  let firstDigits = lettersInLines->map(getFirstNumericalDigitFromStrings)

  let lastDigits =
    lettersInLines
    ->map(Util.reverseLetters)
    ->map(Util.removeCarriageReturn)
    ->map(getFirstNumericalDigitFromStrings)

  firstDigits
  ->zip(lastDigits)
  ->map(nums => nums->joinTwoNumbersInOption)
  ->keep(num => num->Option.isSome)
  ->map(num => num->parseNumberInOption)
  ->Util.sumInt
}
