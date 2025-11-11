return {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = { "blade", "html", "php" },
    settings = {
        tailwindCSS = {
            includeLanguages = {
                blade = "html",
            },
        },
    },
    root_markers = { "tailwind.config.js", "package.json", ".git" },
}
