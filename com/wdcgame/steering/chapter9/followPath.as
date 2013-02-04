package  
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import ladeng6666.steering.Vector2D;
	import ladeng6666.steering.Vehicle;
	import ladeng6666.steering.TargetObj;
	
	public class followPath extends Sprite
	{
		private var pathVehicle:Vehicle;			//机车实例
		private var pathMap:Sprite;
		private var wayPointList:Array;
		
		public function followPath() 
		{
			pathVehicle = new Vehicle();
			pathVehicle.position = new Vector2D(50, 250);
			pathMap = new Sprite();
			wayPointList = new Array();
			
			addChild(pathVehicle);
			addChild(pathMap);
			conifgEvent();
			
			var tip:TextField = new TextField();
			tip.text = "请单击添加新的wayPoint!";
			tip.selectable = false;
			tip.width = 200;
			addChild(tip);
		}
		private function conifgEvent():void {
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		//按照帧频随速度更新机车的位置
		private function enterFrameHandler(e:Event):void {
			pathVehicle.followPath(wayPointList);
			pathVehicle.update();
		}
		private function mouseDownHandler(e:MouseEvent):void {
			if (wayPointList.length == 0) {
				pathMap.graphics.lineStyle(1);
				pathMap.graphics.moveTo(mouseX, mouseY);
			}
			var wayPoint:Vector2D = new Vector2D(mouseX, mouseY);
			var targetObj:TargetObj = new TargetObj();
			targetObj.position = wayPoint;
			
			wayPointList.push(wayPoint);
			addChild(targetObj);
			
			pathMap.graphics.lineTo(mouseX, mouseY);
		}
	}
}