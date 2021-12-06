// Función de slider adaptada a partir del código publicado en 
// https://medium.com/@AmyScript/simple-image-slider-using-html5-css3-and-jquery-fc7b4f23f4b6

function galeria() {
	var i= 0;
	$('.galeria .siguiente').on("click", function(){
		i = i + 1;
		//Si se ha llegado al final, reinicia el índice
		if (i == $('.galeria img').length) {
			i=0;
		}
		//establece la imagen que va a salir y la que va a entrar
		var currentImg = $('.galeria img').eq(i);
		var prevImg = $('.galeria img').eq(i-1);
		moverL(prevImg, currentImg);
	});
	$('.galeria .previo').on("click", function(){
        //Si se ha llegado al principio, salta al final
		if (i==0) {	
			prevImg = $('.galeria img').eq(0);
			i=$('.galeria img').length-1;
			currentImg = $('.galeria img').eq(i);
		}
		else {
			i=i-1;
			//establece la imagen que va a salir y la que va a entrar
			currentImg = $('.galeria img').eq(i);
			prevImg = $('.galeria img').eq(i+1);
		}
		
        moverR(prevImg, currentImg);		
	});

	function moverL(previa, actual) {
		//Coloca la imagen a mostrar a la derecha (fuera de la vista)
		actual.css({"left":"100%"});
		//Muestra la imagen deslizandola desde la derecha
		actual.animate({"left":"0%"}, 500);
		 //Oculta la imagen deslizandola hacia la izquierda
		previa.animate({"left":"-100%"}, 500);
	}

	function moverR(previa, actual) {
		//Coloca la imagen a mostrar a la izquierda (fuera de la vista)
		actual.css({"left":"-100%"});
        //Muestra la imagen deslizandola desde la izquierda
		actual.animate({"left":"0%"}, 500);
        //Oculta la imagen deslizandola hacia la derecha
		previa.animate({"left":"100%"}, 500);	
	}
}