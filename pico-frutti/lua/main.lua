--pico-frutti
--main.lua

game_mode="ready" --intro, ready, game, win, lose, over
ready_timer=0

mute=false

del_fruit={}

function _init()
    reset_game()
end

function _update()
    if game_mode=="ready" then
        reset_game()
        game_mode="game"
        if (mute==false) music(0)
    elseif game_mode=="game" then
        enemies_update()
        player_update()
        seed_update()
        apples_update()
    elseif game_mode=="win" then
        if (btnp(4)) game_mode="ready"
    elseif game_mode=="lose" then
        if (btnp(4)) game_mode="ready"
    end
end

function _draw()
    if game_mode=="ready" then
        --cls()
        --map(mp.mudx,mp.mudy)
        --memcpy(0x8000, 0x6000, 0x2000)
    elseif game_mode=="game" then
        cls()
        --update mud  map
        --memcpy(0x6000, 0x8000, 0x2000)
        --if(del_fruit.x!=nil) then rectfill(del_fruit.x, del_fruit.y, del_fruit.x+7, del_fruit.y+7, 0) del_fruit={} end
        --rectfill(player.x, player.y, player.x+7, player.y+7, 0)
        --memcpy(0x8000, 0x6000, 0x2000)
        mset((player.x+4)/8+mp.mudx, (player.y+4)/8+mp.mudy, 0)
        map(mp.mudx, mp.mudy)
        --draw
        enemies_draw()
        map(mp.x,mp.y)
        player_draw()
        seed_draw()
        apples_draw()
        infobar_draw()
    elseif game_mode=="win" then
        print("you win!", 45, 56, 7)
    elseif game_mode=="lose" then
        print("you lose!", 45, 56, 7)
    end
end

function reset_game()
    reload(0x1000, 0x1000, 0x2000)
    map_init()
    apples_init()
    enemies_init()
    seed_init()
    player_init()
end

function map_init()
    mp={
        x=16,
        y=0,
        mudx=0,
        mudy=0,
        lives=3,
        fruits=20,
        enemies=4
    }
end