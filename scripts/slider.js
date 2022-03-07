// Función de slider adaptada a partir del código publicado en 
// https://medium.com/@AmyScript/simple-image-slider-using-html5-css3-and-jquery-fc7b4f23f4b6

function galeria() {
	var i= 0;
	$('.galeria .siguiente').on("click", function(){
		i =  $(this).parent().data("indice") + 1;
		//Si se ha llegado al final, reinicia el índice
		if (i == $(this).parent().children('img').length) {
			i=0;
		}
		//establece la imagen que va a salir y la que va a entrar
		var currentImg = $(this).parent().children('img').eq(i);
		var prevImg = $(this).parent().children('img').eq(i-1);
		moverL(prevImg, currentImg);
        $(this).parent().data("indice", i);
	});
	$('.galeria .previo').on("click", function(){
        //Si se ha llegado al principio, salta al final
        i = $(this).parent().data("indice");
		if (i==0) {	
			prevImg = $(this).parent().children('img').eq(0);
			i=$(this).parent().children('img').length-1;
			currentImg = $(this).parent().children('img').eq(i);
		}
		else {
			i=i-1;
			//establece la imagen que va a salir y la que va a entrar
			currentImg = $(this).parent().children('img').eq(i);
			prevImg = $(this).parent().children('img').eq(i+1);
		}
        $(this).parent().data("indice", i);
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

function galeria_div() {
	var i= 0;
	$('.galeria_div .siguiente').on("click", function(){
		i =  $(this).parent().data("indice") + 1;
		//Si se ha llegado al final, reinicia el índice
		if (i == $(this).parent().children('.slide').length) {
            i=i-1;
			return;
		}
		//establece la imagen que va a salir y la que va a entrar
		var currentImg = $(this).parent().children('.slide').eq(i);
		var prevImg = $(this).parent().children('.slide').eq(i-1);
		moverL(prevImg, currentImg);
        $(this).parent().data("indice", i);
	});
	$('.galeria_div .previo').on("click", function(){
        //Si se ha llegado al principio, salta al final
        i = $(this).parent().data("indice");
		if (i==0) {	
            i=0;
            return;
			//prevImg = $(this).parent().children('.slide').eq(0);
			//i=$(this).parent().children('.slide').length-1;
			//currentImg = $(this).parent().children('.slide').eq(i);
		}
		else {
			i=i-1;
			//establece la imagen que va a salir y la que va a entrar
			currentImg = $(this).parent().children('.slide').eq(i);
			prevImg = $(this).parent().children('.slide').eq(i+1);
		}
        $(this).parent().data("indice", i);
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

    $('.galeria_div .slide:first-child img').on('load', function(){
        galeria_div_ajustar_botones();
    });
    
}

function galeria_div_ajustar_botones() {
    altura = $('.galeria_div .slide img').css( "height" )
    $('.galeria_div .siguiente').css("height", altura);
    $('.galeria_div .previo').css("height", altura);
    console.log(altura);
}
