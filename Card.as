class Card {
	var suit:Number;
	var numval:Number;
	var cardName:String;
	var isDisplayed:Boolean;
	var faceDisplayed:Boolean;
	//var cardPic; // MovieClip reference;

	function Card(s:Number, n:Number) {
		this.suit = s;
		this.numval = n;
		this.cardName = _global.faceCards[this.numval]+" of "+_global.suits[this.suit];
		this.isDisplayed = false;
		// this.display, x, y, symbol on stage
	}
/*
	public function displayBack() {
		_root.displayStatus = "Back of card being shown.";
	}
	public function displayFace( xx:Number, yy:Number ) {
		_root.displayStatus = this.cardName;
		_root.attachMovie(_global.suits[this.suit]+" card", this.cardName, _root.getNextHighestDepth(), {_x:300, _y:100});
		this.isDisplayed = true;
	} */

	public function showCard( x2, y2 ) {
		_root.attachMovie("card", this.cardName, _root.getNextHighestDepth());
		_root[this.cardName]._x = x2;
		_root[this.cardName]._y = y2;
		//_root[this.cardName].cardNumber = _global.faceCards[this.numval];
	}
	public function showFace() {
		_root[this.cardName].gotoAndStop(this.suit+2);
		_root[this.cardName].thecardnumber.gotoAndStop(this.numval+2);
	}
	public function animateMoveTo( x2, y2 ) {
		_root[this.cardName].dxc = (x2 - _root[this.cardName]._x)/20; 
		_root[this.cardName].dyc = (y2 - _root[this.cardName]._y)/20; 
		_root[this.cardName].xfinal = x2;
		_root[this.cardName].yfinal = y2;
		_root[this.cardName].endAnimation = function() {
			this.onEnterFrame = function() {}
		}
		_root[this.cardName].onEnterFrame = function() {
			this._x += this.dxc;
			this._y += this.dyc;
			if( this._y > this.yfinal ) { this.endAnimation(); }
		}
	}
	public function endAnimation() {
		_root[this.cardName].onEnterFrame = function() {}
	}
	public function makeDraggable() {
		_root[this.cardName].onPress = function() {
			this.startDrag();
			this.played = false;
			this.original_x = this._x;
			this.original_y = this._y;
		}
		_root[this.cardName].onRelease = function() {
			this.stopDrag();
			switch (eval(this._droptarget)) {
				case _root.playedCardsArea:
					this._y = _root.playedCardsArea._y + 60;
					this.played = true;
					_global.players[_global.currentPlayer].disableDragging();
					_root.gotoAndPlay('End of turn');
					break;
				case _root.playersCardsArea:
					this._y = _root.playersCardsArea._y + 52;
					break;
				default:
					this._x = this.original_x;
					this._y = this.original_y;
			}
		}
		_root[this.cardName].onReleaseOutside = _root[this.cardName].onRelease;
	}
	public function undoDraggable() {
		_root[this.cardName].onPress = function() {}
		_root[this.cardName].onRelease = function() {}
		_root[this.cardName].onReleaseOutside = function() {};
	}
}
