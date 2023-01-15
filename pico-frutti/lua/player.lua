function player_init()
    player={ 
        x=64,
        y=64,
        dir="i",
        move=false,
        move_step=0,
        anim_sps={16, 17},
        anim_step=1,
        anim=0,
        xflip=false,
        fruits=0,
        enemies=0,
        shoot_timer=-1,
        has_seed=false,
        score=0
    }
end

function player_update()
        
    if player.shoot_timer>0 then
        player.shoot_timer-=1
    elseif(player.shoot_timer==0) then
        player.shoot_timer=-1
        sfx(3)
        player.has_seed=true
    end

    if (player.move_step==0) then
        local last_dir = player.dir
        if (btn(0) and player.x>0) player.dir="l" player.move_step=8 
        if (btn(1) and player.x<120) player.dir="r" player.move_step=8
        if (btn(2) and player.y>8) player.dir="u" player.move_step=8
        if (btn(3) and player.y<120) player.dir="d" player.move_step=8
        if (btnp(4) and player.has_seed) blow_seed(player) player.has_seed=false
        if check_map(player, player.dir, 0) and player.move_step==8 then
            player.move_step=0
        end
        if player.x<=63 and player.x>=56 and player.y>=63 and player.y<=72 and mp.fruits==0 then
            player.move_step=0
            music(-1)
            game_mode="win"
            sfx(1)
            ready_timer=30
        end
        if apple_col(player) and player.move_step==8 then
            player.move_step=0
        end
        if last_dir!=player.dir then player.anim_step=1 end
    end
    
    if (check_map(player, player.dir, 2) and player.move_step==8) eat_fruit(player)
    move_player()
    anim_player()
end

function player_draw()
    local sp = mid(1, player.anim_step, #player.anim_sps)
    spr(player.anim_sps[sp], player.x, player.y,1,1,player.xflip)
end

function move_player()
    if player.move_step==0 then 
        --player.move=false
        --player.dir="i"
        --player.anim_sps={16, 17}
        if (player.dir=="l") player.anim_sps={19} player.xflip=true
        if (player.dir=="r") player.anim_sps={19} player.xflip=false
        if (player.dir=="u" or player.dir=="d") player.anim_sps={16, 17}
    else 
        if (player.dir=="l") player.x-=1 player.anim_sps={19, 20, 21, 22} player.xflip=true
        if (player.dir=="r") player.x+=1 player.anim_sps={19, 20, 21, 22} player.xflip=false
        if (player.dir=="u") player.y-=1 player.anim_sps={18}
        if (player.dir=="d") player.y+=1 player.anim_sps={18}
        player.move_step-=1
    end
end

function anim_player()
    if time()-player.anim>.15 then
        player.anim=time()
        if #player.anim_sps>1 then
            player.anim_step+=1
            if player.anim_step>#player.anim_sps then
                player.anim_step=1
            end
        else
            player.anim_step=1
            if player.move_step>0 then player.xflip=not player.xflip end
        end
    end
end


function eat_fruit(pl)
    sfx(0)
    if (pl.dir=="l") mset(pl.x/8-1+mp.x, pl.y/8+mp.y, 0) del_fruit={x=pl.x-8, y=pl.y}
    if (pl.dir=="r") mset(pl.x/8+1+mp.x, pl.y/8+mp.y, 0) del_fruit={x=pl.x+8, y=pl.y}
    if (pl.dir=="u") mset(pl.x/8+mp.x, pl.y/8-1+mp.y, 0) del_fruit={x=pl.x, y=pl.y-8}
    if (pl.dir=="d") mset(pl.x/8+mp.x, pl.y/8+1+mp.y, 0) del_fruit={x=pl.x, y=pl.y+8}
    mp.fruits-=1 player.fruits+=1 player.shoot_timer=64
end