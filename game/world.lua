--[[Untitled Game
by Christine Vaughan and Reed Weichler
10/4/19]]

width, height = love.graphics.getDimensions( ) --get width and height of window

Bullets = {} --"class" name

allBullets = {} --holds all the bullets on screen

bullet = {} --holds info for individual bullet
bullet.x = love.math.random(1,width) --the x-coordinate of the bullet
bullet.y = love.math.random(1,height) --the y-coordinate of the bullet
bullet.radius = 5
bullet.directionX = love.math.random() --the x component of the direction the bullet will move
bullet.directionY = love.math.random() --the y component of the direction the bullet will move

timeToNewBullet = 5 --number of frames before a new bullet is generated
numberOfBullets = 0 --number of bullets on screen

function Bullets:update(dt)
	if(Player.Color == {0, 0, 0}) then -- while player is black
		timeToNewBullet = timeToNewBullet - 1
		if(timeToNewBullet == 0) then
			timeToNewBullet = 5 --reset timer
			Bullets:render() --render the new bullet
			numberOfBullets = numberOfBullets + 1
			allBullets[numberOfBullets] = bullet --store the bullet
			bullet.x = love.math.random(1,width) --set bullet data for next bullet
			bullet.y = love.math.random(1,height)
			bullet.directionX = love.math.random()
			bullet.directionY = love.math.random()
		end
		for i, v in ipairs(allBullets) do
			--update bullet positions and render them
			allBullets.bullet.x = allBullets.bullet.x + allBullets.bullet.directionX*dt
			allBullets.bullet.y = allBullets.bullet.y + allBullets.bullet.directionY*dt
			Bullets:render()
		end
	end
end

function Bullets:render()
	love.graphics.setColor(0, 0, 0, 1)
	love.graphics.circle("fill", bullet.x, bullet.y, bullet.radius)
end
	