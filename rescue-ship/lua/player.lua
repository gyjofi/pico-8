--player.lua

function player_init()
    max_shot_sp=4
    pl={
        x=0, --actual x
        y=0, --actual y
        sx=0, --speed x
        sy=0, --speed y
        w=8,
        h=8,
        lshot=max_shot_sp,
        spr=1,
        sprs={1,2},
        shield=500,
        opened=true,
        onedge=false,
        ghost=false,
        docked=true,
        filled=false,
        lives=2,
        score=0
    }
end

function player_update()
	--controls
    if(btn(4)) then
        player_open()
        if(pl.lshot==0) then
            fire(pl.x, pl.y, btn(0), btn(1), btn(2), btn(3))
            pl.lshot=max_shot_sp
        end
    elseif(btn(0) or btn(1) or btn(2) or btn(3)) then
        player_close()
    end

    if(btn(0)) then pl.sx-=acc
    elseif(btn(1)) then pl.sx+=acc
    else pl.sx*=frc end
    if(btn(2)) then pl.sy-=acc
    elseif(btn(3)) then pl.sy+=acc
    else pl.sy*=frc end
	
	--limit speed
    pl.sx=mid(-maxsp,pl.sx,maxsp)
	pl.sy=mid(-maxsp,pl.sy,maxsp)

	--maphit
	if (home_hit(pl.x+pl.sx,pl.y+pl.sy, true) or lost_base_hit(pl.x+pl.sx,pl.y+pl.sy, true)) then
		pl.sx=-pl.sx/2
		pl.sy=-pl.sy/2
	end

    --check docked
	if (home_dock(pl.x+pl.sx,pl.y+pl.sy) or lost_base_dock(pl.x+pl.sx,pl.y+pl.sy)) then
		pl.docked=true
    else
        pl.docked=false
    end

    if((abs(pl.sx)<0.1 and abs(pl.sy)<0.1) or pl.opened) then
        player_open()
        pl.sx=0
        pl.sy=0
        g_sp={sx=0, sy=0}
	end
    if(pl.opened==false) then
        local nx=pl.x+pl.sx
        local ny=pl.y+pl.sy
        if(nx>40 and nx<80) then
	        pl.x=nx
        end
	    if(ny>49 and ny<80) then
            pl.y=ny
        end
        if(nx<=42 or nx>=78 or ny<=51 or ny>=78) then
            --player on dege
            g_sp.sx=pl.sx
            g_sp.sy=pl.sy
        else
            --player in screen
            g_sp.sx=0
            g_sp.sy=0
        end
    elseif(pl.shield>0 and pl.docked==false) then
        pl.shield-=1
        if (pl.shield<0) then pl.shield=0 end
    elseif(pl.shield<500 and home_dock(pl.x+pl.sx,pl.y+pl.sy)) then
        pl.shield+=5
    elseif(pl.shield>999) then
    pl.shield=999
    end 
    pl.lshot-=1
    if pl.lshot<0 then pl.lshot=0 end
    --collision enemy x pl bullets
    for b in all(ebullets) do
        if col(pl,b) then
            del(ebullets, b)
            player_hitlogic()
        end
    end
end

function player_draw()
    spr(pl.spr, pl.x, pl.y)
    if(pl.shield>0 and pl.opened) then
        if(pl.shield>200) then
            circ(pl.x+4, pl.y+4, 13, 13)
        elseif(pl.shield>100) then
            circ(pl.x+4, pl.y+4, 10, 1)
        else
            if((pl.shield/5)%2>0) then
                circ(pl.x+4, pl.y+4, 10, 1)
            else
                sfx(1)
            end
        end
    end
end

function player_open()
    pl.spr = pl.sprs[1]
    pl.opened = true
end

function player_close()
    pl.spr = pl.sprs[2]
    pl.opened = false
end

function player_hitlogic()
    sfx(4)
    if(pl.lives>0 and (pl.shield<=0 or pl.opened==false)) then pl.lives-=1 end
    if(pl.shield>0 and pl.opened) then pl.shield-=200 end
    if(pl.shield<0) pl.shield=0
    if(pl.lives>0) then
        explode(pl.x+4,pl.y+4, true)
    else
        bigexplode(pl.x+4,pl.y+4, true)
        pl.sx=0
        pl.sy=0
        pl.ghost=true
        g_sp={sx=0, sy=0}
        game_mode="over"
    end
end
-->8