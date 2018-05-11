
function include {
  parameter dir.
  parameter file.

  copypath("0:/" + dir + file + ".ks", "1:/" + file + ".ks").
  runpath(file).
}
