# coding: utf-8
module ApplicationHelper
  def to_correct_number(c)
    case c
    when 0
      return 1
    when 1
      return 3
     when 2
      return 4
       when 3
      return 0
      when 4
      return 2
    end
  end
  def getwarmcolor(c)
    
    if c > 2000
      return "#FF0000"
    end
    if c < 2001 && c.to_i > 1500
      return "#FF8800"
    end
    if c < 1501 && c.to_i > 1000
      return "#FFFF00"
    end
    if c < 1001 && c.to_i > 400
      return "#77FF00"
    end
    if c < 401
      return "#00FFFF"
    end
    end
      
   def getwarmcolor2(c)
    
    if c > 1300
      return "#FF0000"
    end
    if c < 1301 && c.to_i > 749
      return "#FF8800"
    end
    if c < 750 && c.to_i > 400
      return "#FFFF00"
    end
    if c < 401 && c.to_i > 200
      return "#77FF00"
    end
    if c < 201
      return "#00FFFF"
    end
      end
      
      def getwarmcolor3(c)
    
    if c > 23
      return "#FF0000"
    end
    if c < 24 && c.to_i > 18
      return "#FF8800"
    end
    if c < 19 && c.to_i > 10
      return "#FFFF00"
    end
    if c < 11 && c.to_i > 5
      return "#77FF00"
    end
    if c < 6
      return "#00FFFF"
    end
    end
    def getwarmcolor4(c)
    
    if c > 79
      return "#FF0000"
    end
    if c < 80 && c.to_i > 40
      return "#FF8800"
    end
    if c < 41 && c.to_i > 25
      return "#FFFF00"
    end
    if c < 26 && c.to_i > 12 
      return "#77FF00"
    end
    if c < 13
      return "#00FFFF"
    end
    end
    def getwarmcolor5(c)
    
    if c > 79
      return "#FF0000"
    end
    if c < 80 && c.to_i > 40
      return "#FF8800"
    end
    if c < 41 && c.to_i > 25
      return "#FFFF00"
    end
    if c < 26 && c.to_i > 12 
      return "#77FF00"
    end
    if c < 13
      return "#00FFFF"
    end
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
    
     if c == 5
     
     return '寶寶日記'
     end
     if c == 6
     
    return '懷孕大小事'
     end
    if c == 7
     return 'Nac Nac'
     end
     if c == 8
     return '愛貝比婦幼生活館'
     end
     if c == 9
     return 'LES ENPHANTS PLUS 兒童時尚名店'
     end
      if c == 10
     return 'OshKosh/ Carter'
     end
      if c == 11
     return '麗嬰房觀光工廠采衣館'
     end
      if c == 12
     return 'BabyHome'
     end
      if c == 13
     return '親子天下'
     end
      if c == 14
     return 'UNIQLO Baby'
     end
      if c == 15
     return 'My nuno'
     end
    
      if c == 16
      return 'Open for kids' 
     end
    end
     
end
