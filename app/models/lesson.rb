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
  
  #data asscoiations
  has_many :module_lessons, :dependent=>:destroy #this deletes only the associations but not asscoiated objects
  has_many :coursemods, :through => :module_lessons
  
  
  validates :name, :presence => true,
                   :length=>{:maximum=>50}
  validates :description, :presence => true
  validates :instructions, :presence => true
  validates :solution, :presence => true 
  
  
  
  
  
  
end
