package.path = package.path..";../?.lua"

local Kernel = require("schedlua.kernel")

local function counter(name, nCount)
	for num=1, nCount do
		local eventName = name..tostring(num);
		print(eventName)

		signalOne(eventName);
		yield();
	end

	signalAll(name..'-finished')
end

-- A task which will wait for the count of 15
-- and print a message
function wait15() 
	waitForSignal("counter15") 
	print("reached 15!!") 
end


local function main()
	-- Spawn the task which will generate a steady stream of signals
	local t1 = coop(1, counter, "counter", 25)
	local t2 = coop(2, wait15)

	-- setup to call halt when counting is finished
	onSignal("counter-finished", halt)
end

run(main)
