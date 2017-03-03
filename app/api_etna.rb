require 'grape'

module API
  class ApiEtna < ::Grape::API
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
