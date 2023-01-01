--minimap.lua

show_minimap=false
function minimap_update()
    if(btnp(5) and game_mode=="game") then
        if(show_minimap==false) then
            show_minimap=true
        else
            show_minimap=false
        end
    end
end

function minimap_draw()
    if(show_minimap) then
        rectfill(2,2,125,125,0) --background

        for p in all(planets) do
            circ(spos(p.x+p.w*8), spos(p.y+p.h*8), 2, 5)
        end

        for e in all(enemies) do
            pset(spos(e.x), spos(e.y), 8)
        end
        for p in all(pickups) do
            pset(spos(p.x), spos(p.y), 12)
        end
        
        --bases
        if(lost_base_show) then
            spr(13, spos(lost_base_pos.x-44), spos(lost_base_pos.y-40))
        end
        spr(26, spos(home_pos.x-44), spos(home_pos.y-40))

        circ(spos(pl.x), spos(pl.y), 1, 8)
        pset(spos(pl.x), spos(pl.y), 10)
        circ(spos(pl.x), spos(pl.y), space_limit/36, 2)

        rect(2,2,125,125,7) --frame
    end
end

function spos(pos)
    local zoom=61
    return ((pos/space_limit)*zoom)+63
end
-->8