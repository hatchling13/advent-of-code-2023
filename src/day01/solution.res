let fileName = "../../input/input011.txt"

let content = fileName->Node.Fs.readFileSync(#utf8)
let splited = content |> Js.String.split("\n")

let splitToLetters = s => s |> Js.String.split("")
let lettersInLines = splited->Belt.Array.map(splitToLetters)

let isStringNumeric = number => number->Js.Float.fromString->Js.Float.isNaN == false
let getFirstNumericalDigitFromStringArray = array => array |> Js.Array.find(isStringNumeric)
let firstDigits = lettersInLines->Belt.Array.map(getFirstNumericalDigitFromStringArray)

let reverseLetters = letters => letters->Belt.Array.reverse
let removeCarriageReturn = letters => letters->Belt.Array.keep(letter => letter !== "\r")
let lastDigits =
  lettersInLines
  ->Belt.Array.map(reverseLetters)
  ->Belt.Array.map(removeCarriageReturn)
  ->Belt.Array.map(getFirstNumericalDigitFromStringArray)

let joinTwoNumbers = ((first, second): (option<Js.String.t>, option<Js.String.t>)) => {
  switch first {
  | Some(firstNum) =>
    switch second {
    | Some(secondNum) => Some(firstNum ++ secondNum)
    | None => None
    }
  | None => None
  }
}

let parseNumber = (num: option<Js.String.t>) =>
  switch num {
  | Some(n) => Js.Float.fromString(n)->Belt.Int.fromFloat
  | None => 0
  }

let sum = (accumulator: int, currentValue: int) => accumulator + currentValue

let value =
  firstDigits
  ->Belt.Array.zip(lastDigits)
  ->Belt.Array.map(nums => nums->joinTwoNumbers)
  ->Belt.Array.keep(num => num->Belt.Option.isSome)
  ->Belt.Array.map(num => num->parseNumber)
  ->Belt.Array.reduce(0, sum)

Js.Console.log(value)
