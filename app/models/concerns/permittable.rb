module Permittable
	extend ActiveSupport::Concern

	included do
		has_many :teams_permissions, as: :permittable
		has_many :teams, through: :teams_permissions

	end

	def permit team_ids
		self.teams << Team.where(id: team_ids)
	end

	def users
		users = []
		self.teams.each do |t|
			users += t.users
		end
		users
	end

	def admins
		admins = []
		self.teams.each do |t|
			admins += t.admins
		end
		admins
	end
end