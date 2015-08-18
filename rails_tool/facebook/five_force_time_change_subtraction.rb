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
mongo_db = mongo_link('192.168.26.180',27017,'DA_kaogaau','phadmin','pw1874')
coll = mongo_db['time_change_2014']

coll.find.each do |doc|	
	user = Array.new()
	post = Array.new()
	comment = Array.new()
	share = Array.new()
	doc['count'].each do |k,v|
		user << v['user']
		post << v['post']
		comment << v['comment']
		share << v['share']
	end
	user_sub = Array.new()
	post_sub = Array.new()
	comment_sub = Array.new()
	share_sub = Array.new()
	share.each_with_index do |ele,index|
		if index > 0
			if share[index] == 0
				share[index] = 1
			end
			share_sub <<  (share[index] - share[index-1])*100 / share[index]
		end
	end
	p share_sub
end



	
#mongo_db = mongo_link('192.168.26.180',27017,'DA_kaogaau','phadmin','pw1874')
#coll = mongo_db['time_change_subtraction_2014']
#puts "insert mongo.."
#coll.insert(hash)	

puts 'complicate'