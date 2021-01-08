os.loadAPI("./button.lua")
local mon = peripheral.wrap("top")
local jukebox = button.create("JukeBox")
local bank = button.create("Bank")
mon.clear()
mon.setCursorPos(1,1)
mon.write("Bank Project")
mon.setCursorPos(1,3)
mon.write("Programs:")
jukebox.setPos(1,4)
bank.setPos(1,5)
jukebox.onClick(function ()
    mon.clear()
    shell.run("programs/jukebox")
end)
bank.onClick(function ()
    mon.clear()
    shell.run("programs/socket")
end)

while true do
    button.await(jukebox,bank)
end


