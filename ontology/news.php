<?php
include_once("./header.php");
include_once('./commonlib.php');

function getNewsList($conn){
    $sql='select title,src,ndate,url from newsarticles order by ndate desc';
    $result = mysql_query($sql,$conn) or die('MySQL query error '.mysql_error().' '.$sql);
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[]=$row[0];
        $ary[]=$row[1];
        $ary[]=$row[2];
        $ary[]=$row[3];
    }
    mysql_free_result($result);

    return $ary;
}


function getNewsStatistics($conn,$kw){
    //    $sql="SELECT YEAR(ndate), MONTH(ndate),count(*) FROM newsarticles  GROUP BY YEAR(ndate), MONTH(ndate)";
    $sql="select YEAR(n.ndate), MONTH(n.ndate),count(*) from crawlerlog cl, newsarticles n where cl.keyword='".$kw."' and cl.logid=n.logid group by YEAR(n.ndate),MONTH(n.ndate) order by YEAR(n.ndate) asc,MONTH(n.ndate) asc";
    $result = mysql_query($sql) or die('MySQL query error');
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[]=$row[0];
        $ary[]=$row[1];
        $ary[]=$row[2];
    }
    mysql_free_result($result);

    return $ary;
}

function getNewsDateList($conn){
    $sql="select YEAR(n.ndate), MONTH(n.ndate) from newsarticles n group by YEAR(n.ndate),MONTH(n.ndate) order by YEAR(n.ndate) asc ,MONTH(n.ndate) asc";
    $result = mysql_query($sql) or die('MySQL query error');
    $ary=array();
    while($row = mysql_fetch_array($result)){
        $ary[]=$row[0];
        $ary[]=$row[1];
    }
    mysql_free_result($result);

    return $ary;
}






$conn=getConnection('jared');

$newsdlist=getNewsDateList($conn);


$ary1=getNewsStatistics($conn,'麗嬰房');
$ary2=getNewsStatistics($conn,'奇哥');

$newslist=getNewsList($conn);
?>

<link href="./assets/c3.css" rel="stylesheet" type="text/css">
<script src="./assets/d3.min.js" charset="utf-8"></script>
<script src="./assets/c3.min.js"></script>
<script src="./assets/js/jQDateRangeSlider.js"></script>
<script>
$(document).ready(function () {
    $("#slider").dateRangeSlider();
});

</script>
    <div id="chart"></div>
    <div class="row">
        <div class="col-sm-2"></div>    
        <div class="col-sm-8">
            <button class="btn btn-info btn-block" type="submit">更新下方新聞</button><br>
            <div id=time></div>
            <br>
        </div>
        <div class="col-sm-2"></div>    
    </div>
    <div class="row">
    <div id="slider"></div>    
</div>
    <div class="row">
        <div class="col-sm-12">
            <table class="table table-striped table-bordered table-hover">
                <thead>
                    <tr class="info">
                        <th>標題</th>
                        <th>媒體</th>
                        <th>日期</th>
                    </tr>
                </thead>
                <tbody id="table_list">
<?php	
for($i=0;$i<sizeof($newslist);$i+=4){
    echo '<tr date="'.$newslist[$i+2].'" class="news_item success">';
    echo "<td > <a href='".$newslist[$i+3]."'>".$newslist[$i]."</a></td><td>".$newslist[$i+1]."</td><td>".$newslist[$i+2]."</td> \n";
    echo '</tr>';
}
?>
                </tbody>
            </table>
<script>
var chart = c3.generate({
    data: { 
        x: 'x',
            columns: [ 
            ['x', 
<?php	
$sizenewsdlist=sizeof($newsdlist);
for($i=0;$i<$sizenewsdlist;$i+=2){
    if($i>0){
        echo ",";
    }
    echo "'".$newsdlist[$i]."-".$newsdlist[$i+1]."-01'";
}
?>		
],			
    ['麗嬰房', 
<?php	
for($i=2;$i<sizeof($ary1);$i+=3){
    if($i>2)
        echo ",";
    echo $ary1[$i];
}
?>		
],
    ['奇哥', 
<?php	
for($i=2;$i<sizeof($ary2);$i+=3){
    if($i>2)
        echo ",";
    echo $ary2[$i];
}
?>		
]





    ],
    onclick: function (d, element) {

    }
    },
        axis: {
            x: {
                type: 'timeseries',
                    tick: {
                        format: '%Y-%m-%d'
    }
    }
    },
        subchart: {
            show: true,
                onbrush: function(){

    }
    },
        zoom: {
            enabled: true
    }	
    });
    </script>

<?php
include_once("footer.php");
?>

