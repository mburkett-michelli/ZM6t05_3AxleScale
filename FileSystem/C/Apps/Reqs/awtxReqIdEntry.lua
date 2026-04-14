--[[
*******************************************************************************

Filename:      awtxReqIdEntry.lua
Version:       1.0.1.0
Date:          2015-09-01
Customer:      Avery Weigh-Tronix
Description:
This lua file provides basic ID entry and recall functionality.

*******************************************************************************
History:
1.0.0.0 - Initial Release
1.0.1.0 - Modified for the Graphics Display
          Removed calls to awtx.display.setMode()

*******************************************************************************
]]

require("awtxReqConstants")

ID = {}


local function create()
  ID.id = 0
  ID.initIDPrintTokens()
end


function ID.initIDPrintTokens()
  awtx.fmtPrint.varSet(1, ID.id, "ID", awtx.fmtPrint.TYPE_INTEGER)
end


function ID.setIDPrintTokens()
  awtx.fmtPrint.varSet(1, ID.id, "ID", awtx.fmtPrint.TYPE_INTEGER)
end


function ID.enterID()
  local idminVal, idmaxVal, newID, isEnterKey
  newID = ID.id
  idminVal= 0
  idmaxVal= 9999999
  newID, isEnterKey = awtx.keypad.enterInteger(newID, idminVal, idmaxVal, entertime, "Enter ID", "7 Digits Max")
  if isEnterKey then
    ID.setID(newID)
  end
end


function ID.showID()
  awtx.display.writeLine("ID", 1000)
  awtx.display.writeLine(string.format("%d", ID.id), 1500)
end


function ID.setID(newID)
  local idminVal, idmaxVal
  idminVal= 0
  idmaxVal= 9999999
  if newID >= idminVal and newID <= idmaxVal then
    ID.id = tonumber(string.format("%d", newID))
    ID.setIDPrintTokens()
  end
end


create()