﻿class Player {
	var playerName:String;
	var playerNumber:Number;
	var score:Number;
	var bid:Number;
	var tricksWon:Number;
	var cards:Array;
	var cardPlayed:Array; // a single-element array that references the card taken out of hand

	function Player( pname:String ) { //constructor function/method
		this.playerName = pname;
		this.score = 0;
		this.bid = 0;
		this.tricksWon = 0;
		this.cards = new Array();
		this.cardPlayed = new Array();
	}

	public function addCard( c:Card ) {
		this.cards.push(c);
		//display card in hand area
	}
	public function showHand( cardAreaX:Number ) {
		var i=0; var yy=160;
		if (playerName == "player0") {
			yy = _root.playersCardsArea._y + 50;
		} else {
			_root[this.playerName+"status"] += " Showing cards";
		}
		for (var c = 0; c < this.cards.length; c++) {
			var xx = cardAreaX + (30*i);
			//c.displayFace(xx, yy);
			this.cards[c].showCard(xx, yy);
			if (playerName == "player0") this.cards[c].showFace();
			i++;
		}
	}
	public function playCard() {
		var i:Number; var xc:Number; var yc:Number;
		var pstatus = "";
		if (this.cards.length == 1) {
			i = 0;
		} else {
			//i = Math.floor(Math.random() * ((this.cards.length-1) - 1)) + 1;
			i = _root.randRange(0,(this.cards.length-1));
		}
		this.cardPlayed = this.cards.splice(i,1);
		if (_root.turnsCompleted == 0) {
			_root.ledSuit = this.cardPlayed[0].suit;
			pstatus += "Led "+_global.suits[this.cardPlayed[0].suit]+". ";
		}
		if (this.cardPlayed[0].suit == _root.trump.suit) {
			_root.trumpPlayed = true;
			pstatus += "Trumped. ";
		}
		this.cardPlayed[0].showFace();
		xc = _root.playedCardsArea._x + _root.currentPlayer*70;
		yc = _root.playedCardsArea._y + 60;
		/* now move the card from its current postion to its desired position */
		this.cardPlayed[0].animateMoveTo(xc,yc);
		pstatus += "Played "+this.cardPlayed[0].cardName;
		_root[this.playerName+"status"] = pstatus;
		//return this.cardPlayed;
	}
	public function removePlayedCard() {
		var card = _root[this.cardPlayed[0].cardName];
		card.swapDepths(7999);
		card.removeMovieClip();
	}

	public function makeBid() {
		// initially the bid is random. later some strategy will be added here.
		var bidAmount = _root.randRange(0,_global.roundOfPlay);
		this.bid = bidAmount;
		return bidAmount;
	}
	public function enableDragging() {
		for(var i=0; i<this.cards.length; i++) {
			this.cards[i].makeDraggable();
		}
	}
	public function disableDragging() {
		var setToRemove = -1;
		for(var i=0; i<this.cards.length; i++) {
			//this.cards[i].  reset Drag, unset functions
			this.cards[i].undoDraggable();
			//check each card for played flag, slice that one into cardPlayed 
			if (_root[this.cards[i].cardName].played == true) {
				setToRemove = i;
			}
		}
		this.cardPlayed = this.cards.splice(setToRemove,1);			
		if (_root.turnsCompleted == 0) _root.ledSuit = this.cardPlayed[0].suit;
		if (this.cardPlayed[0].suit == _root.trump.suit) _root.trumpPlayed = true;
	}
}