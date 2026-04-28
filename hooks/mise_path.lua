local json = require("json")
local cmd = require("cmd")
local log = require("log")

--- Returns PATH entries to prepend when this plugin is active
--- Documentation: https://mise.jdx.dev/env-plugin-development.html#misepath-hook
--- @param ctx {options: table} Context (options = plugin configuration from mise.toml)
--- @return string[] List of paths to prepend to PATH
function PLUGIN:MisePath(ctx)
    local env_name = ctx.options.environment or "default"

    -- Run pixi info to collect information about the session
    local info = json.decode(cmd.exec("pixi info --json"))
    for _, env in pairs(info.environments_info) do
        if env.name == env_name then
            return { env.prefix .. "/bin" }
        end
    end

    log.warn("Environment not found: " .. env_name)
    return {}
end
