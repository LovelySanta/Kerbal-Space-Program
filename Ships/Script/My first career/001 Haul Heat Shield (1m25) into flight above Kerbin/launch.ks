
function countdown {
  parameter countAmount. // Number to count down from

  Clearscreen.
  printTitle(1, "Liftoff").
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

function launch {
  // Declaring states of launch sequence
  local init is 1.
  local liftoff is 2.
  local firstStageSeperation is 3.
  local secondStage is 4.
  local reachedTarget is 5.
  local launched is -1.

  local currentState is init.

  // Declaring control variables
  local mSteering is heading(90,90). // Straight up
  local mThrottle is 1.               // Full speed ahead!

  // Achievement variables
  local mTargetSpeed is 1075.
  local mTargetHeight is 39000.

  until currentState = launched {

    when currentState = init then {
      // Init control pit
      sas off.

      // Lock controls
      lock STEERING to mSteering.
      lock THROTTLE to mThrottle.

      // Countdown sequence
      countdown(3).

      // liftoff!
      stage.
      printTitle(1, "First stage.", true).
      set currentState to liftoff.
    }

    when currentState = liftoff then {
      // Check if booster is empty
      if checkEngineFlameout() {
        set currentState to firstStageSeperation.
      } else {
        preserve.
      }
    }

    when currentState = firstStageSeperation then {
      wait until stage:ready.
      stage. // seperation

      printTitle(1, "Second stage", true).
      wait 1.
      stage. // second stage ignition

      set currentState to secondStage.
    }

    when currentState = secondStage then {
      // Adjusting the speed
      if (SHIP:AIRSPEED < mTargetSpeed) { // Too slow
        set mThrottle to min(mThrottle + .1, 1).

      } else if (SHIP:AIRSPEED > mTargetSpeed) { // Too fast
        set mThrottle to max(mThrottle - .15, 0).
      }

      // Debug printouts
      printLeft(5,  "READOUTS:").
      printLeft(6,  "  Airspeed: " + round(SHIP:AIRSPEED)).
      printLeft(7,  "  Altitude: " + round(SHIP:ALTITUDE)).
      printLeft(8,  "  Pitch:    " + round(vang(SHIP:FACING:vector, SHIP:UP:vector))).
      printLeft(10, "CONTROLS:").
      printLeft(11, "  Throttle: " + round(mThrottle, 2)).

      // check if reached target
      if (SHIP:ALTITUDE >= mTargetHeight) {
        set mThrottle to 0.
        set currentState to launched.
      } else {
        preserve.
      }
    }

  }
}
