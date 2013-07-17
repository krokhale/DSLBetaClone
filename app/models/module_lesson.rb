class ModuleLesson < ActiveRecord::Base
  attr_accessible :lesson_id
  
  belongs_to :lesson
  belongs_to :module, :class_name=>"Coursemod"
  
  #data validations
  
  validates :module_id, :presence => true
  validates :lesson_id, :presence => true
  
end
