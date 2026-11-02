return {
	cmd = { "sqls" },
	filetypes = { "sql", "mysql" },
	settings = {
		sqls = {
			connections = {
				{
					alias = "production_ec",
					driver = "postgresql",
					dataSourceName = "host=164.92.117.244 port=5432 user=bluesky dbname=SRI sslmode=disable",
				},
				{
					alias = "dev_ec",
					driver = "postgresql",
					dataSourceName = "host=localhost port=5432 user=bluesky dbname=SRI sslmode=disable",
				},
			},
		},
	},
}

-- Setup ~/.pgpass
-- chmod 600 ~/.pgpass
--
-- host:port:database:user:password
