	 var xAxisData = [];
    var viewsData = [];
    var salesData = [];
    var conversionsData = [];
    var clicksData = [];
    var costData = [];
    var startdate = "";
    var enddate = "";
    var charttype = "line";
   


   function advListChanged(){
	   $('#campaignlist').empty();
       $('#campaignlist').append( new Option("All Campaigns","0",true,true) );
	   populateCampaignsByAdv();	   
   }

   function populateAdvertisersList(advs){	
	  var defaultSelected = true;
      var nowSelected     = true;
	
      $(advs).each(function(index) {
		        $('#advertiserlist').append( new Option(this.name,this.id,defaultSelected,nowSelected) );
		        defaultSelected = false;
		        nowSelected = false;		
		    });
      
	  populateCampaignsByAdv();

    }

   function populateCampaignsList(camps){
	
      $( camps ).each(function( index ) {
		        $('#campaignlist').append( new Option(this.name,this.id) );
		
		    });

	}		

   function populateCampaignsByAdv(){
	
	 var selectedadvid = $('#advertiserlist').find(":selected").val();		
	 var url = "http://54.174.116.53:8080/api/metadata";
     var postdata = "{\"ids\":[\""+selectedadvid+"\"],\"entityType\":\"advertiser\"}";
     var dataType = "json";	
	
     $.ajax({
     type: "POST",
     url: url,
     async: false,
     contentType: "application/json; charset=utf-8",
     data: postdata,
     success:  function (data, status, jqXHR) {
     		   populateCampaignsList(data.data.data[0].campaigns);			
          },
     dataType: dataType
    });
		
	}	


   function populateAdvertisers(){

	 var url = "http://54.174.116.53:8080/api/metadata";
     var postdata = "{\"entityType\":\"advertiser\"}";
	 var dataType = "json";	

     $.ajax({
     type: "POST",
     url: url,
     async: false,
     contentType: "application/json; charset=utf-8",
     data: postdata,
     success:  function (data, status, jqXHR) {     
	       populateAdvertisersList(data.data.data[0].advertisers);			
          },
     dataType: dataType
   });
		
	}	

   function showChartTypes(chtype){
		
		charttype = chtype;
		if(chtype=="line"){
		$( "#lineicon" ).attr({
		  class: "btn chart-type chart-line active",
		});
			  $( "#baricon" ).attr({
		  class: "btn chart-type chart-bar ",
		});	
		}else{
					$( "#lineicon" ).attr({
		  class: "btn chart-type chart-line ",
		});

  		  $( "#baricon" ).attr({
		  class: "btn chart-type chart-bar active",
		});
		}	
		drawAdvertiserChart();

	}	

   function populateStartEndDates(pastdays){
	var date = new Date();
	
	var newdate = new Date(date);

	newdate.setDate(newdate.getDate() - pastdays); // minus the date

	var nd = new Date(newdate);
	
	   
	var  day = (date.getDate() < 10 ? ('0'+date.getDate()) : date.getDate());
	var	 month = (date.getMonth() +1) ;
	month = (month < 10 ? ('0'+month): month);
	var year = date.getFullYear();
 
	enddate  =  year+"-"+month+"-"+day;			  

	day = (newdate.getDate() < 10 ? ('0'+newdate.getDate()): newdate.getDate());
	month = (newdate.getMonth() +1) ;
    month = (month < 10 ? ('0'+month): month);
	year = newdate.getFullYear();
				
	startdate  =  year+"-"+month+"-"+day;		
   }   

    function populateDataTable(jsontabledata)
	{
	$('#datatable >tr').remove();
	$(jsontabledata).each(function(index, element){  

     $('#datatable').append('<tr><td > '+element.date 
							+'</td><td >'+element.views
							+' </td> <td > '+element.clicks
							+'</td><td >'+element.conversions
							+'</td><td >'+element.sales
							+' </td> <td >'+element.cost
							+' </td></tr>');       
})	
	}	
	function getAdvertiserData(){

	var url = "http://54.174.116.53:8080/api/report";
	var postdata = "{\"ids\":[ENTITY_ID], \"entityType\":\"ENTITY\",\"startdate\":\"FROM_DATE\",\"enddate\":\"TO_DATE\",\"report_interval\":\"daily\"}";
	var dataType = "json";
	var selectedAdvertiser = $('#advertiserlist').find(":selected").val();
	var selectedCampaign = $('#campaignlist').find(":selected").val();
    var selectedChartType = $('#charttypelist').find(":selected").val();
	
	if(selectedCampaign != "0"){	
	postdata = postdata.replace("ENTITY_ID",selectedCampaign);			
	postdata = postdata.replace("ENTITY","campaign");			
	}else{
	postdata = postdata.replace("ENTITY_ID",selectedAdvertiser);		
    postdata = postdata.replace("ENTITY","advertiser");			
	}	
		
	postdata = postdata.replace("FROM_DATE",startdate) ;
	postdata = postdata.replace("TO_DATE",enddate) ;
		
	 xAxisData = [];
     viewsData = [];
     salesData = [];
     conversionsData = [];
     clicksData = [];
     costData = [];
	  
     $.ajax({
     type: "POST",
     url: url,
     async: false,
     contentType: "application/json; charset=utf-8",
     data: postdata,
     success:  function (data, status, jqXHR) {
		 populateDataTable(data.data.data);	   
	           $( data.data.data ).each(function( index ) {
		       viewsData.push(this.views/1000 );		  
		       clicksData.push(this.clicks);
		       conversionsData.push(this.conversions);
		       costData.push(this.cost);
		       xAxisData.push(this.date);
		       salesData.push(this.sales);
				   
			 
		    });
          },
     dataType: dataType
	   });	
	}
		
   function getWeeklyData () {
     jQuery.ajax({
         type: "GET",
         url: "http://54.169.91.32/api/report/seller/weekly?advertiserid=1",
         contentType: "application/json; charset=utf-8",
         dataType: "json",
         success: function (data, status, jqXHR) {
         },
         error: function (jqXHR, status) {
             // error handler			 
         }
	});

  }	
		
	

	function sleep(milliseconds) {
  		var start = new Date().getTime();
  			for (var i = 0; i < 1e7; i++) {
			    if ((new Date().getTime() - start) > milliseconds){
				      break;
			    }
  			}
	}
		
	function drawAdvertiserChart(){
		var dateInterval = $('#dateinterval').find(":selected").val();
		populateStartEndDates(dateInterval);
		getAdvertiserData();	
		drawChart();
	} 

    function drawChart() {

		$('#chart1').highcharts({
			chart: {
            type: charttype
        },
            title: {
                text: 'Analytics Report',
                x: -20 //center
            },
            subtitle: {
                text: '',
                x: -20
            },
            xAxis: {
                categories: xAxisData
            },
            yAxis: {
                title: {
                    text: 'Views (in K)'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                valueSuffix: ''
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0
            },
            series: [{
                name: 'Views',
                data:viewsData
            }, {
                name: 'Clicks',
                data:clicksData
            }, {
                name: 'Conversions',
                data: conversionsData
            }, {
                name: 'Sales',
                data: salesData
            }, {
                name: 'Cost',
                data: costData
            }]
        });
    }