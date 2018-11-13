package code {
	
	import flash.display.MovieClip;
	
	
	public class DissPlat extends MovieClip {
		
		public var collider: ColliderAABB;
		public var isDead:Boolean = false;
		
		
		public function DissPlat() {
			// constructor code
			//set the x and y
			//x = 100;
			//y = 250;
			
			collider = new ColliderAABB(width / 2, height / 2);
			collider.calcEdges(x, y);
			
			
			ScenePlay.trickPlatforms.push(this);
		}
		
		public function update(scene:ScenePlay):void {
			
			if(scene.trickPlatTouched){
					
				isDead = true;	
				
			}
			
			
		}
		
	}
	
}
