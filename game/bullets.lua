--[[Untitled Game
by Christine Vaughan and Reed Weichler
10/4/19]]

width, height = love.graphics.getDimensions( ) --get width and height of window

Bullets = {} --"class" name

--arrays to hold bullet info - bullet n's info will be in bulletX[n], bulletY[n], etc
bulletX = {} --the x-coordinate of each bullet
bulletY =  {} --the y-coordinate of each bullet
bulletR = {} --the radius of each bullet
bulletDX = {} --the x component of the direction each bullet will move
bulletDY = {} --the y component of the direction each bullet will move

timeToNewBullet = 20 --number of frames before a new bullet is generated
newBulletTimer = timeToNewBullet
numberOfBullets = 0 --number of bullets on screen
bulletSpeedScalar = 100 --how fast the bullets move

bulletRenderInfo = {0, 0, 1} --holds x, y, and radius to send to render

function Bullets:load(r)
	table.insert(bulletX, love.math.random(1,width)) --the x-coordinate of the bullet
	table.insert(bulletY, love.math.random(1,height)) --the y-coordinate of the bullet
	table.insert(bulletR, r) --the radius of the bullet
	sign = love.math.random(0,1)
	if(sign == 0) then sign = -1 end --randomly determine x direction of bullet
	table.insert(bulletDX, bulletSpeedScalar * sign * love.math.random( )) --the x component of the direction the bullet will move
	sign = love.math.random(0,1)
	if(sign == 0) then sign = -1 end --randomly determine y direction of bullet
	table.insert(bulletDY, bulletSpeedScalar * sign * love.math.random( )) --the y component of the direction the bullet will move
end

function Bullets:update(dt)
	if(Player.level == 1) then -- while player is black
		newBulletTimer = newBulletTimer - 1 --decrement newBulletTimer
		if(newBulletTimer == 0) then --if newBulletTimer goes to 0
			newBulletTimer = timeToNewBullet --reset newBulletTimer
			Bullets:load(5) --render the new bullet
			numberOfBullets = numberOfBullets + 1 --increment number of bullets
		end
		for i, v in ipairs(bulletX) do
			bulletX[i] = bulletX[i] + bulletDX[i] * dt --update the bullet's x coordinate
		end
		for i, v in ipairs(bulletY) do
			bulletY[i] = bulletY[i] + bulletDY[i] * dt --update the bullet's y coordinate
		end
	end
end

function Bullets:render(bulletX, bulletY, bulletR)
	for i = 1, #bulletX do
		love.graphics.setColor(1, 0, 0, 1)
		love.graphics.circle("fill", bulletX[i], bulletY[i], bulletR[i])
	end
end

function Bullets:spawnCoords()
	change = love.math.random(0,1) --determine if we configure x or y first
	xCoord = love.math.random(-1, width + 1)
	yCoord = love.math.random(-1, height + 1)
	if(change == 0) then --configure x first
		if(xCoord > -1 and xCoord < width + 1) then
			yCoord