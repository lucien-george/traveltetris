class PlansController < ApplicationController

	def new
		@plan = Plan.new
	end

	def create
		@plan = Plan.new(plan_params)
		@plan.user = current_user
		if @plan.save
			redirect_to edit_plan_path(@plan)
		else
			render :new
		end
	end

	def edit
		@plan = Plan.find(params[:id])
		@plan.plan_cities.build().build_city
		@trip_date = TripDate.new
	end

	def update
		@plan = Plan.find(params[:id])
		if params[:plan]
			@cities = params[:plan][:city_ids].reject(&:blank?).map { |id| City.find(id) }
			@plan.cities = @cities
		end
		if params[:trip_dates]
			start_dates = params[:trip_dates][:start_dates]
			end_dates = params[:trip_dates][:end_dates]
			start_dates.count.times do |c|
				departure_date = start_dates[c].values.map { |v| v.rjust(2,'0')  }.join
				arrival_date = end_dates[c].values.map { |v| v.rjust(2,'0')  }.join
				TripDate.create(plan: @plan, departure_date: departure_date, arrival_date: arrival_date)
			end
		end
		if @plan.save
			if @plan.cities.any? && @plan.trip_dates.any?
				redirect_to plan_path(@plan)
			else
				redirect_to edit_plan_path(@plan)
			end
		else
			render :edit
		end
	end

	private

	def plan_params
		params.require(:plan).permit(:city_id)
	end
end
