// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootsy
//= require jquery.turbolinks
//= require_tree .
//=# require turbolinks

//= require websocket_rails/main

var dispatcher = new WebSocketRails('localhost:3000/websocket');
channel = dispatcher.subscribe('orders');
channel.bind('new', function(order) {
  console.log('a new order about '+order.id+' arrived!');
  // $(".order-body").append("<tr><td>" + order.name+ "</td><td> " + order.number + "</td></tr>");
})

// var dispatcher = new WebSocketRails('microlabil.com:3001/websocket');
// channel = dispatcher.subscribe('articles');
// channel.bind('new', function(article) {
//   console.log('a new article about '+article.id+' arrived!');
// })
// $( document ).ready( function(){
//   alert("<%#= articles_path %>")
//   $("a#articles").click( function() {
//     $.get( "<%#= articles_path %>", function( data ) {
//       $( "div#main-container" ).html( "aji" );
//     });
//   });

  // $("input.transaction-type").on("click", function(){
  //   if($(this).attr('id') == 'transaksi_add_saving'){
  //     $("#select_saving").show('fast');
  //     $("#name_events").hide('fast');
  //     $("input#name").removeAttr('required');
  //   }
  //   if($(this).attr('id') == 'transaksi_add_outcome' || $(this).attr('id') == 'transaksi_add_income'){
  //     $("#select_saving").hide('fast');
  //     $("#name_events").show('fast');
  //     $("input#name").attr('required', 'true');
  //   }
  // });

  // $("a.edit").on("click", function(){
  //   $( "div#target" ).load( $(this).attr('href')+" form", function(){
  //     $('.datepicker').datepicker({
  //       format: "dd MM yyyy",
  //       weekStart: 1,
  //       todayBtn: "linked",
  //       autoclose: true,
  //       todayHighlight: true
  //     });
  //   });
  // });

// });

