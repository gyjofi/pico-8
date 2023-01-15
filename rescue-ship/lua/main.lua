--main.lua

grid=8
maxsp=3
frc=0.5
acc=0.2
space_limit=1000
high_score=0
game_paused=false
g_sp={    --global speed, when player on edge
    sx=0,
    sy=0
}

game_mode="main" --main, game, over 

function _init()
    game_init()
end

function _update()
    stars_update()
    planets_update()
    if(game_mode=="main") then
        main_update()
    elseif(game_mode=="game") then
        if(game_paused==false) then
            player_update()
            home_update()
            lostbase_update()
            enemy_update()
            pickup_update()
            bullets_update()
            minimap_update()
        end
        infobar_update()
    elseif(game_mode=="over") then
        bullets_update()
        enemy_update()
        if(btnp(4)) then
            game_init()
            game_mode="game"
        end
        if(btnp(5)) then
            game_mode="main"
        end
    end
end

function _draw()
    if(game_mode=="main") then
        cls()
        stars_draw()
        planets_draw()
        main_draw()
    elseif(game_mode=="game" and game_paused==false) then
        cls()
        stars_draw()
        planets_draw()
        home_draw()
        lostbase_draw()
        pickup_draw()
        player_draw()
        enemy_draw()
        bullets_draw()
        swaves_draw()
        parts_draw()
        infobar_draw()
        minimap_draw()
    elseif(game_mode=="over") then
        cls()
        stars_draw()
        planets_draw()
        home_draw()
        lostbase_draw()
        pickup_draw()
        enemy_draw()
        bullets_draw()
        bullets_draw()
        swaves_draw()
        parts_draw()
        infobar_draw()
        print("game over", 46, 64, 5)
        print("game over", 45, 63, 7)
        print("press 🅾️ to retry", 5, 105, 6)
        print("press ❎ to exit", 5, 115, 6)
    end
end

function game_init()
    home_light=25
    home_light_speed=5
    home_pos={x=44, y=52}
    home={
        { spr=48, x=0, y=0, hit=true },
        { spr=48, x=8, y=0, hit=true },
        { spr=48, x=16, y=0, hit=true },
        { spr=48, x=24, y=0, hit=true },
        { spr=48, x=0, y=8, hit=true },
        { spr=49, x=8, y=8, hit=false, dock=true },
        { spr=50, x=16, y=8, hit=false, dock=true },
        { spr=48, x=24, y=8, hit=true },
        { spr=48, x=0, y=16, hit=true },
        { spr=49, x=8, y=16, hit=false },
        { spr=50, x=16, y=16, hit=false },
        { spr=48, x=24, y=16, hit=true },
    }
    level=1
    parts={}
    shwaves={}
    stars_init()
    planets_init()
    player_init()
    enemy_init()
    pickup_init()
    bullets_init()
	pl.x=7*grid
	pl.y=8*grid
    g_sp.sx=0
    g_sp.sy=0
    lostabse_init()
end

function col(a,b)
    if a==nil or b==nil then 
        return false
    end
    
    local a_left=a.x
    local a_top=a.y
    local a_right=a.x+8
    local a_bottom=a.y+8
    
    local b_left=b.x
    local b_top=b.y
    local b_right=b.x+8
    local b_bottom=b.y+8

    if a_left>b_right then return false end
    if b_left>a_right then return false end
    if a_top>b_bottom then return false end
    if b_top>a_bottom then return false end
    
    return true
end

function get_rnd_pos(far, min)
    local angle=rnd()
    local radius=space_limit-64
    local min_r={}
    if (far==nil or far==false) then
        if(min) then min_r={i=1, o=0} else min_r={i=0.6, o=0.4} end
        radius=rnd(space_limit*min_r.i)+space_limit*min_r.o
    end
    return { x=sin(angle)*radius, y=cos(angle)*radius }
end

function check_pos(el)
    if(el.x<-space_limit or el.x>space_limit) el.x=mid(-space_limit, el.x, space_limit)*-1
    if(el.y<-space_limit or el.y>space_limit) el.y=mid(-space_limit, el.y, space_limit)*-1
end

function home_update()

    home_pos.x-=g_sp.sx
    home_pos.y-=g_sp.sy
    check_pos(home_pos)

    if (home_light_speed<=0) then
        home_light_speed=5
        if(home_light<27) then home_light+=1 else home_light=25 end
    else
        home_light_speed-=1
    end
end

function home_draw()
    if(home_pos.x>-350 and home_pos.x<478 and home_pos.y>-350 and home_pos.y<478) then
        if(home_pos.x>-32 and home_pos.x<128 and home_pos.y>-12 and home_pos.y<128) then
            for h in all(home) do
                spr(h.spr,h.x+home_pos.x,h.y+home_pos.y,1,1)
            end
            spr(home_light, home_pos.x+12, home_pos.y)
        else
            draw_sight_dot({x=home_pos.x+16, y=home_pos.y+12}, 11)
        end
    end
end

function home_hit(x,y,pl)
    coll=false
    for h in all(home) do
        if((pl==true and h.hit==true) or pl==false) then
            if(coll==false) then coll=col({x=h.x+home_pos.x, y=h.y+home_pos.y}, {x=x, y=y}) end
        end
    end
    return coll
end

function home_dock(x,y)
    coll=false
    for h in all(home) do
        if(h.dock==true) then
            if(coll==false) then coll=col({x=h.x+home_pos.x, y=h.y+home_pos.y}, {x=x, y=y}) end
        end
    end
    return coll
end

function swaves_draw()
    for mysw in all(shwaves) do
        circ(mysw.x,mysw.y,mysw.r,mysw.col)
        mysw.r+=mysw.speed
        if mysw.r>mysw.tr then
            del(shwaves,mysw)
        end
    end
end

function smol_shwave(shx,shy,shcol)
    if shcol==nil then
     shcol=9
    end 
    local mysw={}
    mysw.x=shx
    mysw.y=shy
    mysw.r=3
    mysw.tr=6
    mysw.col=shcol
    mysw.speed=1
    add(shwaves,mysw)
end

function big_shwave(shx,shy)
    local mysw={}
    mysw.x=shx
    mysw.y=shy
    mysw.r=3
    mysw.tr=25
    mysw.col=7
    mysw.speed=3.5
    add(shwaves,mysw)
end
   
function smol_spark(sx,sy)
    --for i=1,2 do
    local myp={}
    myp.x=sx
    myp.y=sy

    myp.sx=(rnd()-0.5)*8
    myp.sy=(rnd()-1)*3

    myp.age=rnd(2)
    myp.size=1+rnd(4)
    myp.maxage=10+rnd(10)
    myp.blue=isblue
    myp.spark=true

    add(parts,myp)
    --end
end

function parts_draw()
    for myp in all(parts) do
        local pc=7
      
        if myp.blue then
         pc=page_blue(myp.age)
        else
         pc=page_red(myp.age)
        end
        
        if myp.spark then
         pset(myp.x,myp.y,7)
        else
         circfill(myp.x,myp.y,myp.size,pc)
        end
        
        myp.x+=myp.sx
        myp.y+=myp.sy
        
        myp.sx=myp.sx*0.85
        myp.sy=myp.sy*0.85
        
        myp.age+=1
        
        if myp.age>myp.maxage then
            myp.size-=0.5
            if myp.size<0 then
                del(parts,myp)
            end
        end
    end
    if(#parts==0 and lost_base_destoryed==false) lost_base_destoryed=true
end

function explode(expx,expy,isblue)
 
    local myp={}
    myp.x=expx
    myp.y=expy
    
    myp.sx=0
    myp.sy=0
    
    myp.age=0
    myp.size=10
    myp.maxage=0
    myp.blue=isblue
    
    add(parts,myp)
         
    for i=1,30 do
        local myp={}
        myp.x=expx
        myp.y=expy
        
        myp.sx=rnd()*6-3
        myp.sy=rnd()*6-3
        
        myp.age=rnd(2)
        myp.size=1+rnd(4)
        myp.maxage=10+rnd(10)
        myp.blue=isblue
        
        add(parts,myp)
    end
    
    for i=1,20 do
        local myp={}
        myp.x=expx
        myp.y=expy
        
        myp.sx=(rnd()-0.5)*10
        myp.sy=(rnd()-0.5)*10
        
        myp.age=rnd(2)
        myp.size=1+rnd(4)
        myp.maxage=10+rnd(10)
        myp.blue=isblue
        myp.spark=true
        
        add(parts,myp)
    end
     
    big_shwave(expx,expy)
 
end

function bigexplode(expx,expy, isblue)
 
    local myp={}
    myp.x=expx
    myp.y=expy
    
    myp.sx=0
    myp.sy=0
    
    myp.age=0
    myp.size=25
    myp.maxage=0
    myp.blue=isblue
    
    add(parts,myp)
         
    for i=1,60 do
        local myp={}
        myp.x=expx
        myp.y=expy
        
        myp.sx=rnd()*12-6
        myp.sy=rnd()*12-6
        
        myp.age=rnd(2)
        myp.size=1+rnd(6)
        myp.maxage=20+rnd(20)
        myp.blue=isblue
        
        add(parts,myp)
    end
    
    for i=1,100 do
        local myp={}
        myp.x=expx
        myp.y=expy
        
        myp.sx=(rnd()-0.5)*30
        myp.sy=(rnd()-0.5)*30
        
        myp.age=rnd(2)
        myp.size=1+rnd(4)
        myp.maxage=20+rnd(20)
        myp.blue=isblue
        myp.spark=true
        
        add(parts,myp)
    end
    
    big_shwave(expx,expy)
end

function page_red(page)
    local col=7

    if page>15 then
        col=5
    elseif page>12 then
        col=2
    elseif page>10 then
        col=8
    elseif page>7 then
        col=9
    elseif page>5 then
        col=10
    end
    
    return col
end
   
function page_blue(page)
    local col=7

    if page>15 then
        col=1
    elseif page>12 then
        col=1
    elseif page>10 then
        col=13
    elseif page>7 then
        col=12
    elseif page>5 then
        col=6
    end
    
    return col
end

function draw_sight_dot(e, col, size)
    if(size==nil) size=2

    local dx=e.x-63
    local dy=e.y-63

    local m=dy/dx
    local x,y

    if abs(m)<=1 then
        --left/right
        x=sgn(dx)*64
        y=sgn(dx)*64*m
    else
        --top/bot
        x=sgn(dy)*64/m
        y=sgn(dy)*64
    end
    circfill(mid(0, x+64, 127), mid(12,y+64,127), size, col)
end
-->8