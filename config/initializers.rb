module Constants
	DB_CO = ::Mysql2::Client.new(host: "127.0.0.1", username: "root", password: "root", database: "tcm_rest")
end