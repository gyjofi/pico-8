--planet.lua

planet_types={
    {
        spr=192, --sun
        w=4,
        h=4,
        a=0, --angle
        as=0, --rotation speed
        x=0,
        y=0,
    },
    {
        spr=196, --red_sun
        w=4,
        h=4,
        a=0, --angle
        as=0, --rotation speed
        x=0,
        y=0,
    },
    {
        spr=200, --grey_planet
        w=2,
        h=2,
        a=0, --angle
        as=0, --rotation speed
        x=0,
        y=0,
    },
    {
        spr=232, --blue_plane
        w=2,
        h=2,
        a=0, --angle
        as=0, --rotation speed
        x=0,
        y=0,
    }
}

function planets_init()
    planets={}
    local n_of_p=3
    for t=1, 4 do
        if(t>2) n_of_p=6
        for i=1, n_of_p do
            add(planets, get_planet(planet_types[t]))
        end
    end
end

function planets_update()
    for p in all(planets) do
        p.a+=p.as
        p.x-=g_sp.sx
        p.y-=g_sp.sy
        check_pos(p)
    end
end

function planets_draw()
    for p in all(planets) do
        if (p.x>-p.w*8 and p.x<127 and p.y>12-p.h*8 and p.y<127) then
            spr_r(p.spr,p.x,p.y,p.a%360,p.w,p.h)
        end
    end
end

function get_planet(p_type)
    local planet={}
    planet.spr=p_type.spr
    planet.w=p_type.w
    planet.h=p_type.h
    planet.a=0 --angle
    planet.as=rnd(10)-5 --rotation speed
    local pos=get_rnd_pos(false, true)
    planet.x=pos.x
    planet.y=pos.y

    return planet
end

function spr_r(s,x,y,a,w,h)
    local sw=(w or 1)*8
    local sh=(h or 1)*8
    local sx=(s%16)*8
    local sy=flr(s/16)*8
    local x0=flr(0.5*sw)
    local y0=flr(0.5*sh)
    local a=a/360
    local sa=sin(a)
    local ca=cos(a)
    for ix=0,sw-1 do
        for iy=0,sh-1 do
            local dx=ix-x0
            local dy=iy-y0
            local xx=flr(dx*ca-dy*sa+x0)
            local yy=flr(dx*sa+dy*ca+y0)
            if (xx>=0 and xx<sw and yy>=0 and yy<=sh and sget(sx+xx,sy+yy)>0) then
                pset(x+ix,y+iy,sget(sx+xx,sy+yy))
            end
        end
    end
end
-->8