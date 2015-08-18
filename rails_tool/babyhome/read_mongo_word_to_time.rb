# encoding: UTF-8
require 'time'
require 'rubygems'
require 'json'
require 'bson'
require 'mongo'
include Mongo

MONGODB_HOST = '192.168.26.180'
MONGODB_PORT = 27017
MONGODB_DBNAME = 'les_enphants'
MONGODB_USER_NAME = 'phadmin'
MONGODB_USER_PWD = 'pw1874'
client = MongoClient.new(MONGODB_HOST, MONGODB_PORT)
client.add_auth(MONGODB_DBNAME, MONGODB_USER_NAME, MONGODB_USER_PWD, MONGODB_DBNAME)
mongo_db = client[MONGODB_DBNAME]
coll = mongo_db['Baby_babythings']
hash = Hash.new(0)
File.open('year.txt','r') do |file|
	file.each do |line|
		line = line.chomp
		hash[line] = 0
	end
end
coll.find.each do |doc|
	if doc['doc']['post_content'] != nil
		con = doc['doc']['post_content'] 
		if /mothercare/.match(con) != nil && doc['doc']['post_time'] != nil  &&  doc['doc']['post_time'].size > 9 
			time = doc['doc']['post_time'][0..3]
			if hash.has_key?(time)
				hash[time] += 1
			end
		end
	end
=begin
	doc['doc']['response'].each do |k,v|
		con = v['response_content']
		if /mothercare/.match(con) != nil  &&  v['response_time'] != nil  &&   v['response_time'].size > 9 
			time = v['response_time'][0..3]
			if hash.has_key?(time)
				hash[time] += 1
			end
		end
	end
=end	
end
File.open('out/mothercare_year.txt','w+') do |out|
	hash.each do |k,v|
		out.puts "#{v}"
	end
end
puts 'complicate'