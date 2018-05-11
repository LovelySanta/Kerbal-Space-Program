

function printAtPosition {
  parameter row.  // line to print on
  parameter col.  // indentation on the line
  parameter text. // text to print

  print text at (col, row).
}

function clearLine {
  parameter row.                     // line to print on
  parameter characterToWrite is " ". // character to write on the line
  local text is "".

  from { local count is 0.}
  until count >= terminal:width
  step { set count to count + 1.}
  do {
    set text to text + characterToWrite.
  }

  printAtPosition(row, 0, text).
}

function printLeft {
  parameter row.                  // line to print on
  parameter text.                 // text to print
  parameter clearTheLine is true. // bool to clear the line

  if clearTheLine {
    clearLine(row).
  }
  printAtPosition(row, 0, text).
}

function printRight {
  parameter row.                  // line to print on
  parameter text.                 // text to print
  parameter clearTheLine is true. // bool to clear the line

  if clearTheLine {
    clearLine(row).
  }
  printAtPosition(row, terminal:width - text:length, text).
}

function printCenter {
  parameter row.                  // line to print on
  parameter text.                 // text to print
  parameter clearTheLine is true. // bool to clear the line

  if clearTheLine {
    clearLine(row).
  }
  printAtPosition(row, floor((terminal:width - text:length)/2), text).
}

function printTitle {
  parameter firstRow.         // line to print on
  parameter titleToWrite.     // Title to print
  parameter titleChar is "*". // Character to suround the title with

  printCenter(firstRow + 1,titleToWrite).

  clearLine(firstRow, titleChar).
  printLeft(firstRow + 1, titleChar, false).
  printRight(firstRow + 1, titleChar, false).
  clearLine(firstRow + 2, titleChar).
}
