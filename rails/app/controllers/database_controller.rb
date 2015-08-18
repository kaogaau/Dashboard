# coding: utf-8
class DatabaseController < ActionController::Base
  protect_from_forgery
  #後端處理資料的controller
  def forcsv
    #時間趨勢圖需要用到csv
    require "csv"
    @a4 = @db["tool_A4"].find.to_a
    @a40 = @a4[0]["comment"]["month"]
    CSV.open( "#{Rails.root}/public/a40.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @a40.each do |key,value|
        writer << [key.to_s,value.to_s]
      end
    end
    @a40s = @a4[0]["share"]["month"]
    CSV.open( "#{Rails.root}/public/a40s.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @a40s.each do |key,value|
        writer << [key.to_s,value.to_s]
      end
    end
    @a41 = @a4[1]["comment"]["month"]
    CSV.open( "#{Rails.root}/public/a41.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @a41.each do |key,value|
        writer << [key.to_s,value.to_s]
      end
    end
    @a41s = @a4[1]["share"]["month"]
    CSV.open( "#{Rails.root}/public/a41s.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @a41s.each do |key,value|
        writer << [key.to_s,value.to_s]
      end
    end
    @a42 = @a4[2]["comment"]["month"]
    CSV.open( "#{Rails.root}/public/a42.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @a42.each do |key,value|
        writer << [key.to_s,value.to_s]
      end
    end
    @a42s = @a4[2]["share"]["month"]
    CSV.open( "#{Rails.root}/public/a42s.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @a42s.each do |key,value|
        writer << [key.to_s,value.to_s]
      end
    end
    @a43 = @a4[3]["comment"]["month"]
    CSV.open( "#{Rails.root}/public/a43.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @a43.each do |key,value|
        writer << [key.to_s,value.to_s]
      end
    end
    @a43s = @a4[3]["share"]["month"]
    CSV.open( "#{Rails.root}/public/a43s.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @a43s.each do |key,value|
        writer << [key.to_s,value.to_s]
      end
    end
    @a44 = @a4[4]["comment"]["month"]
    CSV.open( "#{Rails.root}/public/a44.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @a44.each do |key,value|
        writer << [key.to_s,value.to_s]
      end
    end
    @a44s = @a4[4]["share"]["month"]
    CSV.open( "#{Rails.root}/public/a44s.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @a44s.each do |key,value|
        writer << [key.to_s,value.to_s]
      end
    end
    CSV.open( "#{Rails.root}/public/all.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @a44.each do |key,value|
        @total = @a40[key.to_s].to_i  + @a41[key.to_s].to_i + @a42[key.to_s].to_i + @a43[key.to_s].to_i + @a44[key.to_s].to_i
        writer << [key.to_s,@total.to_s]
      end
    end
    CSV.open( "#{Rails.root}/public/alls.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @a44s.each do |key,value|
        @total = @a40s[key.to_s].to_i  + @a41s[key.to_s].to_i + @a42s[key.to_s].to_i + @a43s[key.to_s].to_i + @a44s[key.to_s].to_i
        writer << [key.to_s,@total.to_s]
      end
    end
    render :text => "OK"
  end

  def forcsv2
    #時間趨勢圖需要用到csv
    require "csv"
    @c3 = @db["tool_C3"].find.to_a
    @c30 = @c3[0]["user"]["month"]
    @c31 = @c3[1]["user"]["month"]
    @c32 = @c3[2]["user"]["month"]
    @c33 = @c3[3]["user"]["month"]
    @c34 = @c3[4]["user"]["month"]

    CSV.open( "#{Rails.root}/public/usertime/all.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @c34.each do |key,value|
        @total = @c30[key.to_s].to_i  + @c31[key.to_s].to_i + @c32[key.to_s].to_i + @c33[key.to_s].to_i + @c34[key.to_s].to_i
        writer << [key.to_s,@total.to_s]
      end
    end

    render :text => "OK"
  end

  def f3
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("babyhome")
    @insert = mongo_db.authenticate("or", "12345")
    brand= ['愛的世界','麗嬰房','貝親','奇哥','mothercare']
    
  count = Hash.new(0)
    brand.each do |brand_name|
      arr = ['Baby_babythings','Beauty_momtalk','Birdcall','Edu_teacher']
      arr.each do |ele|
        coll = mongo_db[ele]
        coll.find("post_content" =>{"$ne"=>''},"doc" =>{"$ne"=>''}).each do |doc|
          if doc['doc']['message'] != nil
            con = doc['doc']['post_content']
            if /#{brand_name}/.match(con) != nil
              timer = doc["doc"]['post_time']
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

            doc['doc']['response'].each do |k,v|

              str = v['response_content']
              if /#{brand_name}/.match(str) != nil  &&  v['response_author'] != nil
                timer = v['response_time']
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
    "sorce" => babyhome,
    "order" => 1,
    "愛的世界" => @array1,
    "麗嬰房" => @array2,
    "貝親" => @array3,
    "奇哥" => @array4,
    "mothercare" => @array5

}
    
      @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
       @connection = @db.authenticate("admin", "12345")
       @db["tool_f3"].insert(@data1)
    render :text => @data1
  end

  def f10
    #資料庫f10
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("babyhome")
    @insert = mongo_db.authenticate("or", "12345")
    post_count = 0
    response_count = 0
    post_count = Hash.new(0)
    response_count = Hash.new(0)
    puts "S8_互動度分析"
    #統計---------------------
    arr = ['Baby_babythings','Beauty_momtalk','Birdcall','Edu_teachter','IaCA_cheap','IaCA_events','IaCA_house','IaCA_insurance','IaCA_workplace','Man_543','Man_newhand','Man_understand','Novel','Talk','Waitbird','pregnant']
    arr.each do |ele|
      coll = mongo_db[ele]
      coll.find.each do |doc|
        if doc['doc']['post_time'].size > 9
          y = doc['doc']['post_time'][0..3].to_i
          m = doc['doc']['post_time'][5..6].to_i
          t = Date.new(y,m)
          post_count[t] += 1
          if doc['doc']['response'].size > 0
            doc['doc']['response'].each do |k,v|
              begin
                r_y = v['response_time'][0..3].to_i
                r_m = v['response_time'][5..6].to_i
                r_t = Date.new(r_y,r_m)
                response_count[t] += 1
              rescue Exception => e
              next
              end

            end
          end
        end
      end
    end
    @array3 = Hash.new
    @array4 = Hash.new
    post_count = post_count.sort
    response_count = response_count.sort
    post_count.each do |h,k|
      puts "\'#{h}\':#{k},"
      @array3["#{h.to_time.year}-#{h.to_time.month}-#{h.to_time.day}"] = k
    end
    puts "--------------"
    response_count.each do |h,k|
      puts "\'#{h}\':#{k},"
      @array4["#{h.to_time.year}-#{h.to_time.month}-#{h.to_time.day}"] = k
    end

    @data1 ={
    "page_name" => "Babyhome",
    "sorce" => "forums",
    "post" => {
        "month" =>  @array3

    },
    "comment" => {
        "month" => @array4
    }
}

    post_count = 0
    response_count = 0
    post_count = Hash.new(0)
    response_count = Hash.new(0)

    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("mababy")
    @insert = mongo_db.authenticate("or", "12345")
    arr = ['product_try']
    arr.each do |ele|
      coll = mongo_db[ele]
      coll.find.each do |doc|
        if doc['doc']['post_time'].size > 9
          y = doc['doc']['post_time'][0..3].to_i
          m = doc['doc']['post_time'][5..6].to_i
          t = Date.new(y,m)
          post_count[t] += 1
          if doc['doc']['response'].size > 0
            doc['doc']['response'].each do |k,v|
              begin
                r_y = v['response_time'][0..3].to_i
                r_m = v['response_time'][5..6].to_i
                r_t = Date.new(r_y,r_m)
                response_count[t] += 1
              rescue Exception => e
              next
              end

            end
          end
        end
      end
    end
    @array1 = Hash.new
    @array2 = Hash.new
    post_count = post_count.sort
    response_count = response_count.sort
    post_count.each do |h,k|
      @array1["#{h.to_time.year}-#{h.to_time.month}-#{h.to_time.day}"] = k
    # puts "#{h.to_time.utc}=>#{k},"
    # @array1 << "#{h}=>#{k}"
    end
    puts "--------------"
    response_count.each do |h,k|
      @array2["#{h.to_time.year}-#{h.to_time.month}-#{h.to_time.day}"] = k
    #puts "#{h.to_time.year}-#{h.to_time.month}-#{h.to_time.day}=>#{k},"
    #@array2 << "#{h}=>#{k}"
    end
    @data2 ={
    "page_name" => "Mababy",
    "sorce" => "forums",
    "post" => {
        "month" => @array1
    },
    "comment" => {
        "month" => @array2
    }
}

    @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
    @connection = @db.authenticate("admin", "12345")
    #@db["tool_f10"].update({"page_name" => "Babyhome"},@data1)
    @db["tool_f10"].update({"page_name" => "Mababy"},@data2)
    render :text => @data2
  end

  def w10
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("weibo")
    @insert = mongo_db.authenticate("or", "12345")
    #{'麗嬰房 媽咪同學會'=>'209251989898','奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}

    (0..3).each do |q|
      if q == 0
        weibo = {'丽婴房'=>'209251989898'}
      end
      if q == 1
        weibo = {'红孩儿'=>'209251989898'}
      end
      if q == 2
        weibo = {'派克兰帝'=>'209251989898'}
      end
      if q == 3
        weibo = {'小猪班纳'=>'209251989898'}
      end
      post_count = Hash.new(0)
      response_count = Hash.new(0)
      weibo.each do |w_name,w_id|
        w_count = Hash.new { |k,v| w_count[v] = Hash.new(0) }
        coll = mongo_db['weibo_articles']
        coll.find.each do |doc|
          if doc['page_name'] == w_name
            if doc['doc']['post_time'].size > 9
              y = doc['doc']['post_time'][0..3].to_i
              m = doc['doc']['post_time'][5..6].to_i
              t = Date.new(y,m)
              post_count[t] += 1
              if doc['doc']['comments']['data'].size > 0
                doc['doc']['comments']['data'].each do |k,v|
                  begin
                    r_y = k['created_time'][0..3].to_i
                    r_m = k['created_time'][5..6].to_i
                    r_t = Date.new(r_y,r_m)
                    response_count[t] += 1
                  rescue Exception => e
                  next
                  end

                end
              end
            end
          end
        end
        @array1 = Hash.new
        @array2 = Hash.new
        post_count = post_count.sort
        response_count = response_count.sort
        post_count.each do |h,k|
          @array1["#{h.to_time.year}-#{h.to_time.month}-#{h.to_time.day}"] = k
        # puts "#{h.to_time.utc}=>#{k},"
        # @array1 << "#{h}=>#{k}"
        end
        puts "--------------"
        response_count.each do |h,k|
          @array2["#{h.to_time.year}-#{h.to_time.month}-#{h.to_time.day}"] = k
        #puts "#{h.to_time.year}-#{h.to_time.month}-#{h.to_time.day}=>#{k},"
        #@array2 << "#{h}=>#{k}"
        end

        @data1 = {
    "page_name" => w_name,
    "sorce" => "weibo",
    "post" => {
        "month" => @array1
    },
    "comment" => {
        "month" => @array2
    }
}
        @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
        @connection = @db.authenticate("admin", "12345")

        @db["tool_w10"].update({"page_name" => w_name},@data1)

      end
    end

    render :text => "OK"
  end

  def w11
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("weibo")
    @insert = mongo_db.authenticate("or", "12345")
    #{'麗嬰房 媽咪同學會'=>'209251989898','奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}

    (0..3).each do |q|
      if q == 0
        weibo = {'丽婴房'=>'209251989898'}
      end
      if q == 1
        weibo = {'红孩儿'=>'209251989898'}
      end
      if q == 2
        weibo = {'派克兰帝'=>'209251989898'}
      end
      if q == 3
        weibo = {'小猪班纳'=>'209251989898'}
      end
      post_count = Hash.new(0)
      response_count = Hash.new(0)
      weibo.each do |w_name,w_id|
        w_count = Hash.new { |k,v| w_count[v] = Hash.new(0) }
        coll = mongo_db['weibo_articles']
        coll.find.each do |doc|
          str = doc['doc']['post_time'][5..6]
          #t = Date.strptime(str,'%Y-%m')
          post_count[str] += 1

          #if doc['doc']['comments']['data'] != [] || doc['doc']['comments']['data'] != "[]" || doc['doc']['comments']['data'] != nil || doc['doc']['comments']['data'].size > 0 || doc['doc']['comments']['data'].length > 0
          if doc['doc']['comments']['data'].size > 0
            doc['doc']['comments']['data'].each do |k,v|

              if  k.has_key?('created_time') &&  k['created_time'] != nil

                str2 = k['created_time'][5..6]
              response_count[str2] += 1
              end
            end
          end
        end

        @array1 = []
        @array2 = []
        @ccc = []
        @m1p = []
        @m2p = []
        @m3p = []
        @m4p = []
        @m5p = []
        @m6p = []
        @m7p = []
        @m8p = []
        @m9p = []
        @m10p = []
        @m11p = []
        @m12p = []
        @m1c = []
        @m2c = []
        @m3c = []
        @m4c = []
        @m5c = []
        @m6c = []
        @m7c = []
        @m8c = []
        @m9c = []
        @m10c = []
        @m11c = []
        @m12c = []
        post_count = post_count.sort
        #response_count = response_count .delete(" ")
        response_count = response_count.sort
        puts "post"
        post_count.each do |h,k|
          puts "#{h}:#{k}"
          if h.to_i == 1
          @m1p << k.to_i
          end
          if h.to_i == 2
          @m2p << k.to_i
          end
          if h.to_i == 3
          @m3p << k.to_i
          end
          if h.to_i == 4
          @m4p << k.to_i
          end
          if h.to_i == 5
          @m5p << k.to_i
          end
          if h.to_i == 6
          @m6p << k.to_i
          end
          if h.to_i == 7
          @m7p << k.to_i
          end
          if h.to_i == 8
          @m8p << k.to_i
          end
          if h.to_i == 9
          @m9p << k.to_i
          end
          if h.to_i == 10
          @m10p << k.to_i
          end
          if h.to_i == 11
          @m11p << k.to_i
          end
          if h.to_i == 12
          @m12p << k.to_i
          end
        end
        puts "response"
        response_count.each do |h,k|
          puts "#{h}:#{k}"
          if h.to_i == 1
          @m1c << k.to_i
          end
          if h.to_i == 2
          @m2c << k.to_i
          end
          if h.to_i == 3
          @m3c << k.to_i
          end
          if h.to_i == 4
          @m4c << k.to_i
          end
          if h.to_i == 5
          @m5c << k.to_i
          end
          if h.to_i == 6
          @m6c << k.to_i
          end
          if h.to_i == 7
          @m7c << k.to_i
          end
          if h.to_i == 8
          @m8c << k.to_i
          end
          if h.to_i == 9
          @m9c << k.to_i
          end
          if h.to_i == 10
          @m10c << k.to_i
          end
          if h.to_i == 11
          @m11c << k.to_i
          end
          if h.to_i == 12
          @m12c << k.to_i
          end
        end

        @data1 = {
    "page_name" => w_name,
    "sorce" => "weibo",
   "post" => {
        "month" => {
            "1" => @m1p.reduce(:+),
            "2" => @m2p.reduce(:+),
            "3" => @m3p.reduce(:+),
            "4" => @m4p.reduce(:+),
            "5" => @m5p.reduce(:+),
            "6" => @m6p.reduce(:+),
            "7" => @m7p.reduce(:+),
            "8" => @m8p.reduce(:+),
            "9" => @m9p.reduce(:+),
            "10" => @m10p.reduce(:+),
            "11" => @m11p.reduce(:+),
            "12" => @m12p.reduce(:+)
        }
    },
    "comment" => {
        "month" => {
            "1" => @m1c.reduce(:+),
            "2" => @m2c.reduce(:+),
            "3" => @m3c.reduce(:+),
            "4" => @m4c.reduce(:+),
            "5" => @m5c.reduce(:+),
            "6" => @m6c.reduce(:+),
            "7" => @m7c.reduce(:+),
            "8" => @m8c.reduce(:+),
            "9" => @m9c.reduce(:+),
            "10" => @m10c.reduce(:+),
            "11" => @m11c.reduce(:+),
            "12" => @m12c.reduce(:+)
        }
    }
}
        @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
        @connection = @db.authenticate("admin", "12345")

        @db["tool_w11"].update({"page_name" => w_name},@data1)

      end
    end

    render :text => "OK"
  end

  def f12
    #資料庫f12
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("babyhome")
    @insert = mongo_db.authenticate("or", "12345")
    post_count = 0
    response_count = 0
    puts "S12_互動度分析"
    #統計---------------------
    arr = ['Baby_babythings','Beauty_momtalk','Birdcall','Edu_teachter','IaCA_cheap','IaCA_events','IaCA_house','IaCA_insurance','IaCA_workplace','Man_543','Man_newhand','Man_understand','Novel','Talk','Waitbird','pregnant']
    post_count = Hash.new(0)
    response_count = Hash.new(0)
    arr.each do |ele|
      coll = mongo_db[ele]
      coll.find.each do |doc|
        if doc['doc']['post_time'].size > 9
          str = doc['doc']['post_time'][5..6]
        #t = Date.strptime(str,'%Y-%m')
        post_count[str] += 1
        end
        if doc['doc']['response'].size > 0
          doc['doc']['response'].each do |k,v|

            if  v.has_key?('response_time') &&  v['response_time'] != nil

              str2 = v['response_time'][5..6]
            response_count[str2] += 1

            end
          end
        end
      end
    end
    @array1 = []
    @array2 = []
    @ccc = []
    @m1p = []
    @m2p = []
    @m3p = []
    @m4p = []
    @m5p = []
    @m6p = []
    @m7p = []
    @m8p = []
    @m9p = []
    @m10p = []
    @m11p = []
    @m12p = []
    @m1c = []
    @m2c = []
    @m3c = []
    @m4c = []
    @m5c = []
    @m6c = []
    @m7c = []
    @m8c = []
    @m9c = []
    @m10c = []
    @m11c = []
    @m12c = []
    post_count = post_count.sort
    #response_count = response_count .delete(" ")
    #response_count = response_count.sort
    puts "post"
    post_count.each do |h,k|
      puts "#{h}:#{k}"
      if h.to_i == 1
      @m1p << k.to_i
      end
      if h.to_i == 2
      @m2p << k.to_i
      end
      if h.to_i == 3
      @m3p << k.to_i
      end
      if h.to_i == 4
      @m4p << k.to_i
      end
      if h.to_i == 5
      @m5p << k.to_i
      end
      if h.to_i == 6
      @m6p << k.to_i
      end
      if h.to_i == 7
      @m7p << k.to_i
      end
      if h.to_i == 8
      @m8p << k.to_i
      end
      if h.to_i == 9
      @m9p << k.to_i
      end
      if h.to_i == 10
      @m10p << k.to_i
      end
      if h.to_i == 11
      @m11p << k.to_i
      end
      if h.to_i == 12
      @m12p << k.to_i
      end
    end
    puts "response"
    response_count .each do |h,k|
      puts "#{h}:#{k}"
      if h.to_i == 1
      @m1c << k.to_i
      end
      if h.to_i == 2
      @m2c << k.to_i
      end
      if h.to_i == 3
      @m3c << k.to_i
      end
      if h.to_i == 4
      @m4c << k.to_i
      end
      if h.to_i == 5
      @m5c << k.to_i
      end
      if h.to_i == 6
      @m6c << k.to_i
      end
      if h.to_i == 7
      @m7c << k.to_i
      end
      if h.to_i == 8
      @m8c << k.to_i
      end
      if h.to_i == 9
      @m9c << k.to_i
      end
      if h.to_i == 10
      @m10c << k.to_i
      end
      if h.to_i == 11
      @m11c << k.to_i
      end
      if h.to_i == 12
      @m12c << k.to_i
      end
    end
    @data1 ={
    "page_name" => "Babyhome",
    "sorce" => "forums",
    "post" => {
        "month" => {
            "1" => @m1p.reduce(:+),
            "2" => @m2p.reduce(:+),
            "3" => @m3p.reduce(:+),
            "4" => @m4p.reduce(:+),
            "5" => @m5p.reduce(:+),
            "6" => @m6p.reduce(:+),
            "7" => @m7p.reduce(:+),
            "8" => @m8p.reduce(:+),
            "9" => @m9p.reduce(:+),
            "10" => @m10p.reduce(:+),
            "11" => @m11p.reduce(:+),
            "12" => @m12p.reduce(:+)
        }
    },
    "comment" => {
        "month" => {
            "1" => @m1c.reduce(:+),
            "2" => @m2c.reduce(:+),
            "3" => @m3c.reduce(:+),
            "4" => @m4c.reduce(:+),
            "5" => @m5c.reduce(:+),
            "6" => @m6c.reduce(:+),
            "7" => @m7c.reduce(:+),
            "8" => @m8c.reduce(:+),
            "9" => @m9c.reduce(:+),
            "10" => @m10c.reduce(:+),
            "11" => @m11c.reduce(:+),
            "12" => @m12c.reduce(:+)
        }
    }
}
    post_count = 0
    response_count = 0
    post_count = Hash.new(0)
    response_count = Hash.new(0)

    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("mababy")
    @insert = mongo_db.authenticate("or", "12345")
    arr = ['product_try']
    arr.each do |ele|
      coll = mongo_db[ele]
      coll.find.each do |doc|
        if doc['doc']['post_time'].size > 9
          str = doc['doc']['post_time'][5..6]
        #t = Date.strptime(str,'%Y-%m')
        post_count[str] += 1
        end
        if doc['doc']['response'].size > 0
          doc['doc']['response'].each do |k,v|
            if  v.has_key?('response_time') &&  v['response_time'] != nil

              str2 = v['response_time'][5..6]
            response_count[str2] += 1

            end
          end
        end
      end
    end
    @array1 = []
    @array2 = []
    @ccc = []
    @m1p = []
    @m2p = []
    @m3p = []
    @m4p = []
    @m5p = []
    @m6p = []
    @m7p = []
    @m8p = []
    @m9p = []
    @m10p = []
    @m11p = []
    @m12p = []
    @m1c = []
    @m2c = []
    @m3c = []
    @m4c = []
    @m5c = []
    @m6c = []
    @m7c = []
    @m8c = []
    @m9c = []
    @m10c = []
    @m11c = []
    @m12c = []
    post_count = post_count.sort
    #response_count = response_count .delete(" ")
    #response_count = response_count.sort
    puts "post"
    post_count.each do |h,k|
      puts "#{h}:#{k}"
      if h.to_i == 1
      @m1p << k.to_i
      end
      if h.to_i == 2
      @m2p << k.to_i
      end
      if h.to_i == 3
      @m3p << k.to_i
      end
      if h.to_i == 4
      @m4p << k.to_i
      end
      if h.to_i == 5
      @m5p << k.to_i
      end
      if h.to_i == 6
      @m6p << k.to_i
      end
      if h.to_i == 7
      @m7p << k.to_i
      end
      if h.to_i == 8
      @m8p << k.to_i
      end
      if h.to_i == 9
      @m9p << k.to_i
      end
      if h.to_i == 10
      @m10p << k.to_i
      end
      if h.to_i == 11
      @m11p << k.to_i
      end
      if h.to_i == 12
      @m12p << k.to_i
      end
    end
    puts "response"
    response_count .each do |h,k|
      puts "#{h}:#{k}"
      if h.to_i == 1
      @m1c << k.to_i
      end
      if h.to_i == 2
      @m2c << k.to_i
      end
      if h.to_i == 3
      @m3c << k.to_i
      end
      if h.to_i == 4
      @m4c << k.to_i
      end
      if h.to_i == 5
      @m5c << k.to_i
      end
      if h.to_i == 6
      @m6c << k.to_i
      end
      if h.to_i == 7
      @m7c << k.to_i
      end
      if h.to_i == 8
      @m8c << k.to_i
      end
      if h.to_i == 9
      @m9c << k.to_i
      end
      if h.to_i == 10
      @m10c << k.to_i
      end
      if h.to_i == 11
      @m11c << k.to_i
      end
      if h.to_i == 12
      @m12c << k.to_i
      end
    end
    @data2 ={
    "page_name" => "Mababy",
    "sorce" => "forums",
    "post" => {
        "month" => {
            "1" => @m1p.reduce(:+),
            "2" => @m2p.reduce(:+),
            "3" => @m3p.reduce(:+),
            "4" => @m4p.reduce(:+),
            "5" => @m5p.reduce(:+),
            "6" => @m6p.reduce(:+),
            "7" => @m7p.reduce(:+),
            "8" => @m8p.reduce(:+),
            "9" => @m9p.reduce(:+),
            "10" => @m10p.reduce(:+),
            "11" => @m11p.reduce(:+),
            "12" => @m12p.reduce(:+)
        }
    },
    "comment" => {
        "month" => {
            "1" => @m1c.reduce(:+),
            "2" => @m2c.reduce(:+),
            "3" => @m3c.reduce(:+),
            "4" => @m4c.reduce(:+),
            "5" => @m5c.reduce(:+),
            "6" => @m6c.reduce(:+),
            "7" => @m7c.reduce(:+),
            "8" => @m8c.reduce(:+),
            "9" => @m9c.reduce(:+),
            "10" => @m10c.reduce(:+),
            "11" => @m11c.reduce(:+),
            "12" => @m12c.reduce(:+)
        }
    }
}

    @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
    @connection = @db.authenticate("admin", "12345")
    @db["tool_f12"].update({"page_name" => "Babyhome"},@data1)
    @db["tool_f12"].update({"page_name" => "Mababy"},@data2)
    render :text => @data1
  end

  def f16
    #資料庫f16
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("babyhome")
    @insert = mongo_db.authenticate("or", "12345")
    post_count = 0
    response_count = 0
    puts "S8_互動度分析"
    #統計---------------------
    arr = ['Baby_babythings','Beauty_momtalk','Birdcall','Edu_teachter','IaCA_cheap','IaCA_events','IaCA_house','IaCA_insurance','IaCA_workplace','Man_543','Man_newhand','Man_understand','Novel','Talk','Waitbird','pregnant']
    @array1 =[]
    @array2= []
    post_count = Hash.new(0)
    response_count = Hash.new(0)
    author_count = Hash.new(0)
    puts "S16_意見領袖分析"
    #統計---------------------
    arr.each do |ele|
      coll = mongo_db[ele]
      coll.find.each do |doc|
      author_count[doc['doc']['post_author']] += doc['doc']['response'].size
      end
    end
  
    #post_count = post_count.sort
    #response_count = response_count.sort
    author_count = author_count.sort_by{|k,v| v}
    author_count = author_count.reverse
    author_count.each do |h,k|
      puts "\'#{h}\':#{k},"
      @array1 << "#{h}"
      @array2 << "#{k}"
    end
    @data2 ={
    "page_name" => "Mababy",
    "sorce" => "forums",
    "top5" => {
        @array1[0] => @array2[0],
        @array1[1] => @array2[1],
        @array1[2] => @array2[2],
        @array1[3] => @array2[3],
        @array1[4] => @array2[4]
    }
}

    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("mababy")
    @insert = mongo_db.authenticate("or", "12345")
    @array3 =[]
    @array4= []
    post_count = Hash.new(0)
    response_count = Hash.new(0)
    author_count = Hash.new(0)
    puts "S16_意見領袖分析"
    #統計---------------------
    arr = ['product_try']
    arr.each do |ele|
      coll = mongo_db[ele]
      coll.find.each do |doc|
      author_count[doc['doc']['post_author']] += doc['doc']['response'].size
      end
    end
    #post_count = post_count.sort
    #response_count = response_count.sort
    author_count = author_count.sort_by{|k,v| v}
    author_count = author_count.reverse
    author_count.each do |h,k|
      puts "\'#{h}\':#{k},"
      @array3 << "#{h}"
      @array4 << "#{k}"
    end
    @data2 ={
    "page_name" => "Mababy",
    "sorce" => "forums",
    "top5" => {
        @array3[0] => @array4[0],
        @array3[1] => @array4[1],
        @array3[2] => @array4[2],
        @array3[3] => @array4[3],
        @array3[4] => @array4[4]
    }
}

    @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
    @connection = @db.authenticate("admin", "12345")
    @db["tool_f16"].update({"page_name" => "Babyhome"},@data1)
    @db["tool_f16"].update({"page_name" => "Mababy"},@data2)
    render :text => @data2
  end

  def forcsvf10
    #資料庫f10的csv檔
    require "csv"
    @f10 = @db["tool_f10"].find.to_a
    @f100p = @f10[0]["post"]["month"]
    @f100c = @f10[0]["comment"]["month"]
    @f101p = @f10[1]["post"]["month"]
    @f101c = @f10[1]["comment"]["month"]

    CSV.open( "#{Rails.root}/public/f10/f100p.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @f100p.each do |key,value|
        d = key.to_date
        writer << [ "#{d.strftime("%b")} #{d.year}",value]
      end
    end
    CSV.open( "#{Rails.root}/public/f10/f100c.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @f100c.each do |key,value|
        d = key.to_date
        writer << [ "#{d.strftime("%b")} #{d.year}",value]
      end
    end
    CSV.open( "#{Rails.root}/public/f10/f101p.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @f101p.each do |key,value|
        d = key.to_date
        writer << [ "#{d.strftime("%b")} #{d.year}",value]
      end
    end
    CSV.open( "#{Rails.root}/public/f10/f101c.csv", 'w' ) do |writer|
      writer << ["date","price"]
      @f101c.each do |key,value|
        d = key.to_date
        writer << [ "#{d.strftime("%b")} #{d.year}",value]
      end
    end
    render :text => "OK"
  end

   def w4
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("dashboard")
    @insert = mongo_db.authenticate("admin", "12345")
    @comname = []
    @alltheword1= []
    (0..3).each do |q|
      if q == 0
    fb = {'丽婴房'=>'209251989898'}
    end
    if q == 1
     fb = {'红孩儿'=>'131346323572353'}
     end
     if q == 2
     fb = {'派克兰帝'=>'128267296746'}
     end
     if q == 3
     fb = {'小猪班纳'=>'240961475964301'}
     end
     
    fb.each do |fb_name,fb_id|
      coll = mongo_db['WeiboRecognizeNegativeResultsSortedByTime']
      coll.find.each do |doc|

        if doc['Company:'] == fb_name
          @alltheword1 << [doc["negative:"],1]
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
      @data1 ={
    "page_name" => fb_name,
    "sorce" => "weibo",
    "top5" => {
         @cart.sort_by{|m,n| n}.reverse.first(5)[0][0] => @cart.sort_by{|m,n| n}.reverse.first(5)[0][1].to_i,
         @cart.sort_by{|m,n| n}.reverse.first(5)[1][0] => @cart.sort_by{|m,n| n}.reverse.first(5)[1][1].to_i,
         @cart.sort_by{|m,n| n}.reverse.first(5)[2][0] => @cart.sort_by{|m,n| n}.reverse.first(5)[2][1].to_i,
         @cart.sort_by{|m,n| n}.reverse.first(5)[3][0] => @cart.sort_by{|m,n| n}.reverse.first(5)[3][1].to_i,
         @cart.sort_by{|m,n| n}.reverse.first(5)[4][0] => @cart.sort_by{|m,n| n}.reverse.first(5)[4][1].to_i
    }
}
@db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
    @connection = @db.authenticate("admin", "12345")

    # @db["tool_w4"].update({"page_id" => fb_id},@data1)
    @db["tool_w4"].insert(@data1)
    end

    
    end
    render :text => "Ok"
  end

  

  def forw8
    #資料庫a1
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("weibo")
    @insert = mongo_db.authenticate("or", "12345")
    #{'麗嬰房 媽咪同學會'=>'209251989898','奇哥 寶寶的第一個朋友'=>'128267296746','愛的世界 小熊親子團'=>'237446743049832','台灣貝親'=>'131346323572353','mothercare Taiwan'=>'240961475964301'}
    @theallarray = []

    (0..3).each do |q|
      @m1p = 0
      @m1c = 0
      @m1l = 0

      if q == 0
        weibo = {'丽婴房'=>'209251989898'}
      end
      if q == 1
        weibo = {'红孩儿'=>'209251989898'}
      end
      if q == 2
        weibo = {'派克兰帝'=>'209251989898'}
      end
      if q == 3
        weibo = {'小猪班纳'=>'209251989898'}
      end

      weibo.each do |w_name,w_id|
        w_count = Hash.new { |k,v| w_count[v] = Hash.new(0) }
        coll = mongo_db['weibo_articles']
        coll.find.each do |doc|
          if doc['page_name'] == w_name

            # w_count['likes'][t] = w_count['likes'][t] + doc['doc']['likes']
            # w_count['comments'][t] = w_count['comments'][t] + doc['comments']['data'].count
            @m1p = @m1p + 1
            @m1l = @m1l + doc['doc']['likes'].to_i
            if doc['doc']['comments']['data'].size > 0
              @m1c = @m1c + doc['doc']['comments']['data'].size
            end
          end
        end

        @data1 = {
    "page_name" => w_name,
    "sorce" => "weibo",
    "engagement" => {
        "total" => @m1p + @m1l + @m1c
    },
    "post" => {
        "total" => @m1p
    },
    "like" => {
        "total" => @m1l
    },
    "comment" => {
        "total" => @m1c
    }
}
        @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
        @connection = @db.authenticate("admin", "12345")

        @db["tool_w8"].update({"page_name" => w_name},@data1)
      # @theallarray << @data1
      end
    end

    render :text => "OK"

  end

 

  def test
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("test_kaogaau")
    @insert = mongo_db.authenticate("admin", "12345")

    fb = {'mothercare Taiwan'=>'240961475964301'}
    @aaa = []
    #統計---------------------
    puts "S12_互動時段分析"
    fb.each do |fb_name,fb_id|
      fb_count = Hash.new { |k,v| fb_count[v] = Hash.new(0) }
      coll = mongo_db['statistics']
      coll.find.each do |doc|
        if doc['page_id'] == fb_id
          t = doc['month']
          fb_count['comment'][t] = fb_count['comment'][t] + doc['comment_count']
        end
      end
      fb_count['comment'] = fb_count['comment'].sort
      #輸出評論時段分析------------按讚與分享無時間-------
      puts "#{fb_name}"
      fb_count['comment'].each do |k,v|
        puts "\"#{k}\" : #{v},"
        @aaa << "\"#{k}\" : #{v},"
      end
    end

    render :text => @aaa
  end

 

  def f8
    #資料庫f8
    require 'time'
    require 'rubygems'
    require 'json'
    require 'bson'
    require 'mongo'
    require'date'
    require "csv"
    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("babyhome")
    @insert = mongo_db.authenticate("or", "12345")
    #區網ip為 192.168.26.180:27017
    #外網ip為 220.132.97.119:37017
    #-----------------------

    #設定要統計的粉絲團 "name" => "id"
    post_count = 0
    response_count = 0
    puts "S8_互動度分析"
    #統計---------------------
    arr = ['Baby_babythings','Beauty_momtalk','Birdcall','Edu_teachter','IaCA_cheap','IaCA_events','IaCA_house','IaCA_insurance','IaCA_workplace','Man_543','Man_newhand','Man_understand','Novel','Talk','Waitbird','pregnant']
    arr.each do |ele|
      coll = mongo_db[ele]
      coll.find.each do |doc|
        post_count += 1
        response_count += doc['doc']['response'].size
      end
    end

    puts post_count
    puts response_count
    @data1 ={
    "page_name" => "Babyhome",
    "sorce" => "fourms",
    "engagement" => {
        "total" => post_count.to_i + response_count.to_i
    },
    "post" => {
        "total" => post_count.to_i
    },
    "comment" => {
        "total" => response_count.to_i
    }
}

    post_count = 0
    response_count = 0

    mongo_db = Mongo::Connection.new('220.132.97.119',37017).db("mababy")
    @insert = mongo_db.authenticate("or", "12345")
    coll = mongo_db['product_try']
    coll.find.each do |doc|
      post_count += 1
      response_count += doc['doc']['response'].size
    end
    @data2 ={
    "page_name" => "Mababy",
    "sorce" => "fourms",
    "engagement" => {
        "total" => post_count.to_i + response_count.to_i
    },
    "post" => {
        "total" => post_count.to_i
    },
    "comment" => {
        "total" => response_count.to_i
    }
}

    @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
    @connection = @db.authenticate("admin", "12345")
    @db["tool_f8"].update({"page_name" => "Babyhome"},@data1)
    @db["tool_f8"].update({"page_name" => "Mababy"},@data2)
  end
  

end
