class Lcontent
  include Mongoid::Document
    
  #fields in the document
  field :lid, type: Integer
  field :name, type: String
  field :description, type: String
  field :instructions, type: String
  field :solution, type: String
  field :tips, type: String
  field :messages, type: Hash
  field :_id, type: Integer, default: ->{ lid }
  
  #permissions over the fields
  attr_accessible :description, :instructions, :name, :solution,:tips,:order,:messages
  
  #validations on the fields
  validates :name, :presence => true,
                   :length=>{:maximum=>50}
  validates :description, :presence => true
  validates :instructions, :presence => true
  validates :solution, :presence => true 
end
