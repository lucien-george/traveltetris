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
	end

	def update
		@plan = Plan.find(params[:id])
		@plan.update(plan_params)
		# @cities = params[:plan][:plan_city_ids].reject(&:blank?).map { |id| City.find(id) }
		# @plan.cities = @cities
		if @plan.save
			redirect_to plan_path(@plan)
		else
			render :edit
		end
		raise
	end

	private

	def plan_params
		params.require(:plan).permit(:city_id, plan_cities_attributes: [:id, :name])
	end
end
