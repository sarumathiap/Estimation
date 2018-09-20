require 'rest-client'
require 'json'
require 'base64'
require 'digest'
require 'openssl'
require 'rake'
require 'logger'
require 'parallel'
module ModulsHelper
	@mod=Modul.all
 	@epic = Epic.all
 	ga = Date.today.to_s

 	@log=Logger.new("#{Rails.root}/tmp/#{ga}.log")

def self.ad

 if Sidekiqjob.last.end_progress == "completed"
 b = Time.now.day - Time.parse(Schedule.find(1).name).day  
 yh = 	(b*24) - Time.parse(Schedule.find(1).name).hour

 if ((yh + Time.now.hour)).abs == 1 || ((yh + Time.now.hour)).abs == 0
 t1 = Time.parse(Schedule.find(1).name)
t2 = Time.now
total_seconds = (t1 - t2)

minutes = (total_seconds / 60).floor 
seconds = total_seconds.to_i % 60 

return " Updated #{minutes.abs} minute(s) ago"
  
     else
    return "Updated " + ((yh + Time.now.hour)).abs.to_s + " hours ago"    
     end
    else
    	return "updation in progress"
    end
end

def self.get_time
	data = "#{Rails.root}/config/schedule.rb"
	dat=File.read(data)
	da = dat.to_time.strftime('%H:%M')
	da
end

  	def self.revert(timeqw)
	  	data = "#{Rails.root}/config/schedule.rb"
	  	dat=File.read(data)
	    da = dat.to_time.strftime('%H:%M')
	    fdata=dat.gsub(da,timeqw)
		File.open(data,"w") {|f|
		f.write(fdata)}
	  	%x[rake jira:scheduledb]
	end


    def self.b64enc(data)
      Base64.encode64(data).gsub(/\n/, '')
    end

	def self.decrypted(secretdata)
	 	cre = Info.find_by_id(1)
        secretdata = Base64::decode64(secretdata)
        decipher = OpenSSL::Cipher::Cipher.new('AES-256-CBC')
        decipher.decrypt
        decipher.key = cre.key
        decipher.iv = cre.iv if cre.iv != nil
        decipher.update(secretdata) + decipher.final
    end
@cre = Info.find_by_id(1)
		def self.json_custom

		mutex = Mutex.new
 			logg = @log 
			@release = Release.where(name: "R22")
			logg.info Sidekiqjob.last.updateuser
			begin			
 				@release.each do |rel|
 					linkdata = Hardcode.find_by_name("versioncheck").hardcodedata.gsub("versioncheck" , rel.link)
 					@mod = Modul.where(release_id: rel.id)

					
					Parallel.each(@mod , in_processes: 21) do |f|
					

					sleep rand(0..0.5)
					mutex.synchronize { 
						puts "release name #{rel.name}"
						logg.info "release name #{rel.name}"
						@res=RestClient::Request.execute method: :get, url: "#{linkdata}#{f.jqllink}",user:decrypted(@cre.username),password: decrypted(@cre.password), accept: :json
 						
 						@response=JSON.parse(@res.body)
 							for j in 0..@response['issues'].length-1
 								issue_value = @response['issues'][j]
				  				@epic_key_id =issue_value ['key']
				 				@issue_fields=issue_value['fields'] #keys of each stories/epics 
				 				@epic_name = @issue_fields['summary']
				 				@epic_status = @issue_fields['status']['name']
				 				module_name = @issue_fields	['customfield_21603']['value']
				 				puts "epic id :#{@epic_key_id}"
				 				logg.info "epic id :#{@epic_key_id}"
				 				puts "epic name: #{@epic_name}"
				 				logg.info "epic name: #{@epic_name}"
			 					puts "epic status: #{@epic_status}"
			 					logg.info "epic status: #{@epic_status}"
			 					puts "release name #{rel.name}"
			 					logg.info "release name #{rel.name}"
			 					
			 					puts module_name
			 					logg.info module_name
 									if f.name == module_name
 										
 											
 											epic_url = Hardcode.find_by_name("epiclink").hardcodedata
 											json_story = RestClient::Request.execute method: :get, url:"#{epic_url}#{@epic_key_id}", user: decrypted(@cre.username),password: decrypted(@cre.password), accept: :json
  					  	   					json_story_parse= JSON.parse(json_story.body)
						    		   			if check_epic(@epic_name, @epic_key_id ) == true	
						  	   						epic_spent = 0
  							   						epic_esti = 0
  	   												e1 = Epic.where(modul_id: f.id , key: @epic_key_id  )
 													e1.update(status: @epic_status)
  	   													for j1 in 0..json_story_parse['issues'].size-1
   	   														issue_value1 = json_story_parse['issues'][j1]
   							   								story_key_id = issue_value1['key']
															story_name = issue_value1['fields']['summary']

																if issue_value1['fields']['assignee'] != nil
																	story_assignee1 = issue_value1['fields']['assignee']['name']
																else
																	story_assignee1 = "not.assigned"
																end
															story_status = issue_value1['fields']['status']['name']
															puts "story name: #{story_name}"
															logg.info "story name: #{story_name}"
															puts "story key: #{story_key_id}"
															logg.info "story key: #{story_key_id}"
															puts "story assignee: #{story_assignee1}"
															logg.info "story assignee: #{story_assignee1}"
															puts "story status: #{story_status}"
															logg.info "story status: #{story_status}"
															
															count = 0
															story_spent = 0
															story_esti = 0
															sto = Story.where(key: story_key_id, epic_id: e1.ids)
															sto.update(status: story_status)
																if issue_value1['fields']['subtasks'].empty?
																	puts true
																	logg.info true			
																else
																	puts false
																	logg.info false
																		issue_value1['fields']['subtasks'].each do |a|
																			count = count + 1
																			subtask_story_type =a['fields']['issuetype']['name']
																			subtask_story_name= a['fields']['summary']
																			subtask_story_key = a['key']
																			puts subtask_story_type
																			logg.info subtask_story_type
																			puts "sub task story name #{subtask_story_name}"
																			logg.info "sub task story name #{subtask_story_name}"
																			subtask_link = a['self']
																			puts subtask_link						
																			res=RestClient::Request.execute method: :get, url: subtask_link , user: decrypted(@cre.username),password: decrypted(@cre.password), accept: :json	
																			resp=JSON.parse(res.body)	
																			puts "subtask story key #{subtask_story_key}"
																			logg.info "subtask story key #{subtask_story_key}"
																			subtask_story_status = resp['fields']['parent']['fields']['status']['name']
																			puts "subtask story status: #{subtask_story_status}"
																			logg.info "subtask story status: #{subtask_story_status}" 
																			subtask_story_assignee = resp['fields']['assignee']['name']
																			puts "sub task story assignee: #{subtask_story_assignee}"
																			logg.info "sub task story assignee: #{subtask_story_assignee}"
																			subtask_story_estimate = resp['fields']['aggregatetimeoriginalestimate']
																				if subtask_story_estimate.class == NilClass
																					# esti = esti + 0
																					eos1 = 0
																					story_esti = story_esti + 0
																				else 
																					story_esti = story_esti + subtask_story_estimate
																					eos1 = subtask_story_estimate
																					# esti  = esti +  subtask_story_estimate
																				end
																			subtask_story_estimate  = calculate_time(subtask_story_estimate )
																			subtask_story_time_spent = resp['fields']['timetracking']['timeSpentSeconds']
																				if subtask_story_time_spent.class == NilClass
																					story_spent = story_spent+ 0
																					sps1 = 0
																					# spent = spent + 0
																				else 
																					story_spent = subtask_story_time_spent + story_spent
																					sps1 = subtask_story_time_spent
																					# spent = spent + subtask_story_time_spent
																				end

																				subtask_story_time_spent = calculate_time(subtask_story_time_spent)
																				puts "subtask story estimate #{subtask_story_estimate}"
																				logg.info "subtask story estimate #{subtask_story_estimate}"
																				puts "subtask story spent #{subtask_story_time_spent}"
																				logg.info "subtask story spent #{subtask_story_time_spent}"	
																				subtask_story_time_remain = time_conversion(eos1 , sps1)
																				puts "subtask story remain #{subtask_story_time_remain}"
																				logg.info "subtask story remain #{subtask_story_time_remain}"		
																				#subtask	
				    														    su = Subtask.where(story_id: sto.ids,key: subtask_story_key)
 																				su.update(logged_time: subtask_story_time_spent, remaining_time: subtask_story_time_remain, estimated_time: subtask_story_estimate,status:subtask_story_status)
						            										#end
																		end
																end   
															puts "count : #{count}"	
															puts "story_spent: #{story_spent}"
															logg.info "story_spent: #{story_spent}"
															puts "story_esti:#{story_esti}"
															logg.info "story_esti:#{story_esti}"
															time_conv_story_esti = story_esti
															time_conv_story_spent = story_spent
															time_conv_story_esti = calculate_time(time_conv_story_esti)
															time_conv_story_spent = calculate_time(time_conv_story_spent)
															time_conv_story_remain = time_conversion(story_esti,story_spent)
															puts "story_spent: #{time_conv_story_spent}"
															logg.info "story_spent: #{time_conv_story_spent}"
															puts "story_esti:#{time_conv_story_esti}"
															logg.info "story_esti:#{time_conv_story_esti}"
															puts "story_remain:#{time_conv_story_remain}"
															logg.info "story_remain:#{time_conv_story_remain}"
															epic_spent = epic_spent + story_spent
															epic_esti = epic_esti + story_esti
															#story
															sto.update(sub_task_story_estimated_time: time_conv_story_esti , sub_task_story_logged_time: time_conv_story_spent , sub_task_story_remaining_time: time_conv_story_remain)
			   	   										end		
													spent3 =epic_spent
													esti3 = epic_esti
													spent = calculate_time(epic_spent)
													esti = calculate_time(epic_esti)
													puts "epic_spent: #{spent}"
													logg.info "epic_spent: #{spent}"
   	  							 					puts "epic_esti: #{esti}"
   	  							 					logg.info "epic_esti: #{esti}"
   	   											 	remain = time_conversion(esti3,spent3)
   	   											 	puts "epic remain#{remain}"
   	   											 	logg.info "epic remain#{remain}"
   	   											 	#epic
   	   												e1.update(total_story_spent_time: spent, total_story_remaining_time: remain , total_story_estimation_time: esti)
    	   										elsif check_epic(@epic_name, @epic_key_id) == false
  	   												
  	   												epic_spent1 = 0
  	   												epic_esti1 = 0
  	  			 									e=Epic.create(name: @epic_name , status: @epic_status , key: @epic_key_id, modul_id: f.id )
   	   													for j2 in 0..json_story_parse['issues'].size-1
   	   														issue_value2 = json_story_parse['issues'][j2]						
   	   														story_key_id1 = issue_value2['key']
															story_name1 = issue_value2['fields']['summary']
																if issue_value2['fields']['assignee'] != nil
																	story_assignee1 = issue_value2['fields']['assignee']['name']
																else
																	story_assignee1 = "not.assigned"
																end
															story_status1 = issue_value2['fields']['status']['name']
															puts "story name: #{story_key_id1}"
															logg.info "story name: #{story_key_id1}"
															puts "story key: #{story_name1}"
															logg.info "story key: #{story_name1}"
															puts "story assignee: #{story_assignee1}"
															logg.info "story assignee: #{story_assignee1}"
															puts "story status: #{story_status1}"
															logg.info "story status: #{story_status1}"
															puts  issue_value2['fields']['subtasks'].class
															story_spent1 = 0
															story_esti1 = 0
															stor = Story.create(name: story_name1, key: story_key_id1, QE_assignee: story_assignee1 , status: story_status1 , epic_id: e.id)
																if issue_value2['fields']['subtasks'].empty?
																	puts true
																	logg.info true			
																else
																	puts false
																	logg.info false
																		issue_value2['fields']['subtasks'].each do |a|
																			subtask_story_type1 =a['fields']['issuetype']['name']
																			subtask_story_name1= a['fields']['summary']
																			subtask_story_key1 = a['key']
																			#if subtask_story_type1.include?("Manual Testing")
																	
																			puts subtask_story_type1
																			logg.info subtask_story_type1
																			puts "sub task story name #{subtask_story_name1}"
																			logg.info "sub task story name #{subtask_story_name1}"
																			subtask_link1 = a['self']
																						
																			res1=RestClient::Request.execute method: :get, url: subtask_link1 , user: decrypted(@cre.username),password: decrypted(@cre.password), accept: :json	
																			resp1=JSON.parse(res1.body)	
																			puts "subtask story key #{subtask_story_key1}"
																			logg.info "subtask story key #{subtask_story_key1}"
																			subtask_story_status1 = resp1['fields']['parent']['fields']['status']['name']
																			puts "subtask story status: #{subtask_story_status1}"
																			logg.info "subtask story status: #{subtask_story_status1}"
																			subtask_story_assignee1 = resp1['fields']['assignee']['name']
																			puts "sub task story assignee: #{subtask_story_assignee1}"
																			logg.info "sub task story assignee: #{subtask_story_assignee1}"
																			subtask_story_estimate1 = resp1['fields']['aggregatetimeoriginalestimate']
																				if subtask_story_estimate1.class == NilClass
																					#esti1 = esti1 + 0
																					story_esti1 = story_esti1 + 0
																					eos = 0
																				else 
																					eos = subtask_story_estimate1
																					story_esti1 = story_esti1 + subtask_story_estimate1
																				end
																			subtask_story_estimate1  = calculate_time(subtask_story_estimate1 )
																			subtask_story_time_spent1 = resp1['fields']['timetracking']['timeSpentSeconds']
																				if subtask_story_time_spent1.class == NilClass
																					sps = 0
																					story_spent1 = story_spent1+ 0
																				else 
																					sps = subtask_story_time_spent1
																					story_spent1 = story_spent1 + subtask_story_time_spent1
																				end

																			subtask_story_time_spent1 = calculate_time(subtask_story_time_spent1)
																			puts "subtask story estimate #{subtask_story_estimate1}"
																			logg.info "subtask story estimate #{subtask_story_estimate1}"
																			puts "subtask story spent #{subtask_story_time_spent1}"	
																			logg.info "subtask story spent #{subtask_story_time_spent1}"	
																			subtask_story_time_remain1 = time_conversion(eos , sps)
																			puts "subtask story remain #{subtask_story_time_remain1}"
																			logg.info "subtask story remain #{subtask_story_time_remain1}"																							
				    							  		 			    	subtask_create = Subtask.create(name:subtask_story_name1 , key: subtask_story_key1  ,status: subtask_story_status1 ,assignee: subtask_story_assignee1,logged_time: subtask_story_time_spent1, remaining_time:subtask_story_time_remain1 , estimated_time:subtask_story_estimate1 ,issuetype: subtask_story_type1 ,story_id: stor.id)
				    							 			               #end
																		end
																end
															puts "story_spent: #{story_spent1}"
															logg.info "story_spent: #{story_spent1}"
															puts "story_esti:#{story_esti1}"
															logg.info "story_esti:#{story_esti1}"
															time_conv_story_esti1 = story_esti1
															time_conv_story_spent1 = story_spent1
															time_conv_story_esti1 = calculate_time(time_conv_story_esti1)
															time_conv_story_spent1 = calculate_time(time_conv_story_spent1)
															time_conv_story_remain1 = time_conversion(story_esti1,story_spent1)
															puts "story_spent: #{time_conv_story_spent1}"
															logg.info "story_spent: #{time_conv_story_spent1}"
															puts "story_esti:#{time_conv_story_esti1}"
															logg.info "story_esti:#{time_conv_story_esti1}"
															puts "story_remain:#{time_conv_story_remain1}"
															logg.info "story_remain:#{time_conv_story_remain1}"
															epic_spent1 = epic_spent1 + story_spent1
															epic_esti1 = epic_esti1 + story_esti1
															#story
															stor.update(sub_task_story_estimated_time: time_conv_story_esti1, sub_task_story_logged_time:time_conv_story_spent1,sub_task_story_remaining_time:time_conv_story_remain1)												
														end	
													spent2 =epic_spent1
													esti2 = epic_esti1
													spent1 = calculate_time(epic_spent1)
													esti1 = calculate_time(epic_esti1)
													puts "epic_spent: #{spent1}"
													logg.info "epic_spent: #{spent1}"
   	   												puts "epic_esti: #{esti1}"
   	   												logg.info "epic_esti: #{esti1}"
   	   								 				remain1 = time_conversion(esti2,spent2)
   	  				 				 				puts "epic remain#{remain1}"
   	  				 				 				logg.info "epic remain#{remain1}"
   	   												e.update(total_story_spent_time: spent1, total_story_remaining_time: remain1 , total_story_estimation_time: esti1 )

   							 	   				else
    	   											nil
    	   										end
    	   								
 											
 									end
 						end
 					}
 					sleep rand(0..0.5)
 					end
 					ActiveRecord::Base.connection.reconnect!
				end
		rescue => e
			 logg.error "some error is found "
			 logg.error e
			 logg.error e.backtrace

		end
		ActiveRecord::Base.connection.reconnect!
		logg.close

		
		
	end
			
   		def self.check_epic(epic_name,epic_key)
  		if @epic.exists?(name: epic_name,key: epic_key) 
  			true
  		elsif !@epic.exists?(name: epic_name,key: epic_key)
  			false
  		else	
  			nil
  		end
  		end
  		def self.calculate_time(time)

 			time1= ActiveSupport::Duration.build(time).parts
 			
			if time1.key?(:months)
				month = time1[:months] * 30
				wee = time1[:weeks] * 7
				da = month+wee+time1[:days]
				t = da*24+time1[:hours]+10
				mi = time1[:minutes] + 30
				if mi >= 60
					mi = mi - 60
					t = t + 1

				end


				return t.to_s+ ":" +mi.to_s
			elsif time1.key?(:weeks)
				week=time1[:weeks]*7
				day = time1[:days]+ week
				t= day*24+time1[:hours]
				return t.to_s+ ":" +time1[:minutes].to_s
  			elsif time1.key?(:days)
        		t = time1[:days]*24+time1[:hours]
        		return t.to_s+ ":" +time1[:minutes].to_s
      		else
       			return time1[:hours].to_s+ ':'+time1[:minutes].to_s
			end
		
 		end
 		def self.hours_mins(data)
 			
 				h = data.split(':')[0].concat('h')
 				m = data.split(':')[1].concat('m')
				fd = h+" "+m
			
			

			if fd.include?(" 0m")
			return h
			elsif fd=="0h"
				return m
			elsif fd.include?("0h ")
				fi = fd.split(' ')[0]
				se = fd.split(' ')[1]
				if fi == "0h"
					return m
				else
					return fd
				end
			else
				return fd
			end
			
		end 

	def indicator(e,l)
		
		ew =e.gsub(':' , ".").to_f 
		sa = l.gsub(':' , ".").to_f
     if ew < sa
       return 0
     elsif ew == sa
     	1
     	else
     		2
    end

	end


	def self.time_conversion(estimated , spend)

if estimated > spend
		time = ActiveSupport::Duration.build(estimated - spend).parts
 			
 			
			if time.key?(:months)
				month = time[:months] * 30
				wee = time[:weeks] * 7
				da = month+wee+time[:days]
				t = da*24+time[:hours] + 10
					k = time1[:minutes] + 30
				if k >= 60
					k = k - 60
					t = t + 1
				end
				return t.to_s+ ":" + k.to_s
			elsif time.key?(:weeks)
				week=time[:weeks]*7
				day = time[:days]+ week
				t= day*24+time[:hours]
				return t.to_s+ ":" +time[:minutes].to_s
  			elsif time.key?(:days)
        		t = time[:days]*24+time[:hours]
        		return t.to_s+ ":" +time[:minutes].to_s
      		else
       			return time[:hours].to_s+ ':'+time[:minutes].to_s
			end
 		else
 			time = ActiveSupport::Duration.build(spend - estimated).parts
 			
 			if time.key?(:months)
				month = time[:months] * 30
				wee = time[:weeks] * 7
				da = month+wee+time[:days]
				t = da*24+time[:hours] + 10
					k = time1[:minutes] + 30
				if k >= 60
					k = k - 60
					t = t + 1
				end
				return t.to_s+ ":" + k.to_s
			elsif time.key?(:weeks)
				week=time[:weeks]*7
				day = time[:days]+ week
				t= day*24+time[:hours]
				return t.to_s+ ":" +time[:minutes].to_s
  			elsif time.key?(:days)
        		t = time[:days]*24+time[:hours]
        		return t.to_s+ ":" +time[:minutes].to_s
      		else
       			return time[:hours].to_s+ ':'+time[:minutes].to_s
			end
 		end
	end

	def column(col)
		io=[]
		col.each do|qw| 
			if qw == nil
				io << 0
			else
     		a=qw.split(":")[0].to_i
    		b=qw.split(":")[1].to_i
     		io<< (a*3600)+(b*60)
     	end
   		end  
   		io
	end

	def graph_time(timed)
		timed = timed.abs
		time1= ActiveSupport::Duration.build(timed).parts
			if time1.key?(:months)
				month = time1[:months] * 30
				wee = time1[:weeks] * 7
				da = month+wee+time1[:days]
				t = da*24+time1[:hours] + 10
				k = time1[:minutes] + 30
				if k >= 60
					k = k - 60
					t = t + 1
				end
				return t.to_s+ "." +k.to_s
			elsif time1.key?(:weeks)
				week=time1[:weeks]*7
				day = time1[:days]+ week
				t= day*24+time1[:hours]
				return t.to_s+ "." +time1[:minutes].to_s
  			elsif time1.key?(:days)
        		t = time1[:days]*24+time1[:hours]
        		return t.to_s+ "." +time1[:minutes].to_s
      		else
       			return time1[:hours].to_s+ '.'+time1[:minutes].to_s
			end
	end


def self.checkrecords
		llogger=Logger.new("#{Rails.root}/tmp/record.log")
		mod=Modul.where(release_id: 1)
		mod.each do |m|
			puts m.jqllink
		
		res=RestClient::Request.execute method: :get, url:"https://coupadev.atlassian.net/rest/api/2/search?jql=Project%20in%20(CD)%20AND%20(affectedVersion%20in%20(v22.0.0)%20AND%20'Target%20Release'%20is%20EMPTY%20OR%20'Target%20Release'%20in%20(v22.0.0))%20AND%20issuetype%20%3D%20Epic%20AND%20'Dev%20Team'%20%3D%20#{m.jqllink}" ,user:decrypted(@cre.username),password: decrypted(@cre.password), accept: :json
		dev=JSON.parse(res.body)
			for j in 0..dev['issues'].length-1	
				issue_value = dev['issues'][j]
				epic_key_id =issue_value ['key']
				unless Epic.where(modul_id: m.id).exists?(key:epic_key_id)
					# puts "epic not exist #{epic_key_id}"
					llogger.info "epic not exist #{epic_key_id}"
				else
					puts "epic key #{epic_key_id}"
					epicrecord = Epic.find_by(key: epic_key_id)
					story = RestClient::Request.execute method: :get, url:"https://coupadev.atlassian.net/rest/api/2/search?jql=project%20%3D%20CD%20AND%20issuetype%20%3D%20Story%20AND%20'Epic%20Link'%20%3D#{epic_key_id}", user: decrypted(@cre.username),password: decrypted(@cre.password), accept: :json
					story_parse= JSON.parse(story.body)

						for j1 in 0..story_parse['issues'].size-1
							issue_value1 = story_parse['issues'][j1]
   							story_key_id = issue_value1['key']
   							storyrecord = Story.find_by(key: story_key_id)
   							unless Story.where(epic_id: epicrecord.id).exists?(key: story_key_id)
   								 # puts "story not present #{story_key_id}"
   								 llogger.info"story not present #{story_key_id}"
   							else
   								puts "story key #{story_key_id}"
   								issue_value1['fields']['subtasks'].each do |a|
   									subtask_story_key = a['key']
   									unless Subtask.where(story_id: storyrecord.id).exists?(key: subtask_story_key)
   										# puts "subtask not present #{subtask_story_key}" 
   										llogger.info"subtask not present #{subtask_story_key}"
   									end
									
   								end
   							end
						end
				end
				
			end	
		end

	end
end