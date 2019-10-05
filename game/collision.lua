
Collision = {}

function Collision:update(dt)
    -- check bullet collisions
    for i,bullet in ipairs(bullets) do
        local dist = math.sqrt(math.pow(bullet.x - Player.x, 2) + math.pow(bullet.y - Player.y, 2))
        if dist < Player.shape:getRadius() + bullet.r then
            LevelDown()
        end
    end

    -- check powerup collision
    local dist = math.sqrt(math.pow(powup.x - Player.x, 2) + math.pow(powup.y - Player.y, 2))
    if dist < Player.shape:getRadius() + powup.r then
        LevelUp()
    end
end
