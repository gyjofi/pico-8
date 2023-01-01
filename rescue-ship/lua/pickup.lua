--pickup.lua

function pickup_init()
    pickups={}
    for s=1,10 do
        add(pickups, spawn_pickup('shield'))
    end
    for s=1,10 do
        add(pickups, spawn_pickup('live'))
    end
end

function pickup_update()
    for p in all(pickups) do

        p.x-=g_sp.sx
        p.y-=g_sp.sy
        check_pos(p)

        --collision pickup x pl
        if col(p,pl) then
            del(pickups,p)
            plogic(p)
        end
    end
end

function pickup_draw()
    for p in all(pickups) do
        if(p.x>-8 and p.x<128 and p.y>0 and p.y<128) then
            spr(p.spr, p.x, p.y)
        end
    end
end

function spawn_pickup(type)
    local pos=get_rnd_pos()
    local pickup = {
        x=pos.x,
        y=pos.y,
        type=type,
        ghost=false,
    }
    if(type=='shield') then
        pickup.spr=3
    elseif(type=='live') then
        pickup.spr=11
    end
    return pickup
end

function plogic(mypick)
    if(mypick.type=='live') then
        sfx(2) 
        if(pl.lives<3) then pl.lives+=1 else pl.score+=100 end
    end
    if(mypick.type=='shield') then pl.shield+=500 sfx(3) end
    smol_shwave(mypick.x+4,mypick.y+4,14)
end
-->8