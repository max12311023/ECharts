# Apache ECharts
一個開源的圖表庫，透過JavaScript 展示出數據系列、堆疊圖、動畫效果等。

### 引用Apache ECharts
CDN 方式匯入

```JavaScript
<script type="text/javascript" src="https://fastly.jsdelivr.net/npm/echarts@5.4.2/dist/echarts.min.js"></script>
```
HTML 創建要放報表的DOM 元件

```HTML
<div id="chartmain" style="width:900px; height: 600px;"></div>
```

透過echarts.init方法初始化，並設定後 setOption建立報表
```js
 <script type="text/javascript">

      var myChart = echarts.init(document.getElementById('chartmain'));

      var option = {
        title: {
          text: 'ECharts Sample'
        },
        tooltip: {},
        legend: {
          data: ['Sales']
        },
        xAxis: {
          data: ['衬衫', '羊毛衫', '雪纺衫', '裤子', '高跟鞋', '袜子']
        },
        yAxis: {},
        series: [
          {
            name: '销量',
            type: 'bar',
            data: [5, 20, 36, 10, 10, 20]
          }
        ]
      };

      myChart.setOption(option);
    </script>
```

### Chart with JSON Data
JSON 格式
```json
{"month":["2020/09","2021/02","2021/04","2021/06","2022/07","2022/07","2022/10","2022/11","2023/06"],"open":[1,2,1,0,0,2,2,0,0],"close":[0,0,0,1,1,0,0,1,5]}
```
透過AJAX 後端數據處理後回傳JSON格式

```js
$.getJSON('bug_project_issue_list_json?projectNameDesc='+projectNameDesc, function (bug_project_issue_list) {
chart.hideLoading();
	option = {
	    tooltip : {
	        trigger: 'axis',
	        axisPointer: {
	            type: 'shadow',
	            label: {
	                show: true
	            }
	        }
	    },
	    toolbox: {
	        show : true,
	        feature : {
	            mark : {show: true},
	            dataView : {show: true, readOnly: false},
	            magicType: {show: true, type: ['line', 'bar']},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    calculable : true,
	    legend: {
	        data:[ 'Open', 'Close'],
	        itemGap: 5
	    },
	    grid: {
	        top: '12%',
	        left: '1%',
	        right: '10%',
	        containLabel: true
	    },
	    xAxis: [
	        {
	            type : 'category',
	            data : bug_project_issue_list.month
	        }
	    ],
	    yAxis: [
	        {
	            type : 'value',
	            name : 'Count',
	        }
	    ],
	    dataZoom: [
	        {
	            show: true,
	            start: 1,
	            end: 100
	        },
	        {
	            type: 'inside',
	            start: 94,
	            end: 100
	        },
	        {
	            show: true,
	            yAxisIndex: 0,
	            filterMode: 'empty',
	            width: 30,
	            height: '80%',
	            showDataShadow: false,
	            left: '93%'
	        }
	    ],
	    series : [
	        {
	            name: 'Open',
	            type: 'bar',
	            data: bug_project_issue_list.open,
	            markPoint: {
	                data: [
	                  { type: 'max', name: 'Max' },
	                  { type: 'min', name: 'Min' }
	                ]
	              },
	              markLine: {
	                data: [{ type: 'average', name: 'Avg' }]
	              }
	        },
	        {
	            name: 'Close',
	            type: 'bar',
	            data: bug_project_issue_list.close,
	            markPoint: {
	                data: [
	                  { type: 'max', name: 'Max' },
	                  { type: 'min', name: 'Min' }
	                ]
	              },
	              markLine: {
	                data: [{ type: 'average', name: 'Avg' }]
	              }
	        }
	    ]
	    };
	
	    chart.setOption(option);
	
	})
	.fail(function(xhr, status, error) {
	    chart.hideLoading();
		alert('no data!!')
	});
}
</script>
```
![2023-07-06 09_49_34-bts_customer_report 和其他 2 個頁面 - 公司 - Microsoft​ Edge](https://github.com/max12311023/ECharts/assets/24786119/f3bd262c-b874-43bf-9b6d-2890e17ef57e)
