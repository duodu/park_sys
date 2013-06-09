class ParkHistory < ActiveRecord::Base
  attr_accessible :is_out, :plate_number, :stall_id #is_out=0:停车中；is_out=1:已出停车场
  belongs_to :stall, :class_name => "Stall"
  validates :plate_number, :presence => true
  validates :is_out, :numericality => true
end
