class Tweet < ActiveRecord::Base
	include Twitter::Extractor 

	def yolo
		self.extract_hashtags(self.content)
	end 

	belongs_to:user
	validates :content, length: { maximum: 140 } 

	validate :hashtags_are_created


	def hashtags_are_created

		begin 
			transaction do 
				@hashtags = self.get_hashtags 

				@hashtags.each do |the_hashtag|
					if Hashtag.where(tag: the_hashtag).any?

					else
						if Hashtag.create!(tag: the_hashtag) 
						else 
							self.errors.add(:base, "your hashtag {#{the_hashtag} cannot be created")
						end

					end
				end 
			end
		rescue
			self.errors.add(:base, "your hashtag could not be created")
		end
	end 
end	
