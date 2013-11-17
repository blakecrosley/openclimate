
var options = {
  lines:  { show: true },
  points: { show: true },
  xaxis:  { tickDecimals: 0, tickSize: 1 }
};

$.plot(placeholder, data, options);

var alreadyFetched = {};