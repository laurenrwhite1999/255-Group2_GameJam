package code {
	import flash.geom.Point;

	public class ColliderAABB {

		/** Half of the object's width. */
		private var halfWidth: Number;
		/** Half of the object's height. */
		private var halfHeight: Number;

		/** The object's left edge. */
		public var xmin: Number;
		/** The object's right edge. */
		public var xmax: Number;
		/** The object's top edge. */
		public var ymin: Number;
		/** The object's bottom edge. */
		public var ymax: Number;

		/**
		 * This function sets up the collider.
		 * @param halfWidth Half of the object's width.
		 * @param halfHeight Half of the object's height.
		 */
		public function ColliderAABB(halfWidth: Number, halfHeight: Number): void {
			setSize(halfWidth, halfHeight);
		} // ends the ColliderAABB() constructor

		/**
		 * This function sets the size of the collider.
		 * @param halfWidth Half of the object's width.
		 * @param halfHeight Half of the object's height.
		 */
		public function setSize(halfWidth: Number, halfHeight: Number): void {
			this.halfWidth = halfWidth;
			this.halfHeight = halfHeight;

			// recalculate the edges
			calcEdges((xmin + xmax) / 2, (ymin + ymax) / 2);
		} // ends the setSize() function

		/**
		 * Calculate the position of the four edges from the center (x, y) position.
		 */
		public function calcEdges(x: Number, y: Number): void {
			xmin = x - halfWidth;
			xmax = x + halfWidth;
			ymin = y - halfHeight;
			ymax = y + halfHeight;
		} // ends the calcEdges() function

		/**
		 * This function checks to see if this AABB is overlapping another AABB.
		 * @param other The other AABB to check this AABB against.
		 * @return Whether or not they are overlapping. If true, they are overlapping.
		 */
		public function checkOverlap(other: ColliderAABB): Boolean {
			if (this.xmax < other.xmin) return false; // gap to the right
			if (this.xmin > other.xmax) return false; // gap to the left
			if (this.ymax < other.ymin) return false; // gap below
			if (this.ymin > other.ymax) return false; // gap above

			return true;
		} // ends the checkOverlap() function

		/**
		 * This function calculates how far to move THIS box so that it no longer
		 * intersects another AABB.
		 * @param other The other AABB.
		 * @return The "fix" vector - how far to move this box.
		 */
		public function findOverlapFix(other: ColliderAABB): Point {
			var moveL: Number = other.xmin - this.xmax;
			var moveR: Number = other.xmax - this.xmin;
			var moveU: Number = other.ymin - this.ymax;
			var moveD: Number = other.ymax - this.ymin;

			var fix: Point = new Point();

			//if(Math.abs(moveL) < Math.abs(moveR)) fix.x = moveL;
			//else fix.x = moveR;

			fix.x = (Math.abs(moveL) < Math.abs(moveR)) ? moveL : moveR;
			fix.y = (Math.abs(moveU) < Math.abs(moveD)) ? moveU : moveD;

			if (Math.abs(fix.x) < Math.abs(fix.y)) fix.y = 0;
			else fix.x = 0;

			return fix;
		} // ends the findOverlapFix() function

	} // ends the ColliderAABB class

} // ends the package