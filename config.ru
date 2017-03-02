require 'grape'

module ApiEtna
  class API < ::Grape::API
    version 'v1'
    format :json

    resource :test do
      desc 'test'
      get '/' do
        p "OLELELELELEL"
      end
    end
    
  end
end


# module API

#   class Base < Grape::API
#     mount ::ApiEtna::API
#   end
# end

run ApiEtna::API