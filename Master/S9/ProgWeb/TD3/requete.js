let toilette;

function onSuccess(resp) {
    let data = JSON.stringify(resp);
    let parsed = JSON.parse(data);
    console.log(parsed);
    parsed.d.forEach(function(element) {
	console.log(element.nom);
	$("#data-list").append("<li>"+ element.nom+ "</li>");
    });
    
}

function onError() {
    console.log("error");
}

let url_test = "https://randomuser.me/api/?results=10&format=json";

let myheaderBDX = new Headers();
myheaderBDX.append('Accept', 'application/json, text/plain, text/json, */*');
myheaderBDX.append("Content-Type", "application/json");
myheaderBDX.append("Access-Control-Allow-Origin", "origin");

let initBDX = {method : 'GET' ,
	    headers : myheaderBDX,
	    mode : 'no-cors',
	    cache : 'default'
	   };

async function doFetch(url, init){
    return fetch(url, init)
	.then(onSuccess)
	.catch(function(error){
	    console.log(error);
	});
}

function get_test (){
    rep = doFetch(url_test, {method : 'GET' ,
			     headers : myheaderBDX,
			     mode : 'cors',
			     cache : 'default'
			    });

}


function get_toilettes_location (event){
    let url_toilettes = 'http://odata.bordeaux.fr/v1/databordeaux/sigsanitaire/?format=json&callback=?';
    $.getJSON(url_toilettes, onSuccess);
}

function get_kid_area_location (event){
    let url_play_area = 'http://odata.bordeaux.fr/v1/databordeaux/airejeux/?format=json&callback=?'
    $.getJSON(url_play_area, onSuccess);
}


/*---------
   MAIN
----------*/
$( "#btn-toilets").on("click",get_toilettes_location);
$( "#btn-kidareas").click(get_kid_area_location);
