class EventsController < ApplicationController

	def index
		if params[:date] != nil && params[:date] != ""
 			@events = Event.where(:date => params[:date])
 		else
 			@events = Event.all
 		end
	end


	def new
		@venue = Venue.find(params[:venue_id])
		@event = Event.new
		if @venue[:family_friendly]
			@bands = Band.where(:explicit_lyrics => false)
		else
			@bands = Band.all
		end
	end

	def create		

		@eventFind = Event.where(:date => params[:event][:date])
		if @eventFind.length == 0
			@event = Event.create(event_params)
			redirect_to venues_path
		else
			redirect_to new_venue_event_path
		end

	end

  	def show
  		@event = Event.find(params[:id])

  	end

private

    def event_params
      params.require(:event).permit(:date, :alcohol_served,:band_id).merge({venue_id: params[:venue_id]})
    end

end
