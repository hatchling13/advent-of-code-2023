open Belt
open Belt.Array

module StringCmp = Belt.Id.MakeComparable({
  type rec t = Js.String.t
  let cmp = (a: Js.String.t, b: Js.String.t) => a->Js.String.localeCompare(b)->Float.toInt
})

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

  let lastDigits = lettersInLines->map(Util.reverseLetters)->map(getFirstNumericalDigitFromStrings)

  firstDigits
  ->zip(lastDigits)
  ->map(nums => nums->joinTwoNumbersInOption)
  ->keep(num => num->Option.isSome)
  ->map(num => num->parseNumberInOption)
  ->Util.sumInt
}
