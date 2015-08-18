<?php

function printPagination($now_page, $page_num, $page_format="%d", $len=10){
    //$start = floor(($now_page - 1) / $len) * $len + 1;
    if($now_page < 5){
        $start = 1;
    }
    else{
        $start = $now_page-4;
    }    
    $end = $start + $len;
    echo "<div style='margin: 0 auto; text-align: center;'>";
    echo "</nav>";
    echo "<ul class='pagination'>";
    printf("<li><a href='$page_format'><<</a></li>", $now_page-$len);
    printf("<li><a href='$page_format'><</a></li>", $now_page-1);
    for($i = $start ; $i < $end ; $i++){
        if($i>$page_num) break;
        if($i==$now_page) printf("<li class='active'>");
        else printf("<li>");
        printf("<a href='$page_format'>$i</a></li>", $i);
    }
    printf("<li><a href='$page_format'>></a></li>", $now_page+1);
    printf("<li><a href='$page_format'>>></a></li>", $now_page+$len);
    echo "</ul>";
    echo "</nav>";
    echo "</div>";
}


function getConnection($dbname){
    $dbhost = '127.0.0.1';
    $dbuser = 'root';
    $dbpass = 'iscae100';
    //    $dbname = 'ibabymall';
    $conn = mysql_connect($dbhost, $dbuser, $dbpass) or die('Error with MySQL connection');
    mysql_query("SET NAMES 'utf8'");
    mysql_select_db($dbname);
    return $conn;
}

function getBrandCounts($conn){
    $sql='select b.brand,count(p.title) from brands b, product p where p.title like  CONCAT("%", b.brand ,"%") group by b.brand';
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[]=$row[0];
        $ary[]=$row[1];

    }
    mysql_free_result($result);
    return $ary;
}


function getKeywordCounts($conn){
    $sql='select k.keyword,count(p.title) from product_name_keyword k, product p where p.title like  CONCAT("%", k.keyword ,"%") group by k.keyword';
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[]=$row[0];
        $ary[]=$row[1];

    }
    mysql_free_result($result);

    return $ary;
}


function getBrandKeywordCounts($conn){
    $sql='select b.brand,k.keyword,count(km.pid)  from map_prod_keyword km, map_prod_brand bm,brands b,product_name_keyword k where km.pid=bm.pid and b.bid=bm.bid and k.kid=km.kid group by bm.bid,km.kid order by b.brand,count(km.pid) desc';
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[]=$row[0];
        $ary[]=$row[1];
        $ary[]=$row[2];

    }
    mysql_free_result($result);

    return $ary;
}


function getTotalProducts($conn){
    $sql='select count(id) from product';
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $cnt="0";
    if($row = mysql_fetch_array($result)){
        $cnt=$row[0];
    }
    mysql_free_result($result);

    return $cnt;
}

function getTotalStores($conn){
    $sql='select count(id) from store';
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $cnt="0";
    if($row = mysql_fetch_array($result)){
        $cnt=$row[0];
    }
    mysql_free_result($result);

    return $cnt;
}


function getTotalBrands($conn){
    $sql='select count(bid) from brands';
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $cnt="0";
    if($row = mysql_fetch_array($result)){
        $cnt=$row[0];
    }
    mysql_free_result($result);

    return $cnt;
}

function getStoreNameList($conn){
    $sql='select chinese_name from store where chinese_name!="" limit 50';
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[]=$row;
    }
    mysql_free_result($result);

    return $ary;
}

function getBrandList($conn){
    $sql='select brands.bid, brands.brand, b.count from brands inner join (select bid, count(*) as count from map_prod_brand group by bid) as b on brands.bid=b.bid order by b.count DESC';
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[]=$row;
    }
    mysql_free_result($result);

    return $ary;
}

function getAllBrandList($conn){
    $sql='select * from brands';
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[]=$row;
    }
    mysql_free_result($result);

    return $ary;
}
function getCategoryList($conn){
    $sql='select category.catid, category.category, b.count from category inner join (select catid, count(*) as count from map_prod_category group by catid) as b on category.catid=b.catid order by b.count DESC';
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[]=$row;
    }
    mysql_free_result($result);

    return $ary;
}

function getStoreList($conn){
    $sql = 'select store.* , b.`count` from store inner join (select store_id, count(*) as `count` from product group by store_id) as b on store.id = b.store_id AND store.source!=3 order by b.count DESC, store.id ASC';
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[]=$row;
    }
    mysql_free_result($result);
    return $ary;
}

function getSourceList(){
    $conn = getconnection("ibabymall");
    $ary = array();
    $sql = "SELECT * FROM `source` ORDER BY `source_id` ASC";
    $result = mysql_query($sql, $conn) or die('MySQL query error '.mysql_error().' '.$sql);
    while($row = mysql_fetch_array($result)){
        $ary[$row[0]] = $row[1];
    }
    mysql_free_result($result);
    return $ary;
}
function getSourceCountList($conn){
    $sql = " select source, SUM(b.cnt) from store inner join (select store_id, count(*) as cnt from product group by store_id) as b on b.store_id=store.id group by source order by store.source ASC";
    $result = mysql_query($sql, $conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary = array();
    while($row = mysql_fetch_array($result)){
        $ary[] = $row;
    }
    mysql_free_result($result);
    return $ary;
}
function getHotProductByStoreId($conn, $store_id, $count=30){
    $sql = "select * from product where store_id=$store_id limit $count";
    $result = mysql_query($sql, $conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary = array();
    while($row = mysql_fetch_array($result)){
        $ary[] = $row;
    }
    mysql_free_result($result);
    return $ary;
}
function getProductByID($conn, $pid){
    $sql = "select * from product where id=$pid";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[]=$row;
    }
    mysql_free_result($result);
    return $ary;
}

function getProductListByStoreId($conn, $store_id, $start, $count){
    $sql = "select * from product where store_id=$store_id order by id limit $start, $count";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[]=$row;
    }
    mysql_free_result($result);
    return $ary;
}

function getProductTotalByStoreId($conn, $store_id){
    $sql="select count(id) from product where store_id=$store_id";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $cnt="0";
    if($row = mysql_fetch_array($result)){
        $cnt=$row[0];
    }
    mysql_free_result($result);
    return $cnt;
}

function getProductListBySearch($conn, $word, $start, $count){
    $sql = "select * from product where (title like '%$word%') AND available=1 order by id limit $start, $count";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[]=$row;
    }
    return $ary;
}

function getProductTotalBySearch($conn, $word){
    $sql="select count(id) from product where (title like '%$word%') AND available=1";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $cnt="0";
    if($row = mysql_fetch_array($result)){
        $cnt=$row[0];
    }
    mysql_free_result($result);
    return $cnt;
}

function getProductListByBrandId($conn, $brand_id, $start, $count){
    $sql = "select * from product inner join (select pid from map_prod_brand where bid=$brand_id order by pid limit $start, $count) as b on product.id=b.pid";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[] = $row;
    }
    return $ary;
}

function getProductTotalByBrandId($conn, $brand_id){
    $sql="select count(mid) from map_prod_brand where bid = $brand_id";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $cnt="0";
    if($row = mysql_fetch_array($result)){
        $cnt=$row[0];
    }
    mysql_free_result($result);
    return $cnt;
}

function getProductListByCategoryId($conn, $category_id, $start, $count){
    $sql = "select * from product inner join (select pid from map_prod_category where catid=$category_id order by pid limit $start, $count) as b on product.id=b.pid";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[] = $row;
    }
    return $ary;
}

function getProductTotalByCategoryId($conn, $category_id){
    $sql="select count(catid) from map_prod_category where catid = $category_id";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $cnt="0";
    if($row = mysql_fetch_array($result)){
        $cnt=$row[0];
    }
    mysql_free_result($result);
    return $cnt;
}

function getNewProductList($conn, $source, $store_id, $start_date, $end_date,$start, $count){
    $ary=array();
    $tmp_end_date=new DateTime("$end_date");
    $tmp_end_date->modify('+1 day');
    $add_end_date=date_format($tmp_end_date, 'Y/m/d');
    if ($source=="0" && $store_id=="0"){
        $sql = "select p.* from product as p, (SELECT id FROM product where created_at>'$start_date' and created_at<'$add_end_date' order by id limit $start, $count) as p2 WHERE p.id=p2.id";
    }
    else if($store_id=="0"){
        $sql = "select * from product inner join (select id,source from store where source=$source) as b on product.store_id=b.id where created_at>\"$start_date\" and created_at<\"$add_end_date\" limit $start, $count";
    }
    else{
        $sql = "select * from product where store_id=$store_id and created_at>\"$start_date\" and created_at<\"$add_end_date\" order by id limit $start, $count";
    }
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    while($row = mysql_fetch_array($result)){
        $ary[] = $row;
    }
    return $ary;
}

function getNewProductTotal($conn, $source, $store_id, $start_date, $end_date){ 
    $cnt="0";
    $tmp_end_date=new DateTime($end_date);
    $tmp_end_date->modify('+1 day');
    $add_end_date=date_format($tmp_end_date, 'Y/m/d');
    if ($source=="0" && $store_id=="0"){
        $sql = "select count(id) from product where created_at>\"$start_date\" and created_at<\"$add_end_date\"";
    }
    else if($store_id=="0"){
        $sql = "select count(0) from product inner join (select id,source from store where source=$source) as b on product.store_id=b.id where created_at>\"$start_date\" and created_at<\"$add_end_date\"";
    }
    else{
        $sql = "select count(id) from product where store_id=$store_id and created_at>\"$start_date\" and created_at<\"$add_end_date\"";
    } 
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    if($row = mysql_fetch_array($result)){
        $cnt=$row[0];
    }
    mysql_free_result($result);
    return $cnt;
}

function getTotalNews($conn){
    $sql='SELECT count(newsid) FROM newsarticles';
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $cnt="0";
    if($row = mysql_fetch_array($result)){
        $cnt=$row[0];
    }
    mysql_free_result($result);

    return $cnt;
}




function getBrandPrice($conn, $data){
    $value = "";
    $sz = sizeof($data);
    for($i = 1 ; $i < $sz ; $i++){

        $value .= "SUM(CASE WHEN `current_price` BETWEEN " . $data[$i-1] . " AND " . ($data[$i]-1) . " THEN 1 ELSE 0 END) AS `" .$data[$i-1]."~" . ($data[$i]-1) . "`,";
    }
    $value .= "SUM(CASE WHEN `current_price` > ".$data[$sz-1]." THEN 1 ELSE 0 END) AS `".$data[$sz-1] . "`";
    $sql = 
        "
        SELECT b.bid,
        brands.brand, 
        "
        . $value . 
        "
        , count(*)
        FROM product
        INNER JOIN (SELECT pid, bid from map_prod_brand) as b on product.`id`=b.`pid`
        INNER JOIN brands on brands.bid = b.bid 
        INNER JOIN (SELECT bid from star_brand WHERE uid=1) as s on b.bid = s.bid 
        GROUP BY bid ORDER BY count(*) DESC;
    ";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result))
        $ary[]=$row;
    mysql_free_result($result);
    return $ary;

}
function getPriceByStarStore($conn, $data){
    $value = "";
    $sz = sizeof($data);
    for($i = 1 ; $i < $sz ; $i++){
        $value .= "SUM(CASE WHEN `current_price` BETWEEN " . $data[$i-1] . " AND " . ($data[$i]-1) . " THEN 1 ELSE 0 END) AS `" .$data[$i-1]."~" . ($data[$i]-1) . "`,";
    }
    $value .= "SUM(CASE WHEN `current_price` > ".$data[$sz-1]." THEN 1 ELSE 0 END) AS `".$data[$sz-1] . "`";
    $sql = 
        "
        SELECT product.store_id, 
        store.chinese_name,
        "
        . $value . 
        "
        , count(*)
        FROM product 
        INNER JOIN (SELECT store_id from star_store WHERE uid=1) as s on product.store_id = s.store_id
        INNER JOIN store on store.id = s.store_id
        GROUP BY product.store_id
        ORDER BY count(*) DESC;
    ";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result))
        $ary[]=$row;
    mysql_free_result($result);
    return $ary;
}
function getPriceByStore($conn, $data, $store_id){
    $value = "";
    $sz = sizeof($data);
    for($i = 1 ; $i < $sz ; $i++){
        $value .= "SUM(CASE WHEN `current_price` BETWEEN " . $data[$i-1] . " AND " . ($data[$i]-1) . " THEN 1 ELSE 0 END) AS `" .$data[$i-1]."~" . ($data[$i]-1) . "`,";
    }
    $value .= "SUM(CASE WHEN `current_price` > ".$data[$sz-1]." THEN 1 ELSE 0 END) AS `".$data[$sz-1] . "`";

    $sql = 
        "
        SELECT 
        "
        . $value . 
        "
        , count(*)
        FROM product WHERE store_id=$store_id
        ORDER BY count(*) DESC;
    ";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result))
        $ary[]=$row;
    mysql_free_result($result);
    return $ary;
}
function getDiscount($conn, $data){
    $value = "";
    $sz = sizeof($data);
    for($i = 1 ; $i < $sz ; $i++){
        $value .= "SUM(CASE WHEN `current_price` /`recommend_price` BETWEEN " . $data[$i-1] . " AND " . ($data[$i]-0.01) . " THEN 1 ELSE 0 END),";
    }
    $sql =
        "
        SELECT b.bid,
        brands.brand,
        SUM(CASE WHEN `current_price` < `recommend_price` THEN 1 ELSE 0 END),
        SUM(1), 
        "
        . $value .
        "
        SUM(CASE WHEN `current_price` /`recommend_price`=1 THEN 1 ELSE 0 END)
        FROM product
        INNER JOIN (SELECT pid, bid from map_prod_brand) as b on product.`id`=b.`pid`
        INNER JOIN brands on brands.bid = b.bid GROUP BY bid ORDER BY SUM(1) DESC;
    ";


    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result))
        $ary[]=$row;
    mysql_free_result($result);
    return $ary;
}
function getDiscountByStore($conn, $data, $store_id){
    $value = "";
    $sz = sizeof($data);
    for($i = 1 ; $i < $sz ; $i++){
        $value .= "SUM(CASE WHEN `current_price` /`recommend_price` BETWEEN " . $data[$i-1] . " AND " . ($data[$i]-0.01) . " THEN 1 ELSE 0 END),";
    }
    $sql =
        "
        SELECT
        SUM(CASE WHEN `current_price` < `recommend_price` THEN 1 ELSE 0 END),
            SUM(1), 
        "
        . $value .
        "
        SUM(CASE WHEN `current_price` /`recommend_price`=1 THEN 1 ELSE 0 END)
        FROM product WHERE store_id=$store_id and available=1 
        ORDER BY SUM(1) DESC;
    ";


    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result))
        $ary[]=$row;
    mysql_free_result($result);
    return $ary;
}
function getDiscountByStarStore($conn, $data){
    $value = "";
    $sz = sizeof($data);
    for($i = 1 ; $i < $sz ; $i++){
        $value .= "SUM(CASE WHEN `current_price` /`recommend_price` BETWEEN " . $data[$i-1] . " AND " . ($data[$i]-0.01) . " THEN 1 ELSE 0 END),";
    }
    $sql =
        "
        SELECT
        product.store_id,
        store.chinese_name,
        SUM(CASE WHEN `current_price` < `recommend_price` THEN 1 ELSE 0 END),
        SUM(1), 
        "
        . $value .
        "
        SUM(CASE WHEN `current_price` /`recommend_price`=1 THEN 1 ELSE 0 END)
        FROM product
        INNER JOIN (SELECT store_id from star_store WHERE uid=1) as s on product.store_id = s.store_id
        INNER JOIN store on store.id = s.store_id
        GROUP BY s.store_id
        ORDER BY SUM(1) DESC;
    ";


    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result))
        $ary[]=$row;
    mysql_free_result($result);
    return $ary;
}
function getCountryData($conn){
    $sql = "select a.*, b.cnt from countrylist as a inner join (select cid, count(*) as cnt from map_prod_country group by cid) as b on a.cid = b.cid";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result))
        $ary[] = $row;
    mysql_free_result($result);
    return $ary;
}
function getStarBrand($conn, $uid){
    $sql="SELECT star_brand.bid, b.brand FROM `star_brand` INNER JOIN (SELECT bid, brand FROM brands) as b on star_brand.`bid`=b.`bid` WHERE uid=$uid";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[] = $row;
    }
    mysql_free_result($result);
    return $ary;
}
function checkStarBrand($conn, $uid, $bid){
    $sql = "SELECT * FROM star_brand WHERE uid=$uid AND bid=$bid";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $row_total=mysql_num_rows($result);
    return $row_total;
}

function addStarBrand($conn, $uid, $bid){
    $sql = "INSERT INTO `star_brand`(`uid`, `bid`) VALUES ($uid,$bid)";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
}
function deleteStarBrand($conn, $uid, $bid){
    $sql = "DELETE FROM `star_brand` WHERE uid=$uid AND bid=$bid";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
}
function getStarStore($conn, $uid){
    $sql="SELECT star_store.store_id, s.chinese_name FROM star_store INNER JOIN (SELECT store.id, store.chinese_name FROM store) as s on s.id=star_store.store_id where star_store.uid = $uid";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result))
        $ary[] = $row;
    mysql_free_result($result);
    return $ary;
}
function getStarStore2($conn, $uid){
    $sql="SELECT star_store.store_id, s.chinese_name, s.source FROM star_store INNER JOIN (SELECT store.id, store.chinese_name, store.source FROM store) as s on s.id=star_store.store_id where star_store.uid = $uid order by s.source ASC";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result))
        $ary[] = $row;
    mysql_free_result($result);
    return $ary;
}
function checkStarStore($conn, $uid, $sid){
    $sql = "SELECT * FROM star_store WHERE uid=$uid AND store_id=$sid";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $row_total=mysql_num_rows($result);
    return $row_total;
}

function addStarStore($conn, $uid, $sid){
    $sql = "INSERT INTO `star_store`(`uid`, `store_id`) VALUES ($uid,$sid)";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
}
function deleteStarStore($conn, $uid, $sid){
    $sql = "DELETE FROM `star_store` WHERE uid=$uid AND store_id=$sid";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
}
function getStoreData($conn, $store_id){
    $sql = "SELECT store.* FROM store where id=$store_id";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary = mysql_fetch_array($result);
    mysql_free_result($result);
    $sql = "SELECT count(*) FROM product where store_id=$store_id";
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $temp = mysql_fetch_array($result);
    $ary['count'] = $temp[0];
    $ary['source'] = getSourceList()[$ary['source']];
    mysql_free_result($result);
    return $ary;
}
function getAndroidAppList($conn){
    $sql = "SELECT id, name, star, url FROM app WHERE `type`=1 ORDER BY star DESC";
    $result = mysql_query($sql, $conn) or die('MySL query error '.mysql_error().' '.$sql);
    $ary = array();
    while($row = mysql_fetch_array($result))
        $ary[] = $row;
    mysql_free_result($result);
    return $ary;
}
function getAndroidApp($conn, $id){
    $sql = "SELECT id, name, star, url FROM app WHERE id=$id";
    $result = mysql_query($sql, $conn) or die('MySL query error '.mysql_error().' '.$sql);
    $ary = mysql_fetch_array($result);
    mysql_free_result($result);
    $sql = "SELECT * FROM app_comment WHERE app_id=$id";
    $ary['comment'] = array();
    $result = mysql_query($sql, $conn) or die('MySL query error '.mysql_error().' '.$sql);
    while($row = mysql_fetch_array($result))
        $ary['comment'][] = $row;
    mysql_free_result($result);
    return $ary;
}

function myUrlEncode($string) {
    $entities = array('%21', '%2A', '%27', '%28', '%29', '%3B', '%3A', '%40', '%26', '%3D', '%2B', '%24', '%2C', '%2F', '%3F', '%25', '%23', '%5B', '%5D');
    $replacements = array('!', '*', "'", "(", ")", ";", ":", "@", "&", "=", "+", "$", ",", "/", "?", "%", "#", "[", "]");
    return str_replace($entities, $replacements, urlencode($string));
}

?>
