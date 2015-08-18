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


fb = {'麗嬰房 媽咪同學會'=>'209251989898','奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}


fb.each do |fb_name,fb_id|
	mongo_db = mongo_link('192.168.26.180',27017,'fb_beta','ob','star2474')
	coll = mongo_db['statistics']
	count = {'2014-1'=>Hash.new(0),'2014-2'=>Hash.new(0),'2014-3'=>Hash.new(0),'2014-4'=>Hash.new(0),'2014-5'=>Hash.new(0),'2014-6'=>Hash.new(0),'2014-7'=>Hash.new(0),'2014-8'=>Hash.new(0)}
	coll.find.each do |doc|
		if doc['page_id'] == fb_id
			time = doc['year'].to_s + '-' + doc['month'].to_s
			if count.has_key?(time)
				count[time]['user'] += doc['user_count']
				count[time]['post'] += doc['post_count']
				count[time]['comment'] += doc['comment_count']
				count[time]['share'] += doc['share_count']
			end
						
		end
	end
	hash = {'fb_name'=>fb_name,'count'=>count}
	mongo_db = mongo_link('192.168.26.180',27017,'DA_kaogaau','phadmin','pw1874')
	coll = mongo_db['time_change_subtraction_2014']
	puts "insert mongo.."
	coll.insert(hash)	
end
puts 'complicate'