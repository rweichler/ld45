--[[Untitled Game
by Christine Vaughan and Reed Weichler
10/4/19]]

love.graphics.setDefaultFilter('nearest', 'nearest')
love.mouse.setVisible(false)

require 'awesome'
require 'input'
require 'camera'
require 'physics'
require 'player'
require 'hell'
require 'console'
require 'mainmenu'
require 'powerup'
require 'collision'

function LevelDown()

    Player.level = Player.level - 1
    if Player.level == 0 then
        GameOver()
    else
        Powerup:changeLevel(false)
        Hell:changeLevel()
    end
end

function LevelUp()
    Player.level = Player.level + 1
    if Player.level == 5 then
        YouWin()
    else
        Powerup:changeLevel(true)
        Hell:changeLevel()
    end
end

function YouWin()
    MainMenu.on = true
    MainMenu.win = true
    MainMenu.lose = false
end

function GameOver()
    MainMenu.on = true
    MainMenu.win = false
    MainMenu.lose = true
end

function ResetWorld()
    Player.level = 1
    Player.x = 0
    Player.y = 0
    Camera.x = 0
    Camera.y = 0
    Hell:reset()
    Powerup:reset()
end

function love.update(dt)
    DT = dt

    if Console.on then return end

    if love.keyboard.isDown('backspace') then
        love.event.quit(0)
    end

    if MainMenu.on then
        MainMenu:update(dt)
        return
    end

    Hell:update(dt)
    Player:update(dt)
    Physics:update(dt)
    Camera:update(dt)
    Powerup:update(dt)

    Collision:update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setColor(1, 1, 1, 1)

    if MainMenu.on then
        MainMenu:render()
    else
        Player:render()
		Powerup:render()
        Hell:render()
    end
    Console:render()
end
