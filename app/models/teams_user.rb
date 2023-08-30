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
class TeamsUser < ApplicationRecord
  belongs_to :team
  belongs_to :user

  def admin!
    self.update(admin: true)
  end
end
