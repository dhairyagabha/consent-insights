# == Schema Information
#
# Table name: properties
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  domain     :string
#  api_key    :string           not null
#  secret     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class PropertyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
