# == Schema Information
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  role       :string(255)
#  course     :string(255)
#  user       :string(255)
#  micropost  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Authorization < ActiveRecord::Base
   #attr_accessible :course, :micropost, :role, :user
   
  
   #method for getting the permissions of a particular user
  def self.get_permissions(user)
    @permissions = {}
    @auth = find_by_role(user.role)
    @auth.attributes.each do |key, value|
       unless ['id','role','created_at','updated_at'].include? key
         converted_array= value.split(',') 
         @permissions[key] = converted_array
       end  
    end  
    return @permissions
  end
end
