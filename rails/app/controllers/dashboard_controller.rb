# coding: utf-8
class DashboardController < ActionController::Base
  protect_from_forgery
  before_filter :load
  #為主要的controller單一廠商的資料也是在這裡
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
   @a1 = @db["tool_A1"].find.sort("order"=> 1).to_a
     @a2 = @db["tool_A2"].find.to_a
  end
  def index
   session[:page] = 20
   @a1 = @db["tool_A1"].find.to_a
   @a3 = @db["tool_A3"].find.to_a
   @a4 = @db["tool_A4"].find.to_a
   @a6 = @db["tool_A6"].find.to_a
   @c1 = @db["tool_C1"].find.to_a
   @fid = params[:fid].to_i
  end
  def login
    
  end
  def create_user
    user = {"account" => "root", "password" => "0000", "name" => "joe"}
    id = @db["user"].insert(user)
    redirect_to "/dashboard/index"
  end
  
  def choose_company
  if session[:cid] != '' || session[:fid] != '' || session[:wid] != '' || !session[:oid].blank?
    
    redirect_to "/compare/s#{params[:did]}p?cid=#{session[:cid]}&tid=#{session[:cidall]}&fid=#{session[:fid]}&wid=#{session[:wid]}"
  end
   @a1 = @db["tool_A1"].find.sort("order"=> 1).to_a
   @a3 = @db["tool_A3"].find.to_a
   @a4 = @db["tool_A4"].find.to_a
   @a6 = @db["tool_A6"].find.to_a
   @c1 = @db["tool_C1"].find.to_a
   if params[:did].to_i == 1 || params[:did].to_i == 16
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
     @choose_time = @choose_time.sort
   end 
   @fid = params[:fid].to_i    
   
  end
  
  def for_select
    #選廠商
    @company = ''
    @fav = ''
    @webo = ''
    @oid = []
    if params[:company1] == "1"
      @company << "0"
    end
    if params[:company2] == "1"
      @company << "1"
    end
    if params[:company3] == "1"
      @company << "2"
    end
    if params[:company4] == "1"
      @company << "3"
    end
    if params[:company5] == "1"
      @company << "4"
    end
     if params[:company6] == "1"
      @company << "5"
    end
    if params[:company7] == "1"
      @company << "6"
    end
    if params[:company8] == "1"
      @company << "7"
    end
    if params[:company9] == "1"
      @company << "8"
    end
    if params[:company10] == "1"
      @company << "9"
    end
    if params[:company11] == "1"
      @oid << "10"
    end
    if params[:company12] == "1"
      @oid << "11"
    end
    if params[:company13] == "1"
      @oid << "12"
    end
    if params[:company14] == "1"
      @oid << "13"
    end
    if params[:company15] == "1"
      @oid << "14"
    end
    if params[:company16] == "1"
      @oid << "15"
    end
     if params[:company17] == "1"
      @oid << "16"
    end
    if params[:f1] == "1"
      @fav << "0"
    end
    if params[:f2] == "1"
      @fav << "1"
    end
    if params[:w1] == "1"
      @webo << "0"
    end
    if params[:w2] == "1"
      @webo << "1"
    end
     if params[:w3] == "1"
      @webo << "2"
    end
    if params[:w4] == "1"
      @webo << "3"
    end
    if params[:companyall] == "1"
      @companyall = 1
     else
        @companyall = 0
    end
    if !params[:start_date].blank?
      session[:start_date] = params[:start_date]
    end
    if !params[:end_date].blank?
      session[:end_date] = params[:end_date]
    end
    session[:cid] = @company
    session[:cidall] = @companyall
    session[:fid] = @fav
    session[:wid] = @webo
    session[:oid] = @oid
    if params[:other_date].to_i == 999
      session[:other_date] = nil
    else
      session[:other_date] = params[:other_date]
    end
    #page為目前頁面cid為fb的廠商tid為是否有選全部fid為討論區的廠商wid為微博的廠商
   redirect_to "/compare/s#{params[:page]}p?cid=#{@company}&tid=#{@companyall}&fid=#{@fav}&wid=#{@webo}"
   
  end
  def for_select_up
    #選廠商
    @company = ''
    @fav = ''
    @webo = ''
    @oid = []
    if params[:company1] == "1"
      @company << "0"
    end
    if params[:company2] == "1"
      @company << "1"
    end
    if params[:company3] == "1"
      @company << "2"
    end
    if params[:company4] == "1"
      @company << "3"
    end
    if params[:company5] == "1"
      @company << "4"
    end
    if params[:company6] == "1"
      @company << "5"
    end
    if params[:company7] == "1"
      @company << "6"
    end
    if params[:company8] == "1"
      @company << "7"
    end
    if params[:company9] == "1"
      @company << "8"
    end
    if params[:company10] == "1"
      @company << "9"
    end
     if params[:company11] == "1"
      @oid << "10"
    end
    if params[:company12] == "1"
      @oid << "11"
    end
    if params[:company13] == "1"
      @oid << "12"
    end
    if params[:company14] == "1"
      @oid << "13"
    end
    if params[:company15] == "1"
      @oid << "14"
    end
    if params[:company16] == "1"
      @oid << "15"
    end
    if params[:company17] == "1"
      @oid << "16"
    end
    if params[:f1] == "1"
      @fav << "0"
    end
    if params[:f2] == "1"
      @fav << "1"
    end
    if params[:w1] == "1"
      @webo << "0"
    end
    if params[:w2] == "1"
      @webo << "1"
    end
     if params[:w3] == "1"
      @webo << "2"
    end
    if params[:w4] == "1"
      @webo << "3"
    end
    if params[:companyall] == "1"
      @companyall = 1
     else
        @companyall = 0
    end
    if !params[:start_date].blank?
      session[:start_date] = params[:start_date]
    end
    if !params[:end_date].blank?
      session[:end_date] = params[:end_date]
    end
    session[:cid] = @company
    session[:cidall] = @companyall
    session[:fid] = @fav
    session[:wid] = @webo
    session[:oid] = @oid
      if params[:other_date].to_i == 999
      session[:other_date] = nil
    else
      session[:other_date] = params[:other_date]
    end
    if session[:page].blank? || session[:page] == 20
      redirect_to :back
    else
       #page為目前頁面cid為fb的廠商tid為是否有選全部fid為討論區的廠商wid為微博的廠商
      redirect_to "/compare/s#{session[:page]}p?cid=#{@company}&tid=#{@companyall}&fid=#{@fav}&wid=#{@webo}"
    end
   
  end
  
  def single_company
    @s1 = @db["tool_S1"].find.sort("order"=> 1).to_a
     @s7 = @db["tool_S7"].find.sort("order"=> 1).to_a
      @s4 = @db["tool_S4"].find.to_a
       @s3 = @db["tool_S3"].find.sort("order"=> 1).to_a
       @s10 = @db["tool_S10"].find.to_a
       @s14 = @db["tool_S14"].find.to_a
       @s15 = @db["tool_S15"].find.to_a
       @s16 = @db["tool_S16"].find.to_a
   @a1 = @db["tool_A1"].find.to_a
   @a3 = @db["tool_A3"].find.to_a
   @a4 = @db["tool_A4"].find.to_a
    @a5 = @db["tool_A5"].find.to_a
   @a6 = @db["tool_A6"].find.to_a
   @c1 = @db["tool_C1"].find.to_a
   @c5 = @db["tool_C5"].find.to_a
   @company = [params[:id]]  
  end
  def single_for
    @f3 = @db["tool_f3"].find.sort("order"=> 1).to_a
     @f8 = @db["tool_f8"].find.to_a
      @f10 = @db["tool_f10"].find.to_a
       @f15 = @db["tool_f15"].find.to_a
       @f16 = @db["tool_f16"].find.to_a
   @company2 = [params[:id]]  
  end
  def single_weibo
    @w4 = @db["tool_w4"].find.to_a
     @w8 = @db["tool_w8"].find.to_a
      @w10 = @db["tool_w10"].find.to_a
       @companyw = [params[:id]]
  end
  
end
