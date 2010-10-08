class Ticket < ActiveRecord::Base
  validates :title, :presence => true
  validates :description, :presence => true, :length => { :minimum => 10 }
  belongs_to :project
  belongs_to :user
  has_many :assets
  accepts_nested_attributes_for :assets, :allow_destroy => true, :reject_if => proc { |asset| asset["asset"].blank? }
end
