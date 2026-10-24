local output, previousTitle

local function render(titles)
    local title = (titles or {})[output] or ""
    if title == previousTitle then return end
    previousTitle = title
    barWidget.setVisible(title ~= "")
    barWidget.setTooltip(title)
    barWidget.render(ui.label({ text = title, maxWidth = 260, maxLines = 1 }))
end

noctalia.state.watch("titles", render)
noctalia.setUpdateInterval(1000)

function update()
    -- Async callbacks lack output context in Noctalia 5.3; retain it here.
    output = barWidget.outputName()
    render(noctalia.state.get("titles"))
end
