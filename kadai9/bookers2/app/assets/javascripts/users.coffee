# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
	$("#postal_code").jpostal({
	postcode:["#postal_code"],
	address :{
			"#user_prefecture_code" : "%3",
			"#address_city" : "%4%5",
			"#address_street" : "%6%7"
			}
	})