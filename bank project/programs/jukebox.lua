musicify_API = require("musicify")
local mon = peripheral.wrap("top")
os.loadAPI("./button.lua")
os.loadAPI("./LuaUtils.lua")
button.setMonitor(mon)
mon.clear()
mon.setBackgroundColor(2)
mon.setTextColor(1)
mon.setCursorPos(1,1)
mon.write("Please wait..")
mon.setCursorPos(1,2)
mon.write("Connecting...")
local ws = http.websocket("ws://kristmine.herokuapp.com")
mon.clear()
mon.setCursorPos(1,1)
mon.write("Drop card to start")
while true do 
    local succ = turtle.suck()
    if succ then 
        print("succ")
        turtle.dropDown()
        if fs.exists("disk/carddata.txt") then
            print("found file")
            local datafile = fs.open("disk/carddata.txt","r")
            print("opened file")
            local dataToSend = datafile.readAll()
            ws.send("@coin/"..dataToSend)
            print("send")
            local receivedData,binary = ws.receive()
            print("receive")
            local args = string.split(receivedData, ",")
            if tonumber(args[2]) >= 1 then
                musicify_API.play({1})
            else
                mon.clear()
                mon.setCursorPos(1,1)
                mon.write("You need money")
                mon.setCursorPos(1,2)
                mon.write("Your money: "..args[2])
                turtle.suckDown()
                turtle.drop()
                sleep(4)
            end
        else
            turtle.suckDown()
            turtle.drop()
        end
    end    
end