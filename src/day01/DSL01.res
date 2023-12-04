open Belt
open Belt.Array

module StringCmp = Belt.Id.MakeComparable({
  type rec t = Js.String.t
  let cmp = (a: Js.String.t, b: Js.String.t) => a->Js.String.localeCompare(b)->Float.toInt
})

let createDigitsMap = () => {
  let digitsAsString = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
  let digitsAsNumber = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

  let digits = digitsAsString->Array.zip(digitsAsNumber)

  digits->Map.fromArray(~id=module(StringCmp))
}

let convertEndingDigitString = (
  str: Js.String.t,
  digits: Belt.Map.t<Js.String.t, Js.String.t, StringCmp.identity>,
) => {
  let keys = digits->Map.keysToArray
  let keeped = keys->keep(key => str |> Js.String.endsWith(key))

  let endingDigit = keeped->List.fromArray->List.head

  let result = switch endingDigit {
  | Some(key) => str |> Js.String.replace(key, digits->Map.getWithDefault(key, ""))
  | None => str
  }

  result
}

let stringToDigits = (str: Js.String.t) => {
  let digits = createDigitsMap()
  let destination = ref("")

  let letters = str |> Js.String.split("")

  letters->forEach(letter => {
    destination := destination.contents ++ letter

    destination := destination.contents->convertEndingDigitString(digits)
  })

  destination.contents
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
