---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

---
-- The backup of the original global variables
-- This list is in the format { "variableName" = originalValue }
--
-- @tfield table[] originalGlobalVariables
--
GlobalTableInjector.originalGlobalVariables = nil



function GlobalTableInjector:backupOriginalDependencies()

  -- Backup the original fields of the global table
  self.originalGlobalVariables = {}
  for key, value in pairs(_G) do
    self.originalGlobalVariables[key] = value
  end

end

function GlobalTableInjector:restoreOriginalDependencies()

  -- Overwrite all global variables with the ones that were set before the test started
  for key, _ in pairs(_G) do
    _G[key] = self.originalGlobalVariables[key]
  end

  self.originalGlobalVariables = nil

end
