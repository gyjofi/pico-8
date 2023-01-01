--infobar.lua

loaded_suc_msg=false
mission_succ_msg=false
mission_failed_msg=false
level_display=true
level_display_time=100

timer=60
last_time=flr(time())
level_time=60
countdown=false

function infobar_update()
    if(lost_base_dock(pl.x,pl.y) and pl.opened and lost_base_empty==false) then
        lost_base_empty=true
        pl.filled=true
        pl.score+=500
        maxsp=2
        loaded_suc_msg=true
        g_sp={sx=0, sy=0}
        sfx(8)
        countdown=false
    end
    if(home_dock(pl.x,pl.y) and pl.opened and pl.filled) then
        pl.filled=false
        maxsp=2.7+(level*0.3)
        pl.score+=1000
        mission_succ_msg=true
        g_sp={sx=0, sy=0}
        sfx(9)
        countdown=false
    end
    if(home_dock(pl.x,pl.y) and pl.opened and pl.filled==false and lost_base_dead) then
        lost_base_dead=false
        countdown=false
    end
    if(game_paused and btnp(5) and lost_base_empty and loaded_suc_msg) then
        game_paused=false
        loaded_suc_msg=false
        mission_succ_msg=false
    end
    if(game_paused and btnp(5) and lost_base_empty and mission_succ_msg) then
        game_paused=false
        loaded_suc_msg=false
        mission_succ_msg=false
        lost_base_dead=false
    end
    if(game_paused and btnp(5) and mission_failed_msg) then
        game_paused=false
        mission_failed_msg=false
    end
    if(game_paused==false 
        and lost_base_empty
        and home_dock(pl.x,pl.y)==false
        and lost_base_show==false
        and lost_base_dead==false
        and countdown==false) then
        place_lost_base()
        countdown=true
        level_time=70-(level*10)
        if(level_time<20) level_time=20
        timer=level_time
    end
    if(pl.score>high_score) high_score=pl.score
    if(level<3 and pl.score>(level*3000)) then
        level+=1
        enemy_init()
        level_display=true
        level_display_time=100
    end
    level_display_time-=1
end

function infobar_draw()
    rectfill(0,0,127,11,0)
    rect(0,0,127,11,1)
    if(pl.score>=high_score) then print(pl.score, 3, 3, 6) else print(pl.score, 3, 3, 13) end
    line(39,1,39,10,1)
    timer_draw()
    line(63,1,63,10,1)
    if(pl.filled) then spr(9, 65, 2) else spr(8, 65, 2) end
    line(74,1,74,10,1)
    spr(3, 76, 2)
    print(":"..flr(pl.shield/10), 84, 3, 13)
    for l=1,3 do
        if (pl.lives >= l) then
            spr(11, 128-(l*10), 2)
        else
            spr(10, 128-(l*10), 2)
        end
    end
    if(loaded_suc_msg) then
        rectfill(0,45,127,85,0)
        rect(0,45,127,85,1)
        print("\^wjust on time!", 3, 48, 10)
        print("\^d1crew loaded successfully!", 3, 58, 13)
        print("\^d1bring them back to main base!", 3, 68, 13)
        print("\^d1press ❎ button!", 3, 78, 13)
        game_paused=true
    end
    if(mission_succ_msg) then
        rectfill(0,45,127,85,0)
        rect(0,45,127,85,1)
        print("\^wwell done!", 3, 48, 10)
        print("\^d1you saved the crew!", 3, 58, 13)
        print("\^d1find another lost base!", 3, 68, 13)
        print("\^d1press ❎ button!", 3, 78, 13)
        game_paused=true
    end
    if(mission_failed_msg and lost_base_destoryed) then
        rectfill(0,45,127,85,0)
        rect(0,45,127,85,1)
        print("\^wmission failed!", 3, 48, 8)
        print("\^d1you ran out of time!", 3, 58, 13)
        print("\^d1go back to main base!", 3, 68, 13)
        print("\^d1press ❎ button!", 3, 78, 13)
        game_paused=true
    end
    if(level_display) then
        if(level_display_time>0) then
            print("level: "..level, 46, 24, 5)
            print("level: "..level, 45, 23, 7)
        else
            level_display=false
            level_display_time=0
        end
    end
end

function timer_draw()
    if(flr(time())>flr(last_time) and countdown) then
        last_time=flr(time())
        timer-=1
    end
    if(countdown) then
        timer_col=11
        if(timer<6) then
            timer_col=8
        elseif(timer<16) then
            timer_col=9
        end
    else timer_col=5 end
    local sx=(14%16)*8
    local sy=flr(14/16)*8
    for iy=0,7 do
        for ix=0,7 do
            if(sget(sx+ix,sy+iy)!=0) pset(42+ix,2+iy,timer_col)
        end
    end
    --spr(14, 42, 2)
    print(":"..timer, 50, 3, timer_col)
    if(timer<0) then
        timer=0
        countdown=false
        destroy_base_ins()
        mission_failed_msg=true
        if(pl.score-500>=0) then pl.score-=500 else pl.score=0 end
    end
end
-->8