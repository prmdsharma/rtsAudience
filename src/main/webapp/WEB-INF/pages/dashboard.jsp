<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page session="true"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width">
    <title>AdTech Analytics</title>

    <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet" type="text/css">

    <link rel="stylesheet" href="<c:url value="/resources/css/lib-4679b1aa.css" />" type="text/css">
    <link rel="stylesheet" href="<c:url value="/resources/css/app-9ad3206a.css" />" type="text/css">
	<script src="<c:url value="/resources/js/jquery.js" />"></script>
	<script src = "<c:url value="/resources/js/jquery-ui.js" />"></script>
	<script src = "<c:url value="/resources/js/reportfunctions.js" />"></script>
    <script src = "<c:url value="/resources/js/jquery-ui.js" />"></script>
   	<script src = "<c:url value="/resources/js/jquery.table2excel.js" />"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
    <script src="<c:url value="/resources/js/highcharts.js" />"></script>
    <script src="<c:url value="/resources/js/exporting.js" />"></script>
	<script  type="text/javascript">
	 apihost ="<c:out value="${apihost}"/>";
	 
	     page = "adv";
		 $(function() {
  		  populateAdvertisers();
    	  drawAdvertiserChart();
			$("#advertiserlist").change(function () {
			advListChanged();	
		});	 
  });
		function computeBroadcast(){
			 drawAdvertiserChart();
		}
	</script>
   
</head>
<body>

<div id="layout">
    <!-- uiView: nav --><div ui-view="nav" id="nav-container" class="ng-scope"><div class="container ng-scope" id="header">
    <div class="inside">
        <div id="logo" class="section">
            <a href="/home" class="section-vert-center">
            <img src="<c:url value="/resources/images/odlogo.png" />">
            </a>
        </div>
        <div id="navigation" class="section">
        <div id="navigation" class="section">
            <ul class="nav-list">
      <!-- ngRepeat: nav in navigations --><li ng-repeat="nav in navigations" class="nav ng-scope">
                    <a ng-class="{ active: tabActive(nav.tab) }" ui-sref="app.overview.dashboards" href="/" class="active">
                        <!-- ngIf: ::nav.icon --><span ng-if="::nav.icon" class="ng-scope"></span><!-- end ngIf: ::nav.icon -->
                        <span class="ng-binding">overview</span>                    </a>
                </li>
                <!-- end ngRepeat: nav in navigations --><li ng-repeat="nav in navigations" class="nav ng-scope">
                    <a ng-class="{ active: tabActive(nav.tab) }" ui-sref="app.events.summary" href="#">
                        <!-- ngIf: ::nav.icon --><span ng-if="::nav.icon" class="ng-scope"></span><!-- end ngIf: ::nav.icon -->
                        <span class="ng-binding">events</span>                    </a>
                </li>
                <!-- end ngRepeat: nav in navigations --><li ng-repeat="nav in navigations" class="nav ng-scope">
                    <a ng-class="{ active: tabActive(nav.tab) }" ui-sref="app.timelines.realtime" href="#">
                        <!-- ngIf: ::nav.icon --><span ng-if="::nav.icon" class="ng-scope"></span><!-- end ngIf: ::nav.icon -->
                        <span class="ng-binding">user activity</span>                    </a>
                </li>
                <!-- end ngRepeat: nav in navigations --><li ng-repeat="nav in navigations" class="nav ng-scope">
                    <a ng-class="{ active: tabActive(nav.tab) }" ui-sref="app.funnels" href="#">
                        <!-- ngIf: ::nav.icon --><span ng-if="::nav.icon" class="ng-scope"></span><!-- end ngIf: ::nav.icon -->
                        <span class="ng-binding">funnels</span>                    </a>
                </li>
                <!-- end ngRepeat: nav in navigations --><li ng-repeat="nav in navigations" class="nav ng-scope">
                    <a ng-class="{ active: tabActive(nav.tab) }" ui-sref="app.retention.retention" href="#">
                        <!-- ngIf: ::nav.icon --><span ng-if="::nav.icon" class="ng-scope"></span><!-- end ngIf: ::nav.icon -->
                        <span class="ng-binding">retention</span>                    </a>
                </li>
                <!-- end ngRepeat: nav in navigations --><li ng-repeat="nav in navigations" class="nav ng-scope">
                    <a ng-class="{ active: tabActive(nav.tab) }" ui-sref="app.revenue.summary" href="/revenue">
                        <!-- ngIf: ::nav.icon --><span ng-if="::nav.icon" class="ng-scope"></span><!-- end ngIf: ::nav.icon -->
                        <span class="ng-binding">revenue</span>                    </a>
                </li>
                <!-- end ngRepeat: nav in navigations --><li ng-repeat="nav in navigations" class="nav ng-scope">
                    <a ng-class="{ active: tabActive(nav.tab) }" ui-sref="app.cohorts.list" href="#">
                        <!-- ngIf: ::nav.icon --><span ng-if="::nav.icon" class="ng-scope"></span><!-- end ngIf: ::nav.icon -->
                        <span class="ng-binding">cohorts</span>                    </a>
                </li>
                <!-- end ngRepeat: nav in navigations --><li ng-repeat="nav in navigations" class="nav ng-scope">
                    <a ng-class="{ active: tabActive(nav.tab) }" ui-sref="app.query" href="#">
                        <!-- ngIf: ::nav.icon --><span ng-if="::nav.icon" class="ng-scope"></span><!-- end ngIf: ::nav.icon -->
                        <span class="ng-binding">query</span>                    </a>
                </li>
                <!-- end ngRepeat: nav in navigations --><li ng-repeat="nav in navigations" class="nav ng-scope" onclick="formSubmit()">
                    <a ng-class="{ active: tabActive(nav.tab) }" ui-sref="app.query" href="#" onclick="formSubmit()">
                        <!-- ngIf: ::nav.icon --><span ng-if="::nav.icon" class="ng-scope"></span><!-- end ngIf: ::nav.icon -->
                        <span class="ng-binding">Logout</span>                    </a>
                </li>
                <!-- end ngRepeat: nav in navigations -->
                <!-- end ngRepeat: nav in navigations -->
            </ul>
        </div>
        
    </div>
</div>
</div>

    <!-- uiView: main --><div ui-view-loading="loading" ui-view="main" id="main-container" class="ng-scope"><div class="status-bar-container ng-scope">
    <amp-status-bar class="ng-isolate-scope"><div class="amp-status-bar">
    <!-- ngIf: status.indicator && status.indicator !== 'none' -->
</div>
</amp-status-bar>
</div>
<div class="container ng-scope" id="main">
    <div class="inside">
        <!-- uiView: dashboard --><div ui-view="dashboard" class="main-content ng-scope"><div class="main-window ng-scope">
    <!--- Window-tab-->
    <div class="window tab">
        <div class="main-tab">
</div>
    </div>
    <!-- uiView:  --><div ui-view="" class="ng-scope"><div class="window ng-scope">
    <!--- Window-header-->
    <div class="window-header">
        <div class="title alignleft selection">&nbsp;
  </div>

        <div class="selection alignleft">
        
        </div>
        <div class="selection alignright">
            <intervaldropdown>
				<select ng-disabled="disabled" id="dateinterval" ng-model="dates.interval" ui-select2="{ dropdownAutoWidth: true, minimumResultsForSearch: -1 }" 
						class="ng-pristine ng-untouched ng-valid " tabindex="-1" title="">
    <option selected="" value="1">Daily</option>
    <option value="8">Weekly</option>
    <option value="31">Monthly</option>
</select>
</intervaldropdown>
        </div>
        <div class="selection alignright">
        </div>
    </div>

    <div ng-class="{ gone: error }" class="loading-wrapper ng-isolate-scope" error="overviewError" loading="overviewLoading">
    <div class="loading-window" ng-class="{ blurred: loading, gone: (error || error == 0) }" ng-transclude="">
        <!-- Legend -->
        <!-- ngIf: showLegend -->

        <!-- Graph -->
        <div class="window-content chart chart-type-control ng-scope">
            <dashboardadd params-fn="getDashboardParams" class="ng-isolate-scope"><div popover-append-to-body="true" popover-popup-delay="200" popover-trigger="mouseenter" popover="Add to dashboard" popover-placement="top" ng-click="showDashboardAdd()" class="dashboard-add ng-scope">
    <!-- ngIf: ::!isDemo -->
</div>
</dashboardadd>
            <createalert disabled-fn="alertDisabled" params-fn="getAlertParams" metric="'users'" class="ng-isolate-scope"><div popover-append-to-body="true" popover-popup-delay="200" popover-trigger="mouseenter" popover="Create alert" popover-placement="top" ng-click="canCreateAlert() &amp;&amp; showCreateAlert()" class="create-alert ng-scope">
    <!-- ngIf: alertsEnabled() -->
</div>
</createalert>
            <!-- ngIf: showChartTypes() --><div ng-if="showChartTypes()" class="choose-chart-type ng-scope">
                <charttype types="['line', 'bar']" selected="chart" class="ng-isolate-scope"><div class="btn-group">
    <!-- ngRepeat: type in types --><label id="lineicon" onclick="showChartTypes('line');" ng-class="{ active: type == selected.type }" btn-radio="'line'" ng-model="selected.type" 
										   class="btn chart-type chart-line active" ng-repeat="type in types"></label>
					<!-- end ngRepeat: type in types --><label id="baricon"  onclick = "showChartTypes('bar');" ng-class="{ active: type == selected.type }" btn-radio="'bar'" 
															   ng-model="selected.type" class="btn chart-type chart-bar" ng-repeat="type in types">
					</label><!-- end ngRepeat: type in types -->
</div>
</charttype>
            </div><!-- end ngIf: showChartTypes() -->
            <div class="clearfix"></div>
            <div class="chart-content" id="chart1">   
            </div>
        </div>
    </div>

    <div ng-class="{ loading: loading, ready: !loading}" class="loading-overlay ready">
        <div class="spinner">
            <div class="rect1"></div>
            <div class="rect2"></div>
            <div class="rect3"></div>
            <div class="rect4"></div>
            <div class="rect5"></div>
        </div>
    </div>

    <!-- ngIf: loading && underHeavyLoad && !skipHeavyLoadWarning -->

    <div ng-show="(error || error == 0) &amp;&amp; !loading" class="error-overlay ng-hide">
        <!-- ngIf: error === 503 -->
        <!-- ngIf: error !== 503 --><div ng-if="error !== 503" class="error ng-scope">
            <span style="color: red">An error occurred while loading your data.</span><br>
            <span style="font-size: 9px" class="ng-binding">( status code)</span><br>
            <!--Please contact <b></b> if this failure persists.-->
        </div><!-- end ngIf: error !== 503 -->
    </div>
</div>
</div>

<div class="window ng-scope">
    <!--- Window-header-->
    <div class="window-header">
        <div class="title alignleft selection">
</div>
        <div class="selection alignright">
        <a type="button" id="export" value = "export" onclick="exportTable();">Export</a>           
        </div>
		<div class="selection alignleft"><span  class="ng-pristine ng-untouched ng-valid" >&nbsp;</span></div>
    </div>
    <div ng-class="{ gone: error }" class="loading-wrapper ng-isolate-scope" error="overviewError" loading="overviewLoading">
    <div class="loading-window" ng-class="{ blurred: loading, gone: (error || error == 0) }" ng-transclude="">
        <div class="window-content chart-type-control ng-scope">
            <div class="export-csv right">
               </div>
            <!-- ngIf: chart.data --><div fixed-table-data="['table', chart.data, usersFilterText.label]" fixed-columns="true" fixed-table="" ng-if="chart.data" class="">
                <div class="table-fixed-wrapper-left">
                                    </div>
                <div class="table-fixed-wrapper-right" >
                    <table id="exporttable" class="table series-list time-series-table-right"  >
                        <thead>
                            <tr>
                                
								<th ng-repeat="x in chart.data.xValues" class="ng-binding ng-scope" >Date</th>
								<th ng-repeat="x in chart.data.xValues" class="ng-binding ng-scope" >Advertiser</th>
								<th ng-repeat="x in chart.data.xValues" class="ng-binding ng-scope" >Campaign</th>
								<th ng-repeat="x in chart.data.xValues" class="ng-binding ng-scope" >Views</th>
								<th ng-repeat="x in chart.data.xValues" class="ng-binding ng-scope" >Clicks</th>
								<th ng-repeat="x in chart.data.xValues" class="ng-binding ng-scope" >Conversions</th>
								<th ng-repeat="x in chart.data.xValues" class="ng-binding ng-scope" >Sales</th>
								<th ng-repeat="x in chart.data.xValues" class="ng-binding ng-scope" >Cost</th>
								
                           </tr>
                        </thead>
                        <tbody class="dragger" id="datatable">
                            <!-- ngRepeat: row in chart.data.rows | filter:usersFilterText --><tr ng-repeat="row in chart.data.rows | filter:usersFilterText" class="ng-scope">
                                
                          
                        </tbody>
                    </table>
                </div>
            </div><!-- end ngIf: chart.data -->
        </div>
    </div>

    <div ng-class="{ loading: loading, ready: !loading}" class="loading-overlay ready">
        <div class="spinner">
            <div class="rect1"></div>
            <div class="rect2"></div>
            <div class="rect3"></div>
            <div class="rect4"></div>
            <div class="rect5"></div>
        </div>
    </div>

    <!-- ngIf: loading && underHeavyLoad && !skipHeavyLoadWarning -->

    <div ng-show="(error || error == 0) &amp;&amp; !loading" class="error-overlay ng-hide">
        <!-- ngIf: error === 503 -->
        <!-- ngIf: error !== 503 --><div ng-if="error !== 503" class="error ng-scope">
            <span style="color: red">An error occurred while loading your data.</span><br>
            <span style="font-size: 9px" class="ng-binding">( status code)</span><br>
            <!--Please contact <b></b> if this failure persists.-->
        </div><!-- end ngIf: error !== 503 -->
    </div>
</div>
</div>
</div>
</div>
</div>
        <!-- uiView: segments --><div ui-view="segments" class="side-bar ng-scope"><div class="side-bar-inside active segments-side-bar ng-scope">
    <div class="side-bar-content active">
        <div class="tier1">
            <!--div class="title">
                user segments
                <div class="clear-segments-wrapper">
                    <button ng-click="segmentService.clearSegments()" ng-disabled="!segmentService.activeSegments.length &amp;&amp; segmentService.groupBy.length &lt;= 1" class="btn btn-default clear-segments" disabled="disabled">
                        Clear all                    </button>
                </div>
            </div>
            <div>
             

                <div popover-append-to-body="true" popover-popup-delay="200" popover-trigger="never" popover="Can add at most 10 segments" popover-placement="top" class="add-segment-wrapper ng-scope">
             
                    <button ng-click="makeNewSegment(true)" ng-disabled="!canAddSegment()" class="btn btn-default add-segment">
                        <i class="fa fa-plus fa-lg"></i>Add segment                    </button>
                </div>
            </div-->

            <!-- group by -->
              <div ng-if="segmentService.groupByEnabled" class="title ng-scope">Advertiser</div><!-- end ngIf: segmentService.groupByEnabled -->
              <div ng-if="segmentService.groupByEnabled" class="ng-scope">
              <div popover-append-to-body="true" popover-popup-delay="200" popover-trigger="never" popover="Remove extra segments to use Group By, which is only available for a single segment" popover-placement="top" class="group-by-wrapper ng-scope" ng-repeat="groupBy in segmentService.groupBy track by $index">
			            		<select id="advertiserlist"
										class="select2-container btn-group ng-pristine ng-untouched ng-valid" 
										tabindex="-1" 
										title="" >
                        		<!--option value="1">Microsoft</option>
								<option value="2">Samsung</option-->
			                    </select>
                </div>
				  <div class="title ng-scope"></div>
              <div ng-if="segmentService.groupByEnabled" class="title ng-scope">Campaign</div><!-- end ngIf: segmentService.groupByEnabled -->
              <div ng-if="segmentService.groupByEnabled" class="ng-scope">
              <div popover-append-to-body="true" popover-popup-delay="200" popover-trigger="never" popover="Remove extra segments to use Group By, which is only available for a single segment" popover-placement="top" class="group-by-wrapper ng-scope" ng-repeat="groupBy in segmentService.groupBy track by $index">
			            		<select id="campaignlist"
										class="select2-container btn-group ng-pristine ng-untouched ng-valid" 
										tabindex="-1" 
										title="" >
                        		<option value="0">All Campaigns</option>
			                    </select>
                </div>
				  
				  
            </div><!-- end ngIf: segmentService.groupByEnabled -->
        </div>
        <div class="tier1">
            <!-- compute button -->
            <button onclick="computeBroadcast()" ng-disabled="!segmentService.dirty" class="btn btn-default compute" >
                <i class="fa fa-refresh fa-lg"></i>compute            </button>
        </div>

        <!-- recent segments, currently hidden -->
        <!-- ngIf: false -->
    </div>
</div>
</div>
    </div>
</div>
</div>
</div>





</body>
</html>
