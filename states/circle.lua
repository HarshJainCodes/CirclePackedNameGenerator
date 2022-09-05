Circle = Class{}

function Circle:init(x, y, radius)
    self.x = x
    self.y = y
    self.radius = radius
    self.growing = true
end


function Circle:update(dt)
    if self.growing then
        self.radius = self.radius + math.random(1, 20) * dt
    end 
end

function Circle:render()
    love.graphics.circle("line", self.x, self.y, self.radius)
end