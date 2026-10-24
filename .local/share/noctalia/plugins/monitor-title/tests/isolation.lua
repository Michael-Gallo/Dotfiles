local root = (arg[0]:match("^(.*)/tests/[^/]+$") or ".") .. "/"
local watchers, state, onLine = {}, {}, nil
local monitors = {
    { name = "DP-2", activeWorkspace = { id = 1 }, specialWorkspace = { id = 0 } },
    { name = "DP-3", activeWorkspace = { id = 8 }, specialWorkspace = { id = 0 } },
}
local workspaces = {
    { id = 1, lastwindowtitle = "Left browser" },
    { id = 6, lastwindowtitle = "Hidden workspace" },
    { id = 8, lastwindowtitle = "Right terminal" },
}
local reads, fail = 0, false
local api = {
    setUpdateInterval = function() end,
    log = function() end,
    json = { decode = function(value) return value end },
    runStream = function(_, callback) onLine = callback; return true end,
    runAsync = function(argv, callback)
        reads = reads + 1
        callback({ exitCode = fail and 1 or 0, stdout = argv[3] == "monitors" and monitors or workspaces })
        return true
    end,
    state = {
        get = function(key) return state[key] end,
        watch = function(key, callback)
            watchers[key] = watchers[key] or {}
            table.insert(watchers[key], callback)
        end,
        set = function(key, value)
            state[key] = value
            for _, callback in ipairs(watchers[key] or {}) do callback(value) end
        end,
    },
}
local function loadEntry(file, extra)
    local env = setmetatable({ noctalia = api }, { __index = _G })
    for key, value in pairs(extra or {}) do env[key] = value end
    assert(loadfile(root .. file, "t", env))()
    return env
end
local function widget(output)
    local view = {}
    local entry = loadEntry("widget.luau", {
        barWidget = {
            outputName = function() return output end,
            setVisible = function(value) view.visible = value end,
            setTooltip = function() end,
            render = function(tree) view.title = tree.text end,
        },
        ui = { label = function(props) return props end },
    })
    entry.update()
    return view
end
local service = loadEntry("service.luau")
local left, right = widget("DP-2"), widget("DP-3")
service.update()
assert(left.title == "Left browser" and right.title == "Right terminal")
workspaces[3].lastwindowtitle = "New right title"
onLine("activewindow>>terminal,New right title")
service.update()
assert(left.title == "Left browser" and right.title == "New right title")
local previousReads = reads
onLine("unrelated>>event")
service.update()
assert(reads == previousReads, "Idle ticks must not query Hyprland")
monitors[2].activeWorkspace.id = 6
onLine("workspacev2>>6,1")
service.update()
assert(right.title == "Hidden workspace" and left.title == "Left browser")
table.insert(workspaces, { id = -99, lastwindowtitle = "Scratchpad" })
monitors[2].specialWorkspace.id = -99
onLine("activespecial>>scratchpad,DP-3")
service.update()
assert(right.title == "Scratchpad")
workspaces[1].lastwindowtitle = ""
onLine("closewindow>>1234")
service.update()
assert(not left.visible and right.visible)
fail = true
onLine("workspace>>1")
service.update()
assert(not left.visible and not right.visible, "Failed queries must clear stale titles")
print("PASS: independent titles, workspace/scratchpad changes, idle behavior, empty workspaces, query failure")
