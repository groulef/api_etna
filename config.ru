require 'grape'
require 'mysql'
# require 'app/controllers/application_controller.rb'
require File.expand_path('../app/controllers/user_controller', __FILE__)
require File.expand_path('../app/controllers/application_controller', __FILE__)



# module API

#   class Base < Grape::API
#     mount ::ApiEtna::API
#   end
# end

run ApiEtna::ApplicationController
