$(document).ready(function(){

var imageRotator = {
	
	initialze: function() {

		var itemCount = $(".rotatingimage").length;

		var currentItem = 0;

		$(".rotatingimage").eq(currentItem).fadeIn(1);

		var loop = setInterval(function(){
			$(".rotatingimage").eq(currentItem).fadeOut(2500);
			if(currentItem == itemCount -1){
				currentItem = 0;
			} else {
				currentItem++;
			}
			$(".rotatingimage").eq(currentItem).fadeIn(2500);
			}, 5000);
		}
	};

imageRotator.initialze();


});