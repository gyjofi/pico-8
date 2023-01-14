--pico-frutti
--main.lua

game_mode="ready" --intro, ready, game, win, lose, over
ready_timer=0

mp={
    x=16,
    y=0,
    mudx=0,
    mudy=0,
    fruits=20,
    enemies=4
}

del_fruit={}

function _init()
    player_init()
end

function _update()
    if game_mode=="game" then
        enemies_update()
        player_update()
        seed_update()
    end
end

function _draw()
    if game_mode=="ready" then
        cls()
        map(mp.mudx,mp.mudy)
        memcpy(0x8000, 0x6000, 0x2000)
        game_mode="game"
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
        map(mp.x,mp.y)
        enemies_draw()
        player_draw()
        seed_draw()
        infobar_draw()
    elseif game_mode=="win" then
        print("YOU WIN!", 45, 56, 7)
    end
end