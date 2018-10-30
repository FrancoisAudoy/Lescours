let cards = [52];
let used = [52];
let type = ["Carreau", "Tréfle", "Coeur", "Pique"];

let user_points;
let bank_points;
let bank_money = 100;
let user_money = 100;
let text_user_points = document.getElementById("playerPoint");
let text_bank_points = document.getElementById("bankPoints");
let text_player_cards = document.getElementById("playerCards");
let text_bank_cards = document.getElementById("bankCards");
let text_bank_money = document.getElementById("bankMoney");
let text_user_money = document.getElementById("playerMoney");

function randCard(){
    let already_used = true;
    let rand;
    let i = 0;
    while(already_used && i < 52){
	rand = Math.floor(Math.random() * 52);
	console.log(cards[rand] + " used " + used[rand]);
	already_used = used[rand];
	++i;
    }
    if(!used[rand]){
	return rand;
    } else
	return -1;
}

function synchPoints(){
    text_user_points.innerHTML= user_points;
    text_bank_points.innerHTML= bank_points;
}

function synchMoney(){
    text_bank_money.innerHTML= bank_money;
    text_user_money.innerHTML = user_money;
}

function init(){
    user_points = 0;
    bank_points = 0;
    synchPoints();
    synchMoney();
    for(let i =0; i < 52 ; ++i){
	used[i] = false;
	cards[i] = ((i%13) + 1) + ' ' + type[i%4];
    }

    text_player_cards.innerHTML = '';
    text_bank_cards.innerHTML = '';
}

function addSprite(html_text){
    let img = document.createElement("IMG");
    img.src = "sprite.png";
    html_text.appendChild(img);
}
function newCard(current_text){
    let card = randCard();
    if(card == -1){
	console.log("Out of card");
	return 0;
    }

    used[card] = true;
    let point = card%13 + 1;
    
    if(point >= 10)
	point = 10;

    addSprite(current_text);

    return point;
}

function play(){
    user_points += newCard(text_player_cards);
    synchPoints();
    if(lose(user_points))
	reward();
}

function lose(points){
    return points > 21;
}

function reward(){
    if(lose(user_points)){
	if(!lose(bank_points))
	    bank_money += 10;
    }
    else
	if(lose(bank_points))
	    user_money += 10;
    else
	if(user_points >= bank_points)
	    user_money += 10;
    else
	bank_money += 10;

    init();
}
	

function bankPlay(){
    let add = newCard(text_bank_cards);

    while(add !== 0 && bank_points < 21){
	bank_points += add;
	synchPoints();
	add = newCard(text_bank_cards);
    }

    reward();
}

const btn_new_card = document.querySelector("#NewCard");
btn_new_card.addEventListener('click', play);


const btn_stop = document.querySelector("#StopCard");
btn_stop.addEventListener('click', bankPlay );


init();
