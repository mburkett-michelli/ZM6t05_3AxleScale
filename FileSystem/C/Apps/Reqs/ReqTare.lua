--[[
*******************************************************************************

Filename:      ReqTare.lua
Version:       1.0.1.0
Date:          2017-04-25
Customer:      Avery Weigh-Tronix
Description:
A small set of functions to do some tare database operations.

*******************************************************************************
History:
1.0.0.0 - Initial Release
1.0.1.0 - Removed calls to awtx.display.setMode()

*******************************************************************************
]]

require("awtxReqConstants")
require("awtxReqVariables")
require("awtxReqAppMenu")

-- Due to how the ZM file system works, creating nonvolatile data structures
--  greater than 100 elements are strongly discouraged.   
-- For data sets this large, utilize the SQL database system for these products.
MAX_TARE_INDEX  = 10  -- Maximum tare channels (tareMenu must also be modified if changes are made to this value)

tare = {}             -- Table to hold tare functions
TareTable = {}        -- Holds individual tare channel values
TareConfigTable = {}  -- Holds tare enable flags


local DB_FileLocation_Reports
local DB_ReportName_Tare


local function create()
  tare.DBInit()
  tare.tableRecall()
  tare.configRecall()
  if config.presetTareFlag then
    if TareConfigTable.CurrentChannel.value ~= nil and TareConfigTable.CurrentChannel.value <= MAX_TARE_INDEX then
      tare.setChannel(TareConfigTable.CurrentChannel.value) --get the tare values out of the database and set them into the firmware
    end
  else
    TareConfigTable.CurrentChannel.value = 1
  end
  tare.initPrintTokens()
end


function tare.initPrintTokens()
    awtx.fmtPrint.varSet(2, TareConfigTable.CurrentChannel.value, "Tare Channel", awtx.fmtPrint.TYPE_INTEGER)
end


function tare.setPrintTokens()
    awtx.fmtPrint.varSet(2, TareConfigTable.CurrentChannel.value, "Tare Channel", awtx.fmtPrint.TYPE_INTEGER)
end

function tare.DBInit()
	awtx.variables.createTable("tblTare")
	awtx.variables.createTable("tblTareConfig")

  DB_FileLocation_Reports = [[G:\Reports]] 
  DB_ReportName_Tare = [[\TareReport.csv]]
end


function tare.tableRecall()
  local index
  local strTare
  local TareTableDefault = {}
  
  TareTableDefault.presetTare       = 0
  TareTableDefault.units            = config.calwtunitStr
  for index = 1, MAX_TARE_INDEX do
    strTare = string.format("Tare%d", index)
    TareTable[index] = awtxReq.variables.SavedVariable(strTare, TareTableDefault, true, "tblTare")
  end
end


function tare.configRecall()
  TareConfigTable.CurrentChannel = awtxReq.variables.SavedVariable("Channel", 1, true, "tblTareConfig")
end


function tare.DBClear()
  local index
  for index = 1, MAX_TARE_INDEX do
    TareTable[index].presetTare       = 0
    TareTable[index].units            = config.calwtunitStr
  end
end


-- Called by specific menu functions to edit preset tare values.
-- chanNum identifies the specific preset tare channel being edited.
function tare.editPresetTare(label, chanNum)
  local newTare
  local isEnterKey
  
  if chanNum <= MAX_TARE_INDEX then
    local minTare
    local maxTare
    local tareWtUnit
    local errorState

    -- Get the scale configuration
    wt = awtx.weight.getCurrent(1)
    minTare = 0
    maxTare = wt.curCapacity
    -- Convert tare to current live units of weight
    errorState, tareWtUnit = awtx.weight.unitStrToUnitIndex(TareTable[chanNum].units)
    if errorState == 0 then
      newTare = awtx.weight.convertWeight(tareWtUnit, TareTable[chanNum].presetTare, wt.units, 1)
    else
      newTare = TareTable[chanNum].presetTare
    end
    newTare, isEnterKey = awtx.keypad.enterWeightWithUnits(newTare, minTare, maxTare, wt.unitsStr, config.displaySeparator, -1, 1, "Enter", "  Wt  ")
    awtx.display.writeLine(label)
    if isEnterKey then
      TareTable[chanNum].presetTare = newTare
      TareTable[chanNum].units = wt.unitsStr
    end
  end
end

function tare.editPresetTare1(label)
  supervisor.menuing = false
  tare.editPresetTare(label, 1)
  supervisor.menuing = true
end

function tare.editPresetTare2(label)
  supervisor.menuing = false
  tare.editPresetTare(label, 2)
  supervisor.menuing = true
end

function tare.editPresetTare3(label)
  supervisor.menuing = false
  tare.editPresetTare(label, 3)
  supervisor.menuing = true
end

function tare.editPresetTare4(label)
  supervisor.menuing = false
  tare.editPresetTare(label, 4)
  supervisor.menuing = true
end

function tare.editPresetTare5(label)
  supervisor.menuing = false
  tare.editPresetTare(label, 5)
  supervisor.menuing = true
end

function tare.editPresetTare6(label)
  supervisor.menuing = false
  tare.editPresetTare(label, 6)
  supervisor.menuing = true
end

function tare.editPresetTare7(label)
  supervisor.menuing = false
  tare.editPresetTare(label, 7)
  supervisor.menuing = true
end

function tare.editPresetTare8(label)
  supervisor.menuing = false
  tare.editPresetTare(label, 8)
  supervisor.menuing = true
end

function tare.editPresetTare9(label)
  supervisor.menuing = false
  tare.editPresetTare(label, 9)
  supervisor.menuing = true
end

function tare.editPresetTare10(label)
  supervisor.menuing = false
  tare.editPresetTare(label, 10)
  supervisor.menuing = true
end


function tare.DBReport(label)
  local fho
  local err
  local targetPort
  local isEnterKey
  local dbFile
  local row
  local t = {}

  targetPort, isEnterKey = awtx.keypad.selectList(" Port 1, Port 2, USB", 0)
  awtx.display.writeLine(label)

  if isEnterKey then
    awtx.display.setDisplayBusy()
    awtx.os.sleep(500)

    -- Open up and create a database in memory populate from the Tare db
    if targetPort == 0 or targetPort == 1 then
      t[#t+1] = string.format("tareIndex                       presetTare \r\n")
    elseif targetPort == 2 then
      t[#t+1] = string.format("tareIndex, presetTare, units \r\n")
    end
    for index = 1, MAX_TARE_INDEX do
      if targetPort == 0 or targetPort == 1 then
        t[#t+1] = string.format("%30d %10f %10s \r\n", index, TareTable[index].presetTare, TareTable[index].units)
      elseif targetPort == 2 then
        t[#t+1] = string.format("%d, %f, %s \r\n", index, TareTable[index].presetTare, TareTable[index].units)
      end
    end

    if targetPort == 0 then
      awtx.serial.send(1, table.concat(t))
    elseif targetPort == 1 then
      awtx.serial.send(2, table.concat(t))
    elseif targetPort == 2 then
      result = awtx.os.makeDirectory(DB_FileLocation_Reports)
      if result == 0 then
        fho, err = io.open(string.format("%s%s", DB_FileLocation_Reports, DB_ReportName_Tare), "w")
        if err then
          awtx.display.writeLine("err "..err, 1000)
        else
          fho:write(table.concat(t))
          fho:close()
        end
      else  -- couldnt make the directory
        awtx.display.writeLine("err " .. tostring(result))
      end
    end
    awtx.display.clrDisplayBusy()
  end
end


function tare.DBReset(label)
  local isEnterKey
  local index
  
  index, isEnterKey = awtx.keypad.selectList("No,Yes", 0)
  awtx.display.writeLine(label)
  if isEnterKey then
    if index == 1 then
      awtx.display.setDisplayBusy()
      awtx.os.sleep(500)
      tare.DBClear()
      awtx.display.clrDisplayBusy()
    end
  end
end


function tare.setChannel(chanNum)
  local errorState
  local tareWtUnit
  local newtare

  if chanNum <= MAX_TARE_INDEX then
    TareConfigTable.CurrentChannel.value = chanNum
    tare.setPrintTokens()
    wt = awtx.weight.getCurrent(1)
    -- convert tare to appropriate units
    newtare = TareTable[TareConfigTable.CurrentChannel.value].presetTare
    if newtare ~= nil then
      errorState, tareWtUnit = awtx.weight.unitStrToUnitIndex(TareTable[TareConfigTable.CurrentChannel.value].units)
      if errorState == 0 then
        if tareWtUnit ~= wt.units then
          newtare = awtx.weight.convertWeight(tareWtUnit, newtare, wt.units, 1)
        end
      end
      awtx.weight.requestPresetTare(newtare)
    end
  end
end


function tare.enterChannel()
  local isEnterKey
  local newVal
  
  newVal, isEnterKey = awtx.keypad.enterInteger(TareConfigTable.CurrentChannel.value, 1, MAX_TARE_INDEX, -1, "Tare Channel", " 1 - 10 ")
  if isEnterKey then
    tare.setChannel(newVal)
  end
end


-- Called by specific menu functions to edit tare enable properties.
-- editVal identifies the tare enable property being edited.
function tare.editTareValue(label, editVal)
  local newVal
  local isEnterKey = 0
  newVal = editVal
  newVal, isEnterKey = awtx.keypad.selectList("No,Yes", editVal)

  if isEnterKey == 0 then
    newVal = editVal
  end

  return newVal, isEnterKey
end


-----------------------------------------------------------------------------------
--  Tare Menus
-----------------------------------------------------------------------------------

-- Tare Configuration Menu Structure
TareSetupMenu1 = {text = " Edit  ", key = 1, action = "MENU", variable = "TareSetupEdit"}
TareSetupMenu2 = {text = " Print ", key = 2, action = "FUNC", callThis = tare.DBReport}
TareSetupMenu3 = {text = " Reset ", key = 3, action = "FUNC", callThis = tare.DBReset}
TareSetupMenu4 = {text = " BACK  ", key = 4, action = "MENU", variable = "SuperMenu", subMenu = 2}
TareSetupMenu  = {TareSetupMenu1, TareSetupMenu2, TareSetupMenu3, TareSetupMenu4}

TareSetupEdit1  = {text = "Tare 1 ", key = 1,  action = "FUNC", callThis = tare.editPresetTare1}
TareSetupEdit2  = {text = "Tare 2 ", key = 2,  action = "FUNC", callThis = tare.editPresetTare2}
TareSetupEdit3  = {text = "Tare 3 ", key = 3,  action = "FUNC", callThis = tare.editPresetTare3}
TareSetupEdit4  = {text = "Tare 4 ", key = 4,  action = "FUNC", callThis = tare.editPresetTare4}
TareSetupEdit5  = {text = "Tare 5 ", key = 5,  action = "FUNC", callThis = tare.editPresetTare5}
TareSetupEdit6  = {text = "Tare 6 ", key = 6,  action = "FUNC", callThis = tare.editPresetTare6}
TareSetupEdit7  = {text = "Tare 7 ", key = 7,  action = "FUNC", callThis = tare.editPresetTare7}
TareSetupEdit8  = {text = "Tare 8 ", key = 8,  action = "FUNC", callThis = tare.editPresetTare8}
TareSetupEdit9  = {text = "Tare 9 ", key = 9,  action = "FUNC", callThis = tare.editPresetTare9}
TareSetupEdit10 = {text = "Tare 10", key = 10, action = "FUNC", callThis = tare.editPresetTare10}
TareSetupEdit11 = {text = " BACK  ", key = 11, action = "MENU", variable = "TareSetupMenu", subMenu = 1}
TareSetupEdit   = {TareSetupEdit1, TareSetupEdit2, TareSetupEdit3, TareSetupEdit4, TareSetupEdit5, TareSetupEdit6,
                  TareSetupEdit7, TareSetupEdit8, TareSetupEdit9, TareSetupEdit10, TareSetupEdit11}

tareMenu =
{
  TareSetupMenu = TareSetupMenu,
    TareSetupEdit = TareSetupEdit
}

--[[
Description:
  Overides the Tare Key Up Functionality to prompt for a Preset Tare.
  
Parameters:
  None
  
Returns:
  None
]]--
function awtxReq.keypad.onTareKeyUp()
  if config.presetTareFlag then
    tare.enterChannel()
  end
end

--[[
Description:
  Overides the Tare Key Down Functionality to check if Preset Tare is enabled 
  before doing a Pushbutton Tare.
  
Parameters:
  None
  
Returns:
  None
]]--
function awtxReq.keypad.onTareKeyDown()
  -- Default functionality.
  -- Redefine function to change functionality
  if not config.presetTareFlag then
    if config.pbTareFlag then
      awtx.weight.requestTare()
    else
      awtx.display.writeLine("Cant", 500)
    end
  end
end

create()