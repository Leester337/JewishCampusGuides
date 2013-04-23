class EventCreatorsController < ApplicationController
  # GET /event_creators
  # GET /event_creators.json
  def index
    @event_creators = EventCreator.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @event_creators }
    end
  end

  # GET /event_creators/1
  # GET /event_creators/1.json
  def show
    @event_creator = EventCreator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_creator }
    end
  end

  # GET /event_creators/new
  # GET /event_creators/new.json
  def new
    @event_creator = EventCreator.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_creator }
    end
  end

  # GET /event_creators/1/edit
  def edit
    @event_creator = EventCreator.find(params[:id])
  end

  # POST /event_creators
  # POST /event_creators.json
  def create
    @event_creator = EventCreator.new(params[:event_creator])

    respond_to do |format|
      if @event_creator.save
        format.html { redirect_to @event_creator, notice: 'Event creator was successfully created.' }
        format.json { render json: @event_creator, status: :created, location: @event_creator }
      else
        format.html { render action: "new" }
        format.json { render json: @event_creator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /event_creators/1
  # PUT /event_creators/1.json
  def update
    @event_creator = EventCreator.find(params[:id])

    respond_to do |format|
      if @event_creator.update_attributes(params[:event_creator])
        format.html { redirect_to @event_creator, notice: 'Event creator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event_creator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_creators/1
  # DELETE /event_creators/1.json
  def destroy
    @event_creator = EventCreator.find(params[:id])
    @event_creator.destroy

    respond_to do |format|
      format.html { redirect_to event_creators_url }
      format.json { head :no_content }
    end
  end
end
