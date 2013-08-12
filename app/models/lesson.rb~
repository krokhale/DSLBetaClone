# == Schema Information
#
# Table name: lessons
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lesson < ActiveRecord::Base
    
  attr_accessible :name
  #data asscoiations
  has_many :modularizations, :dependent=>:destroy #this deletes only the associations but not asscoiated objects
  has_many :coursemods, :through => :modularizations
  
  
  validates :name, :presence => true,
                   :length=>{:maximum=>50}
  
  
  def self.import(file)
    CSV.foreach(file.path,:headers => true) do |row|
      Lesson.create! row.to_hash
    end
  end  
end
