namespace :jira do
  desc "TODO"
  task scheduledb: :environment do
  	sh "whenever --update --crontab"
  end

end
