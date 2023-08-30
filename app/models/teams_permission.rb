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
class TeamsPermission < ApplicationRecord
  belongs_to :team
  belongs_to :permittable, polymorphic: true
end
