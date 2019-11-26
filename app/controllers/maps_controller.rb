class MapsController < ApplicationController
  def index
  end

  def map
    results = Geocoder.search(params[:address])
    @latlng = result.first.coordinates #これでmap.js.erbで、経緯緯度情報が入った@latlng


    # respond_to以下の記述によって、
    # remote: trueのアクセスに対して、
    # map.js.erbが変えるようになります。
    respond_to do |format|
      format.js
    end
  end
end
