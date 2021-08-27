require 'csv'
require 'erb'

def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5, '0')[0..4]
end

# TODO: Implement the Google API mentioned in The Odin Project
def legislators_by_zipcode(zip)
    [["Rubio"]]
end

def save_thank_you_letter(id, form_letter)
    Dir.mkdir('output') unless Dir.exist?('output')
    filename = "output/thanks_#{id}.html"

    File.open(filename, 'w') do |file|
        file.puts form_letter
    end
end

def clean_phone_number(phone_number)
    phone_number.gsub!(/([^0-9])/, "") # Remove all none numeric values

    if phone_number.length < 10 || phone_number.length > 11
        phone_number = "0000000000"
    elsif phone_number.length == 11
        if phone_number[0] == "1"
            phone_number = phone_number[1..10]
        else
            phone_number = "0000000000"
        end
    end
    phone_number
end

def time_targeting(timestamp_list)
    sum = 0

    timestamp_list.each do |timestamp|
        time = timestamp.last.split(":")
        sum += time[0].to_i
    end

    "Peak Hour: #{(sum / timestamp_list.length).floor}:00"
end

def day_of_the_week_targeting(timestamp_list)
    sum = 0
    days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

    timestamp_list.each do |timestamp|
        date = timestamp.first.split("/")
        day = Date.new(date[2].to_i + 2000, date[0].to_i, date[1].to_i).wday
        sum += day
    end

    "Day most registered on: #{days[(sum / timestamp_list.length).floor]}"
end




puts 'Event Manager Initialized!'

contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

timestamp_list = []
contents.each do |row|
    id = row[0]
    name = row[:first_name]
    zipcode = clean_zipcode(row[:zipcode])
    legislators = legislators_by_zipcode(zipcode)

    form_letter = erb_template.result(binding)

    save_thank_you_letter(id, form_letter)

    # puts clean_phone_number(row[:homephone])

    timestamp_list.push(row[:regdate].split(" "))
end

puts time_targeting(timestamp_list)

puts day_of_the_week_targeting(timestamp_list)