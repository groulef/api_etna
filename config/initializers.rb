module Constants
	DB_CO = ::Mysql2::Client.new(host: "localhost", username: "root", password: "root", database: "tcm_rest")
end