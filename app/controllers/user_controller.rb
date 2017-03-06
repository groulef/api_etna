module ApiEtna
	class UserController < ::Grape::API
    	format :json


		resource :users do
	      desc 'test'
	      get '/' do
	      	@db_co.query("SELECT * FROM user").each do |e|
	      		p e
	      	end
	        {response: "OK", status: 200}
	      end

	      desc 'Add a user'
	      post '/' do
	      	params.each do |key,value|
	      		p "Key : #{key} | Value : #{value}"
	      	end
	      end
	    end
	end
end



