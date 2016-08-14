#!/usr/bin/env luajit

package.path = package.path..';./deps/*.lua;./deps/*/init.lua'
package.cpath = package.cpath..';./deps/*.so'

socket = require 'socket'


local tcp = socket.tcp()

local result, err = tcp:connect('localhost', 8080)
if not(result == 1) then
    error("couldn't connect to server: "..err)
end

while true do
    local s = io.read()
    if not s then break end

    tcp:send(s..'\n')

    print('recieved: '..tcp:receive())
end

tcp:close()
