stat_done=false
s_t=time()
s_enemies=0
s_fruits=0
s_score=0

function stat_update(reason)
    if btnp(4) and stat_done then
        if (reason=="win") level+=1
        if (reason=="lose" and player_lives>0) or (reason=="win" and level<=#levels) then
            reset_game()
            ready_timer=60
            game_mode="ready"
        else
            reset_game()
            player_lives=3
            player_score=0
            level=1
            game_mode="intro"
        end
    end
    if(time()-s_t>.3 and stat_done==false) then
        if(player.enemies>0) then
            s_enemies+=1
            s_score+=10
            player.enemies-=1
        elseif(player.fruits>0) then
            s_fruits+=1
            s_score+=1
            player.fruits-=1
        end
        s_t=time()
    else
        stat_done = true
    end
end

function stat_draw()
    cls(1)
    map(main_mp.x, main_mp.y)
    rectfill(16, 24, 111, 111, 0)
    spr(16, 24, 32) print("x "..player_lives, 34, 32, 6)
    spr(32, 24, 42) print(": "..s_enemies, 34, 42, 6)
    spr(49, 24, 52) print(": "..s_fruits, 34, 52, 6)

    print("score: "..s_score, 24, 70, 10)
    --if (stat_done) print("press ❎ to continue", 24, 102, 6)
    print("press ❎ to continue", 24, 102, 6)
end