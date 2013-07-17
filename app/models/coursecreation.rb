# == Schema Information
#
# Table name: coursecreations
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  user_id    :integer
#  role       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Coursecreation < ActiveRecord::Base
  attr_accessible :course_id, :role # role is yet to be decided for accessibility
  
  belongs_to :user
  belongs_to :course
end
