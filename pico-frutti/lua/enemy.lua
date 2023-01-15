function enemies_init()
    enemies={}
    spawn_timer=0
end

function enemies_update()
    for e in all(enemies) do
        --check player hit
        if(col(e, player)) then
            music(-1)
            sfx(5)
            player_lives-=1
            game_mode="lose"
            ready_timer=30
        end

        if e.move_step==0 then
            e.move_step=8
            --determine disabled directions by map
            local d_dir=get_disabled_dir(e)

            --should change direction
            local d2_dir={x=nil, y=nil}
            
            if e.x<=0 and e.dir=="l" then d2_dir.x="l" elseif e.x>=120 and e.dir=="r" then d2_dir.x="r" end
            if e.y<=8 and e.dir=="u" then d2_dir.y="u" elseif e.y>=120 and e.dir=="d" then d2_dir.y="d" end
            
            if check_map(e, e.dir, 7, true) or apple_col(e) or d2_dir.x!=nil or d2_dir.y!=nil then
                e.dir=get_free_dir(e, d_dir, d2_dir)
            else --direction change possible
                local psbl = rnd()>0.5+(level/20)
                local look = get_next_dir(e.dir, rnd()>.5)
                if(psbl and look!=d_dir.x and look!=d_dir.y and check_map(e, look, 7, true)==false and apple_col(e, false, look)==false and look!=e.dir) then
                    e.dir=look
                end
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