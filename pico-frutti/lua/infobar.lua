function infobar_draw()
    spr(49,0,0)
    print(":"..mp.fruits, 9, 1, 6)
    spr(32,30,0)
    print(":"..mp.enemies, 39, 1, 6)
    if (player.has_seed) print("split a seed!", 70, 1, 6)
end