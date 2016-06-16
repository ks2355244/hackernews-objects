# Start coding your hackernews scraper here!
require 'nokogiri'
require 'open-uri'
	
class Post
	attr_reader :title, :url, :points, :item_id, :comment
	def initialize(details={})
			@title = details[:title]
			@url = details[:url]
			@points = details[:points]
			@item_id = details[:item_id]
			@comment = []
	end
	def comments
			@comment.each {|comment| puts comment.user + ":" + comment.text}
	end
	def add_comment(comment)
			@comment << comment
	
	
	end
end
	
class Comment
	attr_reader :user, :text
		def initialize(user,text)
			@user = user
			@text = text
		end
end
	
	input=ARGV
	file = Nokogiri::HTML(open(input[0]))
	post = Post.new(title: file.css('title').first.text, url:file.css('a[href^="from"]')[0].text, points:file.css('span[class^="score"]').text, item_id:file.css('a[href^="item?id"]')[0]['href'])
	comment_text = file.css('span[class^="comment"]')
	user_text = file.css('a[href^="user?id"]')
	comment_text.to_a.each_index do |index|
		post.add_comment(Comment.new(user_text[index].text,comment_text[index].text))
	end
puts "Title:" + post.title
puts "Url: " + post.url
puts "Points: " + post.points
puts "Item id: " + post.item_id
puts "Number of Comments:" + post.comment.length.to_s
