class MealsController < ApplicationController
  def index
    @meal = Meal.new

    respond_to do |format|
      format.html
      format.xml
    end
  end

  def results
    @meals = Meal.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @meal = Meal.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def create
    @meal = Meal.new(params[:meal])

    respond_to do |format|
      if @meal.save
        format.html { render :action => "show", :notice => 'Your info was successfully submitted.' }
      else
        format.html { render :action => "index" }
      end
    end
  end
end
