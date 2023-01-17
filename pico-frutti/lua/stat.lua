stat_done=false
s_t=0
s_enemies=0
s_fruits=0
s_score=0
s_reason=nil

function stat_update(reason)
    s_reason=reason
    if(s_t-time()<.3 and stat_done==false) then
        s_t=time()
        if(player.enemies>0) then
            s_enemies+=1
            s_score+=10
            player.enemies-=1
            sfx(20)
        elseif(player.fruits>0) then
            s_fruits+=1
            s_score+=1
            player.fruits-=1
            sfx(20)
        elseif(game_time>0) then
            if (game_time>1000) then game_time-=1000
            elseif (game_time>100) then game_time-=100
            elseif (game_time>10) then game_time-=10
            else game_time-=1 end
            s_score+=1
            sfx(20)
        elseif(player.enemies==0 and player.fruits==0 and game_time==0 and stat_done==false) then
            player_score+=s_score
            stat_done = true
        end
    end
    if btnp(4) and stat_done then
        stat_done = false s_t=0 s_enemies=0 s_fruits=0 s_score=0
        if high_score<player_score then high_score=player_score end
        if (reason=="win") level+=1
        reset_game()
        if (mute==false) then music(0) else music(-1) end
        if (reason=="lose" and player_lives>0) or (reason=="win" and level<=#levels) then
            ready_timer=60
            game_mode="ready"
        else
            level=1
            game_mode="intro"
        end
    end
end

function stat_draw()
    cls(1)
    map(main_mp.x, main_mp.y)
    rectfill(16, 24, 111, 111, 0)
    spr(16, 24, 30) print("x "..player_lives, 34, 32, 6)
    spr(32, 24, 40) print(": "..s_enemies, 34, 42, 6)
    spr(49, 24, 50) print(": "..s_fruits, 34, 52, 6)
    if(s_reason=="win") print("time bonus: "..game_time, 24, 62, 6)

    print("score: "..s_score, 24, 72, 10)
    if(player_score>high_score) then
        print("new highscore!", 24, 82, 10)
    end
    if(player_lives==0) then
        print("game over", 24, 92, 8)
    end
    if (stat_done) print("press ❎ to continue", 24, 102, 6)
end