class InfosController < ApplicationController
  
 def index
   @values = Info.all
     @infos = User.all
    @use = User.where(:status => "0")
  
  end
  def new
    ENV['current_controller'] = "infos"
    @info = User.new
    @infos = User.where(:status => "1")
    @use = User.where(:status => "0")
 @inf = Info.find_by(:id => 1)
 @inf.username = ModulsHelper.decrypted(@inf.username)
 @inf.password = ModulsHelper.decrypted(@inf.password)
 @in = @inf.password
  end
  def create

    @info = User.new(info_params)
    @info.save
    #redirect_to "https://www.goggle.com"

    @inf = Info.new(inf_params)
    @inf.save
  end

  def show
    
    @inf = Info.find(params[:id])

  end
    def edit
    @inf = Info.find(params[1])
  end
  def update
   
  @inf = Info.find(params[:id])

    if @inf.update(inf_params)
      redirect_to new_info_path
    else
      render 'edit'
    end
  end

  def confirm
  @info = User.find(params[:id])

  @info.update_attributes(:status => 1)
   respond_to do |format|
      format.html { redirect_to new_info_path }
      format.json { head :no_content }

end
end

def existing

if User.exists?(email: params[:email])
  @k = true
else
  @k = false
end

respond_to do |format|
format.js
end



  
end

 def edit_role
  puts params[:id]
  puts params[:role][:validated]
   u=User.find_by_id(params[:id])
  if params[:role][:validated] == "0"
     u.update(role:"User", status: 1)
  elsif  params[:role][:validated] == "1"
    u.update(role:"superuser", status: 1)
   
  
  end
    # u.update(role:params[:role] , status: 1)
    redirect_to new_info_path
  end
  
def destroy
    @info = User.find(params[:id])
    @info.delete

    
    respond_to do |format|
      format.html { redirect_to new_info_path, notice: 'User has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end
protected
  def info_params
    params.require(:user).permit(:email)
  end
  protected
  def inf_params
    params.require(:info).permit(:username,:password)
  end
end
