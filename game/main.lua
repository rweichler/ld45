--[[Untitled Game
by Christine Vaughan and Reed Weichler
10/4/19]]

require 'controls'
-- require 'world'
require 'console'

function love.update(dt)
    DT = dt
end

function love.draw()
	love.graphics.setBackgroundColor(1, 1, 1, 1)
    Console:render()
end
