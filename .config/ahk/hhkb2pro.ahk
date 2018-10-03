; hhkb2pro.ahk - HHKB 2 Pro additional settings
; DIP switch config is: 1-off,2-on,3-on,4-off,5-on,6-on

#InstallKeybdHook

; Right Opt shortcuts (NOTE Right Opt is in fact swapped with Right <> due to DIP)
; Right Opt + a,d,f - Volume +, -, mute toggle
RWin & a::Send {Volume_Down}
RWin & s::Send {Volume_Up}
RWin & d::Send {Volume_Mute}

; Right Opt + z,x,c - Music prev, next, play/pause
RWin & z::Send {Media_Prev}
RWin & x::Send {Media_Next}
RWin & c::Send {Media_Play_Pause}

; Power
;RWin & Esc::Send

; vim:set tw=120:
