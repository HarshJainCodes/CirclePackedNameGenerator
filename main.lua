WINDOW_WIDTH = 1239
WINDOW_HEIGHT = 384

push = require 'push'
Class = require 'Class'
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'

function love.load()
    push:setupScreen(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gStateMachine = StateMachine{
        ['play'] = function () return PlayState() end
    }

    love.window.setVSync(0)

    math.randomseed(os.time())

    gStateMachine:change('play')
end


function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    gStateMachine.current:keypressed(key)
end

function love.update(dt)
    gStateMachine:update(dt)

end

function love.draw()
    push:apply('start')
    gStateMachine:render()
    --love.graphics.print(love.timer.getFPS())
    push:apply('end')
end