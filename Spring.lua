--[[
	Edited by LuaVMX to use normal OOP

	Hello! This spring module was originally made by x_o but was FPS dependant so I (ONXXF on roblox, mosleyite. on discord) edited it to make it work at any FPS
	DevForum post: https://devforum.roblox.com/t/modified-spring-module/2690943
--]]

-- Services
local runService = game:GetService('RunService')

-- Config
local iterations = 8

-- Data
local last_Time = tick()
local curr_Delta = 0

-- Module
local spring = {}
spring.__index = spring

-- Functions
function spring.new(mass, force, damping, speed)
	local self = setmetatable({}, spring)
	
	self.target = Vector3.new()
	self.position = Vector3.new()
	self.velocity = Vector3.new()

	self.mass = mass or 5
	self.force = force or 50
	self.damping = damping or 4
	self.speed = speed or 4

	return self
end

function spring:Shove(force)
	local x, y, z = force.X, force.Y, force.Z

	if x ~= x or x == math.huge or x == -math.huge then
		x = 0
	end

	if y ~= y or y == math.huge or y == -math.huge then
		y = 0
	end

	if z ~= z or z == math.huge or z == -math.huge then
		z = 0
	end

	local endVector = Vector3.new(x, y, z)
	self.velocity = self.velocity + (curr_Delta * 60) * endVector
end

function spring:Update(deltaTime)
	deltaTime = math.clamp(deltaTime, 0, 1 / 30)

	local scaledDeltaTime = deltaTime * self.speed / iterations
	curr_Delta = deltaTime

	for i = 1, iterations do
		local iterationForce = self.target - self.position
		local acceleration = (iterationForce * self.force) / self.mass

		acceleration = acceleration - self.velocity * self.damping

		self.velocity = self.velocity + acceleration * scaledDeltaTime
		self.position = self.position + self.velocity * scaledDeltaTime
	end

	return self.velocity
end

return spring
