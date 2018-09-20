class StoriesController < ApplicationController
	include ModulsHelper
  def index
  	@st = Story.all
  	respond_to do |format|
		format.html
		format.json { render json: EpicsDatatable.new(view_context)}
  end
end
  def show

	@stories = Story.find(params[:id])
  gon.story = @stories.key
	puts mod_id=@stories.epic_id
	epiid = Epic.find_by_id(mod_id)
    @moduid = Modul.find_by_id(epiid.modul_id)
    @rel_name = Release.find_by_id(@moduid.release_id).name
	@sto_esti=[]
  @sto_rem=[]
  @sto_logged=[]
  @stories.subtasks.each do |e|
    @sto_logged<<e.logged_time
    @sto_esti<< e.estimated_time
    @sto_rem<< e.remaining_time
  end
  @g=column(@sto_logged)
  @h=column(@sto_esti)
  @i=column(@sto_rem)
  for i in 0..@g.length-1
    if @g[i] < @h[i]
      @i[i] = -@i[i]
    else
      @i[i]
    end
  end
  @total_tasks_logged = graph_time(@g.sum)
  @total_tasks_esti = graph_time(@h.sum)
  @total_tasks_rem = graph_time(@i.sum)
	end
end
