require 'grape'


module API
  class Base < ::Grape::API
    mount ApiEtna
  end
end

run API::Base
