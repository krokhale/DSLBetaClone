# == Schema Information
#
# Table name: coursemods
#
#  id              :integer          not null, primary key
#  module_name     :string(255)
#  module_desc     :text
#  course_id       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  coursemod_order :integer
#

require 'spec_helper'

describe Coursemod do
  pending "add some examples to (or delete) #{__FILE__}"
end
