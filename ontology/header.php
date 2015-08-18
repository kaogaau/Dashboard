<?php
include_once("./commonlib.php");
$conn = getConnection("ibabymall");
$ary = getStarStore2($conn, 1);
$sary = getSourceList($conn);
?>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="">
        <title>麗嬰房資料分析</title>
        <!-- Bootstrap core CSS -->
        <link href="./assets/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
        <script type="text/javascript"  src="http://code.jquery.com/jquery-1.10.2.js"></script>
        <script type="text/javascript" src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
        <link href="./assets/jasny-bootstrap/css/jasny-bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="./assets/sb-admin-2.css" rel="stylesheet">
        <link href="./assets/timeline.css" rel="stylesheet">
        <link href="./assets/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="./assets/c3.css" rel="stylesheet" type="text/css">
        <script src="./assets/js/typeahead.bundle.js"></script>
        <!-- Custom styles for this template -->
        <link href="./assets/dashboard.css" rel="stylesheet">
        <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
        <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
        <script src="./assets/ie-emulation-modes-warning.js"></script>
        <script src="./assets/c3.min.js"></script>
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>


    <body style="margin-left: 200px">
        <nav class="navbar navbar-inverse navbar-fixed-top" style="margin-bottom: 0px;">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="./">麗嬰房資料分析</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                    <a href="" class="dropdown-toggle" data-toggle="dropdown">EC 資料<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="./profile_store.php">商店 Profile</a></li>
                        <li><a href="./profile_brand.php">品牌 Profile</a></li>
                    </ul>
                    </li>
                </ul>
                <form class="navbar-form navbar-right" method="get" action="/dashboard/search_item.php">
                    <input type="text" class="form-control" name="name" placeholder="搜尋">
                    <input type="hidden" name="page" value="1">
                </form>
            </div>
        </div>
        </nav>
        <div class="container-fluid">
            <div class="sidebar" style="padding-top:6px;">
                <nav class="navmenu navmenu-default navmenu-fixed-left" role="navigation" style="margin-top: 50px; max-width: 200px">
                <ul class="nav navmenu-nav">
                    <li><a href="./">Overview <span class="sr-only">(current)</span></a></li>
                    <li class="dropdown">
                    <a href="" class="dropdown-toggle" data-toggle="dropdown">臉書資料與分析<b class="caret"></b></a>
                    <ul class="dropdown-menu navmenu-nav" role="menu">
                        <li><a href="./page_tool.php">粉絲團資料與分析</a></li>
                        <li><a href="./group_tool.php">社團資資料與分析</a></li>
                    </ul>
                    </li>
                    <li class="dropdown">
                    <a href="" class="dropdown-toggle" data-toggle="dropdown">特定商店追蹤<b class="caret"></b></a>
                    <ul class="dropdown-menu navmenu-nav" role="menu">
                        <?php
                            for( $i=0 ; $i < sizeof($ary) ; $i++ )
                            echo "<li><a href=\"./follow.php?store_id=" . $ary[$i][0] . "\">" . $ary[$i][1] . " - " . $sary[$ary[$i][2]] . "</a></li>"
                        ?>
                    </ul>
                    </li>
                    <li class="dropdown">
                    <a href="" class="dropdown-toggle" data-toggle="dropdown">EC 資料<b class="caret"></b></a>
                    <ul class="dropdown-menu navmenu-nav" role="menu">
                        <li><a href="./source_list.php">商城資料</a></li>
                        <li><a href="./store_list.php">商店資料</a></li>
                        <li><a href="./brand_list.php">品牌資料</a></li>
                        <li><a href="./category_list.php">類別資料</a></li>
                    </ul>
                    </li>
                    <li class="dropdown">
                    <a href="" class="dropdown-toggle" data-toggle="dropdown">EC 分析<b class="caret"></b></a>
                    <ul class="dropdown-menu navmenu-nav" role="menu">
                        <li><a href="./yahoo_rank.php">Yahoo 超級商城排行</a></li>
                        <li><a href="./new_product.php">新上架商品</a></li>
                        <li><a href="./store_price.php">價格帶統計 (商店)</a></li>
                        <li><a href="./discount_store.php">折價分析 (商店)</a></li>
                        <li><a href="./brand_price.php">價格帶統計 (品牌)</a></li>
                        <li><a href="./discount_brand.php">折價分析 (品牌)</a></li>
                        <li><a href="./categoryanalysis.php">商品分析</a></li>
                    </ul>
                    </li>
                    <li class="dropdown">
                    <a href="" class="dropdown-toggle" data-toggle="dropdown">App 分析<b class="caret"></b></a>
                    <ul class="dropdown-menu navmenu-nav" role="menu">
                        <li><a href="app_analysis_android_list.php">Android</a></li>
                    </ul>
                    </li>
                    <li class="dropdown">
                    
                    
                    <li><a href="./news.php">新聞曝光分析</a></li>
                    <li><a href="./app.php">好孕邦統計</a></li>
                    <li><a href="./wordtree.php">母嬰Ontology</a></li>
                    <!--
                    <li><a href="./editbrands.php">品牌資料管理</a></li>
                    <li><a href="./pinterest.php">信義居家轉檔</a></li>
                    -->
					</ul>
                </nav>
            </div>
        </div>
        <div class="col-sm-12 main" style="padding-top: 36px;">
            <div class="row">
