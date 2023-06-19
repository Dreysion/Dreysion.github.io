var canvas = document.getElementById("gameWindow");
var ctx = canvas.getContext("2d");
const cardBack = new Image();
cardBack.src = "back1.png";

var time = 0;

cardSize = new Vector2(250,350);

const turnState = ["drawMana","drawEncounter","rollEnemyAttack","reactions","spell"];
const tournTurnState = ["drawMana","spell","opponentReactions","switchPlayer"];

drawFrame = setInterval(function(){
	time++;
	center = new Vector2(canvas.width / 2, canvas.height / 2);
	end = new Vector2(canvas.width, canvas.height);
	
	ctx.clearRect(0,0,end.x,end.y);
	//Draw the table

	//Draw the decks & opponents' hands
	drawCard(center.x-10-cardSize.x,center.y-cardSize.y/2,-20);
	drawCard(center.x+10,center.y-cardSize.y/2,20);

	//Draw your hand

	//Animations
	
	
},1000);



function drawCard(x,y,r){
	ctx.save();
	ctx.translate(x+cardSize.x/2,y+cardSize.y/2);
	ctx.rotate(r * Math.PI/180);
	ctx.translate(-x-cardSize.x/2,-y-cardSize.y/2);
	//ctx.beginPath();
	//ctx.roundRect(x,y,cardSize.x,cardSize.y,20);
	//ctx.stroke();
	ctx.drawImage(cardBack,x,y);
	ctx.restore();
}

function Vector2(x,y){
	this.x = x;
	this.y = y;
}