Player = {}

Player.speed = 400
Player.level = 1
Player.colors = {
    {0.2, 0.2, 0.2},
}

Player.body = love.physics.newBody(Physics.world, 0, 0, 'dynamic')
Player.shape = love.physics.newCircleShape(18)
Player.fixture = love.physics.newFixture(Player.body, Player.shape, 1)

function Player:update()
    local dx = 0
    local dy = 0
    if love.keyboard.isDown('w') then
        dy = dy - 1
    end
    if love.keyboard.isDown('a') then
        dx = dx - 1
    end
    if love.keyboard.isDown('s') then
        dy = dy + 1
    end
    if love.keyboard.isDown('d') then
        dx = dx + 1
    end

    local velocity = math.abs(dx) + math.abs(dy)
    local normal = velocity == 0 and 0 or math.sqrt(velocity) / velocity

    self.body:setLinearVelocity(dx*normal*self.speed, dy*normal*self.speed)
end

function Player:render()
    love.graphics.setColor(unpack(self.colors[self.level]))

    local width, height = love.graphics:getDimensions()

    love.graphics.circle('line', self.body:getX() + Camera.offx, self.body:getY() + Camera.offy, self.shape:getRadius())
end
