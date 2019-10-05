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

timeToNewBullet = 1 --number of frames before a new bullet is generated
newBulletTimer = timeToNewBullet
numberOfBullets = 0 --number of bullets on screen

bulletRenderInfo = {0, 0, 1} --holds x, y, and radius to send to render

function Bullets:load(r)
	table.insert(bulletX, love.math.random(1,width)) --the x-coordinate of the bullet
	table.insert(bulletY, love.math.random(1,height)) --the y-coordinate of the bullet
	table.insert(bulletR, r) --the radius of the bullet
	table.insert(bulletDX, 1) --the x component of the direction the bullet will move
	table.insert(bulletDY, 1) --the y component of the direction the bullet will move
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
			v = v + bulletDX[i] * dt --update the bullet's x coordinate
		end
		for i, v in ipairs(bulletY) do
			v = v + bulletDY[i]	* dt --update the bullet's x coordinate
		end
	end
end

function Bullets:render(bulletX, bulletY, bulletR)
	for i = 1, #bulletX do
		love.graphics.setColor(1, 0, 0, 1)
		love.graphics.circle("fill", bulletX[i], bulletY[i], bulletR[i])
	end
end
	