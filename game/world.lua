--[[Untitled Game
by Christine Vaughan and Reed Weichler
10/4/19]]

allBullets = {}

bullet = {}
bullet.x = love.math.random(0,love.graphics.getMaxImageSize( ))
bullet.y = love.math.random(0,love.graphics.getMaxImageSize( ))
bullet.radius = 5
bullet.directionX = love.math.random()
bullet.directionY = love.math.random()

timeToNewBullet = 5
numberOfBullets = 0

playerColor = black

function love.update(dt)
	if(playerColor == black) -- while player is black
		timeToNewBullet = timeToNewBullet - 1
		if(timeToNewBullet == 0)
			timeToNewBullet = 5
			function love.draw()
				love.graphics.circle("fill", bullet.x, bullet.y, bullet.radius)
			end
			allBullets[numberOfBullets] = bullet
			numberOfBullets = numberOfBullets + 1
			bullet.x = love.math.random(0,love.graphics.getMaxImageSize( ))
			bullet.y = love.math.random(0,love.graphics.getMaxImageSize( ))
			bullet.directionX = love.math.random()
			bullet.directionY = love.math.random()
		

function bulletMove(direction)
	