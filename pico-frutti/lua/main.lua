--pico-frutti
--main.lua

game_mode="intro" --intro, ready, game, win, lose, stat
ready_timer=30
level=1
player_lives=3
player_score=0
stat_reason="lose"
home_color=5

mute=true
high_score=0

del_fruit={}

function _init()
    cls()
    reset_game()
    if (mute==false) then music(0) else music(-1) end
end

function _update()
    if game_mode=="intro" then
        settings_update()
        if (btnp(4) and show_settings==false) game_mode="ready" music(-1)
    elseif game_mode=="ready" then
        if(ready_timer>0) then
            ready_timer-=1
        else 
            game_mode="game"
            if (mute==false) then music(6) else music(-1) end
        end
    elseif game_mode=="game" then
        enemies_update()
        player_update()
        seed_update()
        apples_update()
        if(#enemies>0) then
            home_color+=1
            if(home_color>15) home_color=1
        else
            home_color=5
        end
    elseif game_mode=="win" then
        if(ready_timer>0) then
            ready_timer-=1
        else
            stat_reason=game_mode
            game_mode="stat"
        end
    elseif game_mode=="lose" then
        if(ready_timer>0) then
            ready_timer-=1
        else
            stat_reason=game_mode
            game_mode="stat"
        end
    elseif game_mode=="stat" then
        stat_update(stat_reason)
    end
end

function _draw()
    if game_mode=="intro" then
        main_draw()
        settings_draw()
    elseif game_mode=="ready" then
        cls()
        draw_game_parts()
        print("ready!", 45, 56, 7)
    elseif game_mode=="game" then
        cls()
        mset((player.x+4)/8+mp.mudx, (player.y+4)/8+mp.mudy, 0)
        draw_game_parts()
    elseif game_mode=="win" then
        print("you win!", 45, 56, 7)
    elseif game_mode=="lose" then
        print("you lose!", 45, 56, 7)
    elseif game_mode=="stat" then
        stat_draw()
    end
end

function draw_game_parts()
    map(mp.mudx, mp.mudy)
    --draw
    enemies_draw()
    map(mp.x,mp.y)
    player_draw()
    seed_draw()
    apples_draw()
    infobar_draw()
    rectfill(56,64,63,71,home_color)
end

function reset_game()
    reload(0x1000, 0x1000, 0x2000)
    level=mid(1, level, #levels)
    map_init()
    apples_init()
    enemies_init()
    seed_init()
    player_init()
end

function map_init()
    main_mp={ x=0, y=32, }
    levels={
        {
            x=16,
            y=0,
            mudx=0,
            mudy=0,
            fruits=20,
            enemies=4
        }
    }
    mp=levels[level]
end

function main_draw()
    cls(1)
    map(main_mp.x, main_mp.y)
    print("\^whighscore:"..high_score, 2, 2, 7)
    print("\^b\^t\^wpico frutti", 21, 28, 10)
    print("FEATURING...", 26, 45, 6)
    print("sUPER sTRAWBERRY", 40, 57, 6)
    print("AND THE acid apples", 26, 72, 6)
    print("press ❎ to settings", 26, 94, 6)
    print("press 🅾️ to start", 26, 102, 6)
end