class Coursemod < ActiveRecord::Base
  attr_accessible  :module_desc, :module_name
  
  belongs_to :course
  
  has_many :module_lessons, :foreign_key=>"module_id",:dependent => :destroy
  has_many :lessons, :through=>:module_lessons
  
  # data validations
  
  validates  :module_name, :presence=>true, 
                            :uniqueness=>{:case_sensitive=>false},
                            :length => {:maximum=>30} 
  validates  :module_desc, :presence=>true, 
                           :length => {:maximum=>140} 
 
 
end
