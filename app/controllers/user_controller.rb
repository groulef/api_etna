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
    				true
	    		else
	    		  	false
	    		  	error!({"message" => "You must be connected"}, 401)
	    		end
	    	end

			desc 'get all users - Route 5'
			get '/' do
				p params
				query = "SELECT * FROM user"
				users = []
				::Constants::DB_CO.query(query).each do |u|
					users << u
				end
				status 200
				users
			end

			desc 'searh user/s - Route 6'
			get '/search' do
				status_code = 0
				q = params[:q]
				query = "SELECT id, firstname, lastname, email, role FROM user WHERE lastname LIKE \"%#{q}%\" AND email LIKE \"%#{q}%\""
				verif_count = true if Float(params[:count]) rescue false
				p verif_count
				if params[:count] && verif_count == true
					query += " LIMIT #{params[:count]}"
				elsif params[:count] && verif_count == nil
					status_code = 400
					status_msg = "An error occurred"
				end
				if status_code == 0
					p query
					users = []
					::Constants::DB_CO.query(query).each do |u|
						users << u
					end
					if users == []
						status_code = 404
						status_msg = "No user found"
					else
						status_msg = users
						status_code = 200
					end
				end
				status status_code
				status_msg
			end 
		end

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
			#params do
		    #    requires :firstname, type: String, desc: 'user firstname'
		    #    requires :lastname, type: String, desc: 'user lastname'
		    #    requires :email, type: String, desc: 'user email'
		    #    requires :role, type: String, desc: 'user role'
		    #end
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
				status status_code
				status_msg				
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
    				true
	    		else
	    		  	false
	    		  	error!({"message" => "You must be connected"}, 401)
	    		end
	    	end

	    	desc 'get user - Route 4'
	    	get '/:uid' do
				if ApiEtna::User.check_user(params[:uid]) == 0
	      			status_msg = "User was not found"
					status_code = 404
				else
		    		query = "SELECT id, lastname, firstname, email, role FROM user WHERE id = #{params[:uid]}"
	    			user = []

		    		::Constants::DB_CO.query(query).each do |u|
		    			user = u
		    		end
		    		status_msg = user
		    		status_code = 200
		    	end
	    		status status_code
	    		status_msg
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
		      	status status_code
		      	status_msg
		    end

		    desc 'deletes a user - Route 3'
		    delete '/:uid' do
	      		if ApiEtna::User.check_user(params[:uid]) == 0
	      			status_msg = "User was not found"
					status_code = 404
				else
			    	query = "DELETE FROM user WHERE id = #{params[:uid]}"
			    	::Constants::DB_CO.query(query)
			    	status_msg = "User successfully deleted"
			    	status_code = 200
	    		end
		      	status status_code
		      	status_msg
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



