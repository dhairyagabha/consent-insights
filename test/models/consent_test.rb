# == Schema Information
#
# Table name: consents
#
#  id          :bigint           not null, primary key
#  visit_id    :string           not null
#  property_id :bigint           not null
#  country     :string(4)        not null
#  language    :string(4)        not null
#  user_type   :string           default("NEW"), not null
#  preferences :string(10)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class ConsentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
