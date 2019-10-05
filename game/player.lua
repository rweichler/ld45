Player = {}

Player.speed = 400
Player.level = 1
Player.colors = {
    {0.2, 0.2, 0.2},
    {0.5, 0.2, 0.2},
    {0.5, 0.5, 0.2},
    {0.5, 0.5, 0.5},
    {1.0, 0.5, 0.5},
}

Player.body = love.physics.newBody(Physics.world, 0, 0, 'dynamic')
Player.shape = love.physics.newCircleShape(18)
Player.fixture = love.physics.newFixture(Player.body, Player.shape, 1)

function Player:update()
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
end

function Player:render()
    love.graphics.setColor(unpack(self.colors[self.level]))

    local width, height = love.graphics:getDimensions()

    love.graphics.circle('line', self.x + Camera.offx, self.y + Camera.offy, self.shape:getRadius())
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
