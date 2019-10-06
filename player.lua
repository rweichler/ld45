Player = {}

Player.speed = 400
Player.level = 1
Player.colors = {
    {0.2, 0.2, 0.2},
    {1.0, 0.0, 0.0},
    {0.0, 1.0, 0.0},
    {0.0, 0.0, 1.0},
    {1.0, 1.0, 1.0},
}

Player.body = love.physics.newBody(Physics.world, 0, 0, 'dynamic')
Player.shape = love.physics.newCircleShape(18)
Player.fixture = love.physics.newFixture(Player.body, Player.shape, 1)

Player.metronomepos = 0 -- between 0 and 1 = expanding, between 1 and 2 = contracting
Player.metronomespeed = 0.4 -- num pulses per pixel distance per second

function Player:update(dt)
    local dx = 0
    local dy = 0
    if love.keyboard.isDown(Input.up) then
        dy = dy - 1
    end
    if love.keyboard.isDown(Input.left) then
        dx = dx - 1
    end
    if love.keyboard.isDown(Input.down) then
        dy = dy + 1
    end
    if love.keyboard.isDown(Input.right) then
        dx = dx + 1
    end

    local velocity = math.abs(dx) + math.abs(dy)
    local normal = velocity == 0 and 0 or math.sqrt(velocity) / velocity

    self.body:setLinearVelocity(dx*normal*self.speed, dy*normal*self.speed)

    local distFromPowerup = math.sqrt(math.pow(Player.x - powup.x, 2) + math.pow(Player.y - powup.y, 2))
    self.metronomepos = self.metronomepos + self.metronomespeed / distFromPowerup / dt
    self.metronomepos = self.metronomepos % 2
end

function Player:render()
    local color = self.colors[self.level]
    love.graphics.setColor(color)

    local width, height = love.graphics:getDimensions()

    love.graphics.circle(self.level == 1 and 'line' or 'fill', self.x + Camera.offx, self.y + Camera.offy, self.shape:getRadius())

    local metronomeSize = self.metronomepos
    if metronomeSize > 1 then
        metronomeSize = 2 - metronomeSize
    end

    local scale = 50
    love.graphics.setColor(color[1], color[2], color[3], 0.7)
    love.graphics.circle('line', self.x + Camera.offx, self.y + Camera.offy, self.shape:getRadius() + metronomeSize*scale)
    love.graphics.setColor(color[1], color[2], color[3], 0.4)
    love.graphics.circle('line', self.x + Camera.offx, self.y + Camera.offy, self.shape:getRadius() + metronomeSize*scale*1.25)
    love.graphics.circle('line', self.x + Camera.offx, self.y + Camera.offy, self.shape:getRadius() + metronomeSize*scale/1.25)
end

-- metatable voodoo

local fields = {}
setmetatable(Player, {
    __index = function(t, k)
        return fields[k] and fields[k].get and fields[k].get()
    end,
    __newindex = function(t, k, v)
        return fields[k] and fields[k].set and fields[k].set(v)
    end
})

fields.x = {}
fields.x.get = function()
    return Player.body:getX()
end
fields.x.set = function(v)
    Player.body:setX(v)
end

fields.y = {}
fields.y.get = function()
    return Player.body:getY()
end
fields.y.set = function(v)
    Player.body:setY(v)
end
