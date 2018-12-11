package code {

	import flash.display.MovieClip;

	public class HUD extends MovieClip {

		var player: Player = new Player();


		public function HUD() {
			// constructor code

		}

		public function update(game: ScenePlay): void {

			parent.setChildIndex(this, parent.numChildren - 1);

			scoreBoard.text = "score: " + game.playerScore;
			bar.scaleX = .75;

			x = player.x;
			y = player.y;

			heart1.visible = (game.playerHealth >= 1);
			heart2.visible = (game.playerHealth >= 2);
			heart3.visible = (game.playerHealth >= 3);
			heart4.visible = (game.playerHealth >= 4);
			heart5.visible = (game.playerHealth >= 5);
			heart6.visible = (game.playerHealth >= 6);

			if (game.hasItemOne == true) {
				itemOne.visible = true;
				itemOne.gotoAndStop(1);
			} else {
				itemOne.visible = false;
			}
			if (game.hasItemTwo == true) {
				itemTwo.visible = true;
				itemTwo.gotoAndStop(1);
			} else {
				itemTwo.visible = false;
			}
			if (game.hasItemThree == true) {
				itemThree.visible = true;
				itemThree.gotoAndStop(1);
			} else {
				itemThree.visible = false;
			}
			
			if(game.hasPowerUpOne == true){
				powerupOne.visible = true;
			}
			else{
				powerupOne.visible = false;
			}
			if(game.hasPowerUpTwo == true){
				powerupTwo.visible = true;
			}
			else{
				powerupTwo.visible = false;
			}
			if(game.hasPowerUpThree == true){
				powerupThree.visible = true;
			}
			else{
				powerupThree.visible = false;
			}
		}
	}

}