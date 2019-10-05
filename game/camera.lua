Camera = {}

Camera.width = love.graphics:getWidth() / 2
Camera.height = love.graphics:getHeight() / 2

Camera.x = 0
Camera.y = 0

function Camera:update()
    local px, py = Player.body:getX(), Player.body:getY()

    if Camera.x + Camera.width/2 < px then
        Camera.x = px - Camera.width/2
    elseif Camera.x - Camera.width/2 > px then
        Camera.x = px + Camera.width/2
    end

    if Camera.y + Camera.height/2 < py then
        Camera.y = py - Camera.height/2
    elseif Camera.y - Camera.height/2 > py then
        Camera.y = py + Camera.height/2
    end
end

local fields = {}
fields.offx = function()
    return love.graphics:getWidth()/2 - Camera.x
end
fields.offy = function()
    return love.graphics:getHeight()/2 - Camera.y
end

setmetatable(Camera, {
    __index = function(t, k)
        if fields[k] then
            return fields[k]()
        end
    end,
})
