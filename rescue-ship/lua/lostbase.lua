--loastbase.lua

lost_base_show=false
lost_base_empty=true
sight_dot_size=65

function lostabse_init()
    lost_base_light=28
    lost_base_light_speed=5
    lost_base_pos={x=0, y=0}
    lost_base_life=0
    lost_base_dead=false
    lost_base_destoryed=false
    lost_base={
        { spr=51, x=0, y=0, hit=true },
        { spr=51, x=8, y=0, hit=true },
        { spr=52, x=16, y=0, hit=true },
        { spr=52, x=24, y=0, hit=true },
        { spr=51, x=0, y=8, hit=true },
        { spr=53, x=8, y=8, hit=false, dock=true },
        { spr=54, x=16, y=8, hit=false, dock=true },
        { spr=52, x=24, y=8, hit=true },
        { spr=51, x=0, y=16, hit=true },
        { spr=53, x=8, y=16, hit=false },
        { spr=50, x=16, y=16, hit=false },
        { spr=51, x=24, y=16, hit=true },
    }
end

function lostbase_update()
    if(lost_base_show) then

        lost_base_pos.x-=g_sp.sx
        lost_base_pos.y-=g_sp.sy
        check_pos(lost_base_pos)

        if (lost_base_light_speed<=0) then
            lost_base_light_speed=5
            if(lost_base_light<30) then lost_base_light+=1 else lost_base_light=28 end
        else
            lost_base_light_speed-=1
        end
    end
    if(lost_base_empty and pl.docked==false and lost_base_show and lost_base_dead==false) then
        lost_base_dead=true
        lost_base_life=100
    end
    if(lost_base_life>0) then 
        lost_base_life-=1
        destroy_base()
    end
end

function destroy_base()
    if (lost_base_life==1) then
        lost_base_show=false
        sfx(4)
        bigexplode(lost_base_pos.x+16, lost_base_pos.y+12)
    elseif (lost_base_life==8) then
        sfx(4)
        explode(lost_base_pos.x+rnd(32), lost_base_pos.y+rnd(32))
    elseif (lost_base_life==20) then
        sfx(4)
        explode(lost_base_pos.x+rnd(32), lost_base_pos.y+rnd(32))
    elseif (lost_base_life==45) then
        sfx(4)
        explode(lost_base_pos.x+rnd(32), lost_base_pos.y+rnd(32))
        explode(lost_base_pos.x+rnd(32), lost_base_pos.y+rnd(32))
    elseif (lost_base_life==80) then
        sfx(4)
        explode(lost_base_pos.x+rnd(32), lost_base_pos.y+rnd(32))
    end
end

function destroy_base_ins()
    lost_base_show=false
    lost_base_empty=true
    lost_base_dead=true
    lost_base_destoryed=false
    sfx(4)
    bigexplode(lost_base_pos.x+16, lost_base_pos.y+12)
end

function lostbase_draw()
    if(lost_base_show) then
        if(lost_base_pos.x>-350 and lost_base_pos.x<478 and lost_base_pos.y>-350 and lost_base_pos.y<478) then
            if(lost_base_pos.x>-32 and lost_base_pos.x<128 and lost_base_pos.y>-12 and lost_base_pos.y<128) then
                for h in all(lost_base) do
                    spr(h.spr, h.x+lost_base_pos.x, h.y+lost_base_pos.y,1,1)
                end
                spr(lost_base_light, lost_base_pos.x+12, lost_base_pos.y)
                if(lost_base_light_speed==0) sfx(6)
            else
                draw_sight_dot({x=lost_base_pos.x+16, y=lost_base_pos.y+12}, 10)
            end
        end
    end
end

function place_lost_base()
    lost_base_pos=get_rnd_pos(true)
    lost_base_show=true
    lost_base_empty=false
    lost_base_dead=false
    lost_base_life=0
end

function lost_base_hit(x,y,pl)
    if(lost_base_show==false) return false
    coll=false
    for h in all(lost_base) do
        if((pl==true and h.hit==true) or pl==false) then
            if(coll==false) then coll=col({x=h.x+lost_base_pos.x, y=h.y+lost_base_pos.y}, {x=x, y=y}) end
        end
    end
    return coll
end

function lost_base_dock(x,y)
    if(lost_base_show==false) return false
    coll=false
    for h in all(lost_base) do
        if(h.dock==true) then
            if(coll==false) then coll=col({x=h.x+lost_base_pos.x, y=h.y+lost_base_pos.y}, {x=x, y=y}) end
        end
    end
    return coll
end
-->8