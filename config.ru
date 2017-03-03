require 'grape'
<<<<<<< HEAD


module API
  class Base < ::Grape::API
    mount ApiEtna
  end
end

run API::Base
=======
# require 'app/controllers/application_controller.rb'
require File.expand_path('../app/controllers/test_controller', __FILE__)
require File.expand_path('../app/controllers/application_controller', __FILE__)
# module API

#   class Base < Grape::API
#     mount ::ApiEtna::API
#   end
# end

run ApiEtna::ApplicationController
>>>>>>> 868ba1660ea2d475f35da78544c80c889a08623f
