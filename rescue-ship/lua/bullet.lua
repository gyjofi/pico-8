--bullet.lua

function bullets_init()
    blife_span=30
    bullets={}
    ebullets={}
end

function bullets_update()
    for b in all(bullets) do
        update_b(b)
    end
    for b in all(ebullets) do
        update_b(b)
    end
end

function update_b(b)
    b.x+=(b.spx-pl.sx)
    b.y+=(b.spy-pl.sy)
    b.life_span-=1
    if(b.x<0 or b.x>120 or b.y<0 or b.y>120 or b.life_span<0) then del(bullets, b) end
end

function bullets_draw()
    for b in all(bullets) do
        spr(b.spr, b.x, b.y, 1, 1, b.fx, b.fy)
    end
    for b in all(ebullets) do
        spr(b.spr, b.x, b.y, 1, 1, b.fx, b.fy)
    end
end

function fire(x, y, l, r, u, d)
    local b = {
        x=x,
        y=y,
        spx=0,
        spy=0,
        life_span=blife_span
    }
    if(l or r) then 
        b.spr=6 
        if(r) then b.fx=true b.x+=4 b.spx=4 elseif(l) then b.fx=false b.x-=4 b.spx=-4 end
    elseif(u or d) then
        b.spr=7
        if(d) then b.fy=true b.y+=4 b.spy=4 elseif(u) then b.fy=false b.y-=4 b.spy=-4 end
    end
    if(l or r or u or d) then
        sfx(0)
        add(bullets, b)
    end
end

function efire(x, y, l, r, u, d)
    local b = {
        x=x,
        y=y,
        spx=0,
        spy=0,
        life_span=blife_span
    }
    if(l or r) then 
        b.spr=22 
        if(r) then b.fx=true b.x+=4 b.spx=4 elseif(l) then b.fx=false b.x-=4 b.spx=-4 end
    elseif(u or d) then
        b.spr=23
        if(d) then b.fy=true b.y+=4 b.spy=4 elseif(u) then b.fy=false b.y-=4 b.spy=-4 end
    end
    sfx(5)
    add(ebullets, b)
end
-->8