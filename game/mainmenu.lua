MainMenu = {}
MainMenu.bigFont = love.graphics.newFont('fonts/hack.ttf', 30)
MainMenu.font = love.graphics.newFont('fonts/hack.ttf', 15)
MainMenu.on = true

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

function MainMenu:render()
    if self.win then
        love.graphics.setFont(MainMenu.bigFont)
        love.graphics.setColor(0.3, 1, 0.3)
        love.graphics.print('YOU WIN', 20, 20)
    elseif self.lose then
        love.graphics.setFont(MainMenu.bigFont)
        love.graphics.setColor(1, 0.3, 0.3)
        love.graphics.print('YOU LOSE', 20, 20)
    else
        love.graphics.setFont(MainMenu.font)
        love.graphics.setColor(1, 0.8, 1)
        love.graphics.print("Oh no! You've lost all of your colors.\nTry to get them back, but be careful!\nOthers want to stop you from being brighter than they are.", 20, 20)
		love.graphics.setColor(0.9, 0.7, 0.3)
        love.graphics.print("Your colors look like this:", 20, 190)
        MainMenu.awesome:setColor{math.random(), math.random(), math.random()}
        MainMenu.awesome:render(280, 140, 128, 128)
		love.graphics.setColor(0.8, 0.8, 1)
        love.graphics.print('Enemies look like this:', 20, 300)
		love.graphics.setColor{math.random(), math.random(), math.random()}
		love.graphics.circle("fill", 270, 320, 30)
		love.graphics.setColor(0.8, 0.8, 1)
        love.graphics.print('WASD to move', 20, 380)

		love.graphics.setColor(0.8, 0.8, 1)
        love.graphics.print('Run into your colors to get them back.', 20, 410)
        love.graphics.print('Use your metronome halo to find out how close they are.', 20, 425)

		love.graphics.setColor(0.8, 0.8, 1)
        love.graphics.print('If you hit an enemy, you lose a color.', 20, 470)
		love.graphics.setColor(0.8, 0.8, 1)
        love.graphics.print("If you lose all your colors, it's game over.", 20, 485)
    end
    love.graphics.setFont(MainMenu.bigFont)
    love.graphics.setColor(0.8, 1, 1)
    love.graphics.print('Press space to START WOO', 20, 505)
    love.graphics.setColor(1, 0.8, 0.8)
    love.graphics.print('Press backspace to quit to desktop', 20, 535)
end
