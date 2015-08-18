# coding: utf-8
class CompareController < ActionController::Base
  protect_from_forgery
  before_filter :load
  def load
    #資料庫的讀取
    if session[:users] == nil
      redirect_to "/login/login"
    end
     require 'rubygems'
    require 'mongo'    
   @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard") 
   @connection = @db.authenticate("admin", "12345") 
   @coll = @db.collection("Collections")  
   @user = @db["user"].find("_id" =>session[:users]).first
   @a1 = @db["tool_A1"].find.sort("order"=> 1).to_a
     @a2 = @db["tool_A2"].find.to_a
     @lasttime = @db["update"].find.to_a
  end
  def s1p
    #圖1熱門字分析
    session[:page] = 1
   
      @s1 = @db["tool_S1"].find.sort("order"=> 1).to_a
   
     
     @name = []
     
     @company = params[:cid].split("")
     if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
     (0..9).each do |n| 
     @company.each do|c|
       
      @name << @s1[c.to_i]["top10"].keys[n]
     end
     end
     #--時間區間
     if session[:other_date].present?
    @s1_sep = @db["tool_S1_sep"].find.sort("order"=> 1).to_a
    @name = []
      (0..9).each do |n| 
     @company.each do|c|
       if @s1_sep[c.to_i]["top10"][session[:other_date]].present?
      @name << @s1_sep[c.to_i]["top10"][session[:other_date]].keys[n]
      end
     end
     end
    end
    #--
     counts = Hash.new(0)
     @name.each { |v| counts[v] += 1 }
     @ppp = counts.select { |v, count| count == 1 }.keys
     
     #--time
      @choose_time = []
     @seclect_time = @db["tool_S1_sep"].find.sort("order" => 1).to_a
     @seclect_time.each do |k,v|
       k["top10"].each do |key,value|
       if @choose_time.include?(key)
       else
         @choose_time << key
       end
       end
     end
     #--
    
  end
  def s2p
    session[:page] = 2
  end
  def s3p
    #圖3品牌趨勢
    session[:page] = 3
    @s3 = @db["tool_S3"].find.sort("order"=> 1).to_a
    @f3 = @db["tool_f3"].find.to_a
    @company = params[:cid].split("")
    if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
     @company2 = params[:fid].split("")
     
  end
  def s4p
    #圖4品牌口碑
     @s4 = @db["tool_S4"].find.sort("order"=> 1).to_a
      @w4 = @db["tool_w4"].find.to_a
     @name = []
    session[:page] = 4
    
    
     @company = params[:cid].split("")
     if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
      (0..4).each do |n| 
     @company.each do|c|
       
      @name << @s4[c.to_i]["top5"].keys[n]
     end
     end
    
     counts = Hash.new(0)
     @name.each { |v| counts[v] += 1 }
     @ppp = counts.select { |v, count| count == 1 }.keys
     #----
      @namew = []
    
     @companyw = params[:wid].split("")
      (0..4).each do |n| 
     @companyw.each do|c|
       
      @namew << @w4[c.to_i]["top5"].keys[n]
     end
     end
    
     countsw = Hash.new(0)
     @namew.each { |v| counts[v] += 1 }
     @pppw = countsw.select { |v, count| count == 1 }.keys
     
  end
  def s5p
    #圖5產品口碑
    session[:page] = 5
     @company = params[:cid].split("")
     if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
  end
  def s6p
    #圖6引起互動關鍵字
    session[:page] = 6
     @s6 = @db["tool_S6"].find.to_a
     @company = params[:cid].split("")
     if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
  end
  def s7p
    #圖7紅火關鍵字
    session[:page] = 7
     @s7 = @db["tool_S7"].find.sort("order"=> 1).to_a
     puts "XX000 , #{@s7}"
      @name1 = []
      @name2 = []
      @name3 = []
      @name4 = []
     @company = params[:cid].split("") 

puts "XXX, #{@company}"  
     if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end    
puts "XXX1 ,#{@company}"
     (0..9).each do |n| 
     @company.each do|c|
       
      @name1 << @s7[c.to_i]["montop"].keys[n]
      @name2 << @s7[c.to_i]["yeartop"].keys[n]
      @name3 << @s7[c.to_i]["monnew"].keys[n]
      @name4 << @s7[c.to_i]["yearnew"].keys[n]
puts "XXX2,#{@name1}"
     end
     end  
     counts1 = Hash.new(0)
     counts2 = Hash.new(0)
     counts3 = Hash.new(0)
     counts4 = Hash.new(0)
          @name1.each { |v| counts1[v] += 1 }
          @name2.each { |v| counts2[v] += 1 }
          @name3.each { |v| counts3[v] += 1 }
          @name4.each { |v| counts4[v] += 1 }
     @monthtop = counts1.select { |v, count| count == 1 }.keys
     @yeartop = counts2.select { |v, count| count == 1 }.keys
     @monthnew = counts3.select { |v, count| count == 1 }.keys
     @yearnew = counts4.select { |v, count| count == 1 }.keys
     
  end
  def s8p
    #圖8互動度分析
    session[:page] = 8
     @a1 = @db["tool_A1"].find.sort("order"=> 1).to_a
     @company = params[:cid].split("")
     if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
  end
  def s9p
    session[:page] = 9
  end
  def s10p
    #圖10品牌口碑
    session[:page] = 10
    @a4 = @db["tool_A4"].find.sort("order"=> 1).to_a
     @company = params[:cid].split("")
     if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
  end
  def s11p
    #圖11互動週期分析
    session[:page] = 11
     @a5 = @db["tool_A5"].find.sort("order"=> 1).to_a
     @company = params[:cid].split("")
     if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
  end
  def s12p
    session[:page] = 12
      @a6 = @db["tool_A6"].find.to_a
     @company = params[:cid].split("")
     if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
  end
  def s13p
    #圖13使用者結構分析
    session[:page] = 13
    @c1 = @db["tool_C1"].find.sort("order"=> 1).to_a
    @company = params[:cid].split("")
    if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
    @boytotal = 0
    @girltotal = 0
    (0..4).each do |c|
      @boytotal = @boytotal + @c1[c.to_i]["user_sex"]["boy"].to_i
      @girltotal = @girltotal + @c1[c.to_i]["user_sex"]["girl"].to_i
      @total = @boytotal + @girltotal
    end
  end
  def s14p
    #圖14使用者趨勢分析
    session[:page] = 14
    @c3 = @db["tool_C3"].find.sort("order"=> 1).to_a
    @company = params[:cid].split("")
    if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
  end
  def s15p
    session[:page] = 15
    @c4 = @db["tool_C4"].find.sort("order"=> 1).to_a
    @company = params[:cid].split("")
    if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
  end
 def s18p
    #圖5產品口碑
    session[:page] = 5
     @company = params[:cid].split("")
     if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
  end
   def s17p
    #圖5產品口碑
    session[:page] = 5
     @company = params[:cid].split("")
     if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
  end
  def s16p
    #圖16意見領袖分析
    session[:page] = 16
     if session[:other_date].present?
       @date = session[:other_date].split("/")[0] + "-" + session[:other_date].split("/")[1]
     @c5_sep = @db["tool_C5_sep"].find.sort("order" => 1).to_a
     end
     @c5 = @db["tool_C5"].find.sort("order" => 1).to_a
     @f16 = @db["tool_f16"].find.to_a
    @company = params[:cid].split("")
    if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
    @company2 = params[:fid].split("")
      #--time
      @choose_time = []
     @seclect_time = @db["tool_S1_sep"].find.sort("order" => 1).to_a
     @seclect_time.each do |k,v|
       k["top10"].each do |key,value|
       if @choose_time.include?(key)
       else
         @choose_time << key
       end
       end
     end
     #--
  end
end
