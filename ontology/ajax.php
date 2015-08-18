<?php
include_once("./commonlib.php");
$data = file_get_contents("php://input");
$json = json_decode($data, true);
if(isset($json)){
$conn = getConnection("ibabymall");
    if($json['type']=="addStarBrand"){
        $d = $json['data'];
        if( checkStarBrand($conn,$d['uid'],$d['bid'])==0){
            addStarBrand($conn,$d['uid'],$d['bid']);
            echo '{"status":"OK","data":{"code":0}}';
        }
        else{
            echo '{"status":"ERROR","data":{"reason":"already existed","code":1}}';
        }
    };
    if($json['type']=="deleteStarBrand"){
        $d = $json['data'];
        if(checkStarBrand($conn,$d['uid'],$d['bid'])>0){
            deleteStarBrand($conn,$d['uid'],$d['bid']);
            echo '{"status":"OK","data":{"code":0}}';
        }
        else{
            echo '{"status":"ERROR","data":{"reason":"the star brand doesn\'t exist","code":1}}';
        }
    };
    if($json['type']=="addStarStore"){
        $d = $json['data'];
        if( checkStarStore($conn,$d['uid'],$d['store_id'])==0){
            addStarStore($conn,$d['uid'],$d['store_id']);
            echo '{"status":"OK","data":{"code":0}}';
        }
        else{
            echo '{"status":"ERROR","data":{"reason":"already existed","code":1}}';
        }
    }
    if($json['type']=="deleteStarStore"){
        $d = $json['data'];
        if(checkStarStore($conn,$d['uid'],$d['store_id'])>0){
            deleteStarStore($conn,$d['uid'],$d['store_id']);
            echo '{"status":"OK","data":{"code":0}}';
        }
        else{
            echo '{"status":"ERROR","data":{"reason":"the star store doesn\'t exist","code":1}}';
        }
    }
}
?>
