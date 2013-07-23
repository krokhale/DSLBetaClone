# == Schema Information
#
# Table name: modularizations
#
#  id           :integer          not null, primary key
#  module_id    :integer
#  lesson_id    :integer
#  lesson_order :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Modularization < ActiveRecord::Base
 attr_accessor :skip
 attr_accessible :lesson_id,:lesson_order 
  
  belongs_to :lesson
  belongs_to :module, :class_name=>"Coursemod"
  default_scope :order=> 'modularizations.lesson_order DESC'
  
  #data validations
  validates :module_id, :presence => true
  validates :lesson_id, :presence => true
  
  validate :order_of_lessons, :unless => :skip                           
  before_validation :reordering_lessons, :on=>:create
  
 def order_of_lessons
    errors.add(:coursemod_order, "the module already exists. Please specify another order number") if order_already_exists?(self.lesson_order)
  end  
  
  private
  
    def reordering_lessons
      self.skip=true
      order_id = self.lesson_order
      max_order=0
      if modularization = Modularization.where(module_id: (self.module.id)).first
        max_order=modularization.lesson_order
      end
      if order_id > max_order
         #self.update_attributes(:lesson_order=>(max_order+1))
         self.lesson_order=max_order+1
      elsif order_already_exists?(order_id) 
         to_be_reordered= Modularization.where("module_id = ? AND lesson_order >= ?",self.module.id,order_id) 
         to_be_reordered.each do |mod|
           mod.update_attributes(:lesson_order=>(mod.lesson_order+1))
         end
      end
    end
    
    def order_already_exists?(order_id)
      Modularization.where(module_id: (self.module.id)).exists?(:lesson_order => order_id)
    end
    
end
