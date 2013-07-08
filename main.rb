require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'sinatra/activerecord'
require 'sunlight'

Sunlight::Base.api_key = '035fbbb591aa4fdba299e64c0d9e867c'

#Before I enter db:create migration in terminal prompt I have to include the SET info as shown below.
set :database, {
  adapter: 'postgresql',
  database: 'sunlight',
  host: 'localhost'
}
#After I enter db:create migration in terminal, I have to click on the newly created db folder on the sidebar and fill out the file def up and def down (this creates allows ability to create and delete the database.)

#Step 3 is to write sentence below which allows ActiveRecord to interact with the politicians table.

class Politician < ActiveRecord::Base
end


get '/' do
  erb :home
end

get '/legislator_by_zipcode' do
  zipcode = params[:zip_code]
  @politicians = Sunlight::Legislator.all_in_zipcode(zipcode)
  erb :legislator_by_zipcode
end

post '/favorite' do
  bioguide_id = params[:favorite]
  individual = Sunlight::Legislator.all_where(:bioguide_id => bioguide_id).first
  # db = PG.connect(dbname: 'sunlight', host: 'localhost')
  # sql = "INSERT INTO politicians (first, last, party, phone, state, twitter_id) VALUES ('#{individual.firstname}', '#{individual.lastname}', '#{individual.party}', '#{individual.phone}', '#{individual.state}', '#{individual.twitter_id}')"
  # db.exec(sql)
  # db.close
  Politician.create({first: individual.firstname, last:individual.lastname, party:individual.party, phone:individual.phone, state:individual.state, twitter_id:individual.twitter_id})

  # Option 1 --> params[:politician] = {name:"Joe", age:23}
  #              Politicians.create(params[:politician])

  # Option 2 --> Politicians.create({name:"Joe", age:23})

  # Option 3 --> p1 = Politicians.new()
  #              p1.name = "Joe"
  #              p1.age = 23
  #              p1.save

  redirect to('/favorite')
end

get '/favorite' do
  # db = PG.connect(dbname: 'sunlight', host: 'localhost')
  # sql ="SELECT * FROM politicians "
  # @fav_legislator_description = db.exec(sql)
  # db.close
  @fav_legislator_description = Politician.all
  erb :favorite
end

#Politicians.all ---> gives you all the rows
#Politicians.find(id) ---> gives you a specific row in db



