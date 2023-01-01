--mainscreen.lua

instruction_show=false
function mian_init()
end
function main_update()
    if(g_sp.sy!=-3) g_sp.sy=-3
    if(btnp(4)) then
        game_init()
        game_mode="game"
    end
    if(btnp(5)) then
        if(instruction_show) then
            instruction_show=false
        else
            instruction_show=true
        end
    end
end
function main_draw()
    if(instruction_show) then
        rectfill(2,2,125,125,0)
        rect(2,2,125,125,9)
        print("save the crew on lost base!", 10, 10, 10)
        print("-find the yellow dot on the", 10, 25, 10)
        print(" minimap and targer it to", 10, 35, 10)
        print(" find the lost base.", 10, 45, 10)
        print("-avoid or shoot down enemy", 10, 60, 10)
        print(" ships", 10, 70, 10)
        print("-dock into the lost base", 10, 85, 10)
        print("-pick up shields and hearts", 10, 100, 10)
        print("-use ❎ to see minimap", 10, 115, 10)
    else
        spr(64, 0, 24, 16, 6)
        print("highscore:"..high_score, 5, 90, 6)
        print("press 🅾️ to play", 5, 105, 7)
        print("press ❎ for instructions", 5, 115, 7)
    end
end
-->8