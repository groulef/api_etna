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

			desc 'Add a user'
			post '/' do
				count = res = 0
				status_msg = ""
				status_code = 0
				email = params[:email].nil? ? "" : ::Constants::DB_CO.escape(params[:email])
				::Constants::DB_CO.query("SELECT * FROM user WHERE email = '#{email}'").each do |e|
					count += 1
				end

				if count == 0 && email != ""
					p params
					lastname = params[:lastname].nil? == false ? res += 1 : ::Constants::DB_CO.escape(params[:lastname])
					firstname = params[:firstname].nil? == false ? res += 1 : ::Constants::DB_CO.escape(params[:firstname])
					role = params[:role].nil? == false ? res += 1 : ::Constants::DB_CO.escape(params[:role])
					password = params[:password].nil? == false ? res += 1 : ::Constants::DB_CO.escape(params[:password])

					if res != 0
						::Constants::DB_CO.query("INSERT INTO user (lastname, firstname, email, password, role) VALUES ('#{lastname}', '#{firstname}', '#{email}', '#{password}', '#{role}')")
						status_msg = "Created User"
						status_code = 201
					else
						status_msg = "ErrorResponse"
						status_code = 400
					end
				else
					status_msg = "ErrorResponse"
					status_code = 400 
				end
				error!({"message" => status_msg}, status_code)				
			end	      	
	    end

	    resource :user do
	    	desc 'get user'
	    	get '/:uid' do
	    		query = "SELECT * FROM user WHERE id = #{params[:uid]}"
	    		::Constants::DB_CO.query(query).each do |u|
	    			p u
	    		end
	    	end

		    desc 'modifies a user'
	      	put '/:uid' do
	      		count = 0
	      		::Constants::DB_CO.query("SELECT * FROM user WHERE id = #{params[:uid]}").each do |r|
	      			if r["id"] != params[:uid]
	      				count += 1
	      			end
	      		end
	      		allowed_params = ["email", "firstname", "lastname", "password", "role"]
	      		query = "UPDATE user SET "
	      		params.each do |key, value|
	      			p key
	      			p value
	      			if allowed_params.include?(key)
	      				query += " #{key} = '#{value}',"
	      			end
	      		end
	      		query = query.chop
	      		query += " WHERE id = #{params[:uid]}"
	      		p query
	      		# raise
	      		p params[:uid]
	      		::Constants::DB_CO.query(query)
	      		# query += params[:lastname].nil? ? "" : "`lastname` = #{params[:lastname]} "
	      		# query += params[:firstname].nil? ? "" : "`firstname` = #{params[:firstname]} "
	      		# query += params[:lastname].nil? ? "" : "`lastname` = #{params[:lastname]}"
	      		# query += params[:lastname].nil? ? "" : "`lastname` = #{params[:lastname]}"
	      		# query += params[:lastname].nil? ? "" : "`lastname` = #{params[:lastname]}"
	      		# UPDATE user SET WHERE id = #{params[:uid]}
	      		# ::Constants::DB_CO.query("SELECT * FROM user WHERE id = #{params[:uid]}").each do |e|
	      		# 	lastname 	= params[:lastname].nil? 	? e[1] : params[:lastname]
	      		# 	firstname 	= params[:firstname].nil? 	? e[2] : params[:firstname]
	      		# 	email 		= params[:email].nil? 		? e[3] : params[:email]
	      		# 	#password 	= params[:password].nil? 	? e[2] : Digest::SHA1.hexdigest params[:password]
	      		# 	role 		= params[:role].nil? 		? e[5] : params[:role]
	      		# 	p lastname 
	      		# end
		    end
	    end
	end
end



