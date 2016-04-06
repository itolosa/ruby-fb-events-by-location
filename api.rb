require 'grape'
require './lib/core'

module FBEventsByLocation
  class API < Grape::API
    version 'v1', using: :header, vendor: 'itolosa'
    format :json
    prefix :api

    resource :events do
      desc 'Obtain events'
      params do
        requires :access_token, type: String, desc: 'Your access token.'
        requires :lat, type: Float, values: -90.0..+90.0
        requires :lng, type: Float, values: -180.0..+180.0
        requires :dist, type: Integer, values: 0..100000
      end
      get do
        handler = FBEventsByLocation::Core.new(params[:access_token])
        handler.search(params[:lat], params[:lng], params[:dist], nil)
      end
    end
  end
end