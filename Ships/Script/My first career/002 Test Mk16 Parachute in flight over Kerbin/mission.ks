// Declaration of states
local init is 1.
local launch is 2.
local deployChutes is 3.
local landing is 4.
local finished is -1.

local currentState is init.

local mSteering is heading(90, 90).
local mThrottle is 1.

when (currentState = init) then {
  // init controls
  sas off.
  set SHIP:CONTROL:PILOTMAINTHROTTLE to 0.

  lock STEERING to mSteering.
  lock THROTTLE to mThrottle.

  // Countdown sequence
  countdown(3).

  stage. //ignition
  printTitle(1, "Launch stage", true).
  set currentState to launch.
}

when (currentState = launch) then {
  if (stageWhenEngineFlameout()) {
    set currentState to deployChutes.
    printTitle(1, "Mission test stage", true).
  } else {
    preserve.
  }
}

when (currentState = deployChutes) then {
  local shipSpeed is SHIP:AIRSPEED.
  local shipHeight is SHIP:ALTITUDE.
  local shipStatus is SHIP:STATUS:TOLOWER.

  printLeft(5, "Speed:  " + round(shipSpeed)).
  printLeft(6, "Height: " + round(shipHeight)).
  printLeft(7, "Status: " + shipStatus).

  if (shipSpeed > 230 and shipSpeed < 290 and shipHeight > 6000 and shipHeight < 9000 and isSafeToDeployChutes()) {
    stage. //deploySafeChutes() through staging.
    set currentState to landing.
    printTitle(1, "Landing stage", true).
  } else {
    preserve.
  }
}

when (currentState = landing) then {
  local shipSpeed is SHIP:AIRSPEED.
  local shipHeight is SHIP:ALTITUDE.
  local shipStatus is SHIP:STATUS:TOLOWER.

  printLeft(5, "Speed:  " + round(shipSpeed)).
  printLeft(6, "Height: " + round(shipHeight)).
  printLeft(7, "Status: " + shipStatus).

  if (shipStatus = "landed") {
    set currentState to finished.
  } else {
    preserve.
  }
}

until (currentState = finished) {
  wait 0.
}
