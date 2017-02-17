package.path = "../?.lua;"..package.path

local queue = require("schedlua.queue")
local tutils = require("schedlua.tabutils")

local q1 = queue();

--print("Q Length (0): ", q1:length())


local t1 = {Priority = 100, name = "1"}
local t2 = {Priority = 100, name = "2"}
local t3 = {Priority = 100, name = "3"}
local t4 = {Priority = 1, name = "4"}
local t5 = {Priority = 2, name = "5"}
local t6 = {Priority = 100, name = "6"}
local t7 = {Priority = 100, name = "7"}

local function priority_comp( a,b ) 
   return a.Priority < b.Priority 
end


q1:pinsert(t1, priority_comp);
print("Enqueue:", t1.Priority, t1.name)
q1:pinsert(t2, priority_comp);
print("Enqueue:", t2.Priority, t2.name)
task = q1:dequeue();
print("Dequeue:", task.Priority, task.name)
q1:pinsert(t3, priority_comp);
print("Enqueue:", t3.Priority, t3.name)
task = q1:dequeue();
print("Dequeue:", task.Priority, task.name)
q1:pinsert(t4, priority_comp);
print("Enqueue:", t4.Priority, t4.name)
q1:pinsert(t5, priority_comp);
print("Enqueue:", t5.Priority, t5.name)
q1:pinsert(t6, priority_comp);
print("Enqueue:", t6.Priority, t6.name)
task = q1:dequeue()
print("Dequeue:", task.Priority, task.name)
q1:pinsert(t7, priority_comp)
print("Enqueue:", t7.Priority, t7.name)


print("Q Length : ", q1.first, q1.last, q1:length())


for entry in q1:Entries() do
    print("Entry: ", entry.Priority, entry.name)
end