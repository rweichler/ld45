MainMenu = {}
MainMenu.font = love.graphics.newFont('fonts/hack.ttf', 30)
MainMenu.on = true

-- set these to determine if we won or LOST
MainMenu.win = false
MainMenu.lose = false

function MainMenu:update(dt)
    if Console.on then return end

    if love.keyboard.isDown('space') then
        MainMenu.on = false
    end
    if love.keyboard.isDown('backspace') then
        love.event.quit(0)
    end
end

MainMenu.awesome = Awesome:new()

function MainMenu:render()
    love.graphics.setFont(MainMenu.font)
    if self.win then
        love.graphics.setColor(0.3, 1, 0.3)
        love.graphics.print('YOU WIN', 20, 20)
    elseif self.lose then
        love.graphics.setColor(1, 0.3, 0.3)
        love.graphics.print('YOU LOSE', 20, 20)
    else
        love.graphics.setColor(1, 0.8, 1)
        love.graphics.print('Some random game', 20, 20)
        love.graphics.setColor(0.8, 0.8, 1)
        love.graphics.print('WASD to move', 20, 50)
        MainMenu.awesome:setColor{math.random(), math.random(), math.random()}
        MainMenu.awesome:render(20, 150, 128, 128)
    end
    love.graphics.setColor(0.8, 1, 1)
    love.graphics.print('Press space to START WOO', 20, 90)
    love.graphics.setColor(1, 0.8, 0.8)
    love.graphics.print('Press backspace to quit to desktop', 20, 120)
end
