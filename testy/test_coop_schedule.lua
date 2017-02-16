package.path = package.path..";../?.lua"
local Scheduler = require("schedlua.scheduler")()
local Task = require("schedlua.task")
local taskID = 0;
local Kernel = require("schedlua.kernel")

local function getNewTaskID()
  taskID = taskID+1;
  return taskID;
end

-- local function prioritySpawn(scheduler, func, priority, ...)
--   local task = Task(func, ...);
--   task.Priority = priority;
--   task.TaskID = getNewTaskID();
--   Scheduler:scheduleTaskWithPriority(task, priority);
--  return task;
-- end 

local function range(from, to, step)
  step = step or 1
  return function(_, lastvalue)
    local nextvalue = lastvalue + step
    if step > 0 and nextvalue <= to or step < 0 and nextvalue >= to or
       step == 0
    then
      return nextvalue
    end
  end, nil, from - step
end

local function task1(name, nCount)
	for num=1, nCount do
		local eventName = name..tostring(num);
		print(eventName)

		signalOne(eventName);
		yield();
	end

	signalAll(name..'-finished')
end


local function task2()
  waitForSignal("counter10")
  print("Task2 is running now")
end

local function task3()
  print("Imma have a cool priority")
end

local function main()
  local t1 = coop(1, task1, "counter", 20)
  local t2 = coop(2, task2)

  -- while (true) do
	-- 	print("STATUS: ", t1:getStatus(), t2:getStatus())
	-- 	if t1:getStatus() == "dead" and t2:getStatus() == "dead" then
	-- 		break;
	-- 	end
	-- 	Scheduler:step()
  --   print("I took a step")
	-- end
end

run(main)