class UrlsController < ApplicationController
	def index
		@urls = Url.all
		@url = Url.new
		get_url_unique_key
		get_shortener_url
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
	end

	def create
		@url = Url.new(urls_params)
		@urls = Url.all
		get_shortener_url


		respond_to do |format|
			#If the URL is valid, it will 
			if @url.save
				# Create full links for URL Shortener
				@url_uniquekey = @url.unique_key
				@shortedURL = @shortenURL + @url_uniquekey

				# Output with json and return 200 means success
				format.html { render action: "_list" }
				format.json { render :json => { 
						:status => 200,
						:urls => @urls, 
						:shortenURL => @shortenURL,
						:shortedURL => @shortedURL,
						:url => @url } 
				}
			else
				#Output with json and retun -1 which indicate failure
				format.html { render action: "_list" }
				format.json { render :json => { 
						:status => -1,
						:errors => @url.errors, 
						:urls => @urls, 
						:shortenURL => @shortenURL }, 
						status: :unprocessable_entity
				}
			end
		end
	end

	def show_partial
		@urls = Url.all
		@url = Url.new
		get_shortener_url
	end

	def _form
		@url = Url.new
	end

	def update 

	end

	private
		def urls_params
			params.require(:url).permit(:original_url, :unique_key)
		end

		def get_url_unique_key
			letters = [('a'..'z'),('A'..'Z')].map { |i| i.to_a }.flatten
			@url.unique_key = (0...8).map{ letters[rand(letters.length)] }.join
		end

		def get_shortener_url
			@hostname = request.host
			@hostport = request.port
			@shortenURL = "http://"+@hostname+":"+@hostport.to_s+"/"
		end


end
