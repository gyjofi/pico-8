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

function col(a,b)
    if a==nil or b==nil then 
        return false
    end
    
    local a_left=a.x
    local a_top=a.y
    local a_right=a.x+7
    local a_bottom=a.y+7
    
    local b_left=b.x
    local b_top=b.y
    local b_right=b.x+7
    local b_bottom=b.y+7

    if a_left>b_right then return false end
    if b_left>a_right then return false end
    if a_top>b_bottom then return false end
    if b_top>a_bottom then return false end
    
    return true
end