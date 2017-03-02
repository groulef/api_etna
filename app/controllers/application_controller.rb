module ApiEtna

	class ApplicationController < ::Grape::API
		mount TestController
	end
end