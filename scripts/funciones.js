const padding_ppal = 50;
const min_scroll = 150;
var offset_header = 0;

// ================================================================
// ------------------ FUNCIONES AUXILIARES ------------------------
// ================================================================

// Calcula la altura de la barra de navegacion
// 0 = Altura titulo | 1 = Altura navar  | 2 = Altura todo
function calcular_navbarh(tipo) {
    let altura;
    switch (tipo) {
        case 0:
            altura = $("#titulo").outerHeight();
            break;
        case 1:
            altura = $("#barra_navegacion").outerHeight();
            break;
        default:
            altura = $("#cabecera").outerHeight();
            break;
    }
    return altura;
}

// ================================================================
// ------------------ CARGA DEL CONTENIDO -------------------------
// ================================================================

// Carga el contenido del html que se le pasa en el div contenido_ppal.
function cargar_contenido(seccion, pagina) {
    volver_arriba ();
    $("#cont_dinamico").load('./pages/' + seccion + '/' + pagina + '.html', function() {
        ajustar_altura_contenido();
        if ( $("#nav3").length ) { // Comprueba si existe menu nav3
            click_en_menu_lateral();
            if ( $("#nav3.lateral").length ) {
                //$("#nav3.lateral").css("top", $("#contenido_pagina").offset().top);
                posicionar_menu_lateral(offset_header);
            }
        }
        if ( $(".galeria").length ) {
            console.log("hola")
            $(".galeria").data("indice",0);
            galeria();
        }
        if ( $(".galeria_div").length ) {
            console.log("hola_div")
            $(".galeria_div").data("indice",0);
            galeria_div();
        }
        $("video").on("mouseover", function(event) {
            this.play();
        }).on('mouseout', function(event) {
            this.pause();
        });
    });
}

// Ajusta el margen superior del contenido_ppal para que no
// se solape con la cabecera fija.
function ajustar_altura_contenido() {
    let altura_cabecera = calcular_navbarh(2);
    $("#cont_dinamico").css('margin-top', altura_cabecera + "px");
}

// ================================================================
// -------- POSICION DE ELEMENTOS SEGUN SCROLL --------------------
// ================================================================

// Oculta la barra de titulo al hacer scroll y reposiciona
// el menu lateral respecto a la navbar
function hacer_scroll() {
    var prevScrollpos = window.pageYOffset;
    window.onscroll = function() {
        var currentScrollPos = window.pageYOffset;
        if (prevScrollpos > currentScrollPos) {
            ocultar_titulo(false);
        } else if (currentScrollPos > min_scroll) {
            ocultar_titulo(true);
        }
        prevScrollpos = currentScrollPos;
        if ( $("#nav3.lateral").length ) { posicionar_menu_lateral(offset_header); }
    }
}

// Regresar al inicio de la página mostrando el titulo sin animación.
function volver_arriba () {
    window.scrollTo(0, 0);
    $("#cabecera.cont_fijo").css("transition", "none");
    $("#cabecera.cont_fijo").css("top", "0px");
    $("#cabecera.cont_fijo").outerHeight();
    $("#cabecera.cont_fijo").css("transition", "top 0.3s");
}

// ================================================================
// --------- POSICION DE ELEMENTOS SEGUN TAMAÑO VENTANA -----------
// ================================================================

function redimensionar_ventana() {
    $(window).resize(function() {
        ajustar_altura_contenido();
        posicionar_menu_lateral(offset_header);
        if ($('.galeria_div').length) {
            galeria_div_ajustar_botones();
        }
        // menu_lateral_arriba ();
        // MUY SUCIO -> ARREGLAR
        /*
        if (parseInt($("#cabecera_fija").css("top"),10) == 0) {
            posicionar_menu_lateral(2);
        } else {
            posicionar_menu_lateral(1);
        }*/
    });
}

// Mueve el menu lateral arriba para visualización en pantallas pequeñas.
function menu_lateral_arriba () {
    let contenido_w = $("#contenido_pagina").innerWidth();
    let menu_w = $("#contenido_pagina").outerWidth(true) - contenido_w;
    console.log("MENUL");
    console.log(contenido_w);
    console.log(menu_w);
    if (contenido_w < menu_w * 1.5) {
        console.log("CAMBIO ARRIBA");
    } else {

    }
}

// ================================================================
// ------------------------ NAVBAR --------------------------------
// ================================================================

// Oculta o muestra el header (sólo tiítulo o todo). 
// Devuelve el offset que se le ha aplicado al header.
function ocultar_titulo(ocultar) {
    let altura_titulo = calcular_navbarh(0);
    let altura_total = calcular_navbarh(2);
    if (ocultar) {
        // Si el menú ocupa más del 25% de la pantalla, oculta el header completo
        if ((altura_total - altura_titulo) > ($(window).height() * 0.25)) {
            $("#cabecera.cont_fijo").css("top", "-" + altura_total + "px");
            offset_header = altura_total;
        } else {
            $("#cabecera.cont_fijo").css("top", "-" + altura_titulo + "px");
            offset_header = altura_titulo;
        }
    } else {
        $("#cabecera.cont_fijo").css("top", "0px");
        offset_header = 0;
    }
}

// Escucha el evento click en los elementos del navbar y carga el contenido 
// correspondiente. Si es un elemento del primer nivel, muestra el submenu.
// Además marca el boton pulsado para cambiarle el estilo.
function click_en_navbar (menu) {
    menu.forEach((submenu) => {
        $("#btn1_" + submenu[0]).click(function(event) {
            marcar_boton($(this),1);
            mostrar_submenu(submenu);
            cargar_contenido (submenu[0], submenu[0]);
        });
        submenu.forEach((submenu_elemento) => {
            $("#btn2_" + submenu_elemento).click(function(event) {
                marcar_boton($(this),2);
                cargar_contenido (submenu[0], submenu_elemento);
            });
        });
    });
}

// Si se le pasa el nombre de un submenu, lo muestra.
// Si se le pasa FALSE como submenu, lo oculta.
function mostrar_submenu(submenu) {
    if (submenu.length > 1) {
        $(".nav2_row").css("display","none");
        $("#n2r_" + submenu[0]).css("display","block");
        $("#nav2").css("display","flex");
    } else {
        $("#nav2").css("display","none");
        $(".nav2_row").css("display","none");
    }
}

// Deja marcado el botón de la barra de navegación que indica la sección en la
// que se está.
function marcar_boton(boton, nivel) {
    $("#nav" + nivel + " li").removeClass("seleccionado");
    $(boton).addClass("seleccionado");
    if(nivel == 1) {
        $("#nav2 li").removeClass("seleccionado");
        let btn2 = $(boton).attr("id").replace("btn1", "btn2");
        $("#" + btn2).addClass("seleccionado");
    }
}


// ================================================================
// ------------------------ MENU LATERAL --------------------------
// ================================================================

// !!!!! Reescribir a funcion generica para cualquier elemento fijo
// Reposiciona el menu lateral respecto al menu superior y el footer
function posicionar_menu_lateral(offset) {
    let altura = calcular_navbarh(2) - offset + padding_ppal;
    let doc_restante = $(document).height() - window.pageYOffset - $("footer").outerHeight();
    let altura_ml = $("#nav3.lateral").outerHeight() + altura;
    if ((doc_restante) > altura_ml) {
        $("#nav3.lateral").css("top", altura + "px");
    } else { 
        $("#nav3.lateral").css("top", doc_restante - altura_ml + "px");
    }
}

// Ajusta el offset del enlace al ancla para que quede a la distancia adecuada del 
// menu superior
function click_en_menu_lateral() {
    $("aside li a").click(function(event) {
        let id = $(this).attr("href");
        console.log(id);
        let pos_objetivo = $(id).offset().top;
        let pos_scroll = window.pageYOffset;
        let altura_header = calcular_navbarh(2);
        //console.log(altura_header);
        //console.log("scroll:" + window.pageYOffset + " - posObjetivo" + pos_objetivo);
        if (pos_scroll > pos_objetivo || ((pos_scroll < pos_objetivo) && (pos_objetivo <= (min_scroll + altura_header)))) {
            //console.log("SUBIMOS");
            $([document.documentElement, document.body]).animate({
                scrollTop: (parseInt($(id).offset().top, 10) - altura_header - 25 ) + "px"
            }, 500);
        } else {
            //console.log("BAJAMOS");
            $([document.documentElement, document.body]).animate({
                scrollTop: (parseInt($(id).offset().top, 10) - calcular_navbarh(1) - 25) + "px"
            }, 500);
        }
    }); 
}

// ================================================================
// ---------------------- CAMBIAR TEMA CSS ------------------------
// ================================================================

function cambiar_tema() {
    $("#btn_tema").click(function() {
        if ($(this).hasClass("oscuro")) {
            $("#tema_css").attr({href : "./estilos/claro.css"});
            $(this).removeClass("oscuro").addClass("claro");
        } else {
            $("#tema_css").attr({href : "./estilos/oscuro.css"});
            $(this).removeClass("claro").addClass("oscuro");
        }
    });
}

