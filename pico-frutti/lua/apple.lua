apples_levels={
    { {x=3, y=2}, {x=1, y=10}, {x=14, y=6}, {x=12, y=10} },
    { {x=2, y=1}, {x=1, y=6}, {x=13, y=1}, {x=14, y=3}, {x=5, y=6}, {x=8, y=4} },
    { {x=1, y=2}, {x=3, y=4}, {x=5, y=5}, {x=10, y=5}, {x=12, y=4}, {x=14, y=2} },
    { {x=6, y=4}, {x=9, y=4}, {x=5, y=5}, {x=10, y=5}, {x=2, y=9}, {x=13, y=9} },
    { {x=7, y=3}, {x=13, y=2}, {x=13, y=5}, {x=8, y=6}, {x=3, y=11}, {x=10, y=9} }
}
apples={}

function apples_init()
    apples={}
    for a in all(apples_levels[level]) do
        add(apples, {x=a.x, y=a.y, fall=false,fall_timer=14})
    end
end

function apples_update()
    for a in all(apples) do
        if a.fall==true and a.y<15 then
            if a.fall_timer>0 then
                a.fall_timer-=1
            elseif fget(mget(a.x+mp.mudx, a.y+1+mp.mudy))==0 then
                a.y+=1/8
                local ac={x=a.x*8, y=a.y*8}
                if(col(ac, player)) then
                    music(-1)
                    sfx(5)
                    player_lives-=1
                    game_mode="lose"
                    ready_timer=30
                end
                for e in all(enemies) do
                    if(col(e, ac)) then
                        del(enemies, e)
                        sfx(7)
                        mp.enemies-=1
                    end
                end
            else
                a.fall=false
                a.fall_timer=14
            end
        elseif a.fall==false and fget(mget(a.x+mp.mudx, a.y+1+mp.mudy))==0 and a.y<15 then
            mset(a.x+mp.mudx, a.y+mp.mudy, 0)
            a.fall=true
            sfx(6)
        end
    end
end

function apples_draw()
    for a in all(apples) do
        spr(48, a.x*8, a.y*8)
    end
end

function apple_col(pl, move, dir)
    --pl={x, y} apple_arr={x, y}[]
    local pl_fut={x=0, y=0}
    local pl_dir=pl.dir
    if (dir) pl_dir=dir
    if pl_dir=="l" then pl_fut={x=pl.x-1, y=pl.y} end
    if pl_dir=="r" then pl_fut={x=pl.x+8, y=pl.y} end
    if pl_dir=="u" then pl_fut={x=pl.x, y=pl.y-1} end
    if pl_dir=="d" then pl_fut={x=pl.x, y=pl.y+8} end
    local collide=false
    for o in all(apples) do
        local a={x=o.x*8, y=o.y*8}
        if collide==false and col(pl_fut, a) then
            if move then collide=o.fall else collide=true end
        end
    end
    return collide
end