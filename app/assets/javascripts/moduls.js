

  $ (document).on('turbolinks:load',function()
{
$('#modules').DataTable({
  dom: 'T<"clear">lfrtip',
 "autoWidth": true,
 buttons: [
        {
            extend: 'csv',
            text: 'Copy all data',
            exportOptions: {
                modifier: {
                    search: 'none'
                }
            }
        }
    ]
 });
$PaginationType: "full_numbers"
bJQueryUI: true
bProcessing: true
bServerSide: true
  ajax: "modules-data.php"
$AjaxSource: $('#modules').data('source')

});
  

//   $(document).on('turbolinks:load',function() {
//  $('#modules').DataTable( {
//     dom: 'T<"clear">lfrtip',
//     "autoWidth": true, //initialize tableTools
//     "tableTools": {
//         "sSwfPath": "swf/copy_csv_xls_pdf.swf",  // set swf path
//         "sRowSelect": "multi",
//         "aButtons": [
//             "select_all", 
//             "select_none",
//             {
//                 "sExtends":    "collection",
//                 "sButtonText": "Export",
//                 "aButtons":    [ "csv", "xls", "pdf","print" ]
//             }
//         ]
//     },
//     $PaginationType: "full_numbers",
//     bJQueryUI: true,
//     processing: true,
//     serverSide: true,
    
//     ajax: "modules-data.php" // json datasource
//     } );
// });
$(document).ready(function() {
  //Only needed for the filename of export files.
  //Normally set in the title tag of your page.
  document.title='Simple DataTable';
  // DataTable initialisation
  $('#example').DataTable(
    {
      "dom": '<"dt-buttons"Bf><"clear">lirtp',
      "paging": true,
      "autoWidth": true,
      "buttons": [
        'colvis',
        'copyHtml5',
        'csvHtml5',
        'excelHtml5',
        'pdfHtml5',
        'print'
      ]
      
    }
  );
});


$(document).ready(function () { 

 
$('#modules').on('search.dt', function() {
var table = $('#modules').DataTable();
//console.log(table.page.info().recordsTotal);
var value = $('.dataTables_filter input').val();

$('.dataTables_filter input').on('keyup', function(){


   

var variance = 0 ;
var estimated = 0 ;
var spent = 0 ;  
   // var arr= Object.values(table.rows( {search:'applied'} ).data());
   var array = table.rows( {search:'applied'} ).data();
   // console.log(array);
   $.each(array, function( index, value ) {
 // console.log( index + ": " + value );
    var es =value[2];
    // console.log(typeof(es));
      // es=es.replace('h ', '.').replace('m','')
      es = num(es);
      // console.log(es);

      //console.log("estimated----"+ es);
      // es= parseFloat(es)
      estimated = estimated + es;

      // console.log("estimated" + es)

      var sp =value[3];
      // sp=sp.replace('h ', '.').replace('m','')
      sp = num(sp);
 spent =spent  + sp;
      //console.log("spend----"+ es);
      // sp= parseFloat(sp
});


  
  //console.log(table.data());
//    var arr= Object.values(table.rows( {search:'applied'} ).data());
//    //console.log(arr);
// var variance = 0 ;
// var estimated = 0 ;
// var spent = 0 ;  

  

//    for(i = 0; i < arr[i].length; i++)
//    {
//     // if (arr[i].length == 6)

//       // console.log(arr[i]);
//     // {
//       var es =arr[i][2]
//       // es=es.replace('h ', '.').replace('m','')
//       es = num(es);

//       //console.log("estimated----"+ es);
//       // es= parseFloat(es)
//       estimated = estimated + es

//       // console.log("estimated" + es)

//       var sp = arr[i][3]
//       // sp=sp.replace('h ', '.').replace('m','')
//       sp = num(sp);

//       //console.log("spend----"+ es);
//       // sp= parseFloat(sp)
//       spent =spent  + sp


//       // var as=arr[i][4]
      
//       // var q = as.replace(/<[\/]{0,1}(span)[^><]*>/ig,"")
//       // q= q.replace(/<[\/]{0,1}(img)[^><]*>/ig,"")
//       // q = q.trim()
//       // q = q.replace('h ', '.').replace('m','')
    
//       //q= parseFloat(q)
//       // variance = variance + q



    

//       // }
//     // }
//    }
// alert( 'Rows '+table.rows( '.selected' ).count()+' are selected' );
// console.log(variance);

// var c = variance[0].replace('h ', '.').replace('m','')

// var d = parseFloat(c);

// console.log("asdsadsa" + typeof(d));

// console.log("ploigt"+estimated);
// console.log("rwtyw"+spent)
if (estimated < spent)

{

variance = spent - estimated;

}

else {

  variance = estimated - spent;

}

// console.log(variance);
var spent1 =convertion(spent);
var esti1 = convertion(estimated);
var vari1 = convertion(variance);
// console.log(parseFloat(spent1));
// console.log(parseFloat(esti1));
// console.log(parseFloat(vari1));
// console.log("spe"+spent1);
// console.log("esti"+esti1);
// console.log("vari1"+vari1);

// console.log(arr);
// console.log("*********************************");
// console.log("variance" + variance );
// console.log("spent"+spent);
// console.log("estimated" + estimated);


// console.log("*********************************");  
 // console.log("variance" + variance );
 // console.log("spent"+spent);
 // console.log("estimated" + estimated);

graph(esti1, spent1,Math.abs(vari1));

});



});

function convertion(a){

  var h = Math.floor(a / 3600);

    var m = Math.floor(a % 3600 / 60);
  
     m = String(m);
   if(m.length == 1){
     var totalTime = h +"."+ "0" + m;
     totalTime = parseFloat(totalTime);
    console.log(totalTime + "dsdsdsdsdsd");
     return totalTime    
    }else{

     var totalTime = h +"."+ m
     console.log(totalTime+"llllll");
      totalTime = parseFloat(totalTime);
      console.log(totalTime+"poliju");
     return totalTime
   }
}


function num(a){
    // console.log("num:"+a);
  if (a.includes("h ")) {
    
    var a1 =a.replace('h ', '.').replace('m','')

   b= a1.split('.')
      
      b1= parseInt(b[0])*3600 ;

      b2 = parseInt(b[1])*60 ;

      var c = b1 +b2;
      // console.log("ccccc"+c);
      return c;

  }

  else if (a.includes("h")){

    var a2 = a.replace('h', '.0')

    d = a2.split('.')
      
      c1= parseInt(d[0])*3600 ;

      c2 = parseInt(d[1])*60 ;

      var e  = c1 + c2;
      // console.log("eeeee"+e);
      return e ;
  }
  else {

    var b = a.replace('m', " ")

      b = "0." + b ;

       e1 = b.split('.')

        f1 = parseInt(e1[0])*3600;

        f2 = parseInt(e[1])*60 ;

         var h = f1 + f2;
         // console.log("hhhhh"+h);
         return h;

  }
     

}


function graph(a,b,c) {

    if (a > b)
          {
              var obj = "#93bc71"
          }
          else
          {
              var obj = "#d87763"
          }

        $('#container').highcharts({
                         credits: {
    enabled: false
  },
            chart: {
                type: 'bar',
               

 backgroundColor:'rgba(255, 255, 255, 0.0)'
            },
             title:{
                  text:`Cumulative Estimation of ${gon.mod}`
                                  },
            xAxis: {
                gridLineColor: 'rgba(255, 255, 255, 0.0)',
                categories: ['Total Estimation time', 'Total Logged Time', 'Total Variance'],
                 labels: {
         style: {
          fontSize: '13px',
          fontWeight: 'bold',
            color: '#000000',
           }
           }
            },
            yAxis:{
                     
         gridLineColor: 'rgba(255, 255, 255, 0.0)',
     
      labels: {
         style: {


          fontWeight: 'bold',
            color: '#000000',
           }
      },
      title:{
                            text:'Hours',

                            style:{
                              color: "#000000",
                              fontWeight: 'bold',
                                fontSize: '13px',
                             }
                        }

    },
      legend:
      {
                         enabled: false

                    
      },
      tooltip:{
                       enabled: false
                    },
         
            plotOptions: {
                series: {
                    dataLabels: {
                        enabled: true,
                        color: '#1e1d1d',
                     style: {
                  
                     textOutline: false 
                },
                
                       formatter:function () {
                        console.log(this.y);
                          let a = this.y.toFixed(2);
                          // console.log("yyyy"+typeof(a));

                        var b  = a.split(".");
                          // console.log("lllll"+ b[1]);
                        

                             if(b[1]=="00")
                              {
                                if (b[0] == "1" || b[0] == "0")
                                {
                                  return '' + b[0]+ ' hr '
                                }
                                else
                                {
                                  return '' + b[0]+ ' hrs '
                                }
                              }
                              else if(b[1].length == 1)
                              {
                                b[1] = "0"+b[1]
                                if (b[0] == "1" || b[0] == "0")
                                {
                                  return '' + b[0]+ ' hr ' + b[1]+ ' mins'; 
                                }
                                else
                                {
                                  return '' + b[0]+ ' hrs ' + b[1]+ ' mins'; 
                                }
                               
                              }
                              else
                                { 
                                    if (b[0] == "1" || b[0] == "0")
                                    {
                                      return '' + b[0]+ ' hr ' + b[1]+ ' mins';
                                    }
                                    else
                                    {
                                      return '' + b[0]+ ' hrs ' + b[1]+ ' mins';
                                    }      
                                } 
                          // if(parseInt(b[1]) > 60){
                          //   b[0] = parseInt(b[0]) + 1;
                          //   b[1] = b[1] - 60
                          // }

                        // console.log(a);
                           
                        },
                       
                       
                        inside: true,
                        rotaion: 270
                    },
                    pointPadding: 0.26,
                    groupPadding: 0
                }
            },

             series: [{
                data: [
                {y: a, dataLabels: {
                enabled: true} ,
                  color: "#1bc6c4"},
                {y: b, dataLabels: {
                enabled: true} , color: "#82b1cc"}, {y: c, dataLabels: {
                enabled: true} , color: obj}]
              }]
        });
    }
// console.log(table);
});
