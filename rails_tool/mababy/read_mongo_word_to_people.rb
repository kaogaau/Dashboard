# encoding: UTF-8
require 'time'
require 'rubygems'
require 'json'
require 'bson'
require 'mongo'
include Mongo

MONGODB_HOST = '192.168.26.180'
MONGODB_PORT = 27017
MONGODB_DBNAME = 'mababy'
MONGODB_USER_NAME = 'phadmin'
MONGODB_USER_PWD = 'pw1874'
client = MongoClient.new(MONGODB_HOST, MONGODB_PORT)
client.add_auth(MONGODB_DBNAME, MONGODB_USER_NAME, MONGODB_USER_PWD, MONGODB_DBNAME)
mongo_db = client[MONGODB_DBNAME]
coll = mongo_db['product_try']
hash = Hash.new(0)
coll.find.each do |doc|
	if doc['doc']['post_content'] != nil
		con = doc['doc']['post_content'] 
		if /麗嬰房/.match(con) != nil && doc['doc']['post_author'] != nil
			aut = doc['doc']['post_author']
			hash[aut] += 1
		end
	end
	doc['doc']['response'].each do |k,v|
		str = v['response_content']
		if /麗嬰房/.match(str) != nil  &&  v['response_author'] != nil 
			aut = v['response_author']
			hash[aut] += 1
		end
	end	
end
File.open('out/麗嬰房_品牌_人.txt','w+') do |out|
	#index = 1
	#out.puts 'nodedef>name VARCHAR,label VARCHAR'
	#out.puts "#{index},麗嬰房"
	hash.each do |k,v|
		out.puts "#{k}\t#{v}"
	end
	#out.puts 'edgedef>node1 VARCHAR,node2 VARCHAR, weight DOUBLE'
	#index = 1
	#hash.each do |k,v|
	#	index += 1
	#	out.puts "#{index},1,#{v}"
	#end
end
puts 'complicate'