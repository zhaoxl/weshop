class Ajax::AreaController < ApplicationController
  def cities
    render json: AreaCity.where(province_code: params[:provincecode]).map{|city| {name: city.name, code: city.code}}.to_json
  end
  
  def streets
    render json: AreaStreet.where(city_code: params[:citycode]).map{|street| {name: street.name, code: street.code}}.to_json
  end
end
