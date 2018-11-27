package code {
	
	import flash.display.MovieClip;
	
	/**
	 * This class contains the code for the enemies with ranged attacks.
	 */
	public class RangedEnemy extends Enemy {
		
		/**
		 * This is the constructor code and sets up the properties for the RangedEnemy
		 * objects.
		 */
		public function RangedEnemy(spawnX: Number, spawnY: Number) {
			super(spawnX, spawnY);
		} // ends the RangedEnemy() constructor
		
		override private function handleWalking(): void {
			velocity.x = 0;
		} // ends the handleWalking() function
		
		override private function doPhysics(): void {
			
		}
		
	} // ends the RangedEnemy class
	
} // ends the package