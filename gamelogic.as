function evaluateTrick() {
	highCard = -1;
	winnerPlayer = -1;
	var winningSuit;
	if (trumpPlayed) {
		winningSuit = trump.suit;
		trace("trump is ("+winningSuit+") "+suits[winningSuit]);
	} else {
		winningSuit = ledSuit;
		trace("suit is ("+winningSuit+") "+suits[winningSuit]);
	}
	for(nextPlayer = 0; nextPlayer<numberOfPlayers; nextPlayer++) {
		var playedCard = players[nextPlayer].cardPlayed[0];
		trace(players[nextPlayer].playerName+" = "+nextPlayer+"  --> "+playedCard.cardName);
		if ( playedCard.suit == winningSuit ) {
			if (playedCard.numval > highCard) {
				highCard = playedCard.numval;
				winnerPlayer = nextPlayer;
				trace(" New best card "+players[nextPlayer].playerName);
			} else {
				trace(" Following suit or trump but not better. "+players[nextPlayer].playerName);
			}
		} else {
			//adjust message depending if trump was used to win hand
			if (trumpPlayed) {trace(" Not trump suit.") } else { trace(" Not following suit.") }
		}
	}

/* deprecated (and buggy?) trick evalutation code
for(i = 0; i<3; i++) {
	nextPlayer = ++nextPlayer;
	if(nextPlayer >= numberOfPlayers) nextPlayer = 0;
	order.push(nextPlayer);
}
if (trumpPlayed == true) {
	for(var i=0; i<players.length; i++) {
		cp = order[i];
		var theCard = players[cp].cardPlayed[0];
		if (theCard.suit == trump.suit && theCard.numval > trickWinner[1]) {
			trickWinner[0] = cp;
			trickWinner[1] = theCard.numval;
			trace("  Trump: "+theCard.cardName+" by "+players[cp].playerName);
		} else {
			trace("  ("+theCard.cardName+" by "+players[cp].playerName+")");
		}
	}
} else {
	for(var i=0; i<players.length; i++) {
		cp = order[i];
		var theCard = players[cp].cardPlayed[0];
		if (theCard.suit == ledSuit && theCard.numval > trickWinner[1]) {
			trickWinner[0] = cp;
			trickWinner[1] = theCard.numval;
			trace("  Better: "+theCard.cardName+" by "+players[cp].playerName);
		} else {
			trace("  ("+theCard.cardName+" by "+players[cp].playerName+")");
		}
	}
} */
	trace("====================> Winner is "+players[winnerPlayer].playerName);
	displayStatus = players[winnerPlayer].playerName+" won the trick.";
	players[winnerPlayer].tricksWon++
}
function updateBestCard() {
		_global.bestCard[0] = _global.lastCard[0];
		_global.bestCard[1] = _global.lastCard[1];
		_global.bestCard[2] = _global.currentPlayer;
		trace("Last card was the best one so far.");
}
function tabulateBids() {
	var bidtally = 0;
	for (i = 0; i < numberOfPlayers; i++) {
			bidtally += players[i].bid;
	}
	if (bidtally > roundOfPlay) {
		trace('Overbid ('+bidtally.toString()+')');
		displayStatus = "Overbid";
	} else if (bidtally < roundOfPlay) {
		trace('Underbid ('+bidtally.toString()+')');
		displayStatus = "Underbid";
	} else {
		trace('Aggregate bid equals number of tricks available.');
		displayStatus = "Even bid";
	}
	return bidtally;
}
function evaluateBids() {
	for(var i=0; i<numberOfPlayers; i++) {
		var msg = players[i].playerName;
		msg += " bid "+players[i].bid;
		msg += ", made "+players[i].tricksWon;
		trace(msg);
	}
}