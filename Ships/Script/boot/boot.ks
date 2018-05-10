// Invoke the terminal
core:doevent ("open terminal").
set terminal:charheight to 24.

// Connect to local drive
switch to 1.
Clearscreen.
print "Booting ...".

// Loading default files
copypath("0:/lib/util/include.ks", "1:/include.ks").
runpath("include").

wait until SHIP:UNPACKED and SHIP:LOADED.
wait 1.
print "Boot complete.".
print " ".

// Upload archive script to local disk on the rocket
print "Uploading latest mission data...".

if HOMECONNECTION:ISCONNECTED {
  //COPYPATH("0:/kOS tutorial/" + SHIPNAME + "/hellolaunch.ks", "1:/missionData.ks").
  COPYPATH("0:/My first career/" + SHIPNAME + "/mission.ks", "1:/mission.ks").
}
wait 1.

print "Upload complete.".
print " ".
wait 1.

// Start mission
print "Starting mission...".
wait 3.
run mission.ks.
