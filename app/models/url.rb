class Url < ActiveRecord::Base
	validates :original_url, :url => true
end
