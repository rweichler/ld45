--[[Untitled Game
by Christine Vaughan and Reed Weichler
10/4/19]]

require 'physics'
require 'player'
require 'bullets'
require 'console'

function love.update(dt)
    DT = dt
	Bullets:update(dt)
    Player:update()
    Physics.world:update(dt)
end

function love.draw()
    if Console.on then
        Console:render()
        return
    end

    love.graphics.setBackgroundColor(0, 0, 0)
    Player:render()
	Bullets:render(bulletX, bulletY, bulletR)
end
