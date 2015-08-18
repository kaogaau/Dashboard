# coding: utf-8
class OuterController < ActionController::Base
  protect_from_forgery
  before_filter :load,:except => :test
  #這個controller是對應到compare的iframe也是讓js不打架的關鍵
  def load
    
    if session[:users] == nil
      redirect_to "/login/login"
    end
    require 'rubygems'
    require 'mongo'
    @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
    @connection = @db.authenticate("admin", "12345")
    @coll = @db.collection("Collections")
    @user = @db["user"].find("_id" =>session[:users]).first
  end

  def a1p
    @a1 = @db["tool_A1"].find.to_a
    @fid = params[:fid].to_i
  end

  def a5p
    @a5 = @db["tool_A5"].find.to_a
    @fid = params[:fid].to_i
    @a = @a5[@fid]["comment"]["month"]
    @a5use = []
    @a.each do |key,value|
      @a5use <<"[" + key.to_s + "," + value.to_s + "]"
    end

  end

  def s6p
    @s6 = @db["tool_S6"].find.to_a
    @fid = params[:fid].to_i

  end

  def a4p
    @a4 = @db["tool_A4"].find.to_a
    @fid = params[:fid].to_i

  end

  def a4py
    @a4 = @db["tool_A4"].find.to_a
    @fid = params[:fid].to_i
  end

  def s8p
    @a1 = @db["tool_A1"].find.sort("order"=> 1).to_a
    @company = params[:cid].split("")
    if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
    @minus = 0
    @company.each do |y|

      @minus = @minus + @a1[y.to_i][params[:cate]]["total"].to_i
    end
    @others = @a1[0][params[:cate]]["total"].to_i + @a1[1][params[:cate]]["total"].to_i + @a1[2][params[:cate]]["total"].to_i + @a1[3][params[:cate]]["total"].to_i + @a1[4][params[:cate]]["total"].to_i - @minus
    @theall = @a1[0][params[:cate]]["total"].to_i + @a1[1][params[:cate]]["total"].to_i + @a1[2][params[:cate]]["total"].to_i + @a1[3][params[:cate]]["total"].to_i + @a1[4][params[:cate]]["total"].to_i
  end

  def f8p
    @f8 = @db["tool_f8"].find.to_a
    @company = params[:fid].split("")
    @minus = 0
    @company.each do |y|

      @minus = @minus + @f8[y.to_i][params[:cate]]["total"].to_i
    end
  end
  def w8p
    @w8 = @db["tool_w8"].find.to_a
    @company = params[:wid].split("")
    @minus = 0
    @company.each do |y|

      @minus = @minus + @w8[y.to_i][params[:cate]]["total"].to_i
    end
  end

  def s9p
    @a3 = @db["tool_A3"].find.to_a
    @company = params[:cid].split("")
    if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
  end
  def w10p
    @w10 = @db["tool_w10"].find.to_a
   
    @long = []
    @company = params[:wid].split("")
    @company.each do |c|
      @long << @w10[c.to_i][params[:cate]]["month"].size
    end
    @long.max
  end

  def f10p
    @f10 = @db["tool_f10"].find.to_a
    @company = params[:fid].split("")
    @long = []
    @company.each do |c|
      @long << @f10[c.to_i][params[:cate]]["month"].size
    end
    @long.max
 
  end
  def s10p
    @s10 = @db["tool_S10"].find.sort("order"=> 1).to_a
    @company = params[:cid].split("")
    if params[:nos].to_i != 1
    if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
     end
    @long = []
    @company.each do |c|
      @long << @s10[c.to_i][params[:cate]]["month"].size
    end
    @long.max
 
  end

  def s11p
    @a5 = @db["tool_A5"].find.sort("order"=> 1).to_a
    @a6 = @db["tool_A6"].find.sort("order"=> 1).to_a
    @company = params[:cid].split("")
    if params[:nos].to_i != 1
    if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
     end
  end

  def f12p
    @f12 = @db["tool_f12"].find.to_a

    @company = params[:fid].split("")
  end
  def w11p
    @w11 = @db["tool_w11"].find.to_a

    @company = params[:wid].split("")
  end

  def s14p
    @s14 = @db["tool_S14"].find.sort("order"=> 1).to_a
    @company = params[:cid].split("")
    if params[:nos].to_i != 1
    if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
     end
    @long = []
    @company.each do |c|
      @long << @s14[c.to_i]["user"]["month"].size
    end
    @long.max
  end
  def s15p
    @s15 = @db["tool_S15"].find.sort("order"=> 1).to_a
    @company = params[:cid].split("")
    if params[:nos].to_i != 1
    if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
     end
    @long = []
    @company.each do |c|
      @long << @s15[c.to_i]["data"].size
    end
    @long.max
  end

  def f15p
    @f15 = @db["tool_f15"].find.to_a
    @company = params[:fid].split("")
     @long = []
    @company.each do |c|
      @long << @f15[c.to_i]["data"].size
    end
    @long.max
  end
 def s3p
    @s3 = @db["tool_S3"].find.sort("order"=> 1).to_a
    @company = "01234".split("") 
 
    @long =[] 
     @company.each do |c|
      @long <<  @s3[params[:cid].to_i][getmongodocument(c.to_i)].size
    end
    @long.max
  end
  def s3p_view
     @s3 = @db["tool_S3_see"].find.sort("order"=> 1).to_a
     
  end
  def s4p_view
     @s4 = @db["tool_S4_see"].find.sort("order"=> 1).to_a
     
  end
  def f3p
    @f3 = @db["tool_f3"].find.to_a
    @company = "01234".split("")  
    @long =[] 
     @company.each do |c|
      @long <<  @f3[params[:fid].to_i][getmongodocument(c.to_i)].size
    end
    @long.max
  end
  
    def getmongodocument(c)
      if c == 0
      return "麗嬰房"
    end
    if c == 1
      return "貝親"
    end
    if c == 2
      return "奇哥"
    end
    if c == 3
      return "mothercare"
    end
    if c == 4
      return "愛的世界"
    end
    end  
  
  
  def s4p
    @company = params[:cid].split("")
    if session[:oid].present? && session[:oid] != []
       session[:oid].each do |o|
         @company << o
       end
     end
  end
  
end