function printDebug {
  parameter mPitch is 90.

  printLeft(5,  "READOUTS:").
  printLeft(6,  "  Airspeed: " + round(SHIP:AIRSPEED)).
  printLeft(7,  "  Altitude: " + round(SHIP:ALTITUDE)).
  printLeft(8,  "  Pitch:    " + round(90 - vang(SHIP:FACING:vector, SHIP:UP:vector))).
  printLeft(10, "CONTROLS:").
  printLeft(11, "  Pitch:    " + round(mPitch)).
}

function safeReturn {
  // Declaring states of return sequence
  local init is 1.
  local prepareDeaccelerationBurn is 2.
  local deaccelerationBurn is 3.
  local fallBackToKerbin is 4.
  local returned is -1.

  local currentState is init.

  // Declaring control variables
  local mSteering is heading(90,90). // Straight up
  local mThrottle is 0.              // Free floating in naked space

  // Achievement variables
  local mTargetSpeed is 1075.
  local mTargetHeight is 39000.
  local mDeaccelerationBurnHeight is 60000.


  until currentState = returned {

    when currentState = init then {
      // Lock controls
      lock STEERING to mSteering.
      lock THROTTLE to mThrottle.

      printTitle(1, "Deacceleration burn", true).
      set currentState to prepareDeaccelerationBurn.
    }

    when currentState = prepareDeaccelerationBurn then {
      set mThrottle to 0.
      local mPitch is 90.

      // Do 180 turn
      // 90 at mTargetHeight
      // -90 at mDeaccelerationBurnHeight
      if (SHIP:ALTITUDE >= mTargetHeight and SHIP:ALTITUDE <= mDeaccelerationBurnHeight) {
        //set mPitch to -270 + (SHIP:ALTITUDE - mTargetHeight) * 180 / (mDeaccelerationBurnHeight - mTargetHeight).
        set mPitch to 90 - ((SHIP:ALTITUDE - mTargetHeight) / (mDeaccelerationBurnHeight - mTargetHeight) * (180)).
      } else {
        set mPitch to -90.
      }
      set mSteering to heading(90, mPitch).

      // Debug printouts
      printDebug(mPitch).

      if (90 - round(vang(SHIP:FACING:vector, SHIP:UP:vector)) <= -85) {
        set mSteering to heading(90,-90).
        set currentState to deaccelerationBurn.
      } else {
        preserve.
      }
    }

    when currentState = deaccelerationBurn then {
      set mThrottle to 1.

      if stageWhenEngineFlameout() {
        set currentState to fallBackToKerbin.
        printTitle(1, "Fall back to Kerbin", true).
      } else {
        preserve.
      }
    }

    when currentState = fallBackToKerbin then {
      set mSteering to heading (90,90).

      // Debug printouts
      printDebug().

      // Warp till safe to deplay chutes
      if ((not chutessafe) and SHIP:ALTITUDE < 25000) {
        set KUNIVERSE:TIMEWARP:RATE to 1.
        CHUTESSAFE ON.
      } else {
        set KUNIVERSE:TIMEWARP:RATE to 100.
      }

    }

    // TODO
  }
}
