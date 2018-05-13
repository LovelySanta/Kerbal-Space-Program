
function include {
  parameter dir.
  parameter file.
  parameter printError is true.

  if not EXISTS("1:/" + file + ".ks") {
    copypath("0:/" + dir + file + ".ks", "1:/" + file + ".ks").
    runoncepath(file).
  } else if (printError) {
    print "Cannot include file '" + file + ".ks'".
  }

}
