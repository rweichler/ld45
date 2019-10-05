--[[Untitled Game
by Christine Vaughan and Reed Weichler
10/4/19]]

require 'input'
require 'camera'
require 'physics'
require 'player'
require 'hell'
require 'console'
require 'mainmenu'

function love.update(dt)
    DT = dt

    if Console.on then return end

    if MainMenu.on then
        MainMenu:update(dt)
        return
    end

    Hell:update(dt)
    Player:update(dt)
    Physics:update(dt)
    Camera:update(dt)

    for i,bullet in ipairs(bullets) do
        local dist = math.sqrt(math.pow(bullet.x - Player.x, 2) + math.pow(bullet.y - Player.y, 2))
        if dist < Player.shape:getRadius() + bullet.r then
            MainMenu.on = true
            MainMenu.lose = true
        end
    end
end

function love.draw()
    love.graphics.setBackgroundColor(0, 0, 0)

    if MainMenu.on then
        MainMenu:render()
    else
        Player:render()
        Hell:render()
    end
    Console:render()
end
