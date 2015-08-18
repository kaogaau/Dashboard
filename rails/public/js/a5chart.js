 $(function() {
        
        var dataset = [data1, data2];
        
        var options = {
            series: {
                stack: true,
                 bars: {
        show: true
    },
                shadowSize: 0
            },
            grid: {
                hoverable: true,
                clickable: true,
                tickColor: "#f9f9f9",
                borderWidth: 1,
                borderColor: "#eeeeee"
            },
            legend: {
                position: 'nw',
                labelBoxBorderColor: "#000000",
    container: $("#bar-chart #legendPlaceholder20"),
                noColumns: 0
            }
        };
        var plot;
        function ToggleSeries() {
            var d = [];
            $("#toggle-chart input[type='checkbox']").each(function() {
        if ($(this).is(":checked")) {
        var seqence = $(this).attr("id").replace("cbdata", "");
        d.push({
        label: "data" + seqence,
        data: dataset[seqence - 1]
        });
    }
    });
    options.series.lines = {};
    
    $("#toggle-chart input[type='radio']").each(function() {
        if ($(this).is(":checked")) {
        if ($(this).val() == "line") {
        options.series.lines = {
        fill: true
        };
    } else {
        options.series.bars = {
            show: true
        };
    }
    }
    });
    $.plot($("#toggle-chart #toggle-chartContainer"), d, options);
        }
        $("#toggle-chart input").change(function() {
            ToggleSeries();
        });
        ToggleSeries();
    });
