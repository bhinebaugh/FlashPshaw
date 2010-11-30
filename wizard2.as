//objects and definitions for Wizard players, cards, rules, etc
//************Player object***********
/* now its own class file with new object notation **
function Player(pname) {
	this.playerName = pname;
	this.score = 0;
	this.bid = 0;
	this.tricksWon = 0;
	this.cards = new Array();
	this.cardPlayedName = "";
}
Player.prototype.playCard = function(playerId) {
	var i = randRange(0,this.cards.length-1);
	var c = this.cards.splice(i,1);
	var cardPlayed = new Array;
	cardPlayed[0] = c[0][0];
	cardPlayed[1] = c[0][1];
	trace("Player "+playerId+" plays ("+cardPlayed[0]+" "+cardPlayed[1]+") ... "+translateCard(cardPlayed)+".");
	this.cardPlayedName = "card"+playerId+"-"+i;
	_root["card"+playerId+"-"+i]._y = _root.playedCardsArea._y + 60;
	_root["card"+playerId+"-"+i]._x = _root.playedCardsArea._x + playerId*60;
	return cardPlayed;
}
Player.prototype.makeBid = function() {
	var bidAmount = randRange(0,_global.roundOfPlay);
	trace(this.playerName+" bids "+bidAmount+". 0-"+_global.roundOfPlay);
	this.bid = bidAmount;
	return bidAmount;
}
*/
var dxc:Number;
var dyc:Number;
//score (round x player)
_global.roundNumber;
_global.trumpSuit;
_global.suits = new Array( 'Spades','Clubs','Hearts','Diamonds' );
// card sequence: 2,3,4,5,6,7,8,9,10, Jack, Queen, King, Ace
_global.faceCards = new Array( '2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace' );

function randRange(min:Number, max:Number):Number {
    var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
    return randomNum;
}
function generatePlayers(nOP) {
	_global.players = new Array();
	players[0] = new Player("you");
	players[0].human = true;
	for( i=1; i<nOP; i++ ) {
			players[i] = new Player("Player "+i);
	}
}
function generateDeck() {
	//_global.
	temp_deck = new Array();
	for (i=0;i<4;i++) {
		for (j=0;j<13;j++) {
			var c = new Card(i,j);
			temp_deck.push(c);
		}
	}
	return(temp_deck);
}
function pickRandomCard() {
	pickACard = randRange(0,deck.length-1);
	chosenCard = deck.splice(pickACard,1);
	return chosenCard[0];
}
function dealCards(rOP) {
	for(p=0;p<numberOfPlayers;p++){
		for (i=0;i<rOP;i++) { players[p].addCard(pickRandomCard()); }
	}
	displayCardsLeftInDeck = deck.length;
}
function removePlayedCards() {
	//remove cards in playing area
	for(i=0;i<numberOfPlayers;i++) {
		players[i].removePlayedCard();
		removeMovieClip(players[i].cardPlayed[0].cardName);
	}
}
function updateBestCard() {
		_global.bestCard[0] = _global.lastCard[0];
		_global.bestCard[1] = _global.lastCard[1];
		_global.bestCard[2] = _global.currentPlayer;
		trace("Last card was the best one so far.");
}

//deprecate this function; make it a class method ? maybe not?
function translateCard(info) {
	//trace("info[0] = "+info[0]+", info[1] = "+info[1]);
	suitNumber = info[0];
	suitName = suits[suitNumber];
	faceValue = translateCardValue(info[1]);
	return(faceValue+" of "+suitName);
}
function translateCardValue(v) {
	trace("translating card face value");
	if (v<0 or v>13) {
		return false;
		trace("bad face value");
	}
	if (v > 8) {
		faceName = _global.faceCards[v-9];
	}else{
		faceName = v+2;
	}
	return faceName.toString();
}
function createBidButtons() {
	bidButtons = new Array();
	for ( var i=0; i <= roundOfPlay; i++) {
		var bidName = "bid"+i;
		bidButtons.push(bidArea.attachMovie("bid choice","bid"+i,1200+i));
		bidButtons[i]._x = 0 + i*26; //playersCardsArea._x+180+(i*26);
		bidButtons[i]._y = 22; //playersCardsArea._y+28;
		bidButtons[i].bidnumval = i;
		bidButtons[i].gotoAndStop(0);
		bidButtons[i].onPress = clickedBid;
		bidButtons[i].clickAgain = function() {
			this.gotoAndStop(0);
		}
	}
}
function clickedBid() {
	var previousBid = _global.players[0].bid;
	//if previous bid was valid, unset that MC
	if(previousBid >= 0 && previousBid <= _global.roundOfPlay) {
		bidButtons[previousBid].play();
		bidButtons[previousBid].gotoAndStop(0); //clickAgain();
	}
	if(previousBid == this.bidnumval) {
		_global.players[0].bid = -1;
		continueButton.enabled = false;
	} else {
		this.gotoAndStop(3);
		_global.players[0].bid = this.bidnumval;
		continueButton.enabled = true;
	}
}
function acceptPlayerBid() {
	trace("Player bid ... "+players[0].bid);
	//retrieve bid amount var previousBid = _global.players[0].bid;
	//if(previousBid >= 0 && previousBid < _global.roundOfPlay) {
		gotoAndPlay("Finish bids");
	//}
	for ( var i=0; i <= roundOfPlay; i++) {
		bidButtons[i].swapDepths(8800+i);
		bidButtons[i].removeMovieClip();
	}
	removeMovieClip("bidArea");
}