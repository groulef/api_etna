require 'digest/sha1'
require 'json'

module ApiEtna
	class UserController < ::Grape::API
    	format :json


		resource :users do
			
			desc 'test'
			get '/' do
				{response: "OK", status: 200}
			end

			desc 'Add a user'
			post '/' do
				count = 0
				status_msg = ""
				status_code = 0
				@db_co.query("SELECT * FROM user WHERE email = '#{params[:email]}'").each do |e|
					count += 1
				end

				if count == 0
					password = Digest::SHA1.hexdigest params[:password]
					@db_co.query("INSERT INTO user (lastname, firstname, email, password, role) VALUES ('#{params[:lastname]}', '#{params[:firstname]}', '#{params[:email]}', '#{password}', '#{params[:role]}')")
					status_msg = "Created User"
					status_code = 201 
				else
					status_msg = "ErrorRespone"
					status_code = 400 
				end

				users = []
				users << {status_code: status_code, message: status_msg}
				@db_co.query("SELECT lastname AS ln, firstname AS fn, email AS em, role AS ro , id FROM user").each do |e|
					users << {id: e[4], email: e[2],lastname: e[0], firstname: e[1], role: e[3]}
				end
				users
			end

	      	desc 'modifies a user'
	      	put '/:uid' do
	      		params.each do |key, value|
	      			p "#{key} | #{value}"
	      		end


	      		@db_co.query("SELECT * FROM user WHERE id = #{params[:uid]}").each do |e|
	      			lastname 	= params[:lastname].nil? 	? e[1] : params[:lastname]
	      			firstname 	= params[:firstname].nil? 	? e[2] : params[:firstname]
	      			email 		= params[:email].nil? 		? e[3] : params[:email]
	      			password 	= params[:password].nil? 	? e[2] : Digest::SHA1.hexdigest params[:password]
	      			role 		= params[:role].nil? 		? e[5] : params[:role]
	      			p lastname 
	      		end
	      	end
	    end

	end
end



