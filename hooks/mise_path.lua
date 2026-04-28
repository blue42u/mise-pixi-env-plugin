--- Returns PATH entries to prepend when this plugin is active
--- Documentation: https://mise.jdx.dev/env-plugin-development.html#misepath-hook
--- @param ctx {options: table} Context (options = plugin configuration from mise.toml)
--- @return string[] List of paths to prepend to PATH
function PLUGIN:MisePath(ctx)
    local env_name = ctx.options.environment or "default"
    -- pixi envs are always at a predictable path
    return { ".pixi/envs/" .. env_name .. "/bin" }
end
