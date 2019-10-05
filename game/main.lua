--[[Untitled Game
by Christine Vaughan and Reed Weichler
10/4/19]]

require 'camera'
require 'physics'
require 'player'
require 'bullets'
require 'console'

function love.update(dt)
    DT = dt

    if Console.on then return end

    Bullets:update(dt)
    Player:update(dt)
    Physics:update(dt)
    Camera:update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    Player:render()
	Bullets:render(bulletX, bulletY, bulletR)
    Console:render()
end
