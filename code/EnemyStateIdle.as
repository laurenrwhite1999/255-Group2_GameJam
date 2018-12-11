package code {

	/**
	 * This class tells the enemies what to do when they are idle.
	 */
	public class EnemyStateIdle extends EnemyState {

		/**
		 * This function overrides the enemy's update function.
		 * @param enemy The enemy to update.
		 */
		override public function update(enemy: Enemy): EnemyState {
			enemy.handleWalking(0);
			enemy.doPhysics();
			
			if(enemy.getDisToPlayer() < enemy.attackRange) {
				return new EnemyStateAggro();
			}
			
			return null;
		} // ends the update() function

	} // ends the EnemyStateIdle class

} // ends the package