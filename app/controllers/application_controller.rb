module ApiEtna

	class ApplicationController < ::Grape::API
		before do
    		header "Access-Control-Allow-Origin", "*"
   			@db_co = ::Mysql.connect("localhost", "root", "root", "tcm_rest")
    	end
		mount UserController
	end
end