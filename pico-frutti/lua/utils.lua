function check_diging(obj, dir)
    if dir=="l" and pget(obj.x-4, obj.y+4)!=0 then return true end
    if dir=="r" and pget(obj.x-4, obj.y+4)!=0 then return true end
    if dir=="u" and pget(obj.x-4, obj.y+4)!=0 then return true end
    if dir=="d" and pget(obj.x-4, obj.y+4)!=0 then return true end
    return false
end

function check_map(obj, dir, flag, mud)
    local m={x=mp.x,y=mp.y}
    if mud then m={x=mp.mudx,y=mp.mudy} end
    if dir=="l" then return fget(mget(obj.x/8-1+m.x, obj.y/8+m.y), flag) end
    if dir=="r" then return fget(mget(obj.x/8+1+m.x, obj.y/8+m.y), flag) end
    if dir=="u" then return fget(mget(obj.x/8+m.x, obj.y/8-1+m.y), flag) end
    if dir=="d" then return fget(mget(obj.x/8+m.x, obj.y/8+1+m.y), flag) end
    return false
end