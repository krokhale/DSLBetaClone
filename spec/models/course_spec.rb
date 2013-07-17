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

require 'spec_helper'

describe Course do
  pending "add some examples to (or delete) #{__FILE__}"
end
