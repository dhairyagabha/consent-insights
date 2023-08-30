# == Schema Information
#
# Table name: teams_users
#
#  team_id    :bigint           not null
#  user_id    :bigint           not null
#  admin      :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class TeamsUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
