-- remove the top bar from new windows except for smplayer (undecorating smplayer makes Cinnamon crash
debug_print("Window Name: "..	get_window_name());
if (get_window_name()~="SMPlayer") then
        undecorate_window();
else
        maximize()
end

if (get_window_name()=="st") then
	-- x,y, xsize, ysize
	maximize()
end
