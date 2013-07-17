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

require File.dirname(__FILE__) + '/../spec_helper'

describe Coursecreation do
  it "should be valid" do
    Coursecreation.new.should be_valid
  end
end
