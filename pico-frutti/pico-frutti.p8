pico-8 cartridge // http://www.pico-8.com
version 39
__lua__
#include lua/main.lua
#include lua/utils.lua
#include lua/player.lua
#include lua/infobar.lua
#include lua/seed.lua
#include lua/enemy.lua
__gfx__
00000000111111116666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111116777777500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700111114116755557500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700011111111675dd67500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700014111111675dd67500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700111111116756667500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111416777777500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111116555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00222200002222000022220000222200002222000022220000222200000000000000000000000000000000000000000000000000000000000000000000000000
02888820028888200288882002228800022288000222880002228800000000000000000000000000000000000000000000000000000000000000000000000000
08888880088888800888888002288880022888800228888002288880000000000000000000000000000000000000000000000000000000000000000000000000
08688680088888800868868002888680028886800288868002888680000000000000000000000000000000000000000000000000000000000000000000000000
08866880088668800886688008888860088888600888886008888860000000000000000000000000000000000000000000000000000000000000000000000000
00888800008888000088886000888880008888800086888000888880000000000000000000000000000000000000000000000000000000000000000000000000
06888860068888600688886600868800006888000086680000888600000000000000000000000000000000000000000000000000000000000000000000000000
66000066660000666600000000066000006606600006600000660660000000000000000000000000000000000000000000000000000000000000000000000000
00333300003333000033330000333300003333000033330000000000000000000000000000000000000000000000000000000000000000000000000000000000
03bbbb3003bbbb300333bb300333bb300333bb300333bb3000000000000000000000000000000000000000000000000000000000000000000000000000000000
0bbbbbb00bbbbbb003bbbbb003bbbbb003bbbbb003bbbbb000000000000000000000000000000000000000000000000000000000000000000000000000000000
5b7bb7b55b7bb7b503bbb7b003bbb7b003bbb7b003bbb7b000000000000000000000000000000000000000000000000000000000000000000000000000000000
5bb55bb55bb55bb50bbbbb500bbbbb500bbbbb500bbbbb5000000000000000000000000000000000000000000000000000000000000000000000000000000000
0bbbbbb00bbbbb500bbbbbb00bbbbbb00bb5bbb00bbbbbb000000000000000000000000000000000000000000000000000000000000000000000000000000000
05bbbb5005bbbb5500b5bb00005bbb0000b55b0000bbb50000000000000000000000000000000000000000000000000000000000000000000000000000000000
55000055550000000005500000550550000550000055055000000000000000000000000000000000000000000000000000000000000000000000000000000000
00003000000003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0bb30bb0000033000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbabbbb3000303000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
babbbb33003000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbb33088008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
abbbb3338e828e820000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03333330882288220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00333300022002200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0080010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000804000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100003131313100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100003131313100000000000000003100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000003100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101000000010101010100000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100310000000000000000000031310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000031310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000031310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000003100000000000031310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0003000026050200501d0501e050230502e0503605038050320500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
210a000024050280502b0503005030050300502b05030050300503005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010400003975600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0003000008050080500c05013050180501c0501b05016050120500505001050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
