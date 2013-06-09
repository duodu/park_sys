class Stall < ActiveRecord::Base
  attr_accessible :is_idle, :location, :park_his_id #is_idle=0:不空闲；is_idle=1:空闲
  has_many :park_histories, :class_name => "ParkHistory", :dependent => :nullify, :conditions => "is_out=0"
  validates :is_idle, :location, :presence => true
  validates :is_idle, :numericality => true
  validates :location, :uniqueness => true
end
