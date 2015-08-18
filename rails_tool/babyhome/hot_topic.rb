# encoding: UTF-8
require 'time'
require 'rubygems'
require 'json'
require 'bson'
require 'mongo'
include Mongo

def mongo_link(mongo_host,mongo_port,mongo_dbname,mongo_user_name,mongo_user_pwd)
	client = MongoClient.new(mongo_host, mongo_port)
	client.add_auth(mongo_dbname, mongo_user_name, mongo_user_pwd, mongo_dbname)
	mongo_db = client[mongo_dbname]	
end

start = Time.now

mongo_db = mongo_link('192.168.26.180',27017,'les_enphants','phadmin','pw1874')
arr = Array.new(0) 

	puts "hot topic.. "
	coll = mongo_db['Baby_babythings']
	coll.find.each do |doc|
		if  doc['doc']['post_time'][0..6] == '2014-07' && doc['doc']['response'].size > 50
			puts "#{doc['doc']['title']}\t#{doc['doc']['response'].size}"
		end
	end
#File.open('out.txt','w+') do |file|
#	arr.each do |ele|
#		file.puts ele
#	end
#end
puts "Complicate : All Run #{(Time.now - start)/60} Mins"