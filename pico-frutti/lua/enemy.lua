enemies={}
spawn_timer=0

function enemies_update()
    for e in all(enemies) do
        if e.move_step==0 then
            e.move_step=8

            --determine disabled directions
            local d_dir={x=nil, y=nil}
            if e.x<=0 then d_dir.x="l" end
            if e.x>=120 then d_dir.x="r" end
            if e.y<=8 then d_dir.y="u" end
            if e.y>=120 then d_dir.y="d" end

            --should change direction
            local dx_dir=nil
            local dy_dir=nil
            
            if e.x<=0 and e.dir=="l" then dx_dir="l" elseif e.x>=120 and e.dir=="r" then dx_dir="r" end
            if e.y<=8 and e.dir=="u" then dy_dir="u" elseif e.y>=120 and e.dir=="d" then dy_dir="d" end
            
            if check_map(e, e.dir, 7, true) or dx_dir!=nil or dy_dir!=nil then
                local d=e.dir
                local found_dir=nil
                local next_dir=nil
                local look_right=rnd()>.5
                for ds=1,4 do
                    if found_dir==nil then
                        next_dir=get_next_dir(d, look_right)
                        if check_map(e, next_dir, 7, true) or next_dir==d_dir.x or next_dir==d_dir.y or next_dir==dx_dir or next_dir==dy_dir then 
                            d=next_dir
                        else
                            found_dir=next_dir
                        end
                    end
                end
                e.dir=found_dir
            else --direction change possible

            end
        end

        move_enemy(e)
        anim_enemy(e)
    end

    if (player.fruits>0 and mp.enemies>#enemies and spawn_timer==0) then
        spawn_enemy()
        spawn_timer=50
    elseif (spawn_timer>0) then
        spawn_timer-=1
    end
end

function enemies_draw()
    print(#enemies, 40, 1, 7)
    for e in all(enemies) do
        local sp = mid(1, e.anim_step, #e.anim_sps)
        spr(e.anim_sps[sp], e.x, e.y,1,1,e.xflip)
    end
end

function spawn_enemy()
    add(enemies, { 
        x=56,
        y=64,
        dir="r",
        right=true,
        move_step=8,
        anim_sps={34, 35, 36, 37},
        anim_step=1,
        anim=0,
        xflip=false
    })
end

function move_enemy(enemy)
    if enemy.move_step>0 then 
        if (enemy.dir=="l") enemy.x-=1 enemy.anim_sps={34, 35, 36, 37} enemy.xflip=true
        if (enemy.dir=="r") enemy.x+=1 enemy.anim_sps={34, 35, 36, 37} enemy.xflip=false
        if (enemy.dir=="u") enemy.y-=1 enemy.anim_sps={33}
        if (enemy.dir=="d") enemy.y+=1 enemy.anim_sps={33}
        enemy.move_step-=1
    end
end

function anim_enemy(enemy)
    if time()-enemy.anim>.15 then
        enemy.anim=time()
        if #enemy.anim_sps>1 then
            enemy.anim_step+=1
            if enemy.anim_step>#enemy.anim_sps then
                enemy.anim_step=1
            end
        else
            enemy.anim_step=1
            if enemy.move_step>0 then enemy.xflip=not enemy.xflip end
        end
    end
end

function get_next_dir(dir, right)
    if (dir=="r") if right then return "d" else return "u" end
    if (dir=="l") if right then return "u" else return "d" end
    if (dir=="u") if right then return "r" else return "l" end
    if (dir=="d") if right then return "l" else return "r" end
end