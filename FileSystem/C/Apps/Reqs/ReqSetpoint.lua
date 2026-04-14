--[[
*******************************************************************************

Filename:      ReqSetpoint.lua
Version:       1.0.1.0
Date:          2017-04-25
Customer:      Avery Weigh-Tronix
Description:
This is the Setpoint Database library.

*******************************************************************************
History:
1.0.0.0 - Initial Release
1.0.1.0 - Removed calls to awtx.display.setMode()

*******************************************************************************
]]

-- create the setpoint Namespace
setpoint = {}

require("awtxReqConstants")
require("awtxReqVariables")

--- Define variables
Setpoint1Value = 100.0  -- Initialize setpoint variables to be accessed by the firmware.
Setpoint2Value = 200.0
Setpoint3Value = 300.0

--[[
Description:
  This Function is called to initialize things for this Require file 
Parameters:
  None
  
Returns:
  None
]]--
local function create()
  -- Copy stored setpoint values from database and store to lua variables.
  Setpoint1Variable = awtxReq.variables.SavedVariable("Setpoint1Variable", 100.0, true)
  Setpoint2Variable = awtxReq.variables.SavedVariable("Setpoint2Variable", 200.0, true)
  Setpoint3Variable = awtxReq.variables.SavedVariable("Setpoint3Variable", 300.0, true)
  
  -- Copy current stored values into setpoint config-mapped parameters.
  Setpoint1Value = Setpoint1Variable.value
  Setpoint2Value = Setpoint2Variable.value
  Setpoint3Value = Setpoint3Variable.value
  
  -- Register input event handlers.  Config is set as input setpoints on SP11, SP12, and SP13.
  awtx.setpoint.registerInputEvent(11, setpoint.onInput1)
  awtx.setpoint.registerInputEvent(12, setpoint.onInput2)
  awtx.setpoint.registerInputEvent(13, setpoint.onInput3)
end


-- Default Input 1 functionality.
-- Can be overridden by redefining setpoint.onInput1() function call after ReqSetpoint.lua is included in main application.
function setpoint.onInput1(spNum, state)
  if state == true then
    awtx.keypad.KEY_ZERO_DOWN()
  end
end


-- Default Input 2 functionality.
-- Can be overridden by redefining setpoint.onInput2() function call after ReqSetpoint.lua is included in main application.
function setpoint.onInput2(spNum, state)
  if state == true then
    awtx.weight.requestTare()    
  end
end


-- Default Input 3 functionality.
-- Can be overridden by redefining setpoint.onInput3() function call after ReqSetpoint.lua is included in main application.
function setpoint.onInput3(spNum, state)
  if state == true then
    awtx.keypad.KEY_PRINT_DOWN()
  end
end


-- Global function to enable outputs.
function setpoint.enableOutputSetpoints()
  awtx.setpoint.unlock(1)
  awtx.setpoint.unlock(2)
  awtx.setpoint.unlock(3)
end


-- Global function to disable outputs.
function setpoint.disableOutputSetpoints()
  awtx.setpoint.lockOff(1)
  awtx.setpoint.lockOff(2)
  awtx.setpoint.lockOff(3)
end


-- This function cycles through three prompts for the user to enter the three output setpoint values.
function setpoint.configureSetpoints()
  local newVal1 = 0
  local newVal2 = 0
  local newVal3 = 0
  local isEnterKey1 = false
  local isEnterKey2 = false
  local isEnterKey3 = false
  local spMinVal = -999999
  local spMaxVal = 9999999
  local entertime = 10000 
  
  setpoint.disableOutputSetpoints()
  
  newVal1, isEnterKey1 = awtx.keypad.enterFloat(Setpoint1Variable.value, spMinVal, spMaxVal, config.displaySeparator, entertime, 'Enter', 'Out1')
  
  if isEnterKey1 then
    newVal2, isEnterKey2 = awtx.keypad.enterFloat(Setpoint2Variable.value, spMinVal, spMaxVal, config.displaySeparator, entertime, 'Enter', 'Out2')
    
    if isEnterKey2 then
      newVal3, isEnterKey3 = awtx.keypad.enterFloat(Setpoint3Variable.value, spMinVal, spMaxVal, config.displaySeparator, entertime, 'Enter', 'Out3')
    end
  end

  if isEnterKey1 then
    Setpoint1Variable.value = newVal1         -- Assign to table variable for storage
    Setpoint1Value = Setpoint1Variable.value  -- Assign to current setpoint config-mapped parameter
  end

  if isEnterKey2 then
    Setpoint2Variable.value = newVal2         -- Assign to table variable for storage
    Setpoint2Value = Setpoint2Variable.value  -- Assign to current setpoint config-mapped parameter
  end

  if isEnterKey3 then
    Setpoint3Variable.value = newVal3         -- Assign to table variable for storage
    Setpoint3Value = Setpoint3Variable.value  -- Assign to current setpoint config-mapped parameter
  end
  
  setpoint.enableOutputSetpoints()
end

-- Overide the default functionality of the Select Hold Function
function awtxReq.keypad.onF5KeyUp()
  -- When the Select Key is held we want to configure the Setpoint Values.
  setpoint.configureSetpoints()
end

create()
