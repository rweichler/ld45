MainMenu = {}
MainMenu.font = love.graphics.newFont('fonts/hack.ttf', 30)
MainMenu.on = true

MainMenu.win = false
MainMenu.lose = false

function MainMenu:update(dt)
    if Console.on then return end

    for k,v in pairs(Input) do
        if love.keyboard.isDown(v) then
            MainMenu.on = false
        end
    end
end

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
    end
    love.graphics.setColor(0.8, 1, 1)
    love.graphics.print('Press WASD to START WOO', 20, 90)
end
