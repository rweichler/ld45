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
    if not self.isAnimatingLevelDown then
        self.sprite:render(powup.x - powup.r + Camera.offx, powup.y - powup.r + Camera.offy, powup.r*2, powup.r*2)
    end

    if self.animation then
        self.animation.render()
    end
end

function Powerup:animateLevelUp()
    local sprite = Awesome:new(self.sprite.color)
    local oldX, oldY, oldR = powup.x, powup.y, powup.r

    self.animation = {}
    self.animation.duration = 0.5
    self.animation.timeLeft = self.animation.duration
    self.animation.render = function()
        local a = self.animation
        local percent = (a.duration - a.timeLeft)/a.duration
        local r = oldR + percent*math.max(width, height)
        local x = oldX - r + Camera.offx
        local y = oldY - r + Camera.offy
        sprite:render(x, y, r*2, r*2, 1 - percent)
    end
end

function Powerup:animateLevelDown(newX, newY)
    local pX, pY, pR = Player.x, Player.y, Player.shape:getRadius()

    local sprite = Awesome:new(Player.colors[Player.level + 1])
    self.isAnimatingLevelDown = true
    self.animation = {}
    self.animation.duration = 0.75
    self.animation.timeLeft = self.animation.duration
    self.animation.render = function()
        local a = self.animation
        local percent = (a.duration - a.timeLeft)/a.duration
        local r = pR*(1-percent) + powup.r*percent
        local x = pX*(1-percent) + powup.x*percent
        local y = pY*(1-percent) + powup.y*percent
        sprite:render(x - r + Camera.offx, y - r + Camera.offy, r*2, r*2, 0.25 + percent*0.75)
    end
end

function Powerup:update(dt)
    if self.animation then
        self.animation.timeLeft = self.animation.timeLeft - dt
        if self.animation.timeLeft < 0 then
            self.animation = nil
            self.isAnimatingLevelDown = false
        end
    end
end

function Powerup:changeLevel(up)
    if up then
        self:animateLevelUp()
    else
        self:animateLevelDown()
    end

    local color = Player.colors[Player.level + 1]
    if color then
        self.sprite:setColor(color)
    end
	if(Player.level == 1) then -- player is black, powerup is red
		powup.r = 20
	elseif(Player.level == 2) then -- player is red, powerup is green
		powup.r = 15
	elseif(Player.level == 3) then -- player is green, powerup is blue
		powup.r = 10
	elseif(Player.level == 4) then -- player is blue, powerup is white
		powup.r = 5
	elseif(Player.level == 5) then -- player is white, powerup is black
		self.sprite:setColor({0, 0, 0})
		powup.r = 5
	end
    powup.x, powup.y = love.math.random(-1000,1000), love.math.random(-1000,1000)
end
