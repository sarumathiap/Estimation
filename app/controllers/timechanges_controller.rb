class TimechangesController < ApplicationController
  def new

  end

  def create
  	params.permit!
  	k = params[:hours]
      if Time.parse(k).class == Time
  	     ModulsHelper.revert(k)
  	     redirect_to new_timechange_path
      else
          render :new
      end
  end




    def button
    end 

      def but
        respond_to do |format|
        format.js { render 'but.js.erb'  }
      end
    end
end
