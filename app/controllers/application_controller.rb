module ApiEtna

	class ApplicationController < ::Grape::API
		before do
    		header "Access-Control-Allow-Origin", "*"
    	end
		mount UserController
	end
end