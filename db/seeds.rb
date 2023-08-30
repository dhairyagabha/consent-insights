# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'securerandom'

users = [
	{
		name: "Raymond Holt",
		email: "r.holt@consent-insights.com",
		password: "rholt@123!",
		admin: true
	},
	{
		name: "Jake Peralta",
		email: "j.peralta@consent-insights.com",
		password: "jperalta@123!"
	},
	{
		name: "Amy Santiago",
		email: "a.santiago@consent-insights.com",
		password: "asantiago@123!"
	}
]

users = User.create(users)

raymond = User.find_by(email: 'r.holt@consent-insights.com')
team_brooklyn = Team.create!(name: "Brooklyn 99", user: raymond)

amy = User.find_by(email: 'a.santiago@consent-insights.com')
team_rookie = Team.create!(name: "The Rookie", user: amy)

properties = [
	{
		name: "Brooklyn 99",
		domain: "www.brooklyn99.com"
	},
	{
		name: "The Rookie",
		domain: "www.the-rookie.com"
	}
]

properties = Property.create(properties)

b99 = Property.find_by(name: "Brooklyn 99")
b99.permit team_brooklyn.id

tr = Property.find_by(name: "The Rookie")
tr.permit [team_brooklyn.id, team_rookie.id]

ActiveRecord::Base.record_timestamps = false

# Create sample requests data
Property.all.each do |p|

	15.times.each do |d|

		rand(300..500).times.each do
			ut = ["NEW", "RETURNING"].sample
			vi = SecureRandom.uuid
			pref = ["0:", "0,1:", "0,2:", "0,1,2:"].sample
			ua = ["Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36",
						"Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36",
						"Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Mobile Safari/537.36,gzip(gfe)"].sample
			date = rand(15.days).seconds.ago
			impression_created = false

			visit_id = Visit.all.any? ? (Visit.last.id + 1) : 1
			impression_id = Impression.all.any? ? (Impression.last.id + 1) : 1
			consent_id = Consent.all.any? ? (Consent.last.id + 1) : 1
			
			visit = Visit.insert_all!([{
				id: visit_id,
				property_id: p.id,
				country: "us",
				language: "en",
				visit_id: vi,
				user_type:ut,
				title: "",
				url: "",
				preferences: (ut === "RETURNING" ? pref : ""),
				user_agent: ua,
				created_at: date, 
				updated_at: date
			}], record_timestamps: false)

			if((ut === "RETURNING" && [0,1].sample === 1) ||
				(ut === "NEW"))
				
		    impression = Impression.insert_all!([{
		    	id: impression_id,
		    	property_id: p.id,
					country: "us",
					language: "en",
					visit_id: vi,
					user_type: ut,
					created_at: date, 
					updated_at: date
		    }],record_timestamps: false)

		    impression_created = true
			end

			if(((ut === "NEW" && [0,1].sample === 1) ||
				(ut === "RETURNING")) && impression_created)
				
		    consent = Consent.insert_all!([{
		    	id: consent_id,
		    	property_id: p.id,
					preferences: ["0:", "0,1:", "0,2:", "0,1,2:"].sample,
			    country: "us",
			    language: "en",
			    visit_id: vi,
			    user_type: ut,
					created_at: date, 
					updated_at: date
		    }], record_timestamps: false)
			end
		end
	end
end

# ActiveRecord::Base.record_timestamps = true