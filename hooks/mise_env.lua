local cmd = require("cmd")

--- Returns environment variables to set when this plugin is active
--- Documentation: https://mise.jdx.dev/env-plugin-development.html#miseenv-hook
--- @param ctx {options: table} Context (options = plugin configuration from mise.toml)
--- @return table[] List of environment variable definitions with key/value pairs
function PLUGIN:MiseEnv(ctx)
    local env_name = ctx.options.environment or "default"
    local result = cmd.exec("pixi shell-hook --frozen --shell bash --environment " .. env_name)

    local env_vars = {}
    for line in result:gmatch("[^\n]+") do
        -- parse lines like: export FOO="bar"
        local key, value = line:match("^export ([%w_]+)=[\"']?(.-)[\"']?$")
        if key and key ~= "PATH" then -- PATH handled separately in MisePath
            table.insert(env_vars, { key = key, value = value })
        end
    end

    return {
        cacheable = true,
        watch_files = { "pixi.lock", "pixi.toml" },
        env = env_vars,
    }
end
