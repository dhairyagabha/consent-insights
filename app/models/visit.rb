# == Schema Information
#
# Table name: visits
#
#  id          :bigint           not null, primary key
#  visit_id    :string           not null
#  property_id :bigint           not null
#  country     :string(4)        not null
#  language    :string(4)        not null
#  user_type   :string           default("NEW"), not null
#  preferences :string(10)
#  user_agent  :string
#  title       :string
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Visit < ApplicationRecord
  belongs_to :property
end
