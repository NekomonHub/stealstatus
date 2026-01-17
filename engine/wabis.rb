paths = [
  "/sdcard/WhatsApp Business/Media/.Statuses",
  "/storage/emulated/0/WhatsApp Business/Media/.Statuses",
  "/sdcard/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses",
  "/sdcard/Android/data/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses"
]

bold = "\e[1m"
green = "\e[32m"
red = "\e[31m"
yellow = "\e[33m"
reset = "\e[0m"

target = "/sdcard/StealStatusBusiness"
Dir.mkdir(target) unless Dir.exist?(target)

source = paths.find { |p| Dir.exist?(p) }

unless source
  puts "#{bold}#{red}WhatsApp Business not found#{reset}"
  exit
end

files = Dir.children(source).select { |x| x.downcase.end_with?(".jpg", ".jpeg", ".png", ".mp4", ".gif") }

if files.empty?
  puts "#{bold}#{yellow}Status not found#{reset}"
  exit
end

files.each do |file|
  from = File.join(source, file)
  to = File.join(target, file)
  File.rename(from, to) rescue nil
end

puts "#{bold}#{green}All Statuses have been moved to folder StealStatusBusiness#{reset}"
