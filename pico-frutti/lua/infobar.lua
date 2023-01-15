inf_t=0
function infobar_draw()
    spr(49,0,0)
    print(mp.fruits, 9, 1, 6)
    spr(32,24,0)
    print(mp.enemies, 33, 1, 6)
    spr(16,48,0)
    print(player_lives, 57, 1, 6)
    print("lvl:"..level, 70, 1, 6)
    if player.has_seed and inf_t-time()<-.2 then
        inf_t=time()
        print("seed!", 100, 1, 6)
    end
end