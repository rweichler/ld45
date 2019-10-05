--[[Untitled Game
by Christine Vaughan and Reed Weichler
10/5/19]]

local width, height = love.graphics.getDimensions()

Powerup = {} --"class" name

function Powerup:reset()
    powup = {}

    self.color = {1, 0, 0}
end
Powerup:reset()

local xCoord = 0 --holds x-coordinate
local yCoord = 0 --holds y-coordinate

function Powerup:load(r)
	Powerup:spawnCoords()
    local powup = {}
    powup.x = xCoord
    powup.y = yCoord
    powup.r = r
end

function Powerup:render(powup.x, powup.y, powup.r)
	Powerup:load(10)
	love.graphics.setColor(red, green, blue, 1)
	love.graphics.circle("fill", powup.x + Camera.offx, powup.y + Camera.offy, powup.r)
end

function Powerup:spawnCoords()
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

function Powerup:changeLevel()
	if(Player.level == 1) then -- player is black, powerup is red
		red = 1
		green = 0
		blue = 0
	elseif(Player.level == 2) then -- player is red, powerup is green
		red = 0
		green = 1
		blue = 0
	elseif(Player.level == 3) then -- player is green, powerup is blue
		red = 0
		green = 0
		blue = 1
	elseif(Player.level == 4) then -- player is blue, powerup is white
		red = 1
		green = 1
		blue = 1
	elseif(Player.level == 5) then -- player is white, powerup is black
		red = 0
		green = 0
		blue = 0
	end
end
