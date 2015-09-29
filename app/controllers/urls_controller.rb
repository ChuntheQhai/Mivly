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

		if @url.save
			redirect_to urls_path
		else
			render "new"
		end
	end

	private
		def urls_params
			params.require(:url).permit(:original_url, :unique_key)
		end
end
