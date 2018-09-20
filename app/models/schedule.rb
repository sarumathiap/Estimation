class Schedule < ApplicationRecord
def self.app_upd(a)
		if Schedule.find_by(id: 1).present? == true
			Schedule.update(name: a)
		else
			Schedule.create(name: a)
		end
end
end
