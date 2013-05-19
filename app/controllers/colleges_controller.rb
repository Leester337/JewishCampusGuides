class CollegesController < ApplicationController
  helper :all
  # GET /colleges
  # GET /colleges.json
  def index
    @colleges = College.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @colleges }
    end
  end


  # GET /colleges/UIUC
  # GET /colleges/1.json
  def show
    @college = College.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @college }
    end
  end

  # GET /colleges/new
  # GET /colleges/new.json
  def new
    @college = College.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @college }
    end
  end

  # GET /colleges/UIUC/edit
  def edit
    @college = College.find(params[:id])
  end

  # POST /colleges
  # POST /colleges.json
  def create
    @college = College.new(params[:college])

    respond_to do |format|
      if @college.save
        format.html { redirect_to @college, notice: 'College was successfully created.' }
        format.json { render json: @college, status: :created, location: @college }
      else
        format.html { render action: "new" }
        format.json { render json: @college.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /colleges/UIUC
  # PUT /colleges/1.json
  def update
    @college = College.find(params[:id])

    respond_to do |format|
      if @college.update_attributes(params[:college])
        format.html { redirect_to @college, notice: 'College was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @college.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colleges/UIUC
  # DELETE /colleges/1.json
  def destroy
    @college = College.find(params[:id])
    @college.destroy

    respond_to do |format|
      format.html { redirect_to colleges_url }
      format.json { head :no_content }
    end
  end

  private
  def current_user
    @current_user ||= ProspectiveStudent.find(session[:user_id]) if session[:user_id]
  end
  #helper_method :current_user
end
