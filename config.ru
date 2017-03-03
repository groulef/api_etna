require 'grape'
# require 'app/controllers/application_controller.rb'
require File.expand_path('../app/controllers/test_controller', __FILE__)
require File.expand_path('../app/controllers/application_controller', __FILE__)
# module API

#   class Base < Grape::API
#     mount ::ApiEtna::API
#   end
# end

run ApiEtna::ApplicationController
