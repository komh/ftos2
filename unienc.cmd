/* */
call RxFuncAdd "SysLoadFuncs", "RexxUtil", "SysLoadFuncs"
call SysLoadFuncs

Parse Upper Arg a1 a2

app = "FreeType/2"
key = "Use_Unicode_Encoding"

if Arg() = 0 then call usage

if a1 = 'Q' then call query

if a1 = 'S' then call set
call usage

set:

val = a2

if val = '' then do
   say 'Invalid parameter!'
   exit
end

if val <> 0 & val <> 1 then do
   say 'Only 0 and 1 are acceptable !!!'
   pause
   exit
end

szval = val || d2c(0)

rc = SysIni('USER', app, key, szval)
say rc
if rc = 'ERROR:' then do
   say 'Error updating OS2.INI!'
   pause
   exit
end

say "Unicode encode flag updated to " || val || ". Please reboot to activate changes."
pause
exit

query:
val = SysIni('USER', app, key)
if val = "ERROR:" then val = "not set"
/* strip the terminating NULL character */
else val = substr(val, 1, pos(d2c(0), val) - 1)

say 'The current unicode encode flag is ' || val
pause
exit

usage:
say 'This program is used to set the flag of adding unicode encode.'
say
say 'Usage: UNIENC q         - query the current flag'
say '       UNIENC s  <val>  - set flag to <val=0|1> (effective on next reboot).'
pause
