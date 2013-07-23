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

require 'spec_helper'

describe Modularization do
  pending "add some examples to (or delete) #{__FILE__}"
end
