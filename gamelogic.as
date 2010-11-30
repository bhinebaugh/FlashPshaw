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
			trace(" Not following suit and not a trump.");
		}
	}

/*
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

function evaluateBids() {
	for(var i=0; i<numberOfPlayers; i++) {
		var msg = players[i].playerName;
		msg += " bid "+players[i].bid;
		msg += ", made "+players[i].tricksWon;
		trace(msg);
	}
}