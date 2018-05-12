// Invoke the terminal
core:doevent ("open terminal").
set terminal:charheight to 24.

// Connect to local drive
switch to 1.
Clearscreen.
print "Booting ...".

// Delete all existing files (when rebooting)
local dirList is list().
list files in dirList.
for dirItem in dirList {
  if (dirItem:isfile) {
    DELETEPATH(dirItem).
  }
}

// Loading new boot files
copypath("0:/lib/boot/include.ks", "1:/include.ks").
runoncepath("include").

wait until SHIP:UNPACKED and SHIP:LOADED.
wait 1.
print "Boot complete.".
print " ".

// Upload archive script to local disk on the rocket
print "Uploading latest mission data...".

if HOMECONNECTION:ISCONNECTED {
  // Upload required files to run mission
  runoncepath("0:/My first career/" + SHIPNAME + "/missionIncludes.ks").

  // Upload mission itself
  COPYPATH("0:/My first career/" + SHIPNAME + "/mission.ks", "1:/mission.ks").
}
wait 1.

print "Upload complete.".
print " ".
wait 1.

// Start mission
print "Starting mission...".
wait 2.
run mission.ks.
