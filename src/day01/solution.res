let fileName = "./input/input011.txt"

let content = fileName->Node.Fs.readFileSync(#utf8)
let contentLines = content |> Js.String.split("\n")

let firstSolution = contentLines->DSL01.sumOfCalibrationValues

Js.Console.log(firstSolution)

let correctedLines = contentLines->Belt.Array.map(DSL01.stringToDigits)

Js.Console.log(correctedLines)

let secondSolution = correctedLines->DSL01.sumOfCalibrationValues

Js.Console.log(secondSolution)
