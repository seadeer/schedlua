package.path = package.path..";../?.lua"
local Scheduler = require("schedlua.scheduler")()
local Task = require("schedlua.task")
local taskID = 0;

local function getNewTaskID()
  taskID = taskID+1;
  return taskID;
end

local function prioritySpawn(scheduler, func, priority, ...)
  local task = Task(func, ...);
  task.Priority = priority;
  task.TaskID = getNewTaskID();
  Scheduler:scheduleTaskWithPriority(task, priority);
 return task;
end 

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

local function task1()
  print("foo");
  Scheduler:yield()
  print("task 1 put to sleep")
end

local function task2()
  print("bar")
end

local function task3()
  print("Imma have a cool priority")
end

local function main()
  local t1 = prioritySpawn(Scheduler, task1, 1)
  local t2 = prioritySpawn(Scheduler, task2, 2)

  while (true) do
		print("STATUS: ", t1:getStatus(), t2:getStatus())
		if t1:getStatus() == "dead" and t2:getStatus() == "dead" then
			break;
		end
		Scheduler:step()
	end
end

main()