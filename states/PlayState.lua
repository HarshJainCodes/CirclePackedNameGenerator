require "states/circle"

PlayState = Class{__includes = BaseState}

function PlayState:init()
    imageData = love.image.newImageData("assets/image.png")
    image = love.graphics.newImage("assets/image.png")
    IMAGE_WIDTH = imageData:getWidth()
    IMAGE_HEIGHT = imageData:getHeight()

    pixelDetails = {}

    imageData:mapPixel(readPixel)

    circleTable = {}
    circleTimer = 0
end

function readPixel(x, y, r, g, b, a)
    if (r > 0.9 and g > 0.9 and b > 0.9) then
        table.insert(pixelDetails, {x, y})
    end

    return r, g, b, a
end

function PlayState:update(dt)
    circleTimer = circleTimer + dt

    if circleTimer > 0.000001 then
        isPointValid = true

        local circleX = math.random(0, IMAGE_WIDTH - 1)
        local circleY = math.random(0, IMAGE_HEIGHT - 1)

        for key, value in pairs(pixelDetails) do
            if value[1] == circleX and value[2] == circleY then
                isPointValid = false
                break
            end
        end

        for key, value in pairs(circleTable) do
            local distanceToCenter = math.sqrt(math.pow(circleX - value.x, 2) + math.pow(circleY - value.y, 2))
            if distanceToCenter <= value.radius then
                isPointValid = false
                break
            end
        end
        
        if isPointValid then
            pointfound = true
            table.insert(circleTable, Circle(circleX, circleY, 0))
        end

        circleTimer = 0
    end

    for key, value in pairs(circleTable) do
        -- stops the growing of the cirlce if they touch each other
        for key1, value1 in pairs(circleTable) do
            if value ~= value1 then
                local distanceBetweenRadii = math.sqrt(math.pow(value.x - value1.x, 2) + math.pow(value.y - value1.y, 2))
                if distanceBetweenRadii <= value.radius + value1.radius then
                    value.growing = false
                    value1.growing = false
                end
            end
        end

        value:update(dt)
    end
end

function PlayState:keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function PlayState:render()
    --love.graphics.draw(image)
    love.graphics.setColor(1, 0, 0)

    for key, value in pairs(circleTable) do
        value:render()
    end

    love.graphics.setColor(1, 1, 1)
end