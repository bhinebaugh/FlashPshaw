class Player {
	var playerName:String;
	var playerNumber:Number;
	var score:Number;
	var bid:Number;
	var tricksWon:Number;
	var cards:Array;
	var cardPlayed:Array; // a single-element array that references the card taken out of hand
	var strategy; // will be used to set which approach (function) this player uses to choose a card or bid
	var human:Boolean; // whether the player is computer-controlled or user-controlled

	function Player( pname:String ) { //constructor function/method
		this.playerName = pname;
		this.score = 0;
		this.bid = 0;
		this.tricksWon = 0;
		this.cards = new Array();
		this.cardPlayed = new Array();
		this.human = false;
	}

	public function addCard( c:Card ) {
		this.cards.push(c);
		//display card in hand area
	}
	public function showHand( cardAreaX:Number ) {
		var i=0; var yy=160;
		if (this.human) {
			yy = _root.playersCardsArea._y + 50;
		} else {
			_root[this.playerName+"status"] += " Showing cards";
		}
		for (var c = 0; c < this.cards.length; c++) {
			var xx = cardAreaX + (30*i);
			//c.displayFace(xx, yy);
			this.cards[c].showCard(xx, yy);
			if (this.human) this.cards[c].showFace();
			i++;
		}
	}
	public function playCard() {
		var i:Number; var xc:Number; var yc:Number;
		var pstatus = "";
		if (this.cards.length == 1) { // only one card left in hand, so not a hard choice
			i = 0;
		} else {
			i = this.chooseBestCard();
		}
		this.cardPlayed = this.cards.splice(i,1);
		if (_root.turnsCompleted == 0) {
			_root.ledSuit = this.cardPlayed[0].suit;
			pstatus += "Led with"+_global.suits[this.cardPlayed[0].suit]+".\n";
		}
		if (this.cardPlayed[0].suit == _root.trump.suit) {
			_root.trumpPlayed = true;
			pstatus += "Trumped.\n";
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
	private function chooseBestCard() {
		/***********************************************************
			Choose a card from your hand based on
			number of tricks bid, overbid/underbid of hand,
			number of trump cards, suit led, face value and
			chance of winning a trick and getting to determine
			the suit of future tricks.
		
			But right now, we just return a random card
		************************************************************/
			return _root.randRange(0,(this.cards.length-1));		
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
