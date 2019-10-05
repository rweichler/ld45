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

function love.update(dt)
	if(Player.Color == (0, 0, 0)) -- while player is black
		timeToNewBullet = timeToNewBullet - 1
		if(timeToNewBullet == 0)
			timeToNewBullet = 5
			function love.draw()
				love.graphics.circle("fill", bullet.x, bullet.y, bullet.radius)
				end
			numberOfBullets = numberOfBullets + 1
			allBullets[numberOfBullets] = bullet
			bullet.x = love.math.random(0,love.graphics.getMaxImageSize( ))
			bullet.y = love.math.random(0,love.graphics.getMaxImageSize( ))
			bullet.directionX = love.math.random()
			bullet.directionY = love.math.random()
			end
		for i, v in ipairs(allBullets) do
			bullet.x = bullet.x + bullet.directionX*dt
			bullet.y = bullet.y + bullet.directionY*dt
			end
		end
	end

function bulletMove(direction)
	