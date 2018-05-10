

function printAtPosition {
  parameter row.
  parameter col.
  parameter text.

  print text at (col, row).
}

function clearLine {
  parameter row.
  local text is "".

  from { local count is 0.}
  until count >= terminal:width
  step { set count to count + 1.}
  do {
    set text to text + " ".
  }

  printAtPosition(row, 0, text).
}

function printLeft {
  parameter row.
  parameter text.

  clearLine(row).
  printAtPosition(row, 0, text).

}

function printRight {
  parameter row.
  parameter text.

  clearLine(row).
  printAtPosition(row, terminal:width - text:length, text).
}

function printCenter {
  parameter row.
  parameter text.

  clearLine(row).
  printAtPosition(row, floor((terminal:width - text:length)/2), text).
}
