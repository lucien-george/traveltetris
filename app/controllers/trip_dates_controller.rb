class TripDatesController < ApplicationController
	def new
		@plan = Plan.find(params[:plan_id])
		@trip_date = TripDate.new
	end

	def create
		@plan = Plan.find(params[:plan_id])
		@trip_date = TripDate.new(trip_dates_params)
		@trip_date.plan = @plan
		if @trip_date.save
			redirect_to plan_path(@plan)
		else
			render :new
		end
		raise
	end

	private

	def trip_dates_params
		params.require(:trip_date).permit(:arrival_date, :departure_date)
	end
end
