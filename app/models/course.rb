# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  course_name :string(255)
#  technology  :string(255)
#  level       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  desc        :text
#

class Course < ActiveRecord::Base
  attr_accessible :course_name, :level, :technology,:desc
  
  # data associations
  has_many :coursecreations, :dependent=>:destroy #this deletes only the associations but not asscoiated objects
  has_many :users, :through => :coursecreations
  
  has_many :coursemods, :dependent => :destroy
  
  #data validations
   validates  :course_name, :presence=>true, 
                            :uniqueness=>{:case_sensitive=>false},
                            :length => {:maximum=>50} 
 
  validates :technology, :presence => true
  
  validates :level, :presence => true
  
    
                       
                       
   
end
