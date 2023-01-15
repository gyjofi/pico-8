function stat_update(reason)
    if btnp(4) then
        if (reason=="lose" and player_lives>0) or (reason=="win" and level>#levels) then
            reset_game()
            ready_timer=60
            game_mode="ready"
        else
            player_lives=3
            player_score=0
            game_mode="intro"
        end
    end
end

function stat_draw()
    cls(1)
    map(main_mp.x, main_mp.y)
    rectfill(16, 24, 111, 111, 0)
        
    print("press ❎ to continue", 24, 80, 6)
end