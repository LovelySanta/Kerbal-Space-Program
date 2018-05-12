
function include {
  parameter dir.
  parameter file.

  if not EXISTS("1:/" + file + ".ks") {
    copypath("0:/" + dir + file + ".ks", "1:/" + file + ".ks").
    runoncepath(file).
  } else {
    print "Cannot include file '" + file + ".ks'".
  }

}
