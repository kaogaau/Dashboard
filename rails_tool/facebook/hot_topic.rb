# encoding: UTF-8
require 'time'
require 'rubygems'
require 'json'
require 'bson'
require 'mongo'
include Mongo


fb = {'麗嬰房 媽咪同學會'=>'209251989898'}#,'奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}
#fb_count = Hash.new { |k,v| fb_count[v] = Hash.new(0) }
def mongo_link(mongo_host,mongo_port,mongo_dbname,mongo_user_name,mongo_user_pwd)
	client = MongoClient.new(mongo_host, mongo_port)
	client.add_auth(mongo_dbname, mongo_user_name, mongo_user_pwd, mongo_dbname)
	mongo_db = client[mongo_dbname]	
end
topic = Hash.new(0)
start = Time.now

mongo_db = mongo_link('192.168.26.180',27017,'fb_beta','ob','star2474')

fb.each do |fb_name,fb_id|
	puts "hot topic.. : #{fb_name}"
	coll = mongo_db['posts']
	coll.find.each do |doc|
		if doc['page_id'] == fb_id && doc['doc'].has_key?('comments')
			topic[doc['doc']['message']] =  doc['doc']['comments']['data'].size
		end
	end
end
arr = topic.sort_by{|k,v| v}
File.open('out.txt','w+') do |file|
	file.puts "#{arr[arr.size-1][0]}\t#{arr[arr.size-1][1]}"
	file.puts "#{arr[arr.size-2][0]}\t#{arr[arr.size-2][1]}"
	file.puts "#{arr[arr.size-3][0]}\t#{arr[arr.size-3][1]}"
	file.puts "#{arr[arr.size-4][0]}\t#{arr[arr.size-4][1]}"
	file.puts "#{arr[arr.size-5][0]}\t#{arr[arr.size-5][1]}"
end

#topic.each do |k,v|
#	puts "#{k}\t#{v}"
#end
puts "Complicate : All Run #{(Time.now - start)/60} Mins"