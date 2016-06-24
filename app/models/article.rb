class Article < ActiveRecord::Base
	validates :title, presence: true, length: { minimum:5, maximum:30 }
	validates :description, presence: true, length: { minimum:10 }
end