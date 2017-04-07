require 'digest/sha1'
require 'json'

module ApiEtna
	class UserController < ::Grape::API
    	format :json

		resource :users do
			http_basic do |username, password|
				user = 0
	    		::Constants::DB_CO.query("SELECT * FROM user WHERE email=\"#{username}\"").each do |u|
	    			user = u;
	    		end
	    		pass = Digest::SHA1.hexdigest password

	    		if user != 0 && {user["email"] => user["password"]}[username] == pass
	    			if  user["role"] == "admin"
	    				true
	    			else
	    				false
		    		  	error!({"message" => "You must be admin"}, 403)
	    			end
	    		else
	    		  	false
	    		  	error!({"message" => "You must be connected"}, 401)
	    		end
	    	end

			desc 'Add a user - Route 1 '
			post '/' do
				count = res = 0
				status_msg = ""
				status_code = 0
				roles_allowed = ["admin", "normal"]
				email = params[:email] ?  ::Constants::DB_CO.escape(params[:email]) : res += 1
				::Constants::DB_CO.query("SELECT * FROM user WHERE email = '#{email}'").each do |e|
					count += 1
				end

				lastname = params[:lastname] ? ::Constants::DB_CO.escape(params[:lastname]) : res += 1 
				firstname = params[:firstname] ? ::Constants::DB_CO.escape(params[:firstname]) : res += 1 
				role = params[:role] ? ::Constants::DB_CO.escape(params[:role]) : res += 1 
				password = params[:password] ? ::Constants::DB_CO.escape(params[:password]) : res += 1 
				if count == 0 && roles_allowed.include?(role)
					if res == 0
						::Constants::DB_CO.query("INSERT INTO user (lastname, firstname, email, password, role) VALUES ('#{lastname}', '#{firstname}', '#{email}', '#{password}', '#{role}')")
						status_msg = "User successfully created"
						status_code = 200
					else
						status_msg = "An error occured"
						status_code = 400
					end
				else
					status_msg = "An error occured"
					status_code = 400 
				end
				error!({"message" => status_msg}, status_code)				
			end	      	
	    end

	    resource :user do
	    	http_basic do |username, password|
				user = 0
	    		::Constants::DB_CO.query("SELECT * FROM user WHERE email=\"#{username}\"").each do |u|
	    			user = u;
	    		end
	    		pass = Digest::SHA1.hexdigest password

	    		if user != 0 && {user["email"] => user["password"]}[username] == pass
	    			if  user["role"] == "admin"
	    				true
	    			else
	    				false
		    		  	error!({"message" => "You must be admin"}, 403)
	    			end
	    		else
	    		  	false
	    		  	error!({"message" => "You must be connected"}, 401)
	    		end
	    	end

	    	desc 'get user'
	    	get '/:uid' do
	    		query = "SELECT * FROM user WHERE id = #{params[:uid]}"
	    		user = []
	    		p query
	    		::Constants::DB_CO.query(query).each do |u|
	    			p u
	    			user = u
	    		end
	    		error!(u, 200)
	    	end

		    desc 'modifies a user - Route 2'
	      	put '/:uid' do
	      		if ApiEtna::User.check_user(params[:uid]) == 0
	      			status_msg = "User was not found"
					status_code = 404
				else
					roles_allowed = ["admin", "normal"]
		      		allowed_params = ["email", "firstname", "lastname", "password", "role"]
		      		query = "UPDATE user SET "
		      		params.each do |key, value|
		      			if allowed_params.include?(key)
		      				query += " #{key} = '#{::Constants::DB_CO.escape(value)}',"
		      			end
		      		end
		      		query = query.chop
		      		query += " WHERE id = #{params[:uid]}"
		      		if params[:role] && !roles_allowed.include?(params[:role])
						status_msg = "An error occured"
						status_code = 400 
		      		else
		      			status_msg = "User successfully modified"
		      			status_code = 200
		      		end
		      	end
		      	error!({"message" => status_msg}, status_code)
		    end

		    desc 'deletes a user - Route 3'
		    delete '/:uid' do
	      		if ApiEtna::User.check_user(params[:uid]) == 0
	      			status_msg = "User was not found"
					status_code = 404
				else
			    	query = "DELETE FROM user WHERE id = #{params[:uid]}"
			    	::Constants::DB_CO.query(query)
			    	status_msg = "successfully deleted"
			    	status_code = 200
	    		end
		      	error!({"message" => status_msg}, status_code)
		    end
	    end
	end

	class User
		def self.check_user uid
			count = 0
			::Constants::DB_CO.query("SELECT * FROM user WHERE id = #{uid.to_i}").each do |r|
      			if r["id"].to_i == uid.to_i
      				count += 1
      			end
	      	end
			count
		end
	end
end



