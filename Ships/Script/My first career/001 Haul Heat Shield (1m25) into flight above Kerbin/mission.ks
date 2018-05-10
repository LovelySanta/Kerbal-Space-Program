function countDown {
  parameter countAmount. // Number to count down from

  Clearscreen.
  print "Countdown initiated!".

  from { local count is countAmount.}
  until count = 0
  step { set count to count - 1.}
  do {
    print "   " + count.
    wait 1. // Pause one second till next count
  }
}



countDown(2).
