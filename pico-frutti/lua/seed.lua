function seed_init()
    seed={x=0,y=0,dx=0,dy=0,hide=true}
end

function seed_update()
    if seed.hide==false then
        --check enemy hit
        for e in all(enemies) do
            if(col(e, seed)) then
                seed={x=0,y=0,dx=0,dy=0,hide=true}
                del(enemies, e)
                sfx(7)
                mp.enemies-=1
                player.enemies+=1
            end
        end
        --check map
        if pget(seed.x+seed.dx, seed.y)!=0 or seed.x+seed.dx<0 or seed.x+seed.dx>127 then seed.dx*=-1 sfx(2) end
        if pget(seed.x, seed.y+seed.dy)!=0 or seed.y+seed.dy<8 or seed.y+seed.dy>127 then seed.dy*=-1 sfx(2) end
        seed.x+=seed.dx seed.y+=seed.dy
    end
end

function seed_draw()
    if seed.hide==false then pset(seed.x, seed.y, 10) end
end

function blow_seed(pl)
    if (pl.dir=="r" and pget(pl.x+12, pl.y+4)==0) seed={x=pl.x+8,y=pl.y+4,dx=2,dy=-2,hide=false}
    if (pl.dir=="l" and pget(pl.x-4, pl.y+4)==0) seed={x=pl.x-1,y=pl.y+4,dx=-2,dy=-2,hide=false}
    if (pl.dir=="d" and pget(pl.x+4, pl.y+12)==0) seed={x=pl.x+4,y=pl.y+8,dx=-2,dy=2,hide=false}
    if (pl.dir=="u" and pget(pl.x+4, pl.y-4)==0) seed={x=pl.x+4,y=pl.y-1,dx=-2,dy=-2,hide=false}
end