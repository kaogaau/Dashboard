# coding: utf-8
class FbController < ActionController::Base
  protect_from_forgery
  def fors1
    #資料庫s1
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("dashboard")
    @insert = mongo_db.authenticate("admin", "12345")

    coll = mongo_db['keyword_statics']
    (0..16).each do |q|
      @alltheword1 = []
      if q == 0
     fb = {'麗嬰房 媽咪同學會'=>'209251989898'}
     end
     if q == 1
     fb = {'台灣貝親'=>'131346323572353'}
    
     end
    if q == 2
     fb = {'奇哥 寶寶的第一個朋友'=>'128267296746'}
     end
     if q == 3
     fb = {'mothercare Taiwan'=>'240961475964301'}
     end
     if q == 4
     fb = {'愛的世界 小熊親子團'=>'237446743049832'}
     end
     if q == 5
      fb = {'寶寶日記'=>'279264471269'}
     end
      if q == 6
      fb = {'懷孕大小事'=>'319186521484350'}
      end
      if q == 7
     fb = {'Nac Nac'=>'148722908483450'}
     end
     if q == 8
     fb = {'愛貝比婦幼生活館'=>'222374807844875'}
     end
     if q == 9
     fb = {'LES ENPHANTS PLUS 兒童時尚名店'=>'152486534850394'}
     end
      if q == 10
     fb = {'OshKosh/ Carter'=>'139345196140926'}
     end
      if q == 11
     fb = {'麗嬰房觀光工廠采衣館'=>'169299433126237'}
     end
      if q == 12
     fb = {'BabyHome'=>'135084993203916'}
     end
      if q == 13
     fb = {'親子天下'=>'152905932107'}
     end
      if q == 14
     fb = {'UNIQLO Baby'=>'252975951538930'}
     end
      if q == 15
     fb = {'My nuno'=>'614665685252676'}
     end
    
      if q == 16
      fb = {'Open for kids'=>'518864824797451'} 
     end

      fb.each do |fb_name,fb_id|
        fb_count = Hash.new { |k,v| fb_count[v] = Hash.new(0) }

        coll.find("occurrence_sum" => {"$gt" => 0},"page_id" => fb_id).each do |doc|

          if doc['page_id'] == fb_id && doc['word'].length > 1

            @alltheword1 << [doc['word'],doc['occurrence_sum'].to_i]

          end

        end
        @cart = Hash.new(0)
        @alltheword1.each do |k,v|
          if @cart.has_key?(k)
          @cart[k] = @cart[k].to_i + v.to_i
          else
          @cart[k] = v
          end

        end

         if @cart.blank?
          @data1 = {
    "page_id" => fb_id,
    "page_name" => fb_name,
    "order" => q+1,
    "sorce" => "facebook",
    "top10" => {
       "1" => 0,
        "2" => 0,
        "3" => 0,
        "4" => 0,
       "5" => 0,
       "6" =>0,
        "7" => 0,
        "8" => 0,
        "9" =>0,
        "10" => 0
    }
}
       else
          @cart.sort_by{|m,n| n}
      @cart.sort_by{|m,n| n}.reverse.first(10)
      @data1 = {
    "page_id" => fb_id,
    "page_name" => fb_name,
    "order" => q+1,
    "sorce" => "facebook",
    "top10" => {
        @cart.sort_by{|m,n| n}.reverse.first(10)[0][0] => @cart.sort_by{|m,n| n}.reverse.first(10)[0][1].to_i,
        @cart.sort_by{|m,n| n}.reverse.first(10)[1][0] => @cart.sort_by{|m,n| n}.reverse.first(10)[1][1].to_i,
        @cart.sort_by{|m,n| n}.reverse.first(10)[2][0] => @cart.sort_by{|m,n| n}.reverse.first(10)[2][1].to_i,
        @cart.sort_by{|m,n| n}.reverse.first(10)[3][0] => @cart.sort_by{|m,n| n}.reverse.first(10)[3][1].to_i,
        @cart.sort_by{|m,n| n}.reverse.first(10)[4][0] => @cart.sort_by{|m,n| n}.reverse.first(10)[4][1].to_i,
        @cart.sort_by{|m,n| n}.reverse.first(10)[5][0] => @cart.sort_by{|m,n| n}.reverse.first(10)[5][1].to_i,
        @cart.sort_by{|m,n| n}.reverse.first(10)[6][0] => @cart.sort_by{|m,n| n}.reverse.first(10)[6][1].to_i,
        @cart.sort_by{|m,n| n}.reverse.first(10)[7][0] => @cart.sort_by{|m,n| n}.reverse.first(10)[7][1].to_i,
        @cart.sort_by{|m,n| n}.reverse.first(10)[8][0] => @cart.sort_by{|m,n| n}.reverse.first(10)[8][1].to_i,
        @cart.sort_by{|m,n| n}.reverse.first(10)[9][0] => @cart.sort_by{|m,n| n}.reverse.first(10)[9][1].to_i
    }
}
       end
        @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
        @connection = @db.authenticate("admin", "12345")
        @db["tool_S1"].update({"page_id" => fb_id},@data1)
      end
    end
    # end
    render :text =>  "OK"

  end
  def fors1_sep
    #資料庫s1
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("dashboard")
    @insert = mongo_db.authenticate("admin", "12345")

    coll = mongo_db['keyword_statics']
    (0..16).each do |q|
      @alltheword1 = []
       if q == 0
     fb = {'麗嬰房 媽咪同學會'=>'209251989898'}
     end
     if q == 1
     fb = {'台灣貝親'=>'131346323572353'}
    
     end
    if q == 2
     fb = {'奇哥 寶寶的第一個朋友'=>'128267296746'}
     end
     if q == 3
     fb = {'mothercare Taiwan'=>'240961475964301'}
     end
     if q == 4
     fb = {'愛的世界 小熊親子團'=>'237446743049832'}
     end
     if q == 5
      fb = {'寶寶日記'=>'279264471269'}
     end
      if q == 6
      fb = {'懷孕大小事'=>'319186521484350'}
      end
      if q == 7
     fb = {'Nac Nac'=>'148722908483450'}
     end
     if q == 8
     fb = {'愛貝比婦幼生活館'=>'222374807844875'}
     end
     if q == 9
     fb = {'LES ENPHANTS PLUS 兒童時尚名店'=>'152486534850394'}
     end
      if q == 10
     fb = {'OshKosh/ Carter'=>'139345196140926'}
     end
      if q == 11
     fb = {'麗嬰房觀光工廠采衣館'=>'169299433126237'}
     end
      if q == 12
     fb = {'BabyHome'=>'135084993203916'}
     end
      if q == 13
     fb = {'親子天下'=>'152905932107'}
     end
      if q == 14
     fb = {'UNIQLO Baby'=>'252975951538930'}
     end
      if q == 15
     fb = {'My nuno'=>'614665685252676'}
     end
    
      if q == 16
      fb = {'Open for kids'=>'518864824797451'} 
     end

      fb.each do |fb_name,fb_id|
        fb_count = Hash.new { |k,v| fb_count[v] = Hash.new(0) }

        coll.find("occurrence_sum" => {"$gt" => 0},"page_id" => fb_id).each do |doc|

          if doc['page_id'] == fb_id && doc['word'].length > 1

            @alltheword1 << [doc['static_date'],doc['word'],doc['occurrence_sum'].to_i]

          end

        end
        @cart = Hash.new(0)
        @alltheword1.each do |t,k,v|
           if @cart.has_key?(t)
          if @cart[t].has_key?(k)
          @cart[t][k] = @cart[k].to_i + v.to_i
          else
          @cart[t][k] = v
          end
          else
            
          # @cart = {"#{t}"=>{"#{k}"=>v}}
          @cart[t] = {}
          @cart[t][k] = v
          # @cart[t][k] = v
         end
         
        end
        @cart2 = Hash.new
           @cart.each do |key,value|
              a =  value.sort_by{|m,n| n}.reverse.first(10)
              @cart2[key] = Hash.new
              a.each do |subkey,subvalue|
                @cart2[key][subkey] = subvalue
              end
              #value = b
              # value = "{" +  + "}"
            end
     
         if @cart2.blank?
          @data1 = {
    "page_id" => fb_id,
    "page_name" => fb_name,
    "order" => q+1,
    "sorce" => "facebook",
    "top10" => 0
}
       else
        
      @data1 = {
    "page_id" => fb_id,
    "page_name" => fb_name,
    "order" => q+1,
    "sorce" => "facebook",
    "top10" => @cart2
}
       end
        @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
        @connection = @db.authenticate("admin", "12345")
         @db["tool_S1_sep"].update({"page_id" => fb_id},@data1)
                
      end
    end
    # end
    render :text =>  "OK"

  end

  def s3
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("test_kaogaau")
    @insert = mongo_db.authenticate("admin", "12345")
     (0..16).each do |q|
    brand= ['愛的世界','麗嬰房','貝親','奇哥','mothercare']
    count = Hash.new()
    article = Hash.new()
    count["愛的世界"] = Hash.new
    count["麗嬰房"] = Hash.new
    count["貝親"] = Hash.new
    count["奇哥"] = Hash.new
    count["mothercare"] = Hash.new
     if q == 0
     fb = {'麗嬰房 媽咪同學會'=>'209251989898'}
     end
     if q == 1
     fb = {'台灣貝親'=>'131346323572353'}
    
     end
    if q == 2
     fb = {'奇哥 寶寶的第一個朋友'=>'128267296746'}
     end
     if q == 3
     fb = {'mothercare Taiwan'=>'240961475964301'}
     end
     if q == 4
     fb = {'愛的世界 小熊親子團'=>'237446743049832'}
     end
     if q == 5
      fb = {'寶寶日記'=>'279264471269'}
     end
      if q == 6
      fb = {'懷孕大小事'=>'319186521484350'}
      end
      if q == 7
     fb = {'Nac Nac'=>'148722908483450'}
     end
     if q == 8
     fb = {'愛貝比婦幼生活館'=>'222374807844875'}
     end
     if q == 9
     fb = {'LES ENPHANTS PLUS 兒童時尚名店'=>'152486534850394'}
     end
      if q == 10
     fb = {'OshKosh/ Carter'=>'139345196140926'}
     end
      if q == 11
     fb = {'麗嬰房觀光工廠采衣館'=>'169299433126237'}
     end
      if q == 12
     fb = {'BabyHome'=>'135084993203916'}
     end
      if q == 13
     fb = {'親子天下'=>'152905932107'}
     end
      if q == 14
     fb = {'UNIQLO Baby'=>'252975951538930'}
     end
      if q == 15
     fb = {'My nuno'=>'614665685252676'}
     end
    
      if q == 16
      fb = {'Open for kids'=>'518864824797451'} 
     end
    coll = mongo_db['posts']

    fb.each do |fb_name,fb_id|
      brand.each do |brand_name|
        coll.find("page_id"=>fb_id,"comments" =>{"$ne"=>''}).each do |doc|
          if doc['doc']['message'] != nil
            con = doc['doc']['message']
            if /#{brand_name}/.match(con) != nil
              timer = doc["doc"]['created_time'].to_time
                if count["#{brand_name}"].blank?
                  count["#{brand_name}"] = Hash.new
                  if count["#{brand_name}"]["#{timer.year}-#{timer.month}"].blank?
                    count["#{brand_name}"]["#{timer.year}-#{timer.month}"] = 1
                  else
                    count["#{brand_name}"]["#{timer.year}-#{timer.month}"] += 1 
                  end  
                else
                  if count["#{brand_name}"]["#{timer.year}-#{timer.month}"].blank?
                    count["#{brand_name}"]["#{timer.year}-#{timer.month}"] = 1
                  else
                    count["#{brand_name}"]["#{timer.year}-#{timer.month}"] += 1 
                  end  
                end
            end
          end
          if doc['doc']['comments'] != nil
              
            doc['doc']['comments']['data'].each do |k,v|
                   
              str = k['message']
              if /#{brand_name}/.match(str) != nil
                timer = k['created_time'].to_time
                   wordtimer = k["created_time"].to_s
                article["#{brand_name}-#{wordtimer}"] = k['message']
                if count["#{brand_name}"].blank?
                  count["#{brand_name}"] = Hash.new
                   if count["#{brand_name}"]["#{timer.year}-#{timer.month}"].blank?
                    count["#{brand_name}"]["#{timer.year}-#{timer.month}"] = 1
                  else
                    count["#{brand_name}"]["#{timer.year}-#{timer.month}"] += 1 
                  end  
                else
                  if count["#{brand_name}"]["#{timer.year}-#{timer.month}"].blank?
                    count["#{brand_name}"]["#{timer.year}-#{timer.month}"] = 1
                  else
                    count["#{brand_name}"]["#{timer.year}-#{timer.month}"] += 1 
                  end  
                end
                
              end
            end
          end

        end
      end
     
      
      @array1 = Hash.new
      # count = count.sort_by{|k,v| k}
       count["愛的世界"].sort_by{|k,v| k}.each do |h,k|
         
          @array1["#{h}-1"] = k
        end
        @array2 = Hash.new
      # count = count.sort_by{|k,v| k}
       count["麗嬰房"].sort_by{|k,v| k}.each do |h,k|
         
          @array2["#{h}-1"] = k
        end
        @array3 = Hash.new
      # count = count.sort_by{|k,v| k}
       count["貝親"].sort_by{|k,v| k}.each do |h,k|
         
          @array3["#{h}-1"] = k
        end
        @array4 = Hash.new
      # count = count.sort_by{|k,v| k}
       count["奇哥"].sort_by{|k,v| k}.each do |h,k|
         
          @array4["#{h}-1"] = k
        end
        @array5 = Hash.new
      # count = count.sort_by{|k,v| k}
       count["mothercare"].sort_by{|k,v| k}.each do |h,k|
         
          @array5["#{h}-1"] = k
        end
     
    
      @data1 = {
    "sorce" => fb_name,
    "page_id" => fb_id,
    "order" => q + 1,
    "愛的世界" => @array1,
    "麗嬰房" => @array2,
    "貝親" => @array3,
    "奇哥" => @array4,
    "mothercare" => @array5

}
@data2 = {
  "sorce" => fb_name,
    "page_id" => fb_id,
    "order" => q + 1,
    "aticle" => article

}
      @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
      @connection = @db.authenticate("admin", "12345")
      @db["tool_S3"].update({"page_id" => fb_id},@data1)
      @db["tool_S3_see"].update({"page_id" => fb_id},@data2)
    end
     end
    render :text => "OK"
  end

   def s4
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("dashboard")
    @insert = mongo_db.authenticate("admin", "12345")
  
    (0..16).each do |q|
        @comname = []
    @alltheword1= []
       if q == 0
        fb = {'麗嬰房'=>'209251989898'}
      end
      if q == 1
        fb = {'貝親'=>'131346323572353'}
      end
      if q == 2
        fb = {'奇哥'=>'128267296746'}
      end
      if q == 3
        fb = {'mothercare'=>'240961475964301'}
      end
      if q == 4
        fb = {'愛的世界'=>'237446743049832'}
      end
      if q == 5
     
     fb = {'寶寶日記'=>'279264471269'}
     end
     if q == 6
     
    fb = {'懷孕大小事'=>'319186521484350'} 
     end
    if q == 7
     fb = {'Nac Nac'=>'148722908483450'}
     end
     if q == 8
     fb = {'愛貝比婦幼生活館'=>'222374807844875'}
     end
     if q == 9
     fb = {'LES ENPHANTS PLUS 兒童時尚名店'=>'152486534850394'}
     end
      if q == 10
     fb = {'OshKosh/ Carter'=>'139345196140926'}
     end
      if q == 11
     fb = {'麗嬰房觀光工廠采衣館'=>'169299433126237'}
     end
      if q == 12
     fb = {'BabyHome'=>'135084993203916'}
     end
      if q == 13
     fb = {'親子天下'=>'152905932107'}
     end
      if q == 14
     fb = {'UNIQLO Baby'=>'252975951538930'}
     end
      if q == 15
     fb = {'My nuno'=>'614665685252676'}
     end
    
      if q == 16
      fb = {'Open for kids'=>'518864824797451'} 
     end
        @cart = Hash.new(0)
        @view = Hash.new(0)
    fb.each do |fb_name,fb_id|
      coll = mongo_db['FacebookRecognizeNegativeResultsSortedByTime']
      coll.find('Company:' => fb_name).each do |doc|

          @alltheword1 << [doc["negative:"],1]
           if @view.has_key?(doc["negative:"])
          @view[doc["negative:"]][doc["post time:"].to_s + doc["comment_author"].to_s] = doc["comment:"]
          else
            @view[doc["negative:"]] = Hash.new
            @view[doc["negative:"]][doc["post time:"].to_s + doc["comment_author"].to_s] = doc["comment:"]
          end
      end
   
      @alltheword1.each do |k,v|
        if @cart.has_key?(k)
        @cart[k] = @cart[k].to_i + v.to_i
        else
        @cart[k] = v
        end

      end
      if @cart.blank?
        @data1 ={
    "page_id" => fb_id,
    "page_name" => fb_name,
    "sorce" => "facebook",
    "order" => q+1,
    "top5" => {
         "nil" => 0,
         "nil" => 0,
         "nil" => 0,
         "nil" => 0,
         "nil" => 0
    }
}
  @data2 ={
    "page_id" => fb_id,
    "page_name" => fb_name,
    "sorce" => "facebook",
    "order" => q+1,
    "top1" => {
         "nil" => "none"
        
    },
    "top2" => {
         "nil" => "none"
   
    },
    "top3" => {
         "nil" => "none"
       
    },
    "top4" => {
         "nil" => "none"
      
    },
    "top5" => {
         "nil" => "none"
       
    }
}
      else
        @data1 ={
    "page_id" => fb_id,
    "page_name" => fb_name,
    "sorce" => "facebook",
    "order" => q+1,
    "top5" => {
         @cart.sort_by{|m,n| n}.reverse.first(5)[0][0] => @cart.sort_by{|m,n| n}.reverse.first(5)[0][1].to_i,
         @cart.sort_by{|m,n| n}.reverse.first(5)[1][0] => @cart.sort_by{|m,n| n}.reverse.first(5)[1][1].to_i,
         @cart.sort_by{|m,n| n}.reverse.first(5)[2][0] => @cart.sort_by{|m,n| n}.reverse.first(5)[2][1].to_i,
         @cart.sort_by{|m,n| n}.reverse.first(5)[3][0] => @cart.sort_by{|m,n| n}.reverse.first(5)[3][1].to_i,
         @cart.sort_by{|m,n| n}.reverse.first(5)[4][0] => @cart.sort_by{|m,n| n}.reverse.first(5)[4][1].to_i
    }
}
 @data2 ={
    "page_id" => fb_id,
    "page_name" => fb_name,
    "sorce" => "facebook",
    "order" => q+1,
     "top1" => {
         @cart.sort_by{|m,n| n}.reverse.first(5)[0][0] => @view[@cart.sort_by{|m,n| n}.reverse.first(5)[0][0]]
    },
     "top2" => {
        
         @cart.sort_by{|m,n| n}.reverse.first(5)[1][0] => @view[@cart.sort_by{|m,n| n}.reverse.first(5)[1][0]]
    },
     "top3" => {
      
         @cart.sort_by{|m,n| n}.reverse.first(5)[2][0] => @view[@cart.sort_by{|m,n| n}.reverse.first(5)[2][0]]
    }, "top4" => {
    
         @cart.sort_by{|m,n| n}.reverse.first(5)[3][0] => @view[@cart.sort_by{|m,n| n}.reverse.first(5)[3][0]]
    },
    "top5" => {
         @cart.sort_by{|m,n| n}.reverse.first(5)[4][0] => @view[@cart.sort_by{|m,n| n}.reverse.first(5)[4][0]]
    }
}
      end
      
@db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
    @connection = @db.authenticate("admin", "12345")

   @db["tool_S4"].update({"page_id" => fb_id},@data1)
    @db["tool_S4_see"].update({"page_id" => fb_id},@data2)
    end

    
    end
    render :text => "Ok"
  end
  def fors7
    #資料庫s1
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("dashboard")
    @insert = mongo_db.authenticate("admin", "12345")
    #{'麗嬰房 媽咪同學會'=>'209251989898','奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}
    @startdate = ["Nov 2009","Dec 2009", "Jan 2010", "Feb 2010","Mar 2010","Apr 2010","May 2010","Jun 2010","Jul 2010","Aug 2010","Sep 2010","Oct 2010","Nov 2010","Dec 2010", "Jan 2011", "Feb 2011","Mar 2011","Apr 2011","May 2011","Jun 2011","Jul 2011","Aug 2011","Sep 2011","Oct 2011","Nov 2011","Dec 2011", "Jan 2012", "Feb 2012","Mar 2012","Apr 2012","May 2012","Jun 2012","Jul 2012","Aug 2012","Sep 2012","Oct 2012","Nov 2012","Dec 2012", "Jan 2013", "Feb 2013","Mar 2013","Apr 2013","May 2013","Jun 2013","Jul 2013","Aug 2013","Sep 2013","Oct 2013","Nov 2013","Dec 2013"]
    

    coll = mongo_db['keyword_statics']
     (0..16).each do |q|
    @alltheword1 = []
    @themother = []
    @theson = []
    @theyearmother = []
    @theyearson = []
    @themothernew = []
    @thesonnew = []
    
     if q == 0
     fb = {'麗嬰房 媽咪同學會'=>'209251989898'}
     end
     if q == 1
     fb = {'台灣貝親'=>'131346323572353'}
    
     end
    if q == 2
     fb = {'奇哥 寶寶的第一個朋友'=>'128267296746'}
     end
     if q == 3
     fb = {'mothercare Taiwan'=>'240961475964301'}
     end
     if q == 4
     fb = {'愛的世界 小熊親子團'=>'237446743049832'}
     end
     if q == 5
      fb = {'寶寶日記'=>'279264471269'}
     end
      if q == 6
      fb = {'懷孕大小事'=>'319186521484350'}
      end
      if q == 7
     fb = {'Nac Nac'=>'148722908483450'}
     end
     if q == 8
     fb = {'愛貝比婦幼生活館'=>'222374807844875'}
     end
     if q == 9
     fb = {'LES ENPHANTS PLUS 兒童時尚名店'=>'152486534850394'}
     end
      if q == 10
     fb = {'OshKosh/ Carter'=>'139345196140926'}
     end
      if q == 11
     fb = {'麗嬰房觀光工廠采衣館'=>'169299433126237'}
     end
      if q == 12
     fb = {'BabyHome'=>'135084993203916'}
     end
      if q == 13
     fb = {'親子天下'=>'152905932107'}
     end
      if q == 14
     fb = {'UNIQLO Baby'=>'252975951538930'}
     end
      if q == 15
     fb = {'My nuno'=>'614665685252676'}
     end
    
      if q == 16
      fb = {'Open for kids'=>'518864824797451'} 
     end
    fb.each do |fb_name,fb_id|
      fb_count = Hash.new { |k,v| fb_count[v] = Hash.new(0) }

      coll.find("occurrence_sum" => {"$gt" => 0},"page_id" => fb_id,).each do |doc|

        if doc['page_id'] == fb_id
          #月成長關鍵字
          if doc['occurrence_sum'].to_i >0
            if "#{doc["static_date"]}/01".to_date.month == Time.now.advance(:months => -2).month
              @themother << [doc['word'],doc['occurrence_sum'].to_i]
            end
            if "#{doc["static_date"]}/01".to_date.month == Time.now.advance(:months => -1).month
              @theson<< [doc['word'],doc['occurrence_sum'].to_i]
            end
          end
          #------
          #年成長關鍵字
          if doc['occurrence_sum'].to_i >0
            if "#{doc["static_date"]}/01".to_date.year == Time.now.advance(:years => -2).year
              @theyearmother << [doc['word'],doc['occurrence_sum'].to_i]
            end
            if "#{doc["static_date"]}/01".to_date.year == Time.now.advance(:years => -1).year
              @theyearson<< [doc['word'],doc['occurrence_sum'].to_i]
            end
          end
        #------

        end
      end
      #月成長關鍵字
      @month1 = Hash.new(0)
      @themother.each do |k,v|
        if @month1.has_key?(k)
        @month1[k] = @month1[k].to_i + v.to_i
        else
        @month1[k] = v
        end

      end
      @month2 = Hash.new(0)
      @theson.each do |k,v|
        if @month2.has_key?(k)
        @month2[k] = @month2[k].to_i + v.to_i
        else
        @month2[k] = v
        end

      end
      @resultmonth = Hash.new(0)
      @resultmonthmother = Hash.new(0)
      @month1.each do |k,v|
        if @month2.has_key?(k)
        @resultmonth[k] = @month2[k].to_i * 100 / v.to_i
        @resultmonthmother[k] = v.to_i
        end
      end

      @resultmonth.sort_by{|m,n| n}
      @resultmonth.sort_by{|m,n| n}.reverse.first(10)
      #------
      #年成長關鍵字
      @year1 = Hash.new(0)
      @theyearmother.each do |k,v|
        if @year1.has_key?(k)
        @year1[k] = @year1[k].to_i + v.to_i
        else
        @year1[k] = v
        end

      end
      @year2 = Hash.new(0)
      @theyearson.each do |k,v|
        if @year2.has_key?(k)
        @year2[k] = @year2[k].to_i + v.to_i
        else
        @year2[k] = v
        end

      end
      @resultyear = Hash.new(0)
      @resultyearmother = Hash.new(0)
      @year1.each do |k,v|
        if @year2.has_key?(k)
        @resultyear[k] = @year2[k].to_i * 100 / v.to_i
        @resultyearmother[k] = v.to_i
        end
      end

      @resultyear.sort_by{|m,n| n}
      @resultyear.sort_by{|m,n| n}.reverse.first(10)
      #------
      #月新關鍵字

      @resultmonthnew = Hash.new(0)
      @resultmonthnew2 = Hash.new(0)
      @month2.each do |k,v|
        if @month1.has_key?(k)

        else
          if k.length > 1
        @resultmonthnew[k] = v.to_i
        end
        end
      end
      #------
      #年新關鍵字
      @resultyearnew = Hash.new(0)
       @resultyearnew2 = Hash.new(0)
      @year2.each do |k,v|
        if @year1.has_key?(k)

        else
           if k.length > 1
        @resultyearnew[k] = v.to_i
        end
        end
      end   
           @resultmonthnew.sort_by{|m,n| n}.reverse.first(10).each do |key,value|             
              @resultmonthnew2[key] = value           
            end
           @resultyearnew.sort_by{|m,n| n}.reverse.first(10).each do |key,value|             
              @resultyearnew2[key] = value           
            end
            
           
      #------
      if @resultyearnew.blank? || @resultyear.blank?
        @data1 = {
    "page_id" => fb_id,
    "order" => q + 1,
    "page_name" => fb_name,
    "sorce" => "facebook",
    "montop" => {
         "1" => 0,
        "2" => 0,
        "3" => 0,
        "4" => 0,
       "5" => 0,
       "6" =>0,
        "7" => 0,
        "8" => 0,
        "9" =>0,
        "10" => 0
    },
      "monmother" => {
         "1" => 0,
        "2" => 0,
        "3" => 0,
        "4" => 0,
       "5" => 0,
       "6" =>0,
        "7" => 0,
        "8" => 0,
        "9" =>0,
        "10" => 0
    },
    "yeartop" => {
          "1" => 0,
        "2" => 0,
        "3" => 0,
        "4" => 0,
       "5" => 0,
       "6" =>0,
        "7" => 0,
        "8" => 0,
        "9" =>0,
        "10" => 0
    },
      "yearmother" => {
         "1" => 0,
        "2" => 0,
        "3" => 0,
        "4" => 0,
       "5" => 0,
       "6" =>0,
        "7" => 0,
        "8" => 0,
        "9" =>0,
        "10" => 0
    },
    "monnew" => {
          "1" => 0,
        "2" => 0,
        "3" => 0,
        "4" => 0,
       "5" => 0,
       "6" =>0,
        "7" => 0,
        "8" => 0,
        "9" =>0,
        "10" => 0
    },
    "yearnew" => {
       "1" => 0,
        "2" => 0,
        "3" => 0,
        "4" => 0,
       "5" => 0,
       "6" =>0,
        "7" => 0,
        "8" => 0,
        "9" =>0,
        "10" => 0
    }
}
      else
        @data1 = {
    "page_id" => fb_id,
    "order" => q + 1,
    "page_name" => fb_name,
    "sorce" => "facebook",
    "montop" => {
         @resultmonth.sort_by{|m,n| n}.reverse.first(10)[0][0] => @resultmonth.sort_by{|m,n| n}.reverse.first(10)[0][1].to_i,
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[1][0] => @resultmonth.sort_by{|m,n| n}.reverse.first(10)[1][1].to_i,
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[2][0] => @resultmonth.sort_by{|m,n| n}.reverse.first(10)[2][1].to_i,
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[3][0] => @resultmonth.sort_by{|m,n| n}.reverse.first(10)[3][1].to_i,
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[4][0] => @resultmonth.sort_by{|m,n| n}.reverse.first(10)[4][1].to_i,
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[5][0] => @resultmonth.sort_by{|m,n| n}.reverse.first(10)[5][1].to_i,
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[6][0] => @resultmonth.sort_by{|m,n| n}.reverse.first(10)[6][1].to_i,
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[7][0] => @resultmonth.sort_by{|m,n| n}.reverse.first(10)[7][1].to_i,
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[8][0] => @resultmonth.sort_by{|m,n| n}.reverse.first(10)[8][1].to_i,
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[9][0] => @resultmonth.sort_by{|m,n| n}.reverse.first(10)[9][1].to_i
    },
     "monmother" => {
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[0][0] => @resultmonthmother[@resultmonth.sort_by{|m,n| n}.reverse.first(10)[0][0]],
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[1][0] => @resultmonthmother[@resultmonth.sort_by{|m,n| n}.reverse.first(10)[1][0]],
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[2][0] => @resultmonthmother[@resultmonth.sort_by{|m,n| n}.reverse.first(10)[2][0]],
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[3][0] => @resultmonthmother[@resultmonth.sort_by{|m,n| n}.reverse.first(10)[3][0]],
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[4][0] => @resultmonthmother[@resultmonth.sort_by{|m,n| n}.reverse.first(10)[4][0]],
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[5][0] => @resultmonthmother[@resultmonth.sort_by{|m,n| n}.reverse.first(10)[5][0]],
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[6][0] => @resultmonthmother[@resultmonth.sort_by{|m,n| n}.reverse.first(10)[6][0]],
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[7][0] => @resultmonthmother[@resultmonth.sort_by{|m,n| n}.reverse.first(10)[7][0]],
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[8][0] => @resultmonthmother[@resultmonth.sort_by{|m,n| n}.reverse.first(10)[8][0]],
        @resultmonth.sort_by{|m,n| n}.reverse.first(10)[9][0] => @resultmonthmother[@resultmonth.sort_by{|m,n| n}.reverse.first(10)[9][0]]
    },
    "yeartop" => {
         @resultyear.sort_by{|m,n| n}.reverse.first(10)[0][0] => @resultyear.sort_by{|m,n| n}.reverse.first(10)[0][1].to_i,
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[1][0] => @resultyear.sort_by{|m,n| n}.reverse.first(10)[1][1].to_i,
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[2][0] => @resultyear.sort_by{|m,n| n}.reverse.first(10)[2][1].to_i,
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[3][0] => @resultyear.sort_by{|m,n| n}.reverse.first(10)[3][1].to_i,
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[4][0] => @resultyear.sort_by{|m,n| n}.reverse.first(10)[4][1].to_i,
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[5][0] => @resultyear.sort_by{|m,n| n}.reverse.first(10)[5][1].to_i,
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[6][0] => @resultyear.sort_by{|m,n| n}.reverse.first(10)[6][1].to_i,
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[7][0] => @resultyear.sort_by{|m,n| n}.reverse.first(10)[7][1].to_i,
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[8][0] => @resultyear.sort_by{|m,n| n}.reverse.first(10)[8][1].to_i,
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[9][0] => @resultyear.sort_by{|m,n| n}.reverse.first(10)[9][1].to_i
    },
    "yearmother" => {
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[0][0] => @resultyearmother[@resultyear.sort_by{|m,n| n}.reverse.first(10)[0][0]],
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[1][0] => @resultyearmother[@resultyear.sort_by{|m,n| n}.reverse.first(10)[1][0]],
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[2][0] => @resultyearmother[@resultyear.sort_by{|m,n| n}.reverse.first(10)[2][0]],
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[3][0] => @resultyearmother[@resultyear.sort_by{|m,n| n}.reverse.first(10)[3][0]],
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[4][0] => @resultyearmother[@resultyear.sort_by{|m,n| n}.reverse.first(10)[4][0]],
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[5][0] => @resultyearmother[@resultyear.sort_by{|m,n| n}.reverse.first(10)[5][0]],
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[6][0] => @resultyearmother[@resultyear.sort_by{|m,n| n}.reverse.first(10)[6][0]],
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[7][0] => @resultyearmother[@resultyear.sort_by{|m,n| n}.reverse.first(10)[7][0]],
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[8][0] => @resultyearmother[@resultyear.sort_by{|m,n| n}.reverse.first(10)[8][0]],
        @resultyear.sort_by{|m,n| n}.reverse.first(10)[9][0] => @resultyearmother[@resultyear.sort_by{|m,n| n}.reverse.first(10)[9][0]]
    },
    "monnew" =>   @resultmonthnew2,
    
    "yearnew" => @resultyearnew2
    
}
      end
 

      @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
      @connection = @db.authenticate("admin", "12345")
       @db["tool_S7"].update({"page_id" => fb_id},@data1)
       
    end

     end
    render :text =>  "OK"

  end

  def fors8
    #資料庫a1
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("test_kaogaau")
    @insert = mongo_db.authenticate("admin", "12345")
    #{'麗嬰房 媽咪同學會'=>'209251989898','奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}
    @startdate = ["Nov 2009","Dec 2009", "Jan 2010", "Feb 2010","Mar 2010","Apr 2010","May 2010","Jun 2010","Jul 2010","Aug 2010","Sep 2010","Oct 2010","Nov 2010","Dec 2010", "Jan 2011", "Feb 2011","Mar 2011","Apr 2011","May 2011","Jun 2011","Jul 2011","Aug 2011","Sep 2011","Oct 2011","Nov 2011","Dec 2011", "Jan 2012", "Feb 2012","Mar 2012","Apr 2012","May 2012","Jun 2012","Jul 2012","Aug 2012","Sep 2012","Oct 2012","Nov 2012","Dec 2012", "Jan 2013", "Feb 2013","Mar 2013","Apr 2013","May 2013","Jun 2013","Jul 2013","Aug 2013","Sep 2013","Oct 2013","Nov 2013","Dec 2013"]
    @theallarray = []
    (0..16).each do |q|
      @ccc = []
      @m1l = []
      @m1c = []
      @m1s = []
       if q == 0
        fb = {'麗嬰房 媽咪同學會'=>'209251989898'}
      end
      if q == 1
        fb = {'台灣貝親'=>'131346323572353'}
      end
      if q == 2
        fb = {'奇哥 寶寶的第一個朋友'=>'128267296746'}
      end
      if q == 3
        fb = {'mothercare Taiwan'=>'240961475964301'}
      end
      if q == 4
        fb = {'愛的世界 小熊親子團'=>'237446743049832'}
      end
       if q == 5
     
     fb = {'寶寶日記'=>'279264471269'}
     end
     if q == 6
     
    fb = {'懷孕大小事'=>'319186521484350'} 
     end
    if q == 7
     fb = {'Nac Nac'=>'148722908483450'}
     end
     if q == 8
     fb = {'愛貝比婦幼生活館'=>'222374807844875'}
     end
     if q == 9
     fb = {'LES ENPHANTS PLUS 兒童時尚名店'=>'152486534850394'}
     end
      if q == 10
     fb = {'OshKosh/ Carter'=>'139345196140926'}
     end
      if q == 11
     fb = {'麗嬰房觀光工廠采衣館'=>'169299433126237'}
     end
      if q == 12
     fb = {'BabyHome'=>'135084993203916'}
     end
      if q == 13
     fb = {'親子天下'=>'152905932107'}
     end
      if q == 14
     fb = {'UNIQLO Baby'=>'252975951538930'}
     end
      if q == 15
     fb = {'My nuno'=>'614665685252676'}
     end
    
      if q == 16
      fb = {'Open for kids'=>'518864824797451'} 
     end
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
        #輸出評論時間趨勢------------按讚與分享無時間-------
        puts "#{fb_name}"
        fb_count['comment'].each do |k,v|

          @m1c << v.to_i

        end
        fb_count['share'].each do |k,v|
          @m1s << v.to_i
        end
        #按讚
        
        coll = mongo_db['posts']
        coll.find("page_id" => fb_id).each do |doc|
         @ss = 0
            if doc['doc']['likes'] != nil
              doc['doc']['likes']['data'].each do |f|
                @ss = @ss + 1

              end
            @m1l << @ss
            end
          
        end

        @data1 = {"page_id" => fb_id,
     "page_name" =>fb_name,
     "sorce" =>"facebook",
     "order" => q+1,
     "engagement" => {
       "total" => @m1l.reduce(:+) + @m1c.reduce(:+) + @m1s.reduce(:+)
               },
     "likes" => {
       "total" => @m1l.reduce(:+),
       "percent" => 0
               },
     "comments" => {
       "total" => @m1c.reduce(:+),
       "percent" => 0
               },
     "shares" => {
       "total" => @m1s.reduce(:+),
       "percent" => 0
               }}
        @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
        @connection = @db.authenticate("admin", "12345")

          @db["tool_A1"].update({"page_id" => fb_id},@data1)
       
      end
    end
    render :text => "OK"

  end

  def fors10
    #資料庫A4的csv檔
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("test_kaogaau")
    @insert = mongo_db.authenticate("admin", "12345")
    #{'麗嬰房 媽咪同學會'=>'209251989898','奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}
    @startdate = ["Nov 2009","Dec 2009", "Jan 2010", "Feb 2010","Mar 2010","Apr 2010","May 2010","Jun 2010","Jul 2010","Aug 2010","Sep 2010","Oct 2010","Nov 2010","Dec 2010", "Jan 2011", "Feb 2011","Mar 2011","Apr 2011","May 2011","Jun 2011","Jul 2011","Aug 2011","Sep 2011","Oct 2011","Nov 2011","Dec 2011", "Jan 2012", "Feb 2012","Mar 2012","Apr 2012","May 2012","Jun 2012","Jul 2012","Aug 2012","Sep 2012","Oct 2012","Nov 2012","Dec 2012", "Jan 2013", "Feb 2013","Mar 2013","Apr 2013","May 2013","Jun 2013","Jul 2013","Aug 2013","Sep 2013","Oct 2013","Nov 2013","Dec 2013"]
    @theallarray = []
    @theallarrays= []

    (0..16).each do |q|
       if q == 0
        fb = {'麗嬰房 媽咪同學會'=>'209251989898'}
      end
      if q == 1
        fb = {'台灣貝親'=>'131346323572353'}
      end
      if q == 2
        fb = {'奇哥 寶寶的第一個朋友'=>'128267296746'}
      end
      if q == 3
        fb = {'mothercare Taiwan'=>'240961475964301'}
      end
      if q == 4
        fb = {'愛的世界 小熊親子團'=>'237446743049832'}
      end
       if q == 5
     
     fb = {'寶寶日記'=>'279264471269'}
     end
     if q == 6
     
    fb = {'懷孕大小事'=>'319186521484350'} 
     end
    if q == 7
     fb = {'Nac Nac'=>'148722908483450'}
     end
     if q == 8
     fb = {'愛貝比婦幼生活館'=>'222374807844875'}
     end
     if q == 9
     fb = {'LES ENPHANTS PLUS 兒童時尚名店'=>'152486534850394'}
     end
      if q == 10
     fb = {'OshKosh/ Carter'=>'139345196140926'}
     end
      if q == 11
     fb = {'麗嬰房觀光工廠采衣館'=>'169299433126237'}
     end
      if q == 12
     fb = {'BabyHome'=>'135084993203916'}
     end
      if q == 13
     fb = {'親子天下'=>'152905932107'}
     end
      if q == 14
     fb = {'UNIQLO Baby'=>'252975951538930'}
     end
      if q == 15
     fb = {'My nuno'=>'614665685252676'}
     end
    
      if q == 16
      fb = {'Open for kids'=>'518864824797451'} 
     end
      @thealldate = []
      start = Time.now

      puts "tool A4 : 時間趨勢"
      fb.each do |fb_name,fb_id|
        fb_count = Hash.new { |k,v| fb_count[v] = Hash.new(0) }
        coll = mongo_db['statistics']
        coll.find("page_id" => fb_id).each do |doc|
         
            t = Date.new(doc['year'],doc['month'])
            fb_count['comment'][t] = fb_count['comment'][t] + doc['comment_count']
            fb_count['share'][t] = fb_count['share'][t] + doc['share_count']
          
        end
           @array1 = Hash.new
        @array2 = Hash.new
        fb_count['comment'] = fb_count['comment'].sort
        fb_count['share'] = fb_count['share'].sort
        puts "#{fb_name}"

        fb_count['comment'].each do |h,k|
          @array1["#{h.to_time.year}-#{h.to_time.month}-#{h.to_time.day}"] = k
        # puts "#{h.to_time.utc}=>#{k},"
        # @array1 << "#{h}=>#{k}"
        end
        puts "--------------"
        fb_count['share'].each do |h,k|
          @array2["#{h.to_time.year}-#{h.to_time.month}-#{h.to_time.day}"] = k
        #puts "#{h.to_time.year}-#{h.to_time.month}-#{h.to_time.day}=>#{k},"
        #@array2 << "#{h}=>#{k}"
        end

        @data1 = {
          "page_id" => fb_id,
    "page_name" => fb_name,
    "order" => q+1,
    "sorce" => "facebook",
    "comment" => {
        "month" => @array1
    },
    "share" => {
        "month" => @array2
    }
}
        @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
        @connection = @db.authenticate("admin", "12345")

        @db["tool_S10"].update({"page_id" => fb_id},@data1)
          

      end
    end

    render :text => "OK"

  end

  def fors11
    #資料庫a5
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("test_kaogaau")
    @insert = mongo_db.authenticate("admin", "12345")
    #{'麗嬰房 媽咪同學會'=>'209251989898','奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}
    @startdate = ["Nov 2009","Dec 2009", "Jan 2010", "Feb 2010","Mar 2010","Apr 2010","May 2010","Jun 2010","Jul 2010","Aug 2010","Sep 2010","Oct 2010","Nov 2010","Dec 2010", "Jan 2011", "Feb 2011","Mar 2011","Apr 2011","May 2011","Jun 2011","Jul 2011","Aug 2011","Sep 2011","Oct 2011","Nov 2011","Dec 2011", "Jan 2012", "Feb 2012","Mar 2012","Apr 2012","May 2012","Jun 2012","Jul 2012","Aug 2012","Sep 2012","Oct 2012","Nov 2012","Dec 2012", "Jan 2013", "Feb 2013","Mar 2013","Apr 2013","May 2013","Jun 2013","Jul 2013","Aug 2013","Sep 2013","Oct 2013","Nov 2013","Dec 2013"]
    @theallarray = []
    (0..16).each do |q|
      @ccc = []
      @m1 = []
      @m2 = []
      @m3 = []
      @m4 = []
      @m5 = []
      @m6 = []
      @m7 = []
      @m8 = []
      @m9 = []
      @m10 = []
      @m11 = []
      @m12 = []
      @m1s = []
      @m2s = []
      @m3s = []
      @m4s = []
      @m5s = []
      @m6s = []
      @m7s = []
      @m8s = []
      @m9s= []
      @m10s = []
      @m11s = []
      @m12s = []
    if q == 0
        fb = {'麗嬰房 媽咪同學會'=>'209251989898'}
      end
      if q == 1
        fb = {'台灣貝親'=>'131346323572353'}
      end
      if q == 2
        fb = {'奇哥 寶寶的第一個朋友'=>'128267296746'}
      end
      if q == 3
        fb = {'mothercare Taiwan'=>'240961475964301'}
      end
      if q == 4
        fb = {'愛的世界 小熊親子團'=>'237446743049832'}
      end
       if q == 5
     
     fb = {'寶寶日記'=>'279264471269'}
     end
     if q == 6
     
    fb = {'懷孕大小事'=>'319186521484350'} 
     end
    if q == 7
     fb = {'Nac Nac'=>'148722908483450'}
     end
     if q == 8
     fb = {'愛貝比婦幼生活館'=>'222374807844875'}
     end
     if q == 9
     fb = {'LES ENPHANTS PLUS 兒童時尚名店'=>'152486534850394'}
     end
      if q == 10
     fb = {'OshKosh/ Carter'=>'139345196140926'}
     end
      if q == 11
     fb = {'麗嬰房觀光工廠采衣館'=>'169299433126237'}
     end
      if q == 12
     fb = {'BabyHome'=>'135084993203916'}
     end
      if q == 13
     fb = {'親子天下'=>'152905932107'}
     end
      if q == 14
     fb = {'UNIQLO Baby'=>'252975951538930'}
     end
      if q == 15
     fb = {'My nuno'=>'614665685252676'}
     end
    
      if q == 16
      fb = {'Open for kids'=>'518864824797451'} 
     end
      fb.each do |fb_name,fb_id|
        fb_count = Hash.new { |k,v| fb_count[v] = Hash.new(0) }
        coll = mongo_db['statistics']
        coll.find("page_id" => fb_id).each do |doc|
          
            t = Date.new(doc['year'],doc['month'])
            fb_count['comment'][t] = fb_count['comment'][t] + doc['comment_count']
            fb_count['share'][t] = fb_count['share'][t] + doc['share_count']
         
        end
        fb_count['comment'] = fb_count['comment'].sort
        fb_count['share'] = fb_count['share'].sort
        #輸出評論時間趨勢------------按讚與分享無時間-------
        puts "#{fb_name}"
        fb_count['comment'].each do |k,v|
          if k.mon.to_i == 1
          @m1 << v.to_i
          end
          if k.mon.to_i == 2
          @m2 << v.to_i
          end
          if k.mon.to_i == 3
          @m3 << v.to_i
          end
          if k.mon.to_i == 4
          @m4 << v.to_i
          end
          if k.mon.to_i == 5
          @m5 << v.to_i
          end
          if k.mon.to_i == 6
          @m6 << v.to_i
          end
          if k.mon.to_i == 7
          @m7 << v.to_i
          end
          if k.mon.to_i == 8
          @m8 << v.to_i
          end
          if k.mon.to_i == 9
          @m9 << v.to_i
          end
          if k.mon.to_i == 10
          @m10 << v.to_i
          end
          if k.mon.to_i == 11
          @m11 << v.to_i
          end
          if k.mon.to_i == 12
          @m12 << v.to_i
          end

        end
        fb_count['share'].each do |k,v|
          if k.mon.to_i == 1
          @m1s << v.to_i
          end
          if k.mon.to_i == 2
          @m2s << v.to_i
          end
          if k.mon.to_i == 3
          @m3s << v.to_i
          end
          if k.mon.to_i == 4
          @m4s << v.to_i
          end
          if k.mon.to_i == 5
          @m5s << v.to_i
          end
          if k.mon.to_i == 6
          @m6s << v.to_i
          end
          if k.mon.to_i == 7
          @m7s << v.to_i
          end
          if k.mon.to_i == 8
          @m8s << v.to_i
          end
          if k.mon.to_i == 9
          @m9s << v.to_i
          end
          if k.mon.to_i == 10
          @m10s << v.to_i
          end
          if k.mon.to_i == 11
          @m11s << v.to_i
          end
          if k.mon.to_i == 12
          @m12s << v.to_i
          end

        end
        @data1 = {"page_id" => fb_id,
     "page_name" =>fb_name,
     "sorce" =>"facebook",
     "order" => q+1,
     "comment" => {
       "month" =>{1 =>@m1.reduce(:+),2 =>@m2.reduce(:+),3 =>@m3.reduce(:+),4 =>@m4.reduce(:+),5 =>@m5.reduce(:+),6 =>@m6.reduce(:+),
       7 =>@m7.reduce(:+),8 =>@m8.reduce(:+),9 =>@m9.reduce(:+),10 =>@m10.reduce(:+),11 =>@m11.reduce(:+),12 =>@m12.reduce(:+)}},
     "share"  => {
     "month"=>{1 =>@m1s.reduce(:+),2 =>@m2s.reduce(:+),3 =>@m3s.reduce(:+),4 =>@m4s.reduce(:+),5 =>@m5s.reduce(:+),6 =>@m6s.reduce(:+),
       7 =>@m7s.reduce(:+),8 =>@m8s.reduce(:+),9 =>@m9s.reduce(:+), 10 =>@m10s.reduce(:+),11 =>@m11s.reduce(:+),12 =>@m12s.reduce(:+)}
       }
       }
       
        @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
        @connection = @db.authenticate("admin", "12345")

        @db["tool_A5"].update({"page_id" => fb_id},@data1)
      end
    end
    render :text => "OK"

  end
  def fors11a6
    #資料庫a5
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("test_kaogaau")
    @insert = mongo_db.authenticate("admin", "12345")
    #{'麗嬰房 媽咪同學會'=>'209251989898','奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}
    @startdate = ["Nov 2009","Dec 2009", "Jan 2010", "Feb 2010","Mar 2010","Apr 2010","May 2010","Jun 2010","Jul 2010","Aug 2010","Sep 2010","Oct 2010","Nov 2010","Dec 2010", "Jan 2011", "Feb 2011","Mar 2011","Apr 2011","May 2011","Jun 2011","Jul 2011","Aug 2011","Sep 2011","Oct 2011","Nov 2011","Dec 2011", "Jan 2012", "Feb 2012","Mar 2012","Apr 2012","May 2012","Jun 2012","Jul 2012","Aug 2012","Sep 2012","Oct 2012","Nov 2012","Dec 2012", "Jan 2013", "Feb 2013","Mar 2013","Apr 2013","May 2013","Jun 2013","Jul 2013","Aug 2013","Sep 2013","Oct 2013","Nov 2013","Dec 2013"]
    @theallarray = []
    (0..16).each do |q|
      @ccc = [0]
      @m1 = [0]
      @m2 = [0]
      @m3 = [0]
      @m4 = [0]
      @m5 = [0]
      @m6 = [0]
      @m7 = [0]
      @m8 = [0]
      @m9 = [0]
      @m10 = [0]
      @m11 = [0]
      @m12 = [0]
      @m1s = [0]
      @m2s = [0]
      @m3s = [0]
      @m4s = [0]
      @m5s = [0]
      @m6s = [0]
      @m7s = [0]
      @m8s = [0]
      @m9s= [0]
      @m10s = [0]
      @m11s = [0]
      @m12s = [0]
     if q == 0
        fb = {'麗嬰房 媽咪同學會'=>'209251989898'}
      end
      if q == 1
        fb = {'台灣貝親'=>'131346323572353'}
      end
      if q == 2
        fb = {'奇哥 寶寶的第一個朋友'=>'128267296746'}
      end
      if q == 3
        fb = {'mothercare Taiwan'=>'240961475964301'}
      end
      if q == 4
        fb = {'愛的世界 小熊親子團'=>'237446743049832'}
      end
       if q == 5
     
     fb = {'寶寶日記'=>'279264471269'}
     end
     if q == 6
     
    fb = {'懷孕大小事'=>'319186521484350'} 
     end
    if q == 7
     fb = {'Nac Nac'=>'148722908483450'}
     end
     if q == 8
     fb = {'愛貝比婦幼生活館'=>'222374807844875'}
     end
     if q == 9
     fb = {'LES ENPHANTS PLUS 兒童時尚名店'=>'152486534850394'}
     end
      if q == 10
     fb = {'OshKosh/ Carter'=>'139345196140926'}
     end
      if q == 11
     fb = {'麗嬰房觀光工廠采衣館'=>'169299433126237'}
     end
      if q == 12
     fb = {'BabyHome'=>'135084993203916'}
     end
      if q == 13
     fb = {'親子天下'=>'152905932107'}
     end
      if q == 14
     fb = {'UNIQLO Baby'=>'252975951538930'}
     end
      if q == 15
     fb = {'My nuno'=>'614665685252676'}
     end
    
      if q == 16
      fb = {'Open for kids'=>'518864824797451'} 
     end
      fb.each do |fb_name,fb_id|
        fb_count = Hash.new { |k,v| fb_count[v] = Hash.new(0) }
        coll = mongo_db['statistics']
        coll.find("page_id" => fb_id).each do |doc|
          if doc['page_id'] == fb_id
            t = Date.new(doc['year'],doc['month'])
            fb_count['comment'][t] = fb_count['comment'][t] + doc['comment_count']
            fb_count['share'][t] = fb_count['share'][t] + doc['share_count']
          end
        end
        fb_count['comment'] = fb_count['comment'].sort
        fb_count['share'] = fb_count['share'].sort
        #輸出評論時間趨勢------------按讚與分享無時間-------
        puts "#{fb_name}"
        fb_count['comment'].each do |k,v|
          if k.mon.to_i == 1
          @m1 << v.to_i
          end
          if k.mon.to_i == 2
          @m2 << v.to_i
          end
          if k.mon.to_i == 3
          @m3 << v.to_i
          end
          if k.mon.to_i == 4
          @m4 << v.to_i
          end
          if k.mon.to_i == 5
          @m5 << v.to_i
          end
          if k.mon.to_i == 6
          @m6 << v.to_i
          end
          if k.mon.to_i == 7
          @m7 << v.to_i
          end
          if k.mon.to_i == 8
          @m8 << v.to_i
          end
          if k.mon.to_i == 9
          @m9 << v.to_i
          end
          if k.mon.to_i == 10
          @m10 << v.to_i
          end
          if k.mon.to_i == 11
          @m11 << v.to_i
          end
          if k.mon.to_i == 12
          @m12 << v.to_i
          end

        end
        fb_count['share'].each do |k,v|
          if k.mon.to_i == 1
          @m1s << v.to_i
          end
          if k.mon.to_i == 2
          @m2s << v.to_i
          end
          if k.mon.to_i == 3
          @m3s << v.to_i
          end
          if k.mon.to_i == 4
          @m4s << v.to_i
          end
          if k.mon.to_i == 5
          @m5s << v.to_i
          end
          if k.mon.to_i == 6
          @m6s << v.to_i
          end
          if k.mon.to_i == 7
          @m7s << v.to_i
          end
          if k.mon.to_i == 8
          @m8s << v.to_i
          end
          if k.mon.to_i == 9
          @m9s << v.to_i
          end
          if k.mon.to_i == 10
          @m10s << v.to_i
          end
          if k.mon.to_i == 11
          @m11s << v.to_i
          end
          if k.mon.to_i == 12
          @m12s << v.to_i
          end

        end
        @data1 = {"page_id" => fb_id,
     "page_name" =>fb_name,
     "sorce" =>"facebook",
     "order" => q+1,
     "comment" => {
       "month" =>{1 =>@m1.reduce(:+),2 =>@m2.reduce(:+),3 =>@m3.reduce(:+),4 =>@m4.reduce(:+),5 =>@m5.reduce(:+),6 =>@m6.reduce(:+),
       7 =>@m7.reduce(:+),8 =>@m8.reduce(:+),9 =>@m9.reduce(:+),10 =>@m10.reduce(:+),11 =>@m11.reduce(:+),12 =>@m12.reduce(:+)}},
     "share"  => {
     "month"=>{1 =>@m1s.reduce(:+),2 =>@m2s.reduce(:+),3 =>@m3s.reduce(:+),4 =>@m4s.reduce(:+),5 =>@m5s.reduce(:+),6 =>@m6s.reduce(:+),
       7 =>@m7s.reduce(:+),8 =>@m8s.reduce(:+),9 =>@m9s.reduce(:+), 10 =>@m10s.reduce(:+),11 =>@m11s.reduce(:+),12 =>@m12s.reduce(:+)}}}
       
       @best1 =Hash.new
       @best1[1] = 1
       if @m2.reduce(:+) > @m1.reduce(:+)
         @best1[1] = 2
       end
       if @m3.reduce(:+) > @m2.reduce(:+)
         @best1[1] = 3
       end
       if @m4.reduce(:+) > @m3.reduce(:+)
         @best1[1] = 3
       end
       if @m5.reduce(:+) > @m4.reduce(:+)
         @best1[1] = 5
       end
       if @m6.reduce(:+) > @m5.reduce(:+)
         @best1[1] = 6
       end
       if @m7.reduce(:+) > @m6.reduce(:+)
         @best1[1] = 7
       end
       if @m8.reduce(:+) > @m7.reduce(:+)
         @best1[1] = 8
       end
       if @m9.reduce(:+) > @m8.reduce(:+)
         @best1[1] = 9
       end
       if @m10.reduce(:+) > @m9.reduce(:+)
         @best1[1] = 10
       end
       if @m11.reduce(:+) > @m10.reduce(:+)
         @best1[1] = 11
       end
       if @m12.reduce(:+) > @m11.reduce(:+)
         @best1[1] = 12
       end
       
        @best2 =Hash.new
       @best2[1] = 1
       if @m2s.reduce(:+) > @m1s.reduce(:+)
         @best2[1] = 2
       end
       if @m3s.reduce(:+) > @m2s.reduce(:+)
         @best2[1] = 3
       end
       if @m4s.reduce(:+)> @m3s.reduce(:+)
         @best2[1] = 3
       end
       if @m5s.reduce(:+) > @m4s.reduce(:+)
         @best2[1] = 5
       end
       if @m6s.reduce(:+) > @m5s.reduce(:+)
         @best2[1] = 6
       end
       if @m7s.reduce(:+) > @m6s.reduce(:+)
         @best2[1] = 7
       end
       if @m8s.reduce(:+) > @m7s.reduce(:+)
         @best2[1] = 8
       end
       if @m9s.reduce(:+) > @m8s.reduce(:+)
         @best2[1] = 9
       end
       if @m10s.reduce(:+) > @m9s.reduce(:+)
         @best2[1] = 10
       end
       if @m11s.reduce(:+) > @m10s.reduce(:+)
         @best2[1] = 11
       end
       if @m12s.reduce(:+) > @m11s.reduce(:+)
         @best2[1] = 12
       end
     
        @data2 = {"page_id" => fb_id,
     "page_name" =>fb_name,
     "sorce" =>"facebook",
     "order" => q+1,
     "comment" => {
       "best_month" => @best1[1]
        },
     "share"  => {
     "best_month"=> @best2[1]  
      }
       }
        @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
        @connection = @db.authenticate("admin", "12345")

       
        @db["tool_A6"].update({"page_id"=>fb_id},@data2)
      end
    end
    render :text => "OK"

  end

  def fors14
    #資料庫s14的csv檔
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("test_kaogaau")
    @insert = mongo_db.authenticate("admin", "12345")
    #{'麗嬰房 媽咪同學會'=>'209251989898','奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}
    @startdate = ["Nov 2009","Dec 2009", "Jan 2010", "Feb 2010","Mar 2010","Apr 2010","May 2010","Jun 2010","Jul 2010","Aug 2010","Sep 2010","Oct 2010","Nov 2010","Dec 2010", "Jan 2011", "Feb 2011","Mar 2011","Apr 2011","May 2011","Jun 2011","Jul 2011","Aug 2011","Sep 2011","Oct 2011","Nov 2011","Dec 2011", "Jan 2012", "Feb 2012","Mar 2012","Apr 2012","May 2012","Jun 2012","Jul 2012","Aug 2012","Sep 2012","Oct 2012","Nov 2012","Dec 2012", "Jan 2013", "Feb 2013","Mar 2013","Apr 2013","May 2013","Jun 2013","Jul 2013","Aug 2013","Sep 2013","Oct 2013","Nov 2013","Dec 2013"]
    @theallarray = []

    (0..16).each do |q|
      if q == 0
        fb = {'麗嬰房 媽咪同學會'=>'209251989898'}
      end
      if q == 1
        fb = {'台灣貝親'=>'131346323572353'}
      end
      if q == 2
        fb = {'奇哥 寶寶的第一個朋友'=>'128267296746'}
      end
      if q == 3
        fb = {'mothercare Taiwan'=>'240961475964301'}
      end
      if q == 4
        fb = {'愛的世界 小熊親子團'=>'237446743049832'}
      end
       if q == 5
     
     fb = {'寶寶日記'=>'279264471269'}
     end
     if q == 6
     
    fb = {'懷孕大小事'=>'319186521484350'} 
     end
    if q == 7
     fb = {'Nac Nac'=>'148722908483450'}
     end
     if q == 8
     fb = {'愛貝比婦幼生活館'=>'222374807844875'}
     end
     if q == 9
     fb = {'LES ENPHANTS PLUS 兒童時尚名店'=>'152486534850394'}
     end
      if q == 10
     fb = {'OshKosh/ Carter'=>'139345196140926'}
     end
      if q == 11
     fb = {'麗嬰房觀光工廠采衣館'=>'169299433126237'}
     end
      if q == 12
     fb = {'BabyHome'=>'135084993203916'}
     end
      if q == 13
     fb = {'親子天下'=>'152905932107'}
     end
      if q == 14
     fb = {'UNIQLO Baby'=>'252975951538930'}
     end
      if q == 15
     fb = {'My nuno'=>'614665685252676'}
     end
    
      if q == 16
      fb = {'Open for kids'=>'518864824797451'} 
     end
      @thealldate = []
      start = Time.now

      fb.each do |fb_name,fb_id|
        fb_count = Hash.new { |k,v| fb_count[v] = Hash.new(0) }
        coll = mongo_db['statistics']
        coll.find("page_id" => fb_id).each do |doc|
         
            t = Date.new(doc['year'],doc['month'])
            fb_count['user'][t] = fb_count['user'][t] + doc['user_count']
          
        end
        puts fb_name
        @array1 = Hash.new
        fb_count['user'] = fb_count['user'].sort
      fb_count['user'].each do |h,k|
          @array1["#{h.to_time.year}-#{h.to_time.month}-#{h.to_time.day}"] = k
        # puts "#{h.to_time.utc}=>#{k},"
        # @array1 << "#{h}=>#{k}"
        end
         @data1 = {
          "page_id" => fb_id,
    "page_name" => fb_name,
    "order" => q+1,
    "sorce" => "facebook",
    "user" => {
        "month" => @array1
    }
}
       @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
        @connection = @db.authenticate("admin", "12345")

         @db["tool_S14"].update({"page_id"=> fb_id},@data1)
      end
    end

    render :text => "OK"

  end

  def s15
     #資料庫s14的csv檔
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("test_kaogaau")
    @insert = mongo_db.authenticate("admin", "12345")
    #{'麗嬰房 媽咪同學會'=>'209251989898','奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}
     @theallarray = []

    (0..16).each do |q|
        if q == 0
        fb = {'麗嬰房 媽咪同學會'=>'209251989898'}
      end
      if q == 1
        fb = {'台灣貝親'=>'131346323572353'}
      end
      if q == 2
        fb = {'奇哥 寶寶的第一個朋友'=>'128267296746'}
      end
      if q == 3
        fb = {'mothercare Taiwan'=>'240961475964301'}
      end
      if q == 4
        fb = {'愛的世界 小熊親子團'=>'237446743049832'}
      end
       if q == 5
     
     fb = {'寶寶日記'=>'279264471269'}
     end
     if q == 6
     
    fb = {'懷孕大小事'=>'319186521484350'} 
     end
    if q == 7
     fb = {'Nac Nac'=>'148722908483450'}
     end
     if q == 8
     fb = {'愛貝比婦幼生活館'=>'222374807844875'}
     end
     if q == 9
     fb = {'LES ENPHANTS PLUS 兒童時尚名店'=>'152486534850394'}
     end
      if q == 10
     fb = {'OshKosh/ Carter'=>'139345196140926'}
     end
      if q == 11
     fb = {'麗嬰房觀光工廠采衣館'=>'169299433126237'}
     end
      if q == 12
     fb = {'BabyHome'=>'135084993203916'}
     end
      if q == 13
     fb = {'親子天下'=>'152905932107'}
     end
      if q == 14
     fb = {'UNIQLO Baby'=>'252975951538930'}
     end
      if q == 15
     fb = {'My nuno'=>'614665685252676'}
     end
    
      if q == 16
      fb = {'Open for kids'=>'518864824797451'} 
     end
      @thealldate = []
      start = Time.now
      user = Hash.new{|k,v| user[v] = Hash.new(0)}
      fb.each do |fb_name,fb_id|
        fb_count = Hash.new { |k,v| fb_count[v] = Hash.new(0) }
        coll = mongo_db['posts']
        coll.find("page_id" => fb_id).each do |doc|
          if  doc['doc'].has_key?('comments') 
           doc['doc']['comments']['data'].each do |ele|
        user[ele['created_time'][0..6]][ele['from']['id']] = ele['from']['name']
          end
        end
     end
        @array1 = Hash.new
        
      user.each do |h,k|
        singlemonth = "#{h}-1"
          @array1["#{singlemonth.to_time.year}-#{singlemonth.to_time.month}-#{singlemonth.to_time.day}"] = k.size
        end
        
         @data1 = {
          "page_id" => fb_id,
    "page_name" => fb_name,
    "order" => q+1,
    "sorce" => "facebook",
    "data" =>  @array1
    
}
       @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
        @connection = @db.authenticate("admin", "12345")

         @db["tool_S15"].update({"page_id"=> fb_id},@data1)
      end
    end

    render :text => "OK"

  end

  def fors16
    #資料庫c5
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("test_kaogaau")
    @insert = mongo_db.authenticate("admin", "12345")
    #{'麗嬰房 媽咪同學會'=>'209251989898','奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}
    #設定要統計的粉絲團 "name" => "id"
    (0..16).each do |q|
      @cccname = []
      @ccccount = []
      @ccid =[]
       if q == 0
        fb = {'麗嬰房 媽咪同學會'=>'209251989898'}
      end
      if q == 1
        fb = {'台灣貝親'=>'131346323572353'}
      end
      if q == 2
        fb = {'奇哥 寶寶的第一個朋友'=>'128267296746'}
      end
      if q == 3
        fb = {'mothercare Taiwan'=>'240961475964301'}
      end
      if q == 4
        fb = {'愛的世界 小熊親子團'=>'237446743049832'}
      end
       if q == 5
     
     fb = {'寶寶日記'=>'279264471269'}
     end
     if q == 6
     
    fb = {'懷孕大小事'=>'319186521484350'} 
     end
    if q == 7
     fb = {'Nac Nac'=>'148722908483450'}
     end
     if q == 8
     fb = {'愛貝比婦幼生活館'=>'222374807844875'}
     end
     if q == 9
     fb = {'LES ENPHANTS PLUS 兒童時尚名店'=>'152486534850394'}
     end
      if q == 10
     fb = {'OshKosh/ Carter'=>'139345196140926'}
     end
      if q == 11
     fb = {'麗嬰房觀光工廠采衣館'=>'169299433126237'}
     end
      if q == 12
     fb = {'BabyHome'=>'135084993203916'}
     end
      if q == 13
     fb = {'親子天下'=>'152905932107'}
     end
      if q == 14
     fb = {'UNIQLO Baby'=>'252975951538930'}
     end
      if q == 15
     fb = {'My nuno'=>'614665685252676'}
     end
    
      if q == 16
      fb = {'Open for kids'=>'518864824797451'} 
     end
      user = Hash.new{|k,v| user[v] = Hash.new(0)}
      fb.each do |fb_name,fb_id|
        puts "S16_意見領袖分析"
        coll = mongo_db['posts']

        coll.find("page_id" => fb_id).each do |doc|
          if doc['doc'].has_key?('comments')
            doc['doc']['comments']['data'].each do |ele|
              arr = [ele['from']['id'],ele['from']['name']]
              user[ele['created_time'][0..6]][arr] += 1
            end
          end
        end

      end
        
      #排序
      user.each do |k,v|
        user[k] = v.sort_by{|m,n| n}
      end
      user.each do |k,v|
        user[k] = v.to_a
        user[k] = user[k].reverse
      end
    
      #輸出

      user.each do |k,v|

        v.each_with_index do |ele,index|

          @cccname << "#{ele[0][1]}"
          @ccccount << "#{ele[1]}"
          @ccid << "#{ele[0][0]}"
          #取前五名
          if index > 3
          break
          end
        end

      end
      
      fb.each do |fb_name,fb_id|
        @data1 = {"page_id" => fb_id,
     "page_name" =>fb_name,
     "sorce" =>"facebook",
     "order" => q+1,
     "comment" => {
       @cccname[0]=> @ccccount[0],
       @cccname[1]=> @ccccount[1],
       @cccname[2]=> @ccccount[2],
       @cccname[3]=> @ccccount[3],
       @cccname[4]=> @ccccount[4]
               },
      "fb_id" =>{
        @cccname[0]=> @ccid[0],
       @cccname[1]=> @ccid[1],
       @cccname[2]=> @ccid[2],
       @cccname[3]=> @ccid[3],
       @cccname[4]=> @ccid[4]
      }         
               }
               @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
      @connection = @db.authenticate("admin", "12345")
      @db["tool_C5"].update({"page_id"=>fb_id},@data1)
      end
      
    end

    #程式時間--------------
    render :text => "OK"
  end
  def fors16_sep
    #資料庫c5
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("test_kaogaau")
    @insert = mongo_db.authenticate("admin", "12345")
   
    (0..16).each do |q|
      @cccname = []
      @ccccount = []
      @ccid =[]
       if q == 0
        fb = {'麗嬰房 媽咪同學會'=>'209251989898'}
      end
      if q == 1
        fb = {'台灣貝親'=>'131346323572353'}
      end
      if q == 2
        fb = {'奇哥 寶寶的第一個朋友'=>'128267296746'}
      end
      if q == 3
        fb = {'mothercare Taiwan'=>'240961475964301'}
      end
      if q == 4
        fb = {'愛的世界 小熊親子團'=>'237446743049832'}
      end
       if q == 5
     
     fb = {'寶寶日記'=>'279264471269'}
     end
     if q == 6
     
    fb = {'懷孕大小事'=>'319186521484350'} 
     end
    if q == 7
     fb = {'Nac Nac'=>'148722908483450'}
     end
     if q == 8
     fb = {'愛貝比婦幼生活館'=>'222374807844875'}
     end
     if q == 9
     fb = {'LES ENPHANTS PLUS 兒童時尚名店'=>'152486534850394'}
     end
      if q == 10
     fb = {'OshKosh/ Carter'=>'139345196140926'}
     end
      if q == 11
     fb = {'麗嬰房觀光工廠采衣館'=>'169299433126237'}
     end
      if q == 12
     fb = {'BabyHome'=>'135084993203916'}
     end
      if q == 13
     fb = {'親子天下'=>'152905932107'}
     end
      if q == 14
     fb = {'UNIQLO Baby'=>'252975951538930'}
     end
      if q == 15
     fb = {'My nuno'=>'614665685252676'}
     end
    
      if q == 16
      fb = {'Open for kids'=>'518864824797451'} 
     end
      user = Hash.new{|k,v| user[v] = Hash.new(0)}
      fb.each do |fb_name,fb_id|
        puts "S16_意見領袖分析"
        coll = mongo_db['posts']

        coll.find("page_id" => fb_id).each do |doc|
          if doc['doc'].has_key?('comments')
            doc['doc']['comments']['data'].each do |ele|
              arr = [ele['from']['id'],ele['from']['name']]
              user[ele['created_time'][0..6]][arr] += 1
            end
          end
        end

      end
        @user = Hash.new(0)
      #排序
      user.each do |k,v|
        user[k] = v.sort_by{|m,n| n}
      end
      user.each do |k,v|
        user[k] = v.to_a
        user[k] = user[k].reverse
         user[k] = user[k].first(5)
         @user[k] = Hash.new
         (0..4).each do |i|
           if user[k][i].present?
             
         @user[k][i] = {"fb_id"=>user[k][i][0][0],"name"=>user[k][i][0][1],"count"=>user[k][i][1]}
         end
         end
      end
  
      #輸出

     
      
      fb.each do |fb_name,fb_id|
        @data1 = {"page_id" => fb_id,
     "page_name" =>fb_name,
     "sorce" =>"facebook",
     "order" => q+1,
     "comment" => @user
        }
               @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
      @connection = @db.authenticate("admin", "12345")
      @db["tool_C5_sep"].update({"page_id"=>fb_id},@data1)
    
      end
      
    end

    #程式時間--------------
    render :text => "OK"
  end

  def keyword_final
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("dashboard")
    @insert = mongo_db.authenticate("admin", "12345")
    (0..4).each do |q|
      if q == 0
        fb = {'麗嬰房 媽咪同學會'=>'209251989898'}
      end
      if q == 1
        fb = {'台灣貝親'=>'131346323572353'}
      end
      if q == 2
        fb = {'奇哥 寶寶的第一個朋友'=>'128267296746'}
      end
      if q == 3
        fb = {'mothercare Taiwan'=>'240961475964301'}
      end
      if q == 4
        fb = {'愛的世界 小熊親子團'=>'237446743049832'}
      end
      fb.each do |fb_name,fb_id|
        hash = Hash.new{|k,v| hash[v] = Hash.new(0)}

        coll = mongo_db['keyword_statics']

        coll.find("occurrence_sum" => {"$gt" => 0},"page_id" => fb_id,).each do |doc|
          s = doc['static_date']
          s[4] = '-'
          hash[doc['word']][s] += doc['occurrence_sum']
        end

        hash.each do |k,v|
          hash[k] = v.sort_by{|m,n| m}
        end
        hash2 = Hash.new{|k,v| hash2[v] = Hash.new(0)}
        hash2['page_id'] = fb_id
        hash2['sorce'] = fb_name
        hash.each do |k,v|
          v.each do |ele|
            hash2[k][ele[0]] = ele[1]
          end
        end
        coll = mongo_db['keyword_final']
        coll.insert(hash2)
      end

    end
    render :text => "OK"

  end

end