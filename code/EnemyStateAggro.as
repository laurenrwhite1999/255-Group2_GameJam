﻿package code {

	/**
	 * This class  extends the enemy state
	 */
	public class EnemyStateAggro extends EnemyState {

		/**
		 * This function updates the aggro
		 */
		override public function update(enemy: Enemy): EnemyState {
			// walk to the left
			if (ScenePlay.player.x < enemy.x) {
				enemy.handleWalking(-1);
			}
			// walk to the right
			if (ScenePlay.player.x > enemy.x) {
				enemy.handleWalking(1);
			}

			enemy.doPhysics();

			if (enemy.getDisToPlayer() > enemy.attackRange) {
				return new EnemyStateIdle();
			}

			return null;
		} // ends the update() function

	} // ends the EnemyStateAggro class

} // ends the package