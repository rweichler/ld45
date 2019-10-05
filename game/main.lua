--[[Untitled Game
by Christine Vaughan and Reed Weichler
10/4/19]]

require 'physics'
require 'player'
require 'world'
require 'console'

function love.update(dt)
    DT = dt

    if Console.on then return end

    Bullets:update(dt)
    Player:update()
    Physics.world:update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    Player:render()
    Console:render()
end
