
function countdown {
  parameter countAmount. // Number to count down from

  Clearscreen.
  printTitle(1, "Countdown").
  printLeft(4,"   Initiating lanch sequence...").
  wait 1.

  from { local count is 0.}
  until count = countAmount
  step { set count to count + 1.}
  do {
    printLeft(count + 5, "   " + (countAmount - count)).
    wait 1. // Pause one second till next count
  }
}

function launch {
  countdown(3).

  // TODO
}
