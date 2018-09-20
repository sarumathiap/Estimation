class EnduserController < ApplicationController

  skip_before_action :require_login , only: [:new , :create]

  def index
     
    @users = User.all
    @use = User.where(:status => "0")
 
  end
  def new
    @user = User.new
  end
  def create

    @user = User.new(user_params)
     if @user.save
    flash[:notice] = "User saved to database."
    redirect_to new_enduser_path
  else
    flash.now[:alert] = "Error: #{@user.errors.full_messages.join(', ')}"
    render :new
  end
  end
  def show

    @user= User.find(params[:id])
  end
def confirm
  @user = User.find(params[:id])

  @user.update_attributes(:status => 1)
   respond_to do |format|
      format.html { redirect_to authusers_url }
      format.json { head :no_content }

end
end
def access
  
end
def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to authusers_url, notice: 'User has been successfully destroyed.' }
      format.json { head :no_content }
    end
  end
 
protected
  def user_params
    params.require(:user).permit(:role,:email, :status)
  end
end


