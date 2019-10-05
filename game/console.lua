Console = {}

Console.on = false

Console.lineheight = 16
Console.history = {}
Console.backlog = {}
Console.input = ''

Console.font = love.graphics.newFont('fonts/hack.ttf', Console.lineheight)
Console.fontwidth = Console.font:getWidth('a')

--Console.input = UI.Label:new('', Console.lineheight)
--Console.input.font = Font.Monospace
--Console.input.background_color = false
--Console.input:paint()

local button = 'ESC'

local override = {}
override.help = function(self)
    table.insert(self.history, self.input)
    table.insert(self.backlog, {text = self.input, color = {1, 1, 1}})
    table.insert(self.backlog, {text = 'Type some Lua code. Example: 2+2', color = {1, 1, 1}})

    return true
end

override.quit = function()
    love.event.quit(0)
end

function Console.key(key)
    local self = Console

    if key == '\b' then
        local front = string.sub(self.input, 1, math.max(0, self.blinker.pos - 1))
        local back = string.sub(self.input, self.blinker.pos + 1, #self.input)
        self.input = front..back
        self.blinker.pos = self.blinker.pos - 1
        if self.blinker.pos < 0 then
            self.blinker.pos = 0
        end
    elseif key == '\n' then
        if not _G[self.input] and override[self.input] and override[self.input](self) then
            -- skip
        else
            local empty = string.match(self.input, '(%s*)') == self.input
            local returning = not empty
            local f, err = load('return '..self.input) -- first try returning result
            if err then
                returning = string.find(self.input, 'return')
                f, err = load(self.input)
            end
            local success, result
            if f then
                success, result = pcall(f)
            else
                success = false
                result = err
            end
            if not(empty or self.history[#self.history] == self.input) then
                table.insert(self.history, self.input)
            end
            table.insert(self.backlog, {text = self.input, color = {1, 1, 1}})
            if not success then
                print(result)
                -- remove that dumb [string "what you just typed']:1: part at the beginning
                if string.sub(result, 1, #'[string "')  == '[string "' then
                    local add = #'[string ""]:' + 1
                    if #self.input < 48 then
                        result = string.sub(result, #self.input + add, #result)
                    else
                        result = string.sub(result, 48 + add, #result)
                    end
                    result = string.match(result, '%d+%: (.*)')
                end
            end
            if returning or not(result == nil) then
                local color = success and {0x00, 0xff, 0x00} or {0xff, 0x00, 0x00}
                table.insert(self.backlog, {text = tostring(result), color = color})
            end
        end
        while (#self.backlog + 2) * Console.lineheight > love.graphics.getHeight() do
            table.remove(self.backlog, 1)
        end
        self.input = ''
        self.blinker.pos = 0
        self.history_idx = nil
    else
        local front = string.sub(self.input, 1, self.blinker.pos)
        local back = string.sub(self.input, self.blinker.pos + 1, #self.input)
        self.input= front..key..back
        self.blinker.pos = self.blinker.pos + 1
    end
    self.blinker:reset()
end

    local dirs = {}
    dirs.up = true; dirs.down = true; dirs.left = true; dirs.right = true
    local orig
    local orig = love.keypressed or function() end
    love.keypressed = function(key)
        orig(key)
        if not Console.on then
            if key == 'escape' then
                Console.on = true
                print(Console.on)
            end
            return
        end
        if key == 'return' then
            Console.key('\n')
        elseif key == 'backspace' then
            Console.key('\b')
        elseif key == 'escape' then
            Console.on = false
            love.keyboard.setKeyRepeat(false)
        elseif dirs[key] then
            Console[key](Console)
        end
    end
    local orig = love.textinput or function() end
    love.textinput = function(key)
        orig(key)
        if not Console.on then return end
        Console.key(key)
        love.keyboard.setKeyRepeat(true)
    end

Console.blinker = {}
Console.blinker.interval = 0.6
Console.blinker.time = 0
Console.blinker.on = true
Console.blinker.pos = 0
function Console.blinker:draw(x0, y0)
    self.time = self.time + DT
    while self.time > self.interval do
        self.time = self.time - self.interval
        self.on = not self.on
    end
    if self.on then
        love.graphics.setColor(0, 1, 0)
        local charwidth = #Console.input == 0 and 0 or Console.fontwidth
        local x, y = charwidth*self.pos + x0, (#Console.backlog + 1)*Console.lineheight + y0
        love.graphics.line(x, y, x, y + Console.lineheight)
    end
end
function Console.blinker:reset()
    self.on = true
    self.time = 0
end

function Console:down()
    if not self.history_idx then return end

    self.history_idx = self.history_idx + 1
    if self.history_idx > #self.history then
        self.input = self.cached_command
        self.cached_command = nil
        self.history_idx = nil
    else
        self.input = self.history[self.history_idx]
    end
    self.blinker.pos = #self.input
end

function Console:left()
    self.blinker.pos = self.blinker.pos - 1
    if self.blinker.pos < 0 then
        self.blinker.pos = 0
    end
    self.blinker:reset()
end

function Console:right()
    self.blinker.pos = self.blinker.pos + 1
    if self.blinker.pos > #self.input.text then
        self.blinker.pos = #self.input.text
    end
    self.blinker:reset()
end

function Console:up()
    if self.history_idx then
        self.history_idx = self.history_idx - 1
        if self.history_idx < 1 then
            self.history_idx = 1
        end
    elseif #self.history > 0 then
        self.history_idx = #self.history
        self.cached_command = self.input.text
    end
    if self.history_idx then
        self.input.text = self.history[self.history_idx]
        self.blinker.pos = #self.input.text
    end
    self.input:paint()
end

function Console:render()
    if not Console.on then return end

    love.graphics.setFont(self.font)
    local xpad = 3

    print('wat')
    love.graphics.setColor(0.5, 0.5, 1)
    love.graphics.print('Lua console! Press ESC to return to the game', xpad, 0)
    for i,v in ipairs(self.backlog) do
        love.graphics.setColor(unpack(v.color))
        love.graphics.print(v.text, xpad, i*Console.lineheight)
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.input, xpad, (#self.backlog + 1)*Console.lineheight)

    self.blinker:draw(xpad, 0)
end

return Console
