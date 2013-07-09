# == Schema Information
#
# Table name: lessons
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  description  :text
#  instructions :text
#  solution     :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  tips         :text
#

require 'spec_helper'

describe Lesson do
  pending "add some examples to (or delete) #{__FILE__}"
end
