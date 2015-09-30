class UrlsController < ApplicationController
	def index
		@urls = Url.all
		@url = Url.new
		letters = [('a'..'z'),('A'..'Z')].map { |i| i.to_a }.flatten
		@url.unique_key = (0...8).map{ letters[rand(letters.length)] }.join
		@hostname = request.host
		@hostport = request.port
		@shortenURL = "http://"+@hostname+":"+@hostport.to_s+"/"
	end
 
	def show 
		url = Url.where(:unique_key => params[:id]).first

		if url
			url.increment!(:click_count)
			redirect_to url.original_url
		else
			render "index"
		end
	end

	def new
		@url = Url.new

		letters = [('a'..'z'),('A'..'Z')].map { |i| i.to_a }.flatten
		@url.unique_key = (0...8).map{ letters[rand(letters.length)] }.join
	end

	def create
		@url = Url.new(urls_params)
		@urls = Url.all
		@hostname = request.host
		@hostport = request.port
		@shortenURL = "http://"+@hostname+":"+@hostport.to_s+"/"

		respond_to do |format|
			if @url.save
				
				format.html { render action: "index" }
				format.json { render :json => { :urls => @urls, :shortenURL => @shortenURL } }
			else

				format.html { render action: "index" }
				format.json { render :json => { 
						:errors => @url.errors, 
						:urls => @urls, 
						:shortenURL => @shortenURL }, 
						status: :unprocessable_entity
				}
			end
		end
	end

	def update 

	end

	private
		def urls_params
			params.require(:url).permit(:original_url, :unique_key)
		end


end
