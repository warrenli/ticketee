class Project < ActiveRecord::Base
  validates :name, :presence => true
  has_many :tickets
  has_many :permissions, :as => :object

  scope :readable_by, lambda { |user| joins(:permissions).where( :permissions => {:action => "read", :user_id => user.id} )   }
end
