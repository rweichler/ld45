--[[Untitled Game
by Christine Vaughan and Reed Weichler
10/4/19]]

width, height = love.graphics.getDimensions( )

Bullets = {}

allBullets = {}

bullet = {}
bullet.x = love.math.random(1,width)
bullet.y = love.math.random(1,height)
bullet.radius = 5
bullet.directionX = love.math.random()
bullet.directionY = love.math.random()

timeToNewBullet = 5
numberOfBullets = 0

function Bullets.update(dt)
	if(Player.Color == {0, 0, 0}) then -- while player is black
		timeToNewBullet = timeToNewBullet - 1
		if(timeToNewBullet == 0) then
			--timeToNewBullet = 5
			Bullets:render()
			numberOfBullets = numberOfBullets + 1
			allBullets[numberOfBullets] = bullet
			bullet.x = love.math.random(1,width)
			bullet.y = love.math.random(1,height)
			bullet.directionX = love.math.random()
			bullet.directionY = love.math.random()
		end
		for i, v in ipairs(allBullets) do
			allBullets.bullet.x = allBullets.bullet.x + allBullets.bullet.directionX*dt
			allBullets.bullet.y = allBullets.bullet.y + allBullets.bullet.directionY*dt
		end
	end
end

function Bullets:render()
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.circle("fill", bullet.x, bullet.y, bullet.radius)
end
	