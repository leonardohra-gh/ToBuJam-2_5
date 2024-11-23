local Object = require("libs.classic")
local Size = Object:extend()

function Size:new(width, height)
    self.width = width
    self.height = height
end

function Size:set(width, height)
    self.width = width or self.width
    self.height = height or self.height
end

function Size:get()
    return {width = self.width, height = self.height}
end

return Size