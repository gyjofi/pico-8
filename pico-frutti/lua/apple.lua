apple_Fall_timer=12

function apples_init()
    apples={
        {x=3,y=2,fall=false,fall_timer=apple_Fall_timer},
        {x=1,y=10,fall=false,fall_timer=apple_Fall_timer},
        {x=14,y=6,fall=false,fall_timer=apple_Fall_timer},
        {x=12,y=10,fall=false,fall_timer=apple_Fall_timer},
    }
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
                    player.lives-=1
                    game_mode="lose"
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
                a.fall_timer=apple_Fall_timer
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