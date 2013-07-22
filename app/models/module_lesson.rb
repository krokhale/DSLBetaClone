# == Schema Information
#
# Table name: module_lessons
#
#  id         :integer          not null, primary key
#  module_id  :integer
#  lesson_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ModuleLesson < ActiveRecord::Base
  attr_accessible :lesson_id
  
  belongs_to :lesson
  belongs_to :module, :class_name=>"Coursemod"
  
  #data validations
  
  validates :module_id, :presence => true
  validates :lesson_id, :presence => true
  
end
