# encoding: UTF-8
require 'time'
require 'rubygems'
require 'json'
require 'bson'
require 'mongo'
include Mongo


fb = {'麗嬰房 媽咪同學會'=>'209251989898','奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}
fb_count = Hash.new { |k,v| fb_count[v] = Hash.new(0) }
def mongo_link(mongo_host,mongo_port,mongo_dbname,mongo_user_name,mongo_user_pwd)
	client = MongoClient.new(mongo_host, mongo_port)
	client.add_auth(mongo_dbname, mongo_user_name, mongo_user_pwd, mongo_dbname)
	mongo_db = client[mongo_dbname]	
end

start = Time.now

mongo_db = mongo_link('192.168.26.180',27017,'fb_beta','ob','star2474')

fb.each do |fb_name,fb_id|
	puts "five_forces_model.. : #{fb_name}"
	coll = mongo_db['statistics']
	coll.find.each do |doc|
		if doc['page_id'] == fb_id && doc['year'] == 2013
			fb_count[fb_name]['user'] = fb_count[fb_name]['user'] + doc['user_count']
			fb_count[fb_name]['post'] = fb_count[fb_name]['post'] + doc['post_count']
			fb_count[fb_name]['comment'] = fb_count[fb_name]['comment'] +	doc['comment_count']
			fb_count[fb_name]['share'] = fb_count[fb_name]['share'] +	doc['share_count']		
		end
	end
	coll = mongo_db['likes']
	coll.find.each do |doc|
		if doc['page_id'] == fb_id
			fb_count[fb_name]['like'] = fb_count[fb_name]['like'] + doc['count']
		end
	end
end

mongo_db = mongo_link('192.168.26.180',27017,'DA_kaogaau','phadmin','pw1874')
coll = mongo_db['five_forces_model_2013']

puts "insert mongo.."
fb_count.each do |fb_name,count_hash|
	hash = Hash.new(0)
	hash['fb_name'] = fb_name
	hash['user'] = count_hash['user']
	hash['post'] = count_hash['post']
	hash['comment'] = count_hash['comment']
	hash['share'] = count_hash['share']
	hash['like'] = count_hash['like']
	coll.insert(hash)	
end


puts "Complicate : All Run #{(Time.now - start)/60} Mins"

=begin
	puts "#{fb_name}"
	puts "user : #{fb_count[fb_name]count['user']}"
	puts "post : #{fb_count[fb_name]count['post']}"
	puts "comment : #{fb_count[fb_name]count['comment']}"
	puts "share : #{fb_count[fb_name]count['share']}"
	puts "like : #{fb_count[fb_name]count['like']}"
=end