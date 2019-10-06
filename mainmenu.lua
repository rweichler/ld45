MainMenu = {}
MainMenu.bigFont = love.graphics.newFont('fonts/hack.ttf', 30)
MainMenu.font = love.graphics.newFont('fonts/hack.ttf', 15)
MainMenu.on = true

MainMenu.logoFont = love.graphics.newFont('fonts/hack.ttf', 40)
local logoWidth = MainMenu.logoFont:getWidth('a')

local haloRad = 30

-- set these to determine if we won or LOST
MainMenu.win = false
MainMenu.lose = false

function MainMenu:update(dt)
    if Console.on then return end

    if love.keyboard.isDown('space') then
        ResetWorld()
        MainMenu.on = false
    end
end

MainMenu.awesome = Awesome:new()

local function paintRainbowClosure(x, y)
    local charoff = 0
    return function(char, color)
        love.graphics.setFont(MainMenu.logoFont)
        love.graphics.setColor(unpack(color))
        love.graphics.print(char, x + charoff*logoWidth, y)
        charoff = charoff + 1
    end
end

function MainMenu:render()

    local y = 20

    if self.win then
        love.graphics.setFont(MainMenu.bigFont)
        love.graphics.setColor(0.3, 1, 0.3)
        love.graphics.print('YOU WIN', 20, y)
        y = y + 100
    elseif self.lose then
        love.graphics.setFont(MainMenu.bigFont)
        love.graphics.setColor(1, 0.3, 0.3)
        love.graphics.print('YOU LOSE', 20, y)
        y = y + 100
    else
        local paintRainbow = paintRainbowClosure(20, y)
        paintRainbow('r', {1.0, 0.0, 0})
        paintRainbow('a', {1.0, 0.5, 0})
        paintRainbow('i', {1.0, 1.0, 0})
        paintRainbow('n', {0.0, 1.0, 0})
        paintRainbow('b', {0.0, 0.0, 1.0})
        paintRainbow('0', {math.random(), math.random(), math.random()})
        paintRainbow('w', {1.0, 0, 1.0})
        y = y + 60

        love.graphics.setFont(MainMenu.font)
        love.graphics.setColor(1, 0.8, 1)
        love.graphics.print("Oh no! You've lost all of your colors.\nTry to get them back, but be careful!\nOthers want to stop you from being brighter than they are.", 20, y)
		love.graphics.setColor(0.9, 0.7, 0.3)
        y = y + 170
        love.graphics.print("Your colors look like this:", 20, y)
        MainMenu.awesome:setColor{math.random(), math.random(), math.random()}
        MainMenu.awesome:render(280, y - 40, 128, 128)
        y = y + 120

		love.graphics.setColor(0.8, 0.8, 1)
        love.graphics.print('Enemies look like this:', 20, y)
		love.graphics.setColor{math.random(), math.random(), math.random()}
		love.graphics.circle("fill", 280, y + 10, 30)
        y = y + 70
		love.graphics.setColor(0.8, 0.8, 1)
        love.graphics.print('WASD to move', 20, y)
        y = y + 30

		love.graphics.setColor(1, 0.5, 0)
        love.graphics.print('Run into your colors to get them back.', 20, y)
        y = y + 15
        love.graphics.print('Use your metronome halo to find out how close they are.', 20, y)


		love.graphics.setColor(1, 1, 1)
		love.graphics.circle("line", 700, y - 5, 30)
		haloRad = haloRad + 1
		if(haloRad > 60) then
			haloRad = 30 end
		love.graphics.circle("line", 700, y - 5, haloRad)

        y = y + 45

		love.graphics.setColor(0.5, 0, 1)
        love.graphics.print('If you hit an enemy, you lose a color.', 20, y)
        y = y + 15
		love.graphics.setColor(0, 1, 0.5)
        love.graphics.print("If you lose all your colors, it's game over.", 20, y)
        y = y + 30
    end
    love.graphics.setFont(MainMenu.bigFont)
    love.graphics.setColor(0.8, 1, 1)
    love.graphics.print('Press space to START WOO', 20, y)
    y = y + 30
    love.graphics.setColor(1, 0.8, 0.8)
    love.graphics.print('Press backspace to quit to desktop', 20, y)
end
