class ParkHistoriesController < ApplicationController
  def park
    @park = ParkHistory.new()
    @park.plate_number = params[:plate_number]
    @park.is_out = 0
    stall = Stall.where("is_idle=?",1).first
    if stall == nil
      redirect_to :action => "to_park"
      flash[:notice] = ["Garage is full."]
    else
      @park.stall_id = stall.id
      stall.is_idle = 0
      if @park.save && stall.save
        redirect_to :action => "show_ticket", :id => @park.id
      else
        redirect_to :action => "to_park"
        flash[:notice] = @park.errors.full_messages
      end
    end
    
  end
  def to_park
    #@park = ParkHistory.new
  end
  def show_ticket
    @ticket = ParkHistory.find(params[:id])
  end
  def out
    @park = ParkHistory.find(params[:id])
    if @park.update_attributes(:is_out => 1)
      stall = Stall.find(@park.stall_id)
      if stall.update_attributes(:is_idle => 1)
        redirect_to :action =>"to_park"
      end
    end
  end
  def find_ticket
    redirect_to :action => "show_ticket", :id => params[:id]
  end
end
