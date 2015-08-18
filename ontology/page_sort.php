<?php
$conn=getConnection('fb_page');
#####################
$sql_month_likes="select * from month_likes";
$result_month_likes = mysql_query($sql_month_likes,$conn) or die('MySQL query error '.mysql_error().' '.$sql_month_likes);
while($row = mysql_fetch_array($result_month_likes)){
for ($i = 1; $i <= 31; $i++) {
	 $month_likes[$row[0]] = $month_likes[$row[0]] + $row[$i+1];
}
}
#####################
$sql_month_comments="select * from month_comments";
$result_month_comments = mysql_query($sql_month_comments,$conn) or die('MySQL query error '.mysql_error().' '.$sql_month_comments);
while($row = mysql_fetch_array($result_month_comments)){
for ($i = 1; $i <= 31; $i++) {
	 $month_comments[$row[0]] = $month_comments[$row[0]] + $row[$i+1];
}
}
#####################
$sql_month_shares="select * from month_shares";
$result_month_shares = mysql_query($sql_month_shares,$conn) or die('MySQL query error '.mysql_error().' '.$sql_month_shares);
while($row = mysql_fetch_array($result_month_shares)){
for ($i = 1; $i <= 31; $i++) {
	 $month_shares[$row[0]] = $month_shares[$row[0]] + $row[$i+1];
}
}
#####################
foreach($month_likes as $k => $v){
	$month_engagement[$k] = $month_likes[$k] + $month_comments[$k] + $month_shares[$k];
 }
 #####################
arsort($month_engagement);
arsort($month_likes);
arsort($month_comments);
arsort($month_shares);
#$engagement_top5 = array_slice($month_engagement, 0, 5, true);
#$likes_top5 = array_slice($month_likes, 0, 5, true);
#$comments_top5 = array_slice($month_comments, 0, 5, true);
#$shares_top5 = array_slice($month_shares, 0, 5, true);
?>