--[[
*******************************************************************************

Filename:      Application.lua
Version:       1.0.0.0
Firmware:      2.3.0.0 or higher

Date:          2016-07-01
Customer:      Avery Weigh-Tronix
Description:
This lua application file provides basic general weighing functionality.


*******************************************************************************
]]
-- AppName is displayed when escaping from password entry and entering a password of '0'
AppName = "GEN PLU"

--create the awtxReq namespace
awtxReq = {}

require("awtxReqConstants")
require("awtxReqVariables")

--Global Memory Sentinel ... Define this in your app to a different value to clear
-- the Variable table out.
MEMORYSENTINEL = "B0_120001072016"         -- APP_Time_Day_Month_Year
MemorySentinel = awtxReq.variables.SavedVariable('MemorySentinel', "0", true)
-- if the memory sentinel has changed clear out the variable tables.
if MemorySentinel.value ~= MEMORYSENTINEL then
    -- Clears everything
    awtx.variables.clearTable()
    MemorySentinel.value = MEMORYSENTINEL
end

system = awtx.hardware.getSystem(1) -- Used to identify current hardware type.
config = awtx.weight.getConfig(1)   -- Used to get current system configuration information.
wt = awtx.weight.getCurrent(1)      -- Used to hold current scale snapshot information.

require("awtxReqAppMenu")         -- ReqTare is dependent on this
require("awtxReqScaleKeys")       -- ReqScaleKeysEvents & ReqSetpoint are dependent on this
require("awtxReqScaleKeysEvents")
require("awtxReqRpnEntry")
require("ReqSetpoint")
if config.presetTareFlag then
  require("ReqPresetTare")
end

--[[
Description:
  This function Runs on startup

Parameters:
  None

Returns:
  None
]]--
function onStart()
  if Setpoint1Value == 0 then  -- Initialize setpoint variables to be accessed by the firmware.
     Setpoint1Value = config.capacity
  end
  if Setpoint2Value == 0 then
     Setpoint2Value = config.capacity
  end
  if Setpoint3Value == 0 then
     Setpoint3Value = config.capacity
  end
  
  createScreen1() -- creates Screen1 on start up

  screen1:show()
  setScreen1()
  
end
  
-- Require file for a screen manager of sorts 
-- Global table that will hold all the screens and handle switching between them
screens = require('Req510Screens')
-- Each screen is contained in its own file as a module and gets added to the screens table

----Initializations------------
invert_Flag = 0
awtx.graphics.setInverted(invert_Flag)

configRPNFlag = true

Screen = {}
Screen = awtx.graphics.screens.new("Screen")

screen1 = nil

function createScreen1()
  -- Create the screen
  screen1 = awtx.graphics.screens.new('screen1')
  screen1:addControl(screens.scale2)
  screen1:addControl(screens.btn1)
  screen1:addControl(screens.btn2)
  screen1:addControl(screens.btn3)
  screen1:addControl(screens.btn4)
  screen1:addControl(screens.btn5)
  
end

function setScreen1()
  screens.dispmode6txt:setText("")
  screens.btn1:setText("")
  screens.btn2:setText("")
  screens.btn3:setText("")
  screens.btn4:setText("")
  screens.btn5:setText("SetPt")
end

  --------------------------------------------------------------------------------------------------
  --  Super Menu
  --------------------------------------------------------------------------------------------------
  -- Top level Menu
  TopMenu1 = {text = "Super", key = 1, action = "MENU", variable = "SuperMenu", level = 900}
  TopMenu2 = {text = "EXIT",  key = 2, action = "FUNC", callThis = supervisor.SupervisorMenuExit} 
  TopMenu = {TopMenu1, TopMenu2}

  -- These lines are needed to construct the top layer of the Supervisor Menu
  -- As more menus are added through require files, this layer will grow to include them.
  --SuperMenu  = { }

  
  SuperMenu1 = {text = " TARE  ",  key = 1, action = "MENU", variable = "TareSetupMenu", show = config.presetTareFlag}
  SuperMenu2 = {text = " BACK  ",  key = 2, action = "MENU", variable = "TopMenu", subMenu = 1} 
  SuperMenu  = {SuperMenu1, SuperMenu2}

  TareSetupMenu1 = {text = " Edit  ",  key = 1, action = "FUNC", callThis = findTare}
  TareSetupMenu2 = {text = " Print ",  key = 2, action = "FUNC", callThis = printTareList}
  TareSetupMenu3 = {text = " Reset ",  key = 3, action = "FUNC", callThis = tareReset}
  TareSetupMenu4 = {text = " BACK  ",  key = 4, action = "MENU", variable = "SuperMenu", subMenu = 1} 
  TareSetupMenu  = {TareSetupMenu1, TareSetupMenu2, TareSetupMenu3, TareSetupMenu4}

  -- Need this to turn the table string names into the table addresses 
  generalMenu = {
    TopMenu = TopMenu,
      SuperMenu = SuperMenu,
        TareSetupMenu = TareSetupMenu
  }



--[[
Description:
  Function override from ReqAppMenu.lua
  This function is called when the Supervisor menu is entered.
Parameters:
  None
  
Returns:
  None
]]--
function appEnterSuperMenu()
  setpoint.disableOutputSetpoints()  -- Disable setpoints before entering supervisor menu.
  supervisor.menuLevel    = TopMenu         -- Set current menu level
  supervisor.menuCircular = generalMenu     -- Set menu address table
end


--[[
Description:
  Function override from ReqAppMenu.lua
  This function is called when the Supervisor menu is exited.
Parameters:
  None
  
Returns:
  None
]]--
function appExitSuperMenu()
    -- This function retrieves the updated values from the setpoint configuration table
    --  and updates the current setpoints with the latest information.
  setpoint.enableOutputSetpoints()
  screen1:show()
  setScreen1()
end

onStart()
