// https://ksp-kos.github.io/KOS/commands/flight/systems.html

function isSafeToDeployChutes {
  return not CHUTESSAFE.
}

function hasUndeployedChutes {
  return not CHUTES.
}

function deploySafeChutes {
  if (isSafeToDeployChutes()) {
    CHUTESSAFE ON.
    return true.  // Did deploy some chutes
  } else {
    return false. // No chutes deployed
  }
}
