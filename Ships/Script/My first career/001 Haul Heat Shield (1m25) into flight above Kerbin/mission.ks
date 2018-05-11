
include("lib/util/","printFunctions").

printLeft(4,"test").
printCenter(5,"test").

function countDown {
  parameter countAmount. // Number to count down from

  Clearscreen.
  printTitle(0, "Countdown Initiated!").

  from { local count is 0.}
  until count = countAmount
  step { set count to count + 1.}
  do {
    printLeft(count + 3, "   " + (countAmount - count)).
    wait 1. // Pause one second till next count
  }
}

countDown(10).
