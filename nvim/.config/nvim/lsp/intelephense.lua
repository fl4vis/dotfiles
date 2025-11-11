return {
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php" },
    root_markers = { "composer.json", ".git" },
    diagnostics = {
        enable = true,
        -- Enable strict type checking
        undefinedTypes = true,
        undefinedFunctions = true,
        undefinedConstants = true,
        undefinedProperties = true,
        undefinedMethods = true,
    },
}
