$(document).ready(function() {
  var options = {
    lines: { show: true },
    points: { show: true },
    xaxis: { tickDecimals: 0, tickSize: 1 }
  };

  var data = [];
  var staticChart = $("#staticChart");
  var dynamicChard = $("#dynamic-chart");
  var alreadyFetched = {};

  var staticSeries = {
    "label": "2013-11-15",
    "data": [
        [1,18.0],
        [2,18.5],
        [3,19.3],
        [4,20.9],
        [5,21.9],
        [6,23.0],
        [7,23.4],
        [8,24.8],
        [9,25.1],
        [10,26.3],
        [11,27.3],
        [12,28.5],
        [13,28.9],
        [14,29.4],
        [15,30.2],
        [16,31.3],
        [17,28.9],
        [18,25.1],
        [19,20.1],
        [20,18.0],
        [21,18.0],
        [22,16.7],
        [23,15.0],
        [24,12.0]
    ]
  };

  $.ajax({
    url: '/json/static.json',
    method: 'GET',
    dataType: 'json',
    success: onDataReceived
  });

  function onDataReceived(series) {
    // extract the first coordinate pair so you can see that
    // data is now an ordinary Javascript object
    var firstcoordinate = '(' + series.data[0][0] + ', ' + series.data[0][1] + ')';


    // let's add it to our current data
    if (!alreadyFetched[series.label]) {
        alreadyFetched[series.label] = true;
        data.push(series);
    }

    // and plot all we got
    $.plot(staticChart, data, options);
  }
});

<<<<<<< HEAD
=======
var alreadyFetched = {};
>>>>>>> 376701f6a64c83c5b221ffb6d148e6f3812701d5
