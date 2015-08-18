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
coll = mongo_db['pregnant']
hash = Hash.new { |k,v| hash[k] = Hash.new(0) }
pep = Hash.new(0)
pep_arr = Array.new()
coll.find.each do |doc|
	if doc['doc']['post_content'] != nil
		if doc['doc']['post_author'] != nil
			pos_aut = doc['doc']['post_author']
			if pos_aut.match(/\,/)
				pos_aut.each_char do |char|
					if  char == ','
						pos_aut[','] = '_'
					end
				end
			end
			#hash[pos_aut] = Hash.new(0)
		end
	end
	doc['doc']['response'].each do |k,v|
		if   v['response_author'] != nil 
			res_aut = v['response_author']
			if res_aut.match(/\,/)
				res_aut.each_char do |char|
					if  char == ','
						res_aut[','] = '_'
					end
				end
			end
			hash[pos_aut][res_aut] += 1
		end
	end	
end
hash.each do |k,v|
	v.each do |m,n|
		if n < 250
			v.delete(m)
		end
	end
end
hash.each do |k,v|
	pep[k] = 0
	v.each do |m,n|
		pep[m] = 0
	end
end
pep.each do |k,v|
	pep_arr << k
end
#puts pep_arr.size
File.open('out/people_to_people.gdf','w+') do |out|
	out.puts 'nodedef>name VARCHAR,label VARCHAR'
	pep_arr.each_with_index do |ele,index|
		out.puts "#{index+1},#{ele}"
	end
	out.puts 'edgedef>node1 VARCHAR,node2 VARCHAR, weight DOUBLE'
	hash.each do |k,v|
		v.each do |m,n|
			out.puts "#{pep_arr.index(m)+1},#{pep_arr.index(k)+1},#{n}"
		end
	end
end
puts 'complicate'