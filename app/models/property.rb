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
class Property < ApplicationRecord

	include Permittable

	has_many :consents
	has_many :impressions
	has_many :visits

	validates_presence_of :domain
	validates_uniqueness_of :name, :api_key, :secret

	before_create :generate_tokens

	def generate_tokens
		self.api_key = "CI-#{(SecureRandom.random_number(9e9)+1e7).to_i}"
		self.secret = (SecureRandom.random_number(9e110)+1e7).to_i
	end
end
