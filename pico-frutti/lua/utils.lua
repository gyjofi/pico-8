function check_map(obj, dir, flag, on_mud_map)
    local m={x=mp.x,y=mp.y}
    if on_mud_map then m={x=mp.mudx,y=mp.mudy} end
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

function get_disabled_dir(obj) --return {x: dir, y:dir}
    --determine disabled directions
    local d_dir={x=nil, y=nil}
    if obj.x<=0 then d_dir.x="l" end
    if obj.x>=120 then d_dir.x="r" end
    if obj.y<=8 then d_dir.y="u" end
    if obj.y>=120 then d_dir.y="d" end
    return d_dir
end

function get_free_dir(obj, d_dir, d2_dir) --return dir
    local d=obj.dir
    local found_dir=nil
    local next_dir=nil
    local look_right=rnd()>.5
    for ds=1,4 do
        if found_dir==nil then
            next_dir=get_next_dir(d, look_right)
            if check_map(obj, next_dir, 7, true)
            or apple_col(obj, false, next_dir) 
            or next_dir==d_dir.x 
            or next_dir==d_dir.y 
            or next_dir==d2_dir.x 
            or next_dir==d2_dir.y then 
                d=next_dir
            else
                found_dir=next_dir
            end
        end
    end
    return found_dir
end

function get_next_dir(dir, right)
    if (dir=="r") if right then return "d" else return "u" end
    if (dir=="l") if right then return "u" else return "d" end
    if (dir=="u") if right then return "r" else return "l" end
    if (dir=="d") if right then return "l" else return "r" end
end