require "rubygems"
require "opencv"
require "tts"
include OpenCV

request = String.new

def responses( request )

	"I'm in responses-method".play
	puts request
	
	case request

		when request == "yes" 
			"Ok, boss, what do you want?".play
			get_request

		when "no"
			"Ok, boss, but let me do something for you".play
	end
end


"Hello. Can I do something for you?".play
request = gets
responses( request )


original_window = GUI::Window.new "original"
hough_window = GUI::Window.new "finding circles"

image = IplImage::load "./circles.jpg"
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