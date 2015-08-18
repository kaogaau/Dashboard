<?php
include_once("./header.php");
?>
<br>
<div style="font-size:20px"><a href="./page_tool.php">工具選單</a> <span class="glyphicon glyphicon-arrow-right" aria-hidden="true"></span> <a href="./page_tool_opleader.php">意見領袖</a><div>
<hr>
<script src="./assets/d3.min.js"></script> 
<script src="./assets/d3pie.min.js"></script>

<script src="https://code.jquery.com/jquery-1.10.2.js"></script>


    <!--
    <iframe width="100%" height="700px" src="http://220.132.97.119/tachen/ajax/opinion_leader.php" style="border: none"></iframe>
    -->


    <select id="myselect">
        <option value="209251989898">麗嬰房 媽咪同學會</option>
        <option value="296303767271">幼教粉絲專頁</option>
        <option value="411046232253913">育兒大小事</option>
        <option value="319186521484350">懷孕大小事</option>
        <option value="598315443627319">芊芊小咪寶</option>
        <option value="362216238522">新手爸媽勸敗團</option>
        <option value="155477534498525">媽媽經</option>
        <option value="191066727593516">好媳婦省錢團</option>
        <option value="614665685252676">My nuno</option>
        <option value="518864824797451">Open for kids</option>
        <option value="148722908483450">Nac Nac</option>
        <option value="139345196140926">OshKosh/ Carter's</option>
        <option value="169299433126237">麗嬰房觀光工廠采衣館</option>
        <option value="167038316775699">邊境法式點心坊</option>
        <option value="475566682559945">小咪寶</option>
        <option value="348527915316017">小咪寶的每一天</option>
        <option value="129029797286279">鬱金香童飾城堡＊～手作緞帶材料.蝴蝶結</option>
        <option value="586784241439962">親子學習樂</option>
        <option value="135084993203916">BabyHome寶貝家庭親子網</option>
        <option value="433317256752909">瑪莉桃桃</option>
        <option value="416216968426055">小魚散步。繪本。咖啡。Books & Cafe</option>
        <option value="341620502649564">怪獸小學堂 創意料理派對餐廳</option>
        <option value="182576165149857">名媛婦幼用品專賣店</option>
        <option value="237446743049832">愛的世界 小熊親子團</option>
        <option value="121151784694458">娃娃世界鳳山婦幼精品館</option>
        <option value="247771685294517">娃娃世界富國店</option>
        <option value="316821618478062">四寶媽咪&飛飛姨</option>
        <option value="241947492622184">媽咪最推薦</option>
        <option value="142179675884434">俏媽咪親子生活館</option>
        <option value="141592812610465">媽咪寶貝情報站</option>
        <option value="282576301762911">懷孕媽咪知識團</option>
        <option value="222374807844875">愛貝比婦幼生活館</option>
        <option value="152486534850394">LES ENPHANTS PLUS 兒童時尚名店</option>
        <option value="440694596012148">三姊弟甜品點心坊</option>
        <option value="169748515872">嬰兒與母親 懷孕生產情報站</option>
        <option value="155010791222983">二手嬰兒用品交流團</option>
        <option value="114923575198147">媽咪小寶貝粉絲團</option>
        <option value="506422169398175">十方之愛兒童發展資源館</option>
        <option value="145649977189">7-ELEVEN</option>
        <option value="279264471269">寶寶日記  BabyDiary</option>
        <option value="132622800160756">天才領袖感覺統合兒童發展中心</option>
        <option value="134469309158">媽媽寶寶-懷孕、生產、育兒</option>
        <option value="217633471595956">好媽媽懷孕寶寶交流網</option>
        <option value="152905932107">親子天下</option>
        <option value="252975951538930">Uniqlo Taiwan KIDS & BABY</option>
        <option value="143269825688316">媽媽餵mamaway孕婦裝.哺乳衣</option>
        <option value="240961475964301">mothercare Taiwan</option>
        <option value="599238866779891">Dollbao逗寶國際-頂級嬰幼兒用品進口代理</option>
        <option value="111677458914360">Neat Solution 嬰幼兒用品</option>
        <option value="205200392829655">哈韓孕媽咪</option>
        <option value="131346323572353">台灣貝親</option>
    </select>
    <button>查詢</button>


    <!--<div id="links" style="display:none">意見領袖FB連結</div>-->
    <div id="pieChart"></div>
    <div id="user_list">

        <!--<table class='table table-striped table-bordered table-hover' >-->

            <table class='table table-striped table-condensed table-hover' >

                <thead><tr class='info'>
                        <th>Rank</th><th>Name</th>
                        <th>Rank</th><th>Name</th>
                        <th>Rank</th><th>Name</th>
                        <th>Rank</th><th>Name</th>
                        <th>Rank</th><th>Name</th>
                    </tr>
                </thead> 
                <tbody id='jaredtbl'>
                </tbody>
            </table>

        </div>




<script>


window.myflag=0;

var user_data=[];
$("button").click(function() {
    if(window.myflag==0){
        window.myflag=1;
    }else return;

    var page=$("#myselect").val();
    var page_text=$('#myselect :selected').text();
    //alert("page_text="+page_text);
    //alert($("#myselect").val());
    //$(this).slideUp();
            /*
                $.ajax({
                url: 'genPageData.php',
                type: 'post',
                data: { "callFunc1": page},
                success: function(response) {
                    console.log(response); 



                }
            });
             */
    $("#pieChart").empty();
    $.post( "genPageData.php", { callFunc1: page})
        .done(function( data ) {
            //    alert( "Data Loaded: " + data );
        });



    while(user_data.length){
        user_data.pop();
    }



    d3.tsv("mongodb/data/"+page+".txt", function(d) {

        user_data.push({"USER_NAME" : d.USER_NAME, "USER_ID" : d.USER_ID});
        return {
            label: d.USER_NAME,
                value: +d.SCORE
        };
    }, function(error, rows) {
        console.log("row = " + rows);
        var data = {
            "sortOrder": "value-desc",
                "content": rows
        };

        drawPie(data);
    });

    var drawPie = function (data){

        var pie = new d3pie("pieChart", {
            "header": {
                "title": {
                    "text": page_text+"\n意見領袖",
                        "color": "#3a4edc",
                        "fontSize": 34,
                        "font": "courier"
                },
                "subtitle": {
                    "color": "#999999",
                        "fontSize": 10,
                        "font": "courier"
                },
                "location": "pie-center",
                "titleSubtitlePadding": 10
            },
            "footer": {
                "color": "#999999",
                    "fontSize": 10,
                    "font": "open sans",
                    "location": "bottom-left"
            },
            "size": {
                "canvasHeight": 700,
                    "canvasWidth": 800,
                    "pieInnerRadius": "91%",
                    "pieOuterRadius": "89%"
            },
            "data": data,
            "labels": {
                "outer": {
                    "format": "label-value1",
                        "pieDistance": 20
                },
                "inner": {
                    "format": "none"
                },
                "mainLabel": {
                    "fontSize": 11
                },
                "percentage": {
                    "color": "#999999",
                        "fontSize": 11,
                        "decimalPlaces": 0
                },
                "value": {
                    "color": "#cccc43",
                        "fontSize": 11
                },
                "lines": {
                    "enabled": true,
                        "color": "#777777"
                }
            },
                "effects": {
                    "pullOutSegmentOnClick": {
                        "effect": "linear",
                            "speed": 400,
                            "size": 8
                    }
                },
                    "misc": {
                        "colors": {
                            "segmentStroke": "#000000"
                        }
                    }
        });

        $("#links").show();
        ///$("#user_list").html("this is a test.....................");
        for(var i=0;i<50;i=i+5){
            $("#jaredtbl").append("<tr class='active'><td>"+ 
                (i+1)+".<a href='https://www.facebook.com/"+user_data[i].USER_ID+"'>"+user_data[i].USER_NAME +"</a></td><td><img src='http://graph.facebook.com/"+user_data[i].USER_ID+"/picture'</td><td>"
                + (i+2)+".<a href='https://www.facebook.com/"+user_data[i+1].USER_ID+"'>"+user_data[i+1].USER_NAME +"</a></td><td><img src='http://graph.facebook.com/"+user_data[i+1].USER_ID+"/picture'</td><td>"
                + (i+3)+".<a href='https://www.facebook.com/"+user_data[i+2].USER_ID+"'>"+user_data[i+2].USER_NAME +"</a></td><td><img src='http://graph.facebook.com/"+user_data[i+2].USER_ID+"/picture'</td><td>"
                + (i+4)+".<a href='https://www.facebook.com/"+user_data[i+3].USER_ID+"'>"+user_data[i+3].USER_NAME +"</a></td><td><img src='http://graph.facebook.com/"+user_data[i+3].USER_ID+"/picture'</td><td>"
                + (i+5)+".<a href='https://www.facebook.com/"+user_data[i+4].USER_ID+"'>"+user_data[i+4].USER_NAME +"</a></td><td><img src='http://graph.facebook.com/"+user_data[i+4].USER_ID+"/picture'</td></tr>"

            ); 
            //	$("#user_list").append('<td>'+(i+1)+"</td><td><a target='_blank' href='https://www.facebook.com/"+user_data[i].USER_ID+ "'>" +user_data[i].USER_NAME+"</a></td>");

                    /*        if(((i+1)%10)==0){

                        }else{
                        $("#user_list").append('<a target="_blank" href="https://www.facebook.com/'+user_data[i].USER_ID+'">'+user_data[i].USER_NAME+'</a>');
                    }*/

            ///		$("#user_list").append("<td>test</td></tr>");


        }




    };














});


$( document ).ready(function() {
    $("button").click();
});


    </script>





<?php
include_once("footer.php");
?>

