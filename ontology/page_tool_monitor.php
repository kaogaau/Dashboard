<?php
include_once("./header.php");
$conn=getConnection('fb_page');
$sql="select id,name from pages";
$result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
$row = mysql_fetch_array($result);
?>
<br>
<div style="font-size:20px"><a href="./page_tool.php">工具選單</a> <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span> <a href="./page_tool_monitor.php">社群監控(beta)</a></div>
<hr>
<!--form-->
<form method="post" action="./page_tool_monitor.php" id="mform" class="form-horizontal">
<!--panel-group-->
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
<!--panel1-->
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingOne">
      <h4 class="panel-title">
        <a style="text-decoration: none" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
          粉絲團選擇
        </a>
        &nbsp;
        &nbsp;
        <label><input type="checkbox" class="check" id="checkAll">&nbsp;選擇全部</label>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
      <div class="panel-body">
                <div class="checkbox">
                  
                  <?php
                  while($row = mysql_fetch_array($result)){
                        echo '<label style="display : block"><input class="check" type="checkbox" name="page[]" value="'.$row[0].'">'.$row[1].'</label>';
                    }
                  ?>
                </div>
               
      </div>
    </div>
  </div>
<!--panel2-->
   <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingTwo">
      <h4 class="panel-title">
        <a style="text-decoration: none" class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
          參數選擇
        </a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
      <div class="panel-body">
        <label>按讚數超過<input type="value" name="like" class="form-control" placeholder="Min Likes Count"></label>
        <label>評論數超過<input type="value" name="comment" class="form-control" placeholder="Min Comments Count"></label>
        <label>分享數超過<input type="value" name="share" class="form-control" placeholder="Min Shares Count"></label>
        <label>文章顯示數量<input type="value" name="post" class="form-control" placeholder="Posts Show Count"></label>
      </div>
    </div>
  </div>
<!--panel3-->
   <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingThree">
      <h4 class="panel-title">
        <a style="text-decoration: none" class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
          時間選擇
        </a>
      </h4>
    </div>
    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
      <div class="panel-body">
          時間軸施工中...
      </div>
    </div>
  </div>
<!--panel4-->
   <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingFour">
      <h4 class="panel-title">
        <a style="text-decoration: none" class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
          排序選擇
        </a>
      </h4>
    </div>
    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
      <div class="panel-body">
          <div class="radio">
            <label><input type="radio" name="optionsRadios" id="optionsRadios1" name="sort" value="post_likes">依按讚數排序</label>
            <label><input type="radio" name="optionsRadios" id="optionsRadios2" name="sort" value="post_comments">依評論數排序</label>
            <label><input type="radio" name="optionsRadios" id="optionsRadios3" name="sort" value="post_shares">依分享數排序</label>
            <label><input type="radio" name="optionsRadios" id="optionsRadios4" name="sort" value="post_date">依時間排序</label>
          </div>
      </div>
    </div>
  </div>
</div>
<!--panel-group-->
<button type="submit" class="btn btn-primary">秀出動態牆</button>
</form>
<!--form-->
<?php
if ($_POST["page"] == ""){
  $page_id = array(0);
}
else
{
  $page_id = $_POST['page'];
}
if ($_POST["like"] == ""){
  $like = 0;
}
else
{
  $like = $_POST['like'];
}
if ($_POST["comment"] == ""){
  $comment = 0;
}
else
{
  $comment = $_POST['comment'];
}
if ($_POST["share"] == ""){
  $share = 0;
}
else
{
  $share = $_POST['share'];
}
if ($_POST["post"] == ""){
  $post = 5;
}
else
{
  $post = $_POST['post'];
}
if ($_POST["sort"] == ""){
  $sort = "likes";#change to engament
}
else
{
  $sort = $_POST['sort'];
}
?>
<div class="well well-sm">動態牆 : 您可以透過以下區塊了解所有粉絲團最新與最熱門之動態文章</div>

<?php
                $query_str = "select id,page_id from posts where (date between '".date("Y-m-01")."' and '".date("Y-m-d")."') AND page_id IN (";
                foreach($page_id as $id)
                {
                  $str = $str.$id.",";
                }
                $str = rtrim($str, ",");
                #echo $str;
                $query_str = $query_str.$str;
                $query_str = $query_str.") AND likes >= ".$like." AND comments >= ".$comment." AND shares >= ".$share." order by ".$sort." DESC limit ".$post;
                #echo  $query_str;
                $sql_hot_posts = $query_str;
                $result_hot_posts = mysql_query($sql_hot_posts,$conn) or die('MySQL query error '.mysql_error().' '.$sql_hot_posts);
                 while($row = mysql_fetch_array($result_hot_posts)){
                    echo '<div class="fb-post" data-href="https://www.facebook.com/'.$row[1].'/posts/'.$row[0].'" data-width="500"></div>';
                }
?>
 
<script>
$("#checkAll").click(function () {
    $(".check").prop('checked', $(this).prop('checked'));
});
</script>
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
include_once("./footer.php");
?>

