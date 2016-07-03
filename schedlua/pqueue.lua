--[[
	PQueue
--]]
local PQueue = {}
setmetatable(PQueue, {
	__call = function(self, ...)
		return self:create(...);
	end,
});

local PQueue_mt = {
	__index = PQueue;
}

PQueue.init = function(self, first, last, name)
	first = first or 1;
	last = last or 0;

	local obj = {
		first=first, 
		last=last, 
		name=name};

	setmetatable(obj, PQueue_mt);

	return obj
end

PQueue.create = function(self, first, last, name)
	first = first or 1
	last = last or 0

	return self:init(first, last, name);
end

--[[
function PQueue.new(name)
	return PQueue:init(1, 0, name);
end
--]]

function PQueue:enqueue(value, priority)
	--self.MyList:PushRight(value)
	local last = self.last + 1
	self.last = last
	self[last] = value

	return value
end

function PQueue:pushFront(value)
	-- PushLeft
	local first = self.first - 1;
	self.first = first;
	self[first] = value;
end

function PQueue:dequeue(value)
	-- return self.MyList:PopLeft()
	local first = self.first

	if first > self.last then
		return nil, "list is empty"
	end
	
	local value = self[first]
	self[first] = nil        -- to allow garbage collection
	self.first = first + 1

	return value	
end

function PQueue:length()
	return self.last - self.first+1
end

-- Returns an iterator over all the current 
-- values in the queue
function PQueue:Entries(func, param)
	local starting = self.first-1;
	local len = self:length();

	local closure = function()
		starting = starting + 1;
		return self[starting];
	end

	return closure;
end


return PQueue;
