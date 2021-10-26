---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local ValueBackupCollection = Object:extend()

function ValueBackupCollection:new(_valueBackups)
  self.valueBackups = _valueBackups
end


---
-- Backs up the original dependencies to be able to restore them after a test was executed.
--
function DependencyInjector:backupOriginalDependencies()
  for _, valueInjector in ipairs(self.valueInjectors) do
    valueInjector:backupOriginalDependencies()
  end
end


---
-- Restores the original dependencies and global variables.
--
function DependencyInjector:restoreOriginalDependencies()
  for _, valueInjector in ipairs(self.valueInjectors) do
    valueInjector:restoreOriginalDependencies()
  end
end
