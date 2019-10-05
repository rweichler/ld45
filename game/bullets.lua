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

--bullet color
red = 1
green = 0
blue = 0

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

function Bullets:render(bulletX, bulletY, bulletR)
	for i = 1, #bullets do
        local bullet = bullets[i]

		love.graphics.setColor(red, green, blue, 1)
		love.graphics.circle("fill", bullet.x + Camera.offx, bullet.y + Camera.offy, bullet.r)
	end
end

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

function Bullets:changeLevel()
	if(Player.level == 1) then -- player is black, bullets are red
		red = 1
		green = 0
		blue = 0
		timeToNewBullet = 20 --number of frames before a new bullet is generated
		bulletSpeedScalar = 100 --how fast the bullets move
	elseif(Player.level == 2) then -- player is red, bullets are green
		red = 0
		green = 1
		blue = 0
		timeToNewBullet = 18 --number of frames before a new bullet is generated
		bulletSpeedScalar = 125 --how fast the bullets move
	elseif(Player.level == 3) then -- player is green, bullets are blue
		red = 0
		green = 0
		blue = 1
		timeToNewBullet = 16 --number of frames before a new bullet is generated
		bulletSpeedScalar = 150 --how fast the bullets move
	elseif(Player.level == 4) then -- player is blue, bullets are white
		red = 1
		green = 1
		blue = 1
		timeToNewBullet = 14 --number of frames before a new bullet is generated
		bulletSpeedScalar = 175 --how fast the bullets move
	elseif(Player.level == 5) then -- player is white, bullets are black
		red = 0
		green = 0
		blue = 0
		timeToNewBullet = 12 --number of frames before a new bullet is generated
		bulletSpeedScalar = 200 --how fast the bullets move
	end
end
