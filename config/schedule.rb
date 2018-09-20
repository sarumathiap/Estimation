set :environment, :development
every 1.day, at: "00:35" do
  	runner "Modul.database_updation" , output: {:error => "#{path}/log/error.log", standard: "#{path}/log/cron.log"}
  	runner "Schedule.app_upd(Time.now)" , output: {:error => "#{path}/log/error.log", standard: "#{path}/log/cron.log"}  
end
