lastSpeed=1;

function checkKeys(timer)
if (isKeyPressed(VK_E)) then if lastspeed ~= 10 then speedhack_setSpeed(10) lastSpeed=10 end
else if lastspeed ~= 1 then speedhack_setSpeed(1) lastSpeed=1 end
end

end

t=createTimer(nil)
timer_setInterval(t, 100)
timer_onTimer(t, checkKeys)
timer_setEnabled(t, true)
