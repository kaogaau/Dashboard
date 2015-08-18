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

mongo_db = mongo_link('192.168.26.180',27017,'fb_beta','ob','star2474')

fb = {'麗嬰房 媽咪同學會'=>'209251989898'}#,'奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}
fb_count = Hash.new { |k,v| fb_count[v] = Hash.new(0) }
year = Hash.new(0)
month = Hash.new(0)
start = Time.now

fb.each do |fb_name,fb_id|
	puts "tool A3 : 平均互動"
	coll = mongo_db['statistics']
	coll.find.each do |doc|
		if doc['page_id'] == fb_id 
			year["#{doc['year']}"] = 0
			month["#{doc['year']}-#{doc['month']}"] = 0
			fb_count[fb_name]['comment'] = fb_count[fb_name]['comment'] +	doc['comment_count']
			fb_count[fb_name]['share'] = fb_count[fb_name]['share'] +	doc['share_count']	
		end
	end
end
puts "comment.."
puts  fb_count['麗嬰房 媽咪同學會']['comment']/month.size

puts "share.."
puts  fb_count['麗嬰房 媽咪同學會']['share']/month.size

puts "Complicate : All Run #{(Time.now - start)/60} Mins"