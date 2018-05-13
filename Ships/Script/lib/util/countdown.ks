// Required functions
include("lib/util/","printFunctions", false).

function countdown {
  parameter countAmount is 10. // Number to count down from

  printTitle(1, "Liftoff", true).
  printLeft(4,"   Initiating launch sequence...").
  wait 1.

  from { local count is 0.}
  until count = countAmount
  step { set count to count + 1.}
  do {
    printLeft(count + 5, "   " + (countAmount - count)).
    wait 1. // Pause one second till next count
  }
}
