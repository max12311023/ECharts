<%@ page language="java" contentType="text/html; charset=BIG5" pageEncoding="BIG5"%>
<!DOCTYPE html>
<html lang="en" style="height: 100%">
<head>
<meta charset="BIG5">
<title>bts_customer_report</title>

<script src="js/jquery-1.9.1.js"></script>
<script src="js/bootstrap.min.js"></script>

<script type="text/javascript" src="https://fastly.jsdelivr.net/npm/echarts@5.4.2/dist/echarts.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

</head>

<body >
<div class="container-fluid">
	<br/>
	<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="index.jsp" target="_top" >Home</a></li>
			<li class="breadcrumb-item active" aria-current="page">Customer Report</li>
		</ol>
	</nav>
 <table>
 	 <tr>
        <th align="left">Project Name</th>
        <td><div class="form-group" style="padding-left: 5px;"><input type="text" class="form-control" id="projectNameDesc" size="20" maxlength="100" class="input"   /></div></td>
		
	
<!-- 		<th align="left" style="padding-left: 10px;"> Create Date</th> -->
<!--         <td> -->
<!--            <div class="form-group" style="padding-left: 5px;"> -->
<!-- 			<div class="input-group date" id="datepickerFrom">			 -->
<!-- 			  <input type="text" name="app_date_from"  class="form-control" size="15" maxlength="30"   /> -->
<!-- 			<div class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span> -->
<!-- 			</div></div></div> -->
<!-- 		</td> -->
<!--         <td> -->
<!--             <div class="form-group" style="padding-left: 5px;"> -->
<!-- 			<div class="input-group date" id="datepickerTo" >			 -->
<!-- 			  <input type="text" name="app_date_to" class="form-control" size="15" maxlength="30"  /> -->
<!-- 			  <div class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span> -->
<!-- 			</div> </div></div>       -->
<!--         </td> -->
           <td><div class="form-group"  style="padding-left: 5px;"><input type="BUTTON"  value="FIND" class="btn btn-primary" ONCLICK="javascript:func_to_report('232');"/></div></td>
	</tr>
</table>

<div id="chartmain" style="width:900px; height: 600px;"></div>

</div>
</body>
  <script type="text/javascript">
  function func_to_report (){
		var chart = echarts.init(document.getElementById('chartmain'));
		var projectNameDesc = $("#projectNameDesc").val();
		chart.showLoading();
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
</html>