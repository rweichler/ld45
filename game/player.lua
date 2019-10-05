Player = {}

Player.speed = 10
Player.radius = 18
Player.color = {0, 0, 0}

Player.x = 0
Player.y = 0

Player.dx = 0
Player.dy = 0

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

    self.x = self.x + dx * normal * self.speed
    self.y = self.y + dy * normal * self.speed
end

function Player:render()
    love.graphics.setColor(unpack(self.color))
    love.graphics.circle('fill', self.x, self.y, self.radius)
end
