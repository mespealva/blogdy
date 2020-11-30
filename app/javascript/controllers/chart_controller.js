import Chart from 'chart.js';
console.log("charts")

var ctx = document.getElementById('page-views');
  if (ctx) {
    var myChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: JSON.parse(ctx.dataset.labels),
        datasets: [{
          label: 'Page Views',
          data: JSON.parse(ctx.dataset.data),
          borderWidth: 1
        }]
      },
    });
  }
  
  var ctx = document.getElementById('unique-page-views');
  if (ctx) {
    var myChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: JSON.parse(ctx.dataset.labels),
        datasets: [{
          label: 'Unique Page Views',
          data: JSON.parse(ctx.dataset.data),
          borderWidth: 1
        }]
      },
    });
  }