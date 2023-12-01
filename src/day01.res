open NodeJs

let fileName = "input/input011.txt"

let content = "input/input011.txt"
  -> Fs.readFileSync
  -> Buffer.toString
  -> Js.String2.split(" ")

content -> Belt.Array.forEach(s => Js.log(s))