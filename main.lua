screenWidth = MOAIEnvironment.screenWidth
screenHeight = MOAIEnvironment.screenHeight
print("Starting up on:" .. MOAIEnvironment.osBrand  .. " version:" .. MOAIEnvironment.osVersion)

if screenWidth == nil then screenWidth =640 end
if screenHeight == nil then screenHeight = 480 end

MOAISim.openWindow("Window",screenWidth,screenHeight)

viewport = MOAIViewport.new()
viewport:setSize(screenWidth,screenHeight)
viewport:setScale(screenWidth,screenHeight)

package.path = './moaigui/?.lua;'..package.path
require "gui/support/class"
local moaigui = require "gui/gui"
local resources = require "gui/support/resources"
local filesystem = require "gui/support/filesystem"
local inputconstants = require "gui/support/inputconstants"
local layermgr = require "layermgr"

local gui = moaigui.GUI(screenWidth,screenHeight)

gui:addToResourcePath(filesystem.pathJoin("moaigui/resources", "fonts"))
gui:addToResourcePath(filesystem.pathJoin("moaigui/resources", "gui"))
gui:addToResourcePath(filesystem.pathJoin("moaigui/resources", "media"))
gui:addToResourcePath(filesystem.pathJoin("moaigui/resources", "themes"))

layermgr.addLayer("gui", 99999, gui:layer())
gui:setTheme("basetheme.lua")
gui:setCurrTextStyle("default")

function onButtonClick(event,data)
	label1:setText("You clicked the button")
end

function onLessProgressButtonClick(event,data)
	local curProgress = progress:getProgress()
	if (curProgress > 0) then
		progress:setProgress(curProgress-10)
	end
end

function onMoreProgressButtonClick(event,data)
	local curProgress = progress:getProgress()
	if(curProgress < 100) then
		progress:setProgress(curProgress+10)
	end
end

button = gui:createButton()
button:setPos(0,0)
button:setDim(100,25)
button:setText("This is a button")
button:registerEventHandler(button.EVENT_BUTTON_CLICK,nil,onButtonClick)
button:registerEventHandler(button.EVENT_TOUCH_ENTERS,nil,onButtonClick)

progress = gui:createProgressBar()
progress:setPos(0,25)
progress:setDim(100,25)
progress:setText("This is a progress bar")

button2 = gui:createButton()
button2:setPos(0,50)
button2:setDim(49,25)
button2:setText("Less Progress")
button2:registerEventHandler(button.EVENT_BUTTON_CLICK,nil,onLessProgressButtonClick)
button2:registerEventHandler(button.EVENT_TOUCH_ENTERS,nil,onLessProgressButtonClick)


button3 = gui:createButton()
button3:setPos(51,50)
button3:setDim(49,25)
button3:setText("More Progress")
button3:registerEventHandler(button.EVENT_BUTTON_CLICK,nil,onMoreProgressButtonClick)
button3:registerEventHandler(button.EVENT_TOUCH_ENTERS,nil,onMoreProgressButtonClick)
button3:registerEventHandler(button.EVENT_TOUCH_TAP,nil,onMoreProgressButtonClick)

label1 = gui:createLabel()
label1:setPos(0,75)
label1:setDim(100,25)
label1:setText("Click the top button")
label1:setTextAlignment(label1.TEXT_ALIGN_CENTER)

function onPointerEvent(x, y)
	gui:injectMouseMove(x, y)
end

function onMouseLeftEvent(down)
	if(down) then
		gui:injectMouseButtonDown(inputconstants.LEFT_MOUSE_BUTTON)
	else
		gui:injectMouseButtonUp(inputconstants.LEFT_MOUSE_BUTTON)
	end
end

function onTouchEvent(eventType,idx,x,y,tapCount)
	onPointerEvent(x,y)
	if (MOAITouchSensor.TOUCH_DOWN == eventType) then
		onMouseLeftEvent(true)
	elseif (MOAITouchSensor.TOUCH_UP == eventType) then
		onMouseLeftEvent(false)
	end
end

if MOAIInputMgr.device.pointer then
	MOAIInputMgr.device.pointer:setCallback(onPointerEvent)
	MOAIInputMgr.device.mouseLeft:setCallback(onMouseLeftEvent)
else
	MOAIInputMgr.device.touch:setCallback(onTouchEvent)
end