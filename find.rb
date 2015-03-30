require "rubygems"
require "opencv"
require "tts"
include OpenCV

request = String.new

def responses( request )

	case request

		when "yes"
			'Ok, tsar, what do you want?'.play
			request = get_request
		when "no"
			'Ok, csar, farewell'.play
			exit
		when "how many figures do you see?"
			how_many
	end
end


def get_request

	request = ""
	request = gets.chomp
	responses( request )	
end


def how_many

	original_window = GUI::Window.new "original"
	hough_window = GUI::Window.new "finding circles"

	image = IplImage::load "./stuff.jpg"
	gray = image.BGR2GRAY

	result = image.clone
	original_window.show image
	detect = gray.hough_circles(CV_HOUGH_GRADIENT, 2.0, 10, 200, 50)

	puts number = detect.size

	detect.each do |circle|

		puts "#{circle.center.x},#{circle.center.y} - #{circle.radius}"
		result.circle! circle.center, circle.radius, :color => CvColor::Blue, :thickness => 3
	end

	"There are #{number} circles on this image.".play

	hough_window.show result
	GUI::wait_key	
end

"Hello. Can I do something for you?".play
get_request



