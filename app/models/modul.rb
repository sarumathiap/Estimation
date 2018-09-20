class Modul < ApplicationRecord
	has_many :epics
	def self.database_updation
		if Sidekiqjob.last.end_progress == "completed"
			Rails.logger.debug("updation starts at: #{Time.now}")
			puts ("updation starts at: #{Time.now}")
			ModulsHelper.json_custom
			Rails.logger.debug("updation ends at: #{Time.now}")

		else
			Rails.logger.debug("job is already running")
			puts ("job is already running")
		end
	end
	
end
