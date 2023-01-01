--enemy.lua

function enemy_init()
    enemies={}
    local enemy_count={}
    if (level==1) enemy_count={30, 0, 0}
    if (level==2) enemy_count={25, 10, 0}
    if (level>=3) enemy_count={20, 10, 10}
    if (level>=5) enemy_count={0, 20, 30}
    lev3timer=100
    for c=1, 3 do
        for s=1,enemy_count[c] do
            add(enemies, spawn_enemy(c))
        end
    end
end

function enemy_update()
    for e in all(enemies) do

        e.x-=g_sp.sx
        e.y-=g_sp.sy
        check_pos(e)

        if(abs(pl.x-e.x)<50 and abs(pl.y-e.y)<50 and pl.ghost==false) then
            if(e.detected==false) then 
                e.opened=true
                e.change_dir=20
                e.detected=true
                sfx(7)
                local sx=pl.x-e.x
                local sy=pl.y-e.y
                if (e.level==1) then
                    efire(e.x, e.y, sx<1, sx>1, sy<1, sy>1)
                elseif(e.level==2) then
                    efire(e.x, e.y, true, false, false, false)
                    efire(e.x, e.y, false, true, false, false)
                    efire(e.x, e.y, false, false, true, false)
                    efire(e.x, e.y, false, false, false, true)
                end
                e.sx=0
                e.sy=0
            end
            if(e.level>=3 and lev3timer==0) then
                lev3timer=100
                e.opened=true
                e.sx=0
                e.sy=0
                sfx(7)
                efire(e.x, e.y, true, false, false, false)
                efire(e.x, e.y, false, true, false, false)
                efire(e.x, e.y, false, false, true, false)
                efire(e.x, e.y, false, false, false, true)
            elseif(e.level>=3) then
                lev3timer-=1
                e.opened=false
            end
            if(e.change_dir<=0) then
                e.opened=false
                e.sx=mid(-maxsp/6,(pl.x-e.x)/20,maxsp/6)
                e.sy=mid(-maxsp/6,(pl.y-e.y)/20,maxsp/6)
            end
        elseif(e.change_dir<=0) then
            e.detected=false
            e.sx=rnd(1)-0.5
            e.sy=rnd(1)-0.5
            e.change_dir=100
        end

        --maphit
        if (home_hit(e.x+e.sx,e.y+e.sy, false) or lost_base_hit(e.x+e.sx,e.y+e.sy, false)) then
            e.sx=-e.sx/3
            e.sy=-e.sy/3 
        end
        
        e.x+=e.sx
        e.y+=e.sy
        if (e.change_dir>0) e.change_dir-=1
        --collision enemy x pl
        if col(e,pl) then
            del(enemies,e)
            elogic(e, true)
        end
        --collision enemy x pl bullets
        for b in all(bullets) do
            if col(e,b) then
                del(enemies,e)
                elogic(e, false)
            end
        end
    end
end

function enemy_draw()
    for e in all(enemies) do
        if (e.x>-150 and e.x<277 and e.y>-148 and e.y<277) then
            if (e.x<-8 or e.x>127 or e.y<12 or e.y>127) then
                draw_sight_dot(e, 8)
            else
                if (e.opened) then
                    spr(e.sprites[1], e.x, e.y)
                else
                    spr(e.sprites[2], e.x, e.y)
                end
            end
        end
    end
end

function spawn_enemy(lev)
    local pos=get_rnd_pos()
    return {
        x=pos.x,
        y=pos.y,
        sx=0,
        sy=0,
        sprites={14+(lev*2),15+(lev*2)},
        opened=true,
        ghost=false,
        change_dir=0,
        detected=false,
        level=lev
    }
end

function elogic(e, coll)
    if(coll) then
        player_hitlogic()
    else
        sfx(4)
        pl.score+=50*e.level
        explode(e.x+4,e.y+4)
    end
    add(enemies, spawn_enemy(e.level))
end
-->8