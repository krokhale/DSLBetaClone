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

require 'spec_helper'

describe Authorization do
  pending "add some examples to (or delete) #{__FILE__}"
end
