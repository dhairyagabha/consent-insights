# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Team < ApplicationRecord
  belongs_to :user
  
  has_many :teams_users, dependent: :delete_all
  has_many :users, through: :teams_users

  has_many :teams_permissions, dependent: :delete_all
  has_many :properties, through: :teams_permissions, source: :permittable, source_type: "Property"

  after_create_commit :add_admin

  def add_admin
    self.users << self.user
    self.teams_users.find_by(user_id: self.user_id).admin!
  end

  def admins
    User.where(id: self.teams_users.select(:user_id).where(admin: true))
  end
end
