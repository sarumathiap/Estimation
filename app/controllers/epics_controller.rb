class EpicsController < ApplicationController
include  ModulsHelper
  def index
    @epics = Epic.all
  end
 
  def show
    @story = Epic.find(params[:id])

    gon.epi = @story.key
    puts mod_id=@story.modul_id
    @moduleid = Modul.find_by_id(mod_id)
    @rel_name = Release.find_by(id:@moduleid.release_id).name
    @est=[]
    @act=[]
    @rem=[]
    @story.stories.each do |e|
      @est<<e.sub_task_story_estimated_time
      @act<< e.sub_task_story_logged_time
      @rem<< e.sub_task_story_remaining_time
    end
  @a = column(@est)
  @b = column(@act)
  @c = column(@rem)
  for i in 0..@a.length-1
    if @a[i] < @b[i]
      @c[i] = -@c[i]
    else
      @c[i]
    end
  end

  @final_esti_graph = graph_time(@a.sum)
  @final_act_graph = graph_time(@b.sum)
  @final_rem_graph = graph_time(@c.sum)
  
end
end
