## Miercoles 15 de Junio del 2016
## CSV
## HSP y MRM


require 'faker'
require 'csv'
require 'date'

class Person 
  attr_accessor :first_name, :last_name, :email, :phone, :created_at

  def initialize(first_name, last_name, email, phone, created_at)
    @first_name = first_name
    @last_name =  last_name
    @email = email
    @phone = phone
    @created_at = created_at
  end

  def self.faker(num_de_personas)
    array = []  
    num_de_personas.times do |i|
      first_name = Faker::Name.first_name 
      last_name =  Faker::Name.last_name 
      email = Faker::Internet.email 
      phone = Faker::PhoneNumber.cell_phone 
      created_at = Time.now
      array <<  Person.new(first_name, last_name, email, phone, created_at)
    end
     p array 
  end

end


class PersonWriter
  def initialize(file_name, people)
    @file_name = file_name
    @people = people
  end

  def create_csv
      CSV.open(@file_name, "wb") do |csv|
        @people.each do |person|
          csv << [person.first_name, person.last_name, person.email, person.phone , person.created_at]
        end 
      end
  end 
end

class PersonParser

  def initialize(file_name)
    @file_name = file_name
  end

  def people
    arreglo = []
    CSV.foreach(@file_name) do |row|

     arreglo << Person.new(row[0], row[1], row[2], row[3], DateTime.parse(row[4]))
    end
   p arreglo
  end
 
end



people = Person.faker(5)

person_writer = PersonWriter.new("people.csv", people)
person_writer.create_csv

parser = PersonParser.new('people.csv')
people = parser.people

