class ParkHistory < ActiveRecord::Base
  attr_accessible :is_out, :plate_number, :stall_id #is_out=0:停车中；is_out=1:已出停车场
  belongs_to :stall, :class_name => "Stall"
  validates :plate_number, :presence => true, :format => {:with =>/\A[A-Za-z]{1,}[\d]{1,}\z/, :message => "should be like 'Abc1234'"}, :length => {:maximum => 10 }
  validates :is_out, :numericality => true
  validates :plate_number, :uniqueness => {:scope => :is_out}, :if => :is_out?
  def is_out?
    is_out == 0
  end
end
