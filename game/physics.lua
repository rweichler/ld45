Physics = {}

Physics.world = love.physics.newWorld(0, 0, true)

local function makewall(x, y, width, height)
    local body = love.physics.newBody(Physics.world, x, y)
    local shape = love.physics.newRectangleShape(width, height)
    local fixture = love.physics.newFixture(body, shape)
    return body, shape, fixture
end

local width, height = love.graphics.getDimensions()
Physics.walls = {
    {makewall(width/2, 0, width, 1)}, -- top
    {makewall(width/2, height, width, 1)}, -- bottom
    {makewall(0, height/2, 1, height)}, -- left
    {makewall(width, height/2, 1, height)}, -- right
}
