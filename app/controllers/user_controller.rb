require 'digest/sha1'
require 'json'

module ApiEtna
	class UserController < ::Grape::API
    	format :json



		resource :users do

			# http_basic do |username, password|
	  #   		p " user : #{username} pass : #{password}"
	  #   		::Constants::DB_CO.query("SELECT role FROM user WHERE email='#{username}' AND password='#{password}'").each do |u|
	  #   			p u
	  #   		end

	  #   		# if user
	  #   		# end
	  #   	# { 'test' => 'password1' }[username] == password
	  #   	end
    		
			
			desc 'Add a user'
			post '/' do
				count = 0
				status_msg = ""
				status_code = 0
				::Constants::DB_CO.query("SELECT * FROM user WHERE email = '#{params[:email]}'").each do |e|
					count += 1
				end

				email = params[:email].nil? ? "" : ::Constants::DB_CO.escape(params[:email])
				if count == 0 && email != ""
					lastname = params[:lastname].nil? ? "" : ::Constants::DB_CO.escape(params[:lastname])
					firstname = params[:firstname].nil? ? "" : ::Constants::DB_CO.escape(params[:firstname])
					role = params[:role].nil? ? "" : ::Constants::DB_CO.escape(params[:role])
					password = Digest::SHA1.hexdigest ::Constants::DB_CO.escape(params[:password])

					::Constants::DB_CO.query("INSERT INTO user (lastname, firstname, email, password, role) VALUES ('#{lastname}', '#{firstname}', '#{email}', '#{password}', '#{role}')")
					status_msg = "Created User"
					status_code = 201
				else
					status_msg = "ErrorResponse"
					status_code = 400 
				end
				res = {status: status_code, message: status_msg}
				res
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



