Camera = {}

Camera.width = 250
Camera.height = 250

Camera.x = 0
Camera.y = 0

function Camera:update()
    if Camera.x + Camera.width/2 < Player.x then
        Camera.x = Player.x - Camera.width/2
    elseif Camera.x - Camera.width/2 > Player.x then
        Camera.x = Player.x + Camera.width/2
    end

    if Camera.y + Camera.height/2 < Player.y then
        Camera.y = Player.y - Camera.height/2
    elseif Camera.y - Camera.height/2 > Player.y then
        Camera.y = Player.y + Camera.height/2
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
        return fields[k] and fields[k]()
    end,
})
