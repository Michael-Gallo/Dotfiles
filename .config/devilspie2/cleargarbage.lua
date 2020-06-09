-- remove the top bar from new windows except for smplayer (undecorating smplayer makes Cinnamon crash

debug_print("Window Name: "..	get_window_name());

local function contains(table, val)
   for i=1,#table do
      if table[i] == val then 
         return true
      end
   end
   return false
end
needs_decorate={"firefox","smplayer"}

if not contains(needs_decorate,get_application_name()) then
        undecorate_window()
end

maximize_programs = {"ranger","st","SMPlayer"}
if contains(maximize_programs,get_window_name()) then
	-- x,y, xsize, ysize
	maximize()
end
