---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

TestCase.injector = nil
TestCase.mockCreator = nil


---
-- The list of mocked dependencies
-- This list is in the format { "dependencyPackageId" = mockObject }
--
-- @tfield table dependencyMocks
--
TestCase.dependencyMocks = nil



function DependencyInjector:backupOriginalDependencies()
  self.valueBackupCollection:backupOriginalDependencies()
end

---
-- Initializes the mocks for the test class dependencies.
--
function TestCase:initializeDependencyMocks(_dependencyInfos)

  local dependencyType, dependencyId, dependencyPath
  local dependencyMock, injectableValue

  -- Create mocks and load them into the package.loaded or the _G table
  self.dependencyMocks = {}
  for _, dependencyInfo in pairs(_dependencyInfos) do

    dependencyType = dependencyInfo["type"] or "object"
    dependencyId = dependencyInfo["id"]
    dependencyPath = dependencyInfo["path"]

    -- Load the dependency

    dependencyMock = self.mockCreator:createDependencyMock(dependencyType, dependencyId, dependencyPath)

    injectableValue = InjectableValueFactory:getInjectableValue(dependencyType, dependencyId, dependencyMock)

    self.injector:inject(injectableValue)


    -- Save the mock to be able to use it in the tests
    self.dependencyMocks[dependencyId] = dependencyMock

  end

end

function DependencyInjector:restoreOriginalDependencies()
  self.valueBackupCollection:restoreOriginalDependencies()
  self.dependencyMocks = nil
end
