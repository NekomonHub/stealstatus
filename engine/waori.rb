#!/usr/bin/env ruby
require("colorize")


paths = [
  "/sdcard/WhatsApp/Media/.Statuses",
  "/storage/emulated/0/WhatsApp/Media/.Statuses",
  "/sdcard/Android/media/com.whatsapp/WhatsApp/Media/.Statuses",
  "/sdcard/Android/data/com.whatsapp/WhatsApp/Media/.Statuses"
]

bold = "\e[1m"
green = "\e[32m"
red = "\e[31m"
yellow = "\e[33m"
reset = "\e[0m"

target = "/sdcard/StealStatus"
Dir.mkdir(target) unless Dir.exist?(target)

source = paths.find { |p| Dir.exist?(p) }

unless source
  puts "#{bold}#{red}WhatsApp not found#{reset}"
  exit
end

files = Dir.children(source).select { |x| x.downcase.end_with?(".jpg", ".jpeg", ".png", ".mp4", ".gif") }

if files.empty?
	puts "Not found Status".cyan.bold
	exit
end

files.each do |file|
  from = File.join(source, file)
  to = File.join(target, file)
  File.rename(from, to) rescue nil
end

puts "#{bold}#{green}All statuses have been moved to the folder StealStatus#{reset}"
