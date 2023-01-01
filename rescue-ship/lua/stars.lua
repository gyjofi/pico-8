--stars.lua

function stars_init()
    stars={}
    for s=1,100 do
        add(stars, spawn_star())
    end
end

function stars_update()

    for s in all(stars) do
        s.x-=(g_sp.sx*s.spratio)
        s.y-=(g_sp.sy*s.spratio)
        if(s.x<0) then s.x=127 s.y=12+rnd(116) end
        if(s.x>127) then s.x=0 s.y=12+rnd(116) end
        if(s.y<12) then s.y=127 s.x=rnd(128) end
        if(s.y>127) then s.y=12 s.x=rnd(128) end
    end

end

function stars_draw()
    for s in all(stars) do
        pset(s.x, s.y, s.col)
    end
end

function spawn_star()
    local col=ceil(rnd(3))
    return {
        x=rnd(128),
        y=12+rnd(116),
        col=3+col,
        spratio=col*0.3
    }
end
-->8