class ParkHistoriesController < ApplicationController
  def park
    @park = ParkHistory.new()
    @park.plate_number = params[:plate_number]
    @park.is_out = 0
    stall = Stall.where("is_idle=?",1).first
    if stall == nil
      redirect_to :action => "to_park"
      flash[:notice] = ["Garage is full"]
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
    @count = Stall.where("is_idle=?",1).count
  end
  def show_ticket
    @ticket = ParkHistory.find(params[:id])
    if @ticket.is_out == 1#已出车库
      redirect_to :action => "no_ticket"
    else
      now = Time.new
      @now_time = now.strftime("%Y-%m-%d %H:%M:%S")
      @create_time = @ticket.created_at.strftime("%Y-%m-%d %H:%M:%S")
      @distance_time = (now - @ticket.created_at).to_i / 60 / 60
    end 
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
    if ParkHistory.find_by_id(params[:id])
      redirect_to :action => "show_ticket", :id => params[:id]
    else
      redirect_to :action => "no_ticket"
    end
  end
  def no_ticket
    
  end
end
