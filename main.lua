screenWidth = MOAIEnvironment.screenWidth
screenHeight = MOAIEnvironment.screenHeight
print("Starting up on:" .. MOAIEnvironment.osBrand  .. " version:" .. MOAIEnvironment.osVersion)

if screenWidth == nil then screenWidth =640 end
if screenHeight == nil then screenHeight = 480 end

MOAISim.openWindow("Window",screenWidth,screenHeight)

viewport = MOAIViewport.new()
viewport:setSize(screenWidth,screenHeight)
viewport:setScale(screenWidth,screenHeight)

layer = MOAILayer2D.new()
layer:setViewport(viewport)

MOAIRenderMgr.pushRenderPass(layer)

sprite = MOAIGfxQuad2D.new()
sprite:setTexture("smile.png")
sprite:setRect(-50,0,50,70)

prop = MOAIProp2D.new()
prop:setDeck(sprite)
prop:setLoc(0,0)
layer:insertProp(prop)

MOAIGfxDevice.setClearColor(1,1,1,1)