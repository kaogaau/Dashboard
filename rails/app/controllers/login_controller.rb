# coding: utf-8
class LoginController < ActionController::Base
  protect_from_forgery
  before_filter :load , :except => [:login,:forword]
  #用來登錄的controller
  def load
    require 'rubygems'
    require 'mongo'
    @db = Mongo::Connection.new('220.132.97.119', 37017).db("dashboard")
    @connection = @db.authenticate("admin", "12345")
    @coll = @db.collection("Collections")
  end

  def login

  end

  def check_user
    @user = @db["user"].find("account" => params[:account],"password" => params[:password]).first
    if @user.blank?
      render :text => "帳號密碼錯誤"
    else
      session[:cid] = ""
      session[:fid] = ""
      session[:wid] = ""
      session[:users] = @user["_id"]
      redirect_to "/dashboard/index"
    end
  end

  def logout
    session[:users] = nil
    redirect_to "/login/login"
  end

  def test
     @s3 = @db["tool_S3"].find.to_a
    @company = "01234".split("")  
    @long =[] 
     @company.each do |c|
      @long <<  @s3[params[:cid].to_i][getmongodocument(c.to_i)].size
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

  def create_user
    @data1 = {
    "page_id" =>"209251989898",
    "page_name" =>"麗嬰房 媽咪同學會",
    "sorce" =>"facebook",
    "monnew" =>{
        "特價" =>18830,
        "圍兜" =>1269,
        "背心" =>5783,
        "童裝" =>4985,
        "泳衣" =>4776,
        "上衣" =>4523,
        "限時" =>3084,
        "評價" =>2456,
        "優惠" =>1383,
        "套裝" =>769
    }
    }
    @data2 = {
    "page_id" =>"128267296746",
    "page_name" =>"奇哥 寶寶的第一個朋友",
    "sorce" =>"facebook",
    "monnew" =>{
        "幼童" =>5653,
        "過季" =>4523,
        "背心" =>3004,
        "奶瓶" =>1783,
        "新品" =>698,
        "零售" =>432,
        "夯" =>52,
        "最新" =>30,
        "打折" =>25,
        "當寄" =>6
    }
}
    @data3 = {
    "page_id" =>"237446743049832",
    "page_name" =>"愛的世界 小熊親子團",
    "sorce" =>"facebook",
    "monnew" =>{
        "愛" =>7423,
        "小熊" =>6523,
        "世界" =>2564,
        "驚嚇" =>1783,
        "阿雞絲" =>1258,
        "學運女王" =>652,
        "海賊王" =>354,
        "西魯" =>79,
        "佛力沙" =>78,
        "孫悟飯" =>20
    }
}
    @data4 = {
    "page_id" =>"131346323572353",
    "page_name" =>"台灣貝親",
    "sorce" =>"facebook",
    "monnew" =>{
         "海賊王" =>7423,
        "魯夫" =>6523,
        "橋巴" =>2564,
        "索隆" =>1783,
        "山治" =>1258,
        "白胡子" =>652,
        "D羅傑" =>354,
        "頂上戰爭" =>79,
        "客洛克" =>78,
        "橡膠橡膠" =>20
    }
}
    @data5 = {
    "page_id" =>"240961475964301",
    "page_name" =>"mothercare Taiwan",
    "sorce" =>"facebook",
    "monnew" =>{
        "特價" =>830,
        "鳴人" =>583,
        "佐助" =>464,
        "雷影" =>301,
        "需佐能呼" =>251,
        "童裝" =>79,
        "斑" =>8,
        "飛雷神" =>6,
        "背心" =>4,
        "天照" =>1
    }
}
    @db["tool_S6"].insert(@data1)
    @db["tool_S6"].insert(@data2)
    @db["tool_S6"].insert(@data3)
    @db["tool_S6"].insert(@data4)
    @db["tool_S6"].insert(@data5)
    redirect_to "/dashboard/index"
  end
 
  
end