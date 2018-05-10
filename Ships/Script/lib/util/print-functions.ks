

function printAtPosition {
  parameter row.  // line to print on
  parameter col.  // Indentation on the line
  parameter text. // Text to print

  print text at (col, row).
}

function clearLine {
  parameter row.  // line to print on
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
  parameter row.  // line to print on
  parameter text. // Text to print

  clearLine(row).
  printAtPosition(row, 0, text).
}

function printRight {
  parameter row.  // line to print on
  parameter text. // Text to print

  clearLine(row).
  printAtPosition(row, terminal:width - text:length, text).
}

function printCenter {
  parameter row.  // line to print on
  parameter text. // Text to print

  clearLine(row).
  printAtPosition(row, floor((terminal:width - text:length)/2), text).
}
