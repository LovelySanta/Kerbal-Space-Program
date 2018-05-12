
function checkEngineFlameout {
  local engineList is list().
  list ENGINES in engineList.
  for engine in engineList {
    if (engine:ignition and engine:flameout) {
      return true.
    }
  }
}

function stageWhenEngineFlameout {
  if checkEngineFlameout {
    wait until stage:ready.
    stage.
    return true.
  }
  return false.
}
