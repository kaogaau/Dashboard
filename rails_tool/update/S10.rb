#S10P 互動度成長趨勢
require "json"
require "bson"
#initial date_hash#####

def initial_hash
	month_now = Time.now.to_s[0..6]
	date_hash = Hash.new {0}
	date_from  = Date.parse('2015-01-01')
	date_to = Date.parse("#{month_now}-01")#time now
	date_range = date_from..date_to
	date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
	date_months.each do |date|
		d_s = date.to_s
		if d_s[5] == '0'
			d_s.slice!(5)
			d_s.slice!(7)
		else
			d_s.slice!(8)
		end
		date_hash[d_s] = 0
	end
	date_hash
end

require './mongo_client'
client = mongo_client([ '192.168.26.180:27017' ],'dashboard','admin','12345')
doc_object = Array.new(0)
page_id = Array.new(0)
client[:tool_S10].find.each do|doc|
	doc_object << doc
	page_id << doc['page_id']
end

###################
client = mongo_client([ '192.168.26.180:27017' ],'test_kaogaau','admin','12345')
update_comment = Hash.new {0}
update_share = Hash.new {0}
page_id.each do |id|
	hash_comment = initial_hash
	hash_share = initial_hash
	client[:statistics].find("page_id"=>id,"year"=>2015).each do|doc|
		hash_comment["#{doc['year']}-#{doc['month']}-1"] = doc['comment_count']
		hash_share["#{doc['year']}-#{doc['month']}-1"] = doc['share_count']
	end
	update_comment[id] = hash_comment
	update_share[id] = hash_share
end

#test
#update.each do |k,v|
#	puts "#{k}\t#{v}"
#end


client = mongo_client([ '192.168.26.180:27017' ],'dashboard','admin','12345')
doc_object.each do |doc|
	hash_comment = doc['comment']['month']
	hash_share = doc['share']['month']
	hash_comment = hash_comment.merge(update_comment[doc['page_id']]).sort_by{|k,v| k}.to_h
	hash_share = hash_share.merge(update_share[doc['page_id']]).sort_by{|k,v| k}.to_h
	doc['comment']['month'] = hash_comment
	doc['share']['month'] = hash_share
	result = client[:tool_S10].find("page_id" => doc['page_id']).delete_one
	result = client[:tool_S10].insert_one(doc)
end 