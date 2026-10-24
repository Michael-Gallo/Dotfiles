local dirty, pending = true, false
local events = {
    activewindow = true, activewindowv2 = true,
    windowtitle = true, windowtitlev2 = true,
    workspace = true, workspacev2 = true, focusedmon = true,
    openwindow = true, closewindow = true,
    movewindow = true, movewindowv2 = true,
    activespecial = true, activespecialv2 = true,
    monitoradded = true, monitoraddedv2 = true, monitorremoved = true,
}

noctalia.setUpdateInterval(100)
noctalia.runStream('socat -u UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" -', function(line)
    if events[line:match("^([^>]+)>>")] then dirty = true end
end)

local function query(command, callback)
    local started = noctalia.runAsync({ "hyprctl", "-j", command }, function(result)
        local data = result.exitCode == 0 and noctalia.json.decode(result.stdout)
        if type(data) ~= "table" then
            noctalia.log("Cannot read Hyprland " .. command)
            noctalia.state.set("titles", {})
            pending = false
            return
        end
        callback(data)
    end)
    if not started then
        noctalia.state.set("titles", {})
        pending = false
    end
end

function update()
    if not dirty or pending then return end
    dirty, pending = false, true
    query("monitors", function(monitors)
        query("workspaces", function(workspaces)
            local titles = {}
            for _, monitor in ipairs(monitors) do
                local workspace = monitor.activeWorkspace
                if monitor.specialWorkspace and monitor.specialWorkspace.id ~= 0 then
                    workspace = monitor.specialWorkspace
                end
                for _, candidate in ipairs(workspaces) do
                    if workspace and candidate.id == workspace.id then
                        titles[monitor.name] = (candidate.lastwindowtitle or ""):gsub("%s+", " ")
                        break
                    end
                end
            end
            noctalia.state.set("titles", titles)
            pending = false
        end)
    end)
end
