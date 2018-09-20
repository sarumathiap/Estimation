class StoriesDatatable
	delegate :params, :h, :link_to, :number_to_currency, to: :@view
def intialize(view)
	@view = view
end
def as_json(options = {})
	{
		sEcho: params[:sEcho].to_i,
		iTotalRecords: Story.count,
		iTotalDisplayRecords: stories.total_entries,
		aaData: data
	}
	end 
	private
	def data
		stories.map do |story|
			[
				link_to(story.name, story),
				h(story.sprint),
				h(story.estimated),
				h(story.logged)
			]
		end
	end
	def stories
		@stories ||=fetch_stories
	end
	def fetch_stories
		stories = Story.order("#{sort_column} #{sort_direction}")
		stories = stories.page(page).per_page(per_page)
		if params[:sSearch].present?
			stories = stories.where("name like :search or sprintno like :serach", search: "%#{params[:sSearch]}")
		end
		stories
	end
	def page
		params[:iDisplayStart].to_i/per_page + 1
	end

	def per_page
		params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
	end
	def sort_column
		columns = %w[name sprint estimated logged]
		columns[params[:iSortCol_0].to_i]
	end
	def sort_direction
		params[:sSortDir_0 == "desc" : "asc"]
	end
end
