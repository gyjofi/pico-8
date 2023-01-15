show_settings=false

function settings_update()
    if (btnp(4) and show_settings) then
        if (mute==true) then
            mute=false
            music(0)
        else
            mute=true
            music(-1)
        end
    end
    if (btnp(5)) show_settings=not show_settings
end

function settings_draw()
    if show_settings then
        rectfill(16, 24, 111, 111, 0)
        print("mute music", 32, 49, 6)
        if(mute) then spr(50, 88, 48) else spr(51, 88, 48) end
        print("press ❎ to return", 24, 80, 6)
        print(" INSPIRED BY\n \"tutti frutti\"\n(mr chip software 1985)", 19, 94, 5)
    end
end