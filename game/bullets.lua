--[[Untitled Game
by Christine Vaughan and Reed Weichler
10/4/19]]

local width, height = 0

Bullets = {} --"class" name

bullets = {}

local xCoord = 0 --holds x-coordinate
local yCoord = 0 --holds y-coordinate

timeToNewBullet = 20 --number of frames before a new bullet is generated
newBulletTimer = timeToNewBullet
bulletSpeedScalar = 100 --how fast the bullets move

bulletRenderInfo = {0, 0, 1} --holds x, y, and radius to send to render

function Bullets:load(r)
	Bullets:spawnCoords()
    local bullet = {}
    bullet.x = xCoord
    bullet.y = yCoord
    bullet.r = r
	local sign = love.math.random(0,1)
	if(sign == 0) then sign = -1 end --randomly determine x direction of bullet
    bullet.dx = bulletSpeedScalar * sign * love.math.random() --the x component of the direction the bullet will move
	sign = love.math.random(0,1)
	if(sign == 0) then sign = -1 end --randomly determine y direction of bullet
    bullet.dy = bulletSpeedScalar * sign * love.math.random() --the y component of the direction the bullet will move
    table.insert(bullets, bullet)
end

function Bullets:update(dt)
	width, height = love.graphics.getDimensions( ) --get width and height of window
	if(Player.level == 1) then -- while player is black
		newBulletTimer = newBulletTimer - 1 --decrement newBulletTimer
		if(newBulletTimer == 0) then --if newBulletTimer goes to 0
			newBulletTimer = timeToNewBullet --reset newBulletTimer
			Bullets:load(5) --render the new bullet
		end
		for i, v in ipairs(bullets) do
			bullets[i].x = bullets[i].x + bullets[i].dx * dt --update the bullet's x coordinate
			bullets[i].y = bullets[i].y + bullets[i].dy * dt --update the bullet's y coordinate
		end
	end
end

function Bullets:render(bulletX, bulletY, bulletR)
	for i = 1, #bullets do
        local bullet = bullets[i]

		love.graphics.setColor(1, 0, 0, 1)
		love.graphics.circle("fill", bullet.x + Camera.offx, bullet.y + Camera.offy, bullet.r)
	end
end

--[[function Bullets:spawnCoords()
	local change = love.math.random(0,1) --determine if we configure x or y first
	xCoord = love.math.random(-1, width + 1)
	yCoord = love.math.random(-1, height + 1)
	if(change == 0) then --configure based on x first
		if(xCoord > -1 and xCoord < width + 1) then
			yCoord = love.math.random(0,1)
			if(yCoord == 0) then yCoord = 1 elseif(yCoord == 1) then yCoord = height + 1 end
		end
	elseif(change == 1) then
		if(yCoord > -1 and yCoord < height + 1) then
			yCoord = love.math.random(0,1)
			if(xCoord == 0) then xCoord = 1 elseif(xCoord == 1) then xCoord = width + 1 end
		end
	end
end]]

function Bullets:spawnCoords()
	local first = love.math.random(0,1) --determine if we set x or y based on player location
	
	if(first == 0) then --set x based on player location
		local sign = love.math.random(0,1) --determine if x is negative or positive
		if(sign == 0) then -- x is negative
			xCoord = Camera.x - (width/2) - 1
		elseif(sign == 1) then -- x is positive
			xCoord = Camera.x + (width/2) + 1
		end
		yCoord = love.math.random(-1, height + 1)
	elseif(first == 1) then --set y based on player location
		local sign = love.math.random(0,1) --determine if y is negative or positive
		if(sign == 0) then -- y is negative
			yCoord = Camera.y - (height/2) - 1
		elseif(sign == 1) then -- y is positive
			yCoord = Camera.y + (height/2) + 1
		end
		xCoord = love.math.random(-1, width + 1)
	end
end
