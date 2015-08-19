<?php
include_once("./header.php");
$conn=getConnection('fb_page');
$page_id = (int)$_GET['id'];
###########list##########
$list_query="select id,name,old_fans,new_fans from pages";
$list = mysql_query($list_query,$conn) or die('MySQL query error '.mysql_error().' '.$list_query);
while($row = mysql_fetch_array($list)){
    $page_list[$row[0]] = $row[1];
    if ($row[0] == $page_id){
        $month_fans = $row[3] - $row[2];
    }
}
###########datelist##########
$daterange = array();
$date = date("Y-m-01");
$end_date = date("Y-m-31");
 while (strtotime($date) <= strtotime($end_date)) {
    $month_posts_arr[$date] = array();
    $month_likes_arr[$date] = 0;
    $month_comments_arr[$date] = 0;
    $month_shares_arr[$date] = 0;
    array_push($daterange,$date);
    $date = date ("Y-m-d", strtotime("+1 day", strtotime($date)));
 }
###########posts,likes,comments,shares##########
$sort_query = "select id,date,likes,comments,shares from posts where (date between '".date("Y-m-01")."' and '".date("Y-m-d")."' and page_id = '".$page_id."') order by likes DESC";
$sort = mysql_query($sort_query,$conn) or die('MySQL query error '.mysql_error().' '.$sort_query);  
$hot_posts_count = 0;
$hot_posts_arr = array();
while($row = mysql_fetch_array($sort)){
    if ($hot_posts_count < 3){#hot posts limit
        array_push($hot_posts_arr,$row[0]);
    }
    array_push($month_posts_arr[$row[1]],$row[0]);
    $month_likes_arr[$row[1]] = $month_likes_arr[$row[1]] + $row[2];
    $month_comments_arr[$row[1]] = $month_comments_arr[$row[1]] + $row[3];
    $month_shares_arr[$row[1]] = $month_shares_arr[$row[1]] + $row[4];
    $hot_posts_count ++ ;
}
$month_posts = mysql_num_rows($sort);
$month_likes = 0;
$month_comments = 0;
$month_shares = 0;
$day_count = 1;
foreach($daterange as $date)
 {
   $month_likes = $month_likes + $month_likes_arr[$date];
   $month_comments = $month_comments + $month_comments_arr[$date];
   $month_shares = $month_shares + $month_shares_arr[$date];
   echo "<script>var likes_day".$day_count." = ".$month_likes_arr[$date]."</script>";
   echo "<script>var comments_day".$day_count." = ".$month_comments_arr[$date]."</script>";
   echo "<script>var shares_day".$day_count." = ".$month_shares_arr[$date]."</script>";
   $day_count ++;
}
#var_dump($daterange);
?>

<link href="./assets/page.css" rel="stylesheet" type="text/css">
<div style="font-size:16px">
<br>
<div style="font-size:20px"><a href="./page_tool.php">工具選單</a> <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span> <a href="./page_tool_insight.php">個別洞察分析</a> <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span> <?php echo '<a href="./page_insight.php?id='.$page_id.'">'.$page_list[$page_id].'</a>';?></div>
<hr>
<div class="dropdown">
  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
    選擇粉絲團
    <span class="caret"></span>
  </button>
  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
    <?php foreach($page_list as $k => $v){
        echo '<li role="presentation"><a role="menuitem" tabindex="-1" href="./page_insight.php?id='.$k.'">'.$v.'</a></li>';
    }
    ?>
  </ul>
</div>

<br>

<div class="well well-sm">互動監控 : 您可以藉由以下數據觀察此粉絲團本月成長數據</div>
<div class="row">
        <div class="col-lg-2 col-md-6">
            <div class="panel">
                <div class="panel-heading">
                    <div class="row">
                        <div class="text-center">
                            <div style="font-size:36px"><?php echo number_format($month_fans, 0, '.' ,','); ?></div>
                            <div style="font-size:20px;color:#a0522d"><b>本月粉絲增加數</b></div>
                        </div>
                    </div>
                </div> 
            </div>
        </div>

        <div class="col-lg-2 col-md-6">
            <div class="panel">
                <div class="panel-heading">
                    <div class="row">
                        <div class="text-center">
                            <div style="font-size: 36px"><?php echo number_format($month_posts, 0, '.' ,','); ?></div>
                            <div style="font-size:20px;color:#000080"><b>本月文章增加數</b></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-md-6">
            <div class="panel">
                <div class="panel-heading">
                    <div class="row">
                        <div class="text-center">
                            <div style="font-size: 36px"><?php echo number_format($month_likes, 0, '.' ,','); ?></div>
                            <div style="font-size:20px;color:#32cd32"><b>本月按讚增加數</b></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-md-6">
            <div class="panel">
                <div class="panel-heading">
                    <div class="row">
                        <div class="text-center">
                            <div style="font-size: 36px"><?php echo number_format($month_comments, 0, '.' ,','); ?></div>
                            <div style="font-size:20px;color:#ffa500"><b>本月評論增加數</b></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-2 col-md-6">
            <div class="panel">
                <div class="panel-heading">
                    <div class="row">
                        <div class="text-center">
                            <div style="font-size: 36px"> <?php echo number_format($month_shares, 0, '.' ,','); ?></div>
                            <div style="font-size:20px;color:#dc143c"><b>本月分享增加數</b></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</div>

<div class="well well-sm">本月趨勢 : 您可以在以下圖表觀看此粉絲團於本月份的各種互動趨勢變化</div>
<div id='dashboard'></div>
<br>
<div class="well well-sm">動態牆 : 您可以透過以下區塊了解此粉絲團最新與最熱門之動態文章並與上方圖表進行交叉比對</div>

<div class="bs-example bs-example-tabs" role="tabpanel">
    <!-- Nav tabs -->
    <ul id="myTab" class="nav nav-tabs" role="tablist">
    <li role="presentation" class="active"><a href="#hot" aria-controls="hot" role="tab" data-toggle="tab">熱門動態</a></li>
    <li role="presentation" class="dropdown">
        <a id="myTabDrop1" class="dropdown-toggle" aria-controls="new" data-toggle="dropdown" href="#">最新動態 <span class="caret"></span></a>
        <ul id="new" class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
            <?php  
                    foreach($daterange as $date)
                    {
                        echo '<li><a href="#'.$date.'" aria-controls="'.$date.'" role="tab" tabindex="-1" data-toggle="tab">'.$date.'</a></li>';
                    }
            ?>
        </ul>
    </li>
    </ul>
    <!-- Tab panes -->
    <div id="myTabContent" class="tab-content">
        <div id="fb-root"></div>
        <div role="tabpanel" class="tab-pane fade in active" id="hot">
            <?php
                foreach($hot_posts_arr as $post_id){
                    echo '<div class="fb-post" data-href="https://www.facebook.com/'.$page_id.'/posts/'.$post_id.'" data-width="500"></div>';
                }
            ?>
        </div>
        <?php  
                     foreach($daterange as $date)
                     {
                         echo '<div role="tabpanel" class="tab-pane fade" id="'.$date.'">';
                         $posts_id_arr = $month_posts_arr[$date] ;
                         foreach($posts_id_arr as $post_id){
                            echo '<div class="fb-post" data-href="https://www.facebook.com/'.$page_id.'/posts/'.$post_id.'" data-width="500"></div>';
                         }
                        echo '</div>';
                    }
                  ?>
    </div>
</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js"></script>
<script src="./assets/d3/month.js"></script>
<script src="http://connect.facebook.net/zh_TW/sdk.js"></script> 
<script>
          window.fbAsyncInit = function() {
            FB.init({
              appId      : '560005114025412',
              xfbml      : true,
              version    : 'v2.3'
            });

            // ADD ADDITIONAL FACEBOOK CODE HERE
          };

          (function(d, s, id){
             var js, fjs = d.getElementsByTagName(s)[0];
             if (d.getElementById(id)) {return;}
             js = d.createElement(s); js.id = id;
             js.src = "https://connect.facebook.net/zh_TW/sdk.js";
             fjs.parentNode.insertBefore(js, fjs);
           }(document, 'script', 'facebook-jssdk'));
</script>
<?php
include_once("footer.php");
?>