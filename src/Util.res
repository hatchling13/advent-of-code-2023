open Belt.Array

let sumInt = (nums: array<int>) =>
  nums->reduce(0, (accumulator: int, currentValue: int) => accumulator + currentValue)

let isStringNumeric = number => number->Js.Float.fromString->Js.Float.isNaN == false

let reverseLetters = letters => letters->reverse

let removeCarriageReturn = (line: Js.String.t) => {
  if line |> Js.String.endsWith("\r") {
    line->Js.String.slice(~from=0, ~to_=-1)
  } else {
    line
  }
}

let splitToLetters = s => s |> Js.String.split("")
