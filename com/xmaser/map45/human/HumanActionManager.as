package  com.xmaser.map45.human
{
	import com.xmaser.bitmap.AnimationBitmap;
	import com.xmaser.bitmap.BitmapUtils;
	import com.xmaser.map45.human.Action;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author 小火柴
wendi14@qq.com

每个人物有八个面
每个面有各处种样的动作,所有动作放在一个action中;　放了一个位图中



	 */
	public class HumanActionManager 
	{
		private var _faces:Array
		private var _man:Human;
		private var _rect:Rectangle;
		public function HumanActionManager(man:Human,face:int=8) 
		{
			_man = man;
			_faces = []
			for (var i:int = 1; i <= face; i++) 
			{
				var item:Action = new Action();
				_faces[i] = item;
			}
		}
		public function setFaceActionBitmap(face:int,action:String,bd:BitmapData,rec:Rectangle):void
		{
			var ar:Array = BitmapUtils.buildRows(bd, rec);
			_faces[face][action]=new AnimationBitmap()
		}
		
		public function setFaceActionURL(face:int,action:String,url:String,rec:Rectangle):void
		{
			var ab:AnimationBitmap = new AnimationBitmap();
			ab.loadPic(url, rec);
			_faces[face][action] = ab;
			ab.addEventListener(AnimationBitmap.LOADED,__l)
		}
		
		public function setActionURL(action:String,url:String,rec:Rectangle,perNum:int=10):void
		{
			
			this._rect = rec;
			var _drawRec:Rectangle = rec;
			var l:Loader = new Loader()
			l.load(new URLRequest(url));
			var _this:*= this;
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void
			{
				var c:*= e.target.content;
				var ar:Array = BitmapUtils.buildCols(c.bitmapData, _drawRec);
				//trace("ar: " + ar);
				var len:int = ar.length / perNum;
				
				for (var i:int =1; i <= len; i++) 
				{
					var bb:Array = ar.slice((i -1)* perNum, (i)*perNum);
					
					
					var ab:AnimationBitmap = new AnimationBitmap(bb);
					_faces[i][action] = ab;
					
					
					
						//设置相对的面
				
						if (i == 4)
						{
							_faces[FaceConts.TOP_RIGHT][action] = new AnimationBitmap(bb, -1);
						}else if (i==3) 
						{
							_faces[FaceConts.RIGHT][action] = new AnimationBitmap(bb, -1);
						}else if (i==2) 
						{
							_faces[FaceConts.RIGTH_FRONT][action] = new AnimationBitmap(bb, -1);
						}
				
				
				}
			
				
				_man.setActionManager(_this);
				
			}
			
			)
			
			
		}
	
		private function __l(e:Event):void 
		{
			_man.setActionManager(this);
		}
		
		public function get faces():Array 
		{
			return _faces;
		}
		
		public function get rect():Rectangle 
		{
			return _rect;
		}
		
	}

}