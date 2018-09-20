class Dbupdater
	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform(name)
		side = Sidekiqjob.last
		side.update(jobid: self.jid , start_progess: "started" , updateuser: name, end_progress: nil)
		ModulsHelper.json_custom
		Schedule.app_upd(Time.now)
		side.update(end_progress: "completed")
	end
end
