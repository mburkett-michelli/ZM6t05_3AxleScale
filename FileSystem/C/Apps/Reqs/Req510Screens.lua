
-- Module table
local M = {}

local activeScreen = {}
MaxX = 320
MaxY = 80

--Setup global softkeys(buttons) that all the screens can use
    btnF1 = ""
    btnF2 = ""
    btnF3 = ""
    btnF4 = ""
    btnF5 = ""

    btnFont = awtx.graphics.FONT_VERDANA_15
    btnSizeX = (MaxX/5) + 1 --65
    btnWidth = 60
    btnSizeY = 30 --font size plus a couple
    btnOffsetY = 15

    btnX1 = btnSizeX * 0
    btnX2 = btnSizeX * 1
    btnX3 = btnSizeX * 2
    btnX4 = btnSizeX * 3
    btnX5 = btnSizeX * 4

    btnY1 = MaxY - btnSizeY
    btnY2 = MaxY - btnSizeY
    btnY3 = MaxY - btnSizeY
    btnY4 = MaxY - btnSizeY
    btnY5 = MaxY - btnSizeY

    btnY1 = (MaxY - btnSizeY) + btnOffsetY
    btnY2 = (MaxY - btnSizeY) + btnOffsetY
    btnY3 = (MaxY - btnSizeY) + btnOffsetY
    btnY4 = (MaxY - btnSizeY) + btnOffsetY
    btnY5 = (MaxY - btnSizeY) + btnOffsetY

    local btn1 = awtx.graphics.button.new("btn1")
    btn1:setLocation(btnX1, btnY1)
    btn1:reSize(btnWidth, btnSizeY)
    btn1:setText(btnF1)
    btn1:setFont(btnFont)
    btn1:setAlignment(-2)

    M.btn1 = btn1

    local btn2 = awtx.graphics.button.new("btn2")
    btn2:setLocation(btnX2, btnY2)
    btn2:reSize(btnWidth, btnSizeY)
    btn2:setText(btnF2)
    btn2:setFont(btnFont)
    btn2:setAlignment(-2)

    M.btn2 = btn2

    local btn3 = awtx.graphics.button.new("btn3")
    btn3:setLocation(btnX3, btnY3)
    btn3:reSize(btnWidth, btnSizeY)
    btn3:setText(btnF3)
    btn3:setFont(btnFont)
    btn3:setAlignment(-2)

    M.btn3 = btn3

    local btn4 = awtx.graphics.button.new("btn4")
    btn4:setLocation(btnX4, btnY4)
    btn4:reSize(btnWidth, btnSizeY)
    btn4:setText(btnF4)
    btn4:setFont(btnFont)
    btn4:setAlignment(-2)

    M.btn4 = btn4

    local btn5 = awtx.graphics.button.new("btn5")
    btn5:setLocation(btnX5, btnY5)
    btn5:reSize(btnWidth, btnSizeY)
    btn5:setText(btnF5)
    btn5:setFont(btnFont)
    btn5:setAlignment(-2)

    M.btn5 = btn5

--Setup global scales that all the screens can use
    local scale1 = awtx.graphics.scale.new("scale1",0, 1) --Scale style 1 320x80 Large
    scale1:setLocation(0, 0)
    scale1:setScaleNumVisible(true)

    M.scale1 = scale1

    local scale2 = awtx.graphics.scale.new("scale2",0, 2) --Scale style 2 320x60 Medium
    scale2:setLocation(0, 0)
    scale2:setScaleNumVisible(true)

    M.scale2 = scale2

    local scale3a = awtx.graphics.scale.new("scale3a",1, 3) --Scale style 3 320x34 Small
    scale3a:setLocation(0, 0)
    scale3a:setScaleNumVisible(true)

    M.scale3a = scale3a

    local scale3b = awtx.graphics.scale.new("scale3b",2, 3) --Scale style 3 320x34 Small
    scale3b:setLocation(0, 40)
    scale3b:setScaleNumVisible(true)

    M.scale3b = scale3b

    local scale3c = awtx.graphics.scale.new("scale3c",1, 3) --Scale style 3 320x34 Small
    scale3c:setLocation(110, 0)
    scale3c:setScaleNumVisible(true)

    M.scale3c = scale3c

    local scale3d = awtx.graphics.scale.new("scale3d",2, 3) --Scale style 3 320x34 Small
    scale3d:setLocation(110, 40)
    scale3d:setScaleNumVisible(true)

    M.scale3d = scale3d

    local scale4a = awtx.graphics.scale.new("scale4a",1, 4) --Scale style 4 160x24 Side-by-side
    scale4a:setLocation(0, 0)
    scale4a:setScaleNumVisible(true)

    M.scale4a = scale4a

    local scale4b = awtx.graphics.scale.new("scale4b",2, 4) --Scale style 4 160x24 Side-by-side
    scale4b:setLocation(160, 0)
    scale4b:setScaleNumVisible(true)

    M.scale4b = scale4b

--Setup global textboxes that all the screens can use
    dispmode1txt = awtx.graphics.label.new("dispmode1txt")
    dispmode1txt:setLocation( 0, 1)
    dispmode1txt:reSize( 320, 12)
    dispmode1txt:setText("")
    dispmode1txt:setFont(awtx.graphics.FONT_LUCIDA_CON_10)

    M.dispmode1txt = dispmode1txt

    dispmode2txt = awtx.graphics.label.new("dispmode2txt")
    dispmode2txt:setLocation( 0, 14)
    dispmode2txt:reSize( 320, 12)
    dispmode2txt:setText("")
    dispmode2txt:setFont(awtx.graphics.FONT_LUCIDA_CON_10)

    M.dispmode2txt = dispmode2txt

    dispmode3txt = awtx.graphics.label.new("dispmode3txt")
    dispmode3txt:setLocation( 0, 27)
    dispmode3txt:reSize( 320, 12)
    dispmode3txt:setText("")
    dispmode3txt:setFont(awtx.graphics.FONT_LUCIDA_CON_10)

    M.dispmode3txt = dispmode3txt

    dispmode4txt = awtx.graphics.label.new("dispmode4txt")
    dispmode4txt:setLocation( 0, 40)
    dispmode4txt:reSize( 320, 12)
    dispmode4txt:setText("")
    dispmode4txt:setFont(awtx.graphics.FONT_LUCIDA_CON_10)

    M.dispmode4txt = dispmode4txt

    dispmode5txt = awtx.graphics.label.new("dispmode5txt")
    dispmode5txt:setLocation( 0, 53)
    dispmode5txt:reSize( 320, 12)
    dispmode5txt:setText("")
    dispmode5txt:setFont(awtx.graphics.FONT_LUCIDA_CON_10)

    M.dispmode5txt = dispmode5txt

    dispmode6txt = awtx.graphics.label.new("dispmode6txt")
    dispmode6txt:setLocation( 0, 66)
    dispmode6txt:reSize( 320, 12)
    dispmode6txt:setText("")
    dispmode6txt:setFont(awtx.graphics.FONT_LUCIDA_CON_10)

    M.dispmode6txt = dispmode6txt

    prompt1txt = awtx.graphics.label.new("prompt1txt")
    prompt1txt:setLocation( 0, 15)
    prompt1txt:reSize( 320, 45)
    prompt1txt:setText("")
    prompt1txt:setFont(awtx.graphics.FONT_LUCIDA_CON_40)

    M.prompt1txt = prompt1txt

--Setup global bitmaps that all the screens can use
    homebmp1 = awtx.graphics.picturebox.new("homebmp1", "C:\\Apps\\Graphics\\ZM510a.bmp")
    homebmp1:setLocation(0, 0)
    M.homebmp1 = homebmp1

    homebmp2 = awtx.graphics.picturebox.new("homebmp2", "C:\\Apps\\Graphics\\ZM510b.bmp")
    homebmp2:setLocation(0, 0)
    M.homebmp2 = homebmp2

--Setup global bargraphs that all the screens can use
    local grbasis1 = 1       -- awtx.weight.VAL_GROSS = 0, awtx.weight.VAL_NET = 1
    local grscale1 = 0       --
    local grmin1   = 0       --
    local grmax1   = 100     --

    local graph1 = awtx.graphics.graph.new("graph1", grbasis1, grscale1, grmin1, grmax1)
    graph1:setLocation(0, 60)
    graph1:reSize(320, 20)
    graph1:setVisible(true)
    graph1:setValue(0)             -- Used to set the current value if you set the basis to 12 (awtx.weight.VAL_VAR)
    --graph1:setBasis(grbasis)       -- Change the basis value of the graph
    --graph1:setScale(grscale)       -- Change the scale number
    --graph1:setLimits(grmin, grmax) -- Takes 2 parameters to change the min and max values

    M.graph1 = graph1

    local grbasis2 = 0       -- awtx.weight.VAL_GROSS = 0
    local grscale2 = 0       --
    local grmin2   = 0       --
    local grmax2   = 100     --

    local graph2 = awtx.graphics.graph.new("graph2", grbasis2, grscale2, grmin2, grmax2)
    graph2:setLocation(0, 60)
    graph2:reSize(320, 80)
    graph2:setVisible(true)
    graph2:setValue(0)             -- Used to set the current value if you set the basis to 12 (awtx.weight.VAL_VAR)
    --graph2:setBasis(grbasis)       -- Change the basis value of the graph
    --graph2:setScale(grscale)       -- Change the scale number
    --graph2:setLimits(grmin, grmax) -- Takes 2 parameters to change the min and max values

    M.graph2 = graph2

    local grbasis3 = 0       -- awtx.weight.VAL_GROSS = 0
    local grscale3 = 0       --
    local grmin3   = 0       --
    local grmax3   = 100     --

    local graph3 = awtx.graphics.graph.new("graph3", grbasis3, grscale3, grmin3, grmax3)
    graph3:setLocation(0, 60)
    graph3:reSize(320, 80)
    graph3:setVisible(true)
    graph3:setValue(0)             -- Used to set the current value if you set the basis to 12 (awtx.weight.VAL_VAR)
    --graph3:setBasis(grbasis)       -- Change the basis value of the graph
    --graph3:setScale(grscale)       -- Change the scale number
    --graph3:setLimits(grmin, grmax) -- Takes 2 parameters to change the min and max values

    M.graph3 = graph3


----Create some sample screens that everyone can use
--Screen = {}
--Screen = awtx.graphics.screens.new("Screen")

--promptScreen one line large text used in awtxReqDisplayMessages500
--promptScreen = nil

--function createPromptScreen()
--  -- Create the screen
--  promptScreen = awtx.graphics.screens.new('promptScreen')
--  promptScreen:addControl(screens.prompt1txt)
--end
--createPromptScreen() -- creates promptScreen on start up

--function setPromptScreen()
--  screens.prompt1txt:setText("")
--end

--screen1 medium scale and one line text
--screen1 = nil

--function createScreen1()
--  -- Create the screen
--  screen1 = awtx.graphics.screens.new('screen1')
--  screen1:addControl(screens.scale2)
--  screen1:addControl(screens.dispmode6txt)
--end
--createScreen1() -- creates Screen1 on start up

--function setScreen1()
--  screens.dispmode6txt:setText("")
--end

--screen2 simple ZM510 bitmap
--local screen2 = nil

--function createScreen2()
--  -- Create the screen
--  screen2 = awtx.graphics.screens.new('screen2')
--  screen2:addControl(screens.homebmp2)
--end
--createScreen2() -- creates Screen2 on start up

--function setScreen2()
--end

--screen3 medium scale and softkeys
--local screen3 = nil

--function createScreen3()
--  -- Create the screen
--  screen3 = awtx.graphics.screens.new('screen3')
--  screen3:addControl(screens.scale2)
--  screen3:addControl(screens.btn1)
--  screen3:addControl(screens.btn2)
--  screen3:addControl(screens.btn3)
--  screen3:addControl(screens.btn4)
--  screen3:addControl(screens.btn5)
--end
--createScreen3() -- creates Screen3 on start up

--function setScreen3()
--screens.btn1:setText("F1")
--screens.btn2:setText("F2")
--screens.btn3:setText("F3")
--screens.btn4:setText("F4")
--screens.btn5:setText("F5")
--end

--local screen4 = nil

--function createScreen4()
--  -- Create the screen
--  screen4 = awtx.graphics.screens.new('screen4')
--  screen4:addControl(screens.scale2)
--  screen4:addControl(screens.btn1)
--  screen4:addControl(screens.btn2)
--  screen4:addControl(screens.btn3)
--  screen4:addControl(screens.btn4)
--  screen4:addControl(screens.btn5)
--end
--createScreen4() -- creates Screen4 on start up

--function setScreen4()
--screens.btn1:setText("")
--screens.btn2:setText("")
--screens.btn3:setText("ENTER")
--screens.btn4:setText("CLEAR")
--screens.btn5:setText("STORE")
--end

--local screen5 = nil

--function createScreen5()
--  -- Create the screen
--  screen5 = awtx.graphics.screens.new('screen5')
--  screen5:addControl(screens.scale2)
--  screen5:addControl(screens.btn1)
--  screen5:addControl(screens.btn2)
--  screen5:addControl(screens.btn3)
--  screen5:addControl(screens.btn4)
--  screen5:addControl(screens.btn5)
--end
--createScreen5() -- creates Screen5 on start up

--function setScreen5()
--screens.btn1:setText("")
--screens.btn2:setText("")
--screens.btn3:setText("")
--screens.btn4:setText("")
--screens.btn5:setText("")
--end

--local screen6 = nil

--function createScreen6()
--  -- Create the screen
--  screen6 = awtx.graphics.screens.new('screen6')
--  screen6:addControl(screens.scale2)
--  screen6:addControl(screens.btn1)
--  screen6:addControl(screens.btn2)
--  screen6:addControl(screens.btn3)
--  screen6:addControl(screens.btn4)
--  screen6:addControl(screens.btn5)
--end
--createScreen6() -- creates Screen6 on start up

--function setScreen6()
--screens.btn1:setText("")
--screens.btn2:setText("")
--screens.btn3:setText("")
--screens.btn4:setText("")
--screens.btn5:setText("")
--end

--local screen7 = nil

--function createScreen7()
--  -- Create the screen
--  screen7 = awtx.graphics.screens.new('screen7')
--  screen7:addControl(screens.scale2)
--  screen7:addControl(screens.btn1)
--  screen7:addControl(screens.btn2)
--  screen7:addControl(screens.btn3)
--  screen7:addControl(screens.btn4)
--  screen7:addControl(screens.btn5)
--end
--createScreen7() -- creates Screen7 on start up

--function setScreen7()
--screens.btn1:setText("")
--screens.btn2:setText("")
--screens.btn3:setText("")
--screens.btn4:setText("")
--screens.btn5:setText("")
--end

--local screen8 = nil

--function createScreen8()
--  -- Create the screen
--  screen8 = awtx.graphics.screens.new('screen8')
--  screen8:addControl(screens.dispmode1txt)
--  screen8:addControl(screens.dispmode2txt)
--  screen8:addControl(screens.dispmode3txt)
--  screen8:addControl(screens.dispmode4txt)
--  screen8:addControl(screens.dispmode5txt)
--  screen8:addControl(screens.btn1)
--  screen8:addControl(screens.btn2)
--  screen8:addControl(screens.btn3)
--  screen8:addControl(screens.btn4)
--  screen8:addControl(screens.btn5)
--end
--createScreen8() -- creates Screen8 on start up

--function setScreen8()
--screens.dispmode1txt:setText("")
--screens.dispmode2txt:setText("")
--screens.dispmode3txt:setText("")
--screens.dispmode4txt:setText("")
--screens.dispmode5txt:setText("")

--screens.btn1:setText("")
--screens.btn2:setText("")
--screens.btn3:setText("")
--screens.btn4:setText("")
--screens.btn5:setText("")
--end

--local screen9 = nil

--function createScreen9()
--  -- Create the screen
--  screen9 = awtx.graphics.screens.new('screen9')
--  screen9:addControl(screens.scale4a)
--  screen9:addControl(screens.scale4b)
--end
--createScreen9() -- creates Screen9 on start up

--function setScreen9()
--end

--local screen10 = nil

--function createScreen10()
--  -- Create the screen
--  screen10 = awtx.graphics.screens.new('screen10')
--  screen10:addControl(screens.scale3a)
--  screen10:addControl(screens.scale3b)
--end
--createScreen10() -- creates Screen10 on start up

--function setScreen10()
--end

--local screen11 = nil

--function createScreen11()
--  -- Create the screen
--  screen11 = awtx.graphics.screens.new('screen11')
--  screen11:addControl(screens.scale3c)
--  screen11:addControl(screens.scale3d)
--end
--createScreen11() -- creates Screen11 on start up

--function setScreen11()
--end

--screen0:show()
--setScreen0()

return M