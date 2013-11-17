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

  fetchData();

  function fetchData() {

    data = []
    alreadyFetched = {};

    function onDataFetch(series) {

      data = [series.message];

      $.plot($("#dynamicChart"), data, options);

    }

    $.ajax({
      url: '/temperature/get',
      method: 'GET',
      dataType: 'json',
      success: onDataFetch
    });

    setTimeout(fetchData, 1000);
  }
});
