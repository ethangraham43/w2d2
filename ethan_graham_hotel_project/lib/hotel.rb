require_relative "room"

class Hotel
    def initialize(name, hash)
        @name = name
        @rooms = {}
        hash.each do |k, v|
            @rooms[k] = Room.new(v)
        end
    end 

    def name
        new_name = @name.split(" ").map {|word| word[0].upcase + word[1..-1]}
        new_name.join(" ")
    end

    def rooms
        @rooms
    end

    def room_exists?(str)
        if @rooms.has_key?(str)
            return true
        else
            return false
        end
    end

    def check_in(person, room)
        if self.room_exists?(room)
            if @rooms[room].add_occupant(person)
                p "check in successful"
            else
                p "sorry, room is full"
            end
        else
            p "sorry, room does not exist"
        end
    end

    def has_vacancy?
        @rooms.values.each do |room|
            if room.available_space > 0
                return true
            else
                return false
            end
        end
    end

    def list_rooms
        @rooms.each do |name, room|
            p "#{name}.*#{room.available_space}"
        end
    end
end

