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
