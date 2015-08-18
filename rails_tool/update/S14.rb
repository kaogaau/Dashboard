#S14P 使用者成長趨勢
require './mongo_client'
client = mongo_client([ '192.168.26.180:27017' ],'dashboard','admin','12345')
page_id = Array.new(0)
client[:tool_S10].find.each do|doc|
	page_id << doc['page_id']
	#hash = doc['comment']['month']
	#hash = Hash.new(0)
	#hash['2015-1-1'] = 0
	#hash['2015-2-1'] = 0
	#hash['2015-3-1'] = 0
	#hash['2015-4-1'] = 0
	#hash['2015-5-1'] = 0
	#doc['comment']['month'] = hash
	#client[:tool_S10].find(:page_id => page_id).raplace_one("doc.comment.month" => hash)
end

client = mongo_client([ '192.168.26.180:27017' ],'test_kaogaau','admin','12345')

File.open('./S14.txt','w+') do |output|
	page_id.each do |page_id|
		output.puts page_id
		client[:statistics].find("page_id"=>page_id,"year"=>2015).each do|doc|
			output.puts "\"#{doc['year']}-#{doc['month']}-1\":#{doc['user_count']},"
		end
	end
end