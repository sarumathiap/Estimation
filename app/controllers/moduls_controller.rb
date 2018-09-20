class ModulsController < ApplicationController
  before_action :set_modul, only: [:show, :edit, :update, :destroy]
  include ModulsHelper
  # GET /moduls
  # GET /moduls.json
  def index
   #ModulsHelper.checkrecords
    @mods = Modul.all
   
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

  def butt

  end


  # def button
    
  #  # job_id = Dbupdater.perform_async

  # #    respond_to do |format|
  # #   format.js { render :js => button.js.erb }
  # # end
  #   #Dbupdater.perform_async
  # end 

  # def but
  #   respond_to do |format|
  #   format.js { render 'but.js.erb'  }
  # end
  #end 

  # GET /moduls/1
  # GET /moduls/1.json
  def show
  @mod = Modul.find(params[:id])
  gon.mod = @mod.name
  @mod_esti=[]
  @mod_rem=[]
  @mod_logged=[]
  @mod.epics.each do |e|
    @mod_logged<<e.total_story_spent_time
    @mod_esti<< e.total_story_estimation_time
    @mod_rem<< e.total_story_remaining_time
  end
  @d=column(@mod_logged)
  @e=column(@mod_esti)
  @f=column(@mod_rem)
  for i in 0..@d.length-1
    if @d[i] < @e[i]
      @f[i] = -@f[i]
    else
      @f[i]
    end
  end
  @total_mod_logged = graph_time(@d.sum)
  @total_mod_esti = graph_time(@e.sum)
  @total_mod_rem = graph_time(@f.sum)

  @rel_name = Release.find_by(id:@mod.release_id).name
  end


  # respond_to do |format|
  #   format.html
  #   format.xlsx
#  end


  # GET /moduls/new

  # PATCH/PUT /moduls/1
  # PATCH/PUT /moduls/1.json
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_modul
      @mod = Modul.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def modul_params
      params.require(:modul).permit(:name)
    end
end
