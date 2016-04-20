class Letter
    attr_reader :letter, :id
    attr_accessor :incidence

    def initialize(letter, num_incidence, id_group)
        @letter = letter
        @incidence = num_incidence
        @id = id_group
    end

    def incidences(num_incidence)
        @incidence = num_incidence + 1
    end
end

class ManagerString

    attr_reader :letters

    def cifrate_string(data, key)
    
    end

    def decipher_string(data_cifrate)
        letters_array = []
        [*2..10].each{ |index_group|
            groups = data_cifrate.split("").each_slice(index_group).to_a
            joined_groups = groups.map {|group| group.join("")}
            joined_groups.each_with_index do |group, index|
                obj_letter = locate({letter: group}, letters_array)
                if obj_letter.nil?
                    letters_array.push Letter.new(group, 1, index % index_group) 
                else
                    obj_letter.incidences(obj_letter.incidence)
                end
            end
            break
        }
        @letters = letters_array
        letters_array
    end

    def locate(data, letters_array)
        letter = letters_array.select { |letter| letter.send(:letter) == data[:letter] }.first if !letters_array.nil?
        letter
    end

    def conver_hex(data)
        data_hex = ''
        data.chars do |chr| 
            data_hex = data_hex + "%02X" % [chr.ord]
        end
        data_hex
    end
end

obj_manager_string = ManagerString.new
a = 'SIWWUQUKUUWSSIWWUQARUDCQTICYEF IJBBERNTRDMBPGSBWVAHGZIUJRUUVKETRDM'
a = obj_manager_string.conver_hex(a)
puts a
obj_manager_string.decipher_string(a)
p obj_manager_string.letters

