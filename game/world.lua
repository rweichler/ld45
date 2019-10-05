--[[Untitled Game
by Christine Vaughan and Reed Weichler
10/4/19]]

bullet = {}
bullet.x = love.math.random(0,love.graphics.getMaxImageSize( ))
bullet.y = love.math.random(0,love.graphics.getMaxImageSize( ))
bullet.radius = 5

player{}
player.color = black

function love.update(dt)
	while(player.color == black) --player is black
		function love.draw()
			love.graphics.circle("fill", bullet.x, bullet.y, bullet.radius)
		end

function bulletMove(direction)
	