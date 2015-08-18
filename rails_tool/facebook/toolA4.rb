# encoding: UTF-8
require 'time'
require 'rubygems'
require 'json'
require 'bson'
require 'mongo'
require'date'
include Mongo

def mongo_link(mongo_host,mongo_port,mongo_dbname,mongo_user_name,mongo_user_pwd)
	client = MongoClient.new(mongo_host, mongo_port)
	client.add_auth(mongo_dbname, mongo_user_name, mongo_user_pwd, mongo_dbname)
	mongo_db = client[mongo_dbname]	
end

mongo_db = mongo_link('192.168.26.180',27017,'fb_beta','ob','star2474')
#{'麗嬰房 媽咪同學會'=>'209251989898','奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}
fb = {'mothercare Taiwan'=>'240961475964301'}



start = Time.now
puts "tool A4 : 時間趨勢"
fb.each do |fb_name,fb_id|
	fb_count = Hash.new { |k,v| fb_count[v] = Hash.new(0) }
	coll = mongo_db['statistics']
	coll.find.each do |doc|
		if doc['page_id'] == fb_id 
			t = Date.new(doc['year'],doc['month'])
			fb_count['comment'][t] = fb_count['comment'][t] + doc['comment_count']
			fb_count['share'][t] = fb_count['share'][t] + doc['share_count']		
		end
	end
	fb_count['comment'] = fb_count['comment'].sort
	fb_count['share'] = fb_count['share'].sort
	puts "#{fb_name}"
	fb_count['comment'].each do |k,v|
		puts "\"#{k.year}-#{k.mon}\" : #{v},"
	end
	puts "share.."
	fb_count['share'].each do |k,v|
		puts "\"#{k.year}-#{k.mon}\" : #{v},"
	end
end
#-#{k.mon}

puts "Complicate : All Run #{(Time.now - start)/60} Mins"