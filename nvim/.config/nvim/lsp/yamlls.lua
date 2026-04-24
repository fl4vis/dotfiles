return {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
    settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
            format = { enable = true },
            schemaStore = {
                enable = true,
            },
            schemas = {
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
                    "docker-compose.yml",
                    "docker-compose.yaml",
                    "*compose*.yml",
                    "*compose*.yaml",
                },
                -- Kubernetes built-in schema (bundled with yaml-language-server)
                --
                -- kubernetes = { "*.yaml", "*.yml" },
            },
            -- optional but useful with k8s
            validate = true,
            completion = true,
        },
    },
}
