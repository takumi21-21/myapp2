class MapsController < ApplicationController
  def index
    @posts = Post.all
    @hash = Gmaps4rails.build_markers(@posts) do |post, marker|
            marker.lat post.latitude
            marker.lng post.longitude
            marker.infowindow post.address
            marker.json({ title: post.description })
        end
  end

  # def map
  #   results = Geocoder.search(params[:address])
  #   @latlng = result.first.coordinates #これでmap.js.erbで、経緯緯度情報が入った@latlng
  #
  #
  #   # respond_to以下の記述によって、
  #   # remote: trueのアクセスに対して、
  #   # map.js.erbが変えるようになります。
  #   respond_to do |format|
  #     format.js
  #   end
  # end
end
