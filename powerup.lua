--[[Untitled Game
by Christine Vaughan and Reed Weichler
10/5/19]]

local width, height = love.graphics.getDimensions()
--local xCoord, yCoord

Powerup = {} --"class" name

function Powerup:reset()
    powup = {}
	
	powup.x = love.math.random(-1000, 1000) --holds x-coordinate
	powup.y = love.math.random(-1000, 1000) --holds y-coordinate
	powup.r = 20

    self.sprite = Awesome:new({1, 0, 0})
end

function Powerup:render()
    self.sprite:render(powup.x - powup.r + Camera.offx, powup.y - powup.r + Camera.offy, powup.r*2, powup.r*2)

    if self.animation then
        self.animation.render()
    end
end

function Powerup:animateLevelUp()
    self.animation = {}
    self.animation.sprite = Awesome:new(self.sprite.color)
    self.animation.x = powup.x
    self.animation.y = powup.y
    self.animation.r = powup.r
    self.animation.duration = 0.5
    self.animation.timeLeft = self.animation.duration
    self.animation.render = function()
        local a = self.animation
        local percent = (a.duration - a.timeLeft)/a.duration
        local r = a.r + percent*math.max(width, height)
        local x = a.x - r + Camera.offx
        local y = a.y - r + Camera.offy
        a.sprite:render(x, y, r*2, r*2, 1 - percent)
    end
end

function Powerup:update(dt)
    if self.animation then
        self.animation.timeLeft = self.animation.timeLeft - dt
        if self.animation.timeLeft < 0 then
            self.animation = nil
        end
    end
end

function Powerup:changeLevel()
	if(Player.level == 1) then -- player is black, powerup is red
		self.sprite:setColor({1, 0, 0})
		powup.r = 20
	elseif(Player.level == 2) then -- player is red, powerup is green
		self.sprite:setColor({0, 1, 0})
		powup.r = 15
	elseif(Player.level == 3) then -- player is green, powerup is blue
		self.sprite:setColor({0, 0, 1})
		powup.r = 10
	elseif(Player.level == 4) then -- player is blue, powerup is white
		self.sprite:setColor({1, 1, 1})
		powup.r = 5
	elseif(Player.level == 5) then -- player is white, powerup is black
		self.sprite:setColor({0, 0, 0})
		powup.r = 5
	end
	powup.x = love.math.random(-1000, 1000) --holds x-coordinate
	powup.y = love.math.random(-1000, 1000) --holds y-coordinate
end
