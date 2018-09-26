let toilette;
let rep;

function onSuccess(resp) {
    if(rep.state === "fullfiled")
	console.log("I did it");
    console.log(resp);
    return resp;
}

function onError() {
    console.log("error");
}

let url_test = "https://randomuser.me/api/?results=10,format=json";

let myheaderBDX = new Headers();
myheaderBDX.append('Accept', 'application/json, text/plain, */*');
myheaderBDX.append("Content-Type", "application/json");
myheaderBDX.append("Access-Control-Allow-Origin", "origin");

let initBDX = {method : 'GET' ,
	    headers : myheaderBDX,
	    mode : 'no-cors',
	    cache : 'default'
	   };

function doFetch(url, init){
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
    let url_toilettes = 'http://opendata.bordeaux.fr/content/toilettes-publiques/?format=json';
    rep = doFetch(url_test, initBDX );
}

function get_kid_area_location (event){
    let url_play_area = 'http://opendata.bordeaux.fr/aires-de-jeux/?format=json';
    rep = doFetch(url_test, initBDX);
}


/*---------
   MAIN
----------*/
$( "#btn-toilets").on("click",get_toilettes_location);
$( "#btn-kidareas").click(get_kid_area_location);

get_test();
