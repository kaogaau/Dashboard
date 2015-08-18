<?php
include_once("./header.php");
?>

    <div class="container">
        <div id="table">
        </div>
        <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
        <script type="text/javascript">
            $.get("./analyze_price.php", function(response){
                raw=$.parseJSON(response);
                var color = ['#4FC5C7', '#97EC71', '#F3E59A', '#DE9DD6', '#FA6E86'];
                var table = '<table class="table">\n';
                var table_title = "<tr>\n    <th>價格帶</th>\n";
                var color_picker = 0;

                for (var store_key in raw['data']) {
                    if (raw['data'].hasOwnProperty(store_key)) {
                        table_title += '    <th style="border-bottom: solid 4px ' + color[color_picker%5] + ';">' + store_key + "</th>\n";
                        color_picker += 1;
                    }
                }
                table_title += "</tr>\n"
                    var table_data = "";
                for (var range_key in raw['range']) {
                    if (raw['range'].hasOwnProperty(range_key)) {
                        table_data += "<tr>\n";
                        table_data += '    <td>' + raw['range'][range_key] + "</td>\n";
                        color_picker = 0;
                        for (var brand_key in raw['data']) {
                            if (raw['data'].hasOwnProperty(brand_key)) {
                                var amount = raw['data'][brand_key][raw['range'][range_key]];
                                var radius = Math.log(amount) * 5;
                                var circle = '<svg height="100" width="100">\
                                    <circle cx="50" cy="50" r="' + radius + '" stroke="black" stroke-width="0" fill="' + color[color_picker%5] +
                                    '" />\
                                    <text x="50%" y="50%" text-anchor="middle" fill="black" dy=".3em" ;>' + amount + '</text>\
                                    </svg>';
                                color_picker += 1;
                                table_data += '    <td>' + circle + '</td>\n';
                            }
                        }
                        table_data += "</tr>\n";
                    }
                };
                table = table + table_title + table_data + "</table>\n"
                    $("#table").append(table);
            })
        </script>
    </div>

<?php
include_once("footer.php");
?>

