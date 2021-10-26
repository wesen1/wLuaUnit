---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

---
-- The backup of the originally loaded packages in the package.loaded table
-- This is created before mocks are injected
--
-- @tfield table originalLoadedPackages
--
DependencyInjector.originalLoadedPackages = nil


function LoadedPackagesInjector:backupOriginalDependencies()

  -- Backup the original loaded packages
  self.originalLoadedPackages = {}
  for packagePath, loadedPackage in pairs(package.loaded) do
    self.originalLoadedPackages[packagePath] = loadedPackage
  end

end

function LoadedPackagesInjector:restoreOriginalDependencies()

  -- Restore all packages that were loaded before the test started
  for packagePath, _ in pairs(package.loaded) do
    package.loaded[packagePath] = self.originalLoadedPackages[packagePath]
  end

  self.originalLoadedPackages = nil

end



function DependencyInjector:getOriginalValueFor(_valueId)

  for _, valueInjector in ipairs(self.valueInjectors) do
    if (valueInjector:hasBackupFor(_valueId)) then
      return valueInjector:getBackupFor(_valueId)
    end
  end

end
