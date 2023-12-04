let fileName = "./input/input011.txt"

let content = fileName->Node.Fs.readFileSync(#utf8)
let splited = content |> Js.String.split("\n")
let contentLines = splited->Belt.Array.map(Util.removeCarriageReturn)

let firstSolution = contentLines->DSL01.sumOfCalibrationValues

Js.Console.log(firstSolution)

// let correctedLines = contentLines->Belt.Array.map(DSL01.stringToDigits)
// let secondSolution = correctedLines->DSL01.sumOfCalibrationValues

// Js.Console.log(secondSolution)
