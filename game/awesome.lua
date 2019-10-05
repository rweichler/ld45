Awesome = {}

Awesome.baseimagedata = love.image.newImageData('pics/awesome16x16.png')
Awesome.width, Awesome.height = Awesome.baseimagedata:getDimensions()

function Awesome:new(color)
    local self = setmetatable({}, {__index = self})

    self:setColor(color or {1, 1, 0})

    return self
end

function Awesome:setColor(color)
    self.color = color
    self.imagedata = self.baseimagedata:clone()

    for y=0,self.height-1 do
        for x=0,self.width-1 do
            local r, g, b, a = self.imagedata:getPixel(x, y)
            if r == 1 and g == 1 and b == 0 then
                self.imagedata:setPixel(x, y, unpack(color))
            end
        end
    end

    self.image = love.graphics.newImage(self.imagedata)
end

function Awesome:update(dt)
end

function Awesome:render(x, y, w, h)
    w = w or self.width * 2
    h = h or self.height * 2
    love.graphics.draw(self.image, x, y, nil, w/self.width, h/self.height)
end
