--[[Untitled Game
by Christine Vaughan and Reed Weichler
10/4/19]]

require 'player'
require 'world'
require 'console'

function love.load()
    Player.x = love.graphics.getWidth() / 2
    Player.y = love.graphics.getHeight() / 2
end

function love.update(dt)
    DT = dt

    Player:update()
end

function love.draw()
    if Console.on then
        Console:render()
        return
    end

    love.graphics.setBackgroundColor(1, 1, 1, 1)
    Player:render()
end
