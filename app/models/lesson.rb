# == Schema Information
#
# Table name: lessons
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  instructions :text
#  solution     :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  tips         :text
#

class Lesson < ActiveRecord::Base

  attr_accessible :description, :instructions, :name, :solution,:tips
  
  validates :name, :presence => true,
                   :length=>{:maximum=>50}
  validates :description, :presence => true
  validates :instructions, :presence => true
  validates :solution, :presence => true 
  
  
  
  
  
  
end
