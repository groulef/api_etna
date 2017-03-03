module ApiEtna
	class TestController < ::Grape::API
    format :json

	    resource :test do
	      desc 'test'
	      get '/' do
	        {response: "OK", status: 200}
	      end
	    end
	end
end



