class DummyController < ApplicationController
  def index

  	@a = Release.all
  end

  def selected
  
  	a= Release.find_by(name: params[:release])
  	d=Modul.where(release_id:a.id)
  	arr = Array.new(d.length) { Array.new(2) }
  	for i in 0..d.length-1
  		arr[i][0] = d[i].id
  		arr[i][1] = d[i].name
  	end
  	@l = arr
  	render :json => @l
  end
end
