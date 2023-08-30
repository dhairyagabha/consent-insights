# == Schema Information
#
# Table name: teams_permissions
#
#  team_id          :bigint           not null
#  permittable_type :string           not null
#  permittable_id   :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "test_helper"

class TeamsPermissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
