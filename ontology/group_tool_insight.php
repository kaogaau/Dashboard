<?php
include_once("./header.php");
$conn=getConnection('fb_group');
$sql='select id,name from groups';
$result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
$record_count = 0;
while($row = mysql_fetch_array($result)){
    $group_id_arr[$record_count] = $row[0];
    $group_name_arr[$record_count] = $row[1];
    #$group_feeds_arr[$record_count] = $row[2];
    #$group_likes_arr[$record_count] = $row[3];
   # $group_comments_arr[$record_count] = $row[4];
    #$group_oldest_feed_time_arr[$record_count] = $row[5];
    #$group_latest_feed_time_arr[$record_count] = $row[6];
    $record_count = $record_count  + 1;
    }
?>
<br>
<div style="font-size:20px"><a href="./group_tool.php">工具選單</a> <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span> <a href="./group_tool_insight.php">個別洞察分析</a></div>
<hr>
<div class="row">
<!-- picture -->
<?php
    for ($i = 0; $i <= $record_count-1; $i++) 
    {
        echo '<div class="col-sm-3 col-md-2">';
            echo '<div class="thumbnail">';
                echo '<a href="./group_insight.php?id='.$group_id_arr[$i].'" class="thumbnail">';
                    echo '<img style="height:200px" data-src="holder.js/158x105" src="./assets/images/'.$group_id_arr[$i].'.jpg" alt="...">';
                echo '</a>';
                echo '<div style="height:60px">';
                    echo '<h4 style="text-align:center"><b>'.$group_name_arr[$i].'</b></h4>';
            #echo '<p>...</p>';
            #echo '<p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>';
                echo '</div>';
            echo '</div>';
        echo '</div>';
    }
 ?>
<!-- picture -->
</div>
<?php
include_once("./footer.php");
?>
