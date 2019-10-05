Player = {}

Player.speed = 10
Player.size = 30
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

    self.x = self.x + dx * self.speed
    self.y = self.y + dy * self.speed
end

function Player:render()
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle('fill', self.x - self.size/2, self.y - self.size/2, self.size, self.size)
end
