package hcxm.cn.map {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	* ...
	* @author Default
	* 
	*/
	public class Map {
		
		private var dir = [
			[0,-1],
			[1, 0],
			[0, 1],
			[-1,0]];

		//计算屏幕,然后可以要放置几个到屏幕上
		var ww=300;//图像宽
		var hh=300;//图像高
		var LeftAll=-1;
		var RightAll = 2;
		private var TopAll = 2;
		private var BottomAll = -2;

		
		
		var Whow;//屏幕上放的横有几个
		var Hhow;

		//private var host:String="http://www.hcxm.cn/test/map/"
		private var host:String = "";
		private var mc:Sprite;

		var wwh ;//横共几个
		var hhh ;
		
		//var centxN=int(wwh/2);//中心点
		//var centyN=int(hhh/2);
		var arr:Array=[];
		var dirLen=[5,5];
		var draging=false;

		
		public function Map (holdMc:Sprite) {
			
			Whow=int(holdMc.stage.stageWidth/ww)+1;
			Hhow=int(holdMc.stage.stageHeight/hh)+1;
			//trace(Whow+"-"+Hhow);			
			mc = new Sprite ();
			holdMc.addChild (mc);

			holdMc.stage.addEventListener (Event.MOUSE_LEAVE, MOUSE_LEAVE);
			mc.addEventListener(MouseEvent.MOUSE_DOWN,mcMOUSE_DOWN);
			mc.addEventListener(MouseEvent.MOUSE_UP,mcMOUSE_UP);
			mc.addEventListener(MouseEvent.MOUSE_MOVE,mcMOUSE_MOVE);
			
			
		}
		/**
		 * 鼠标离开舞台
		 * @param	e
		 */
		private function MOUSE_LEAVE(e:Event) {
			mc.stopDrag();
			draging=false;
			check4Dir();	
		}
		public function bulid (x,y):void {
			mc.x = -(x * ww)
			
			//mc.y = -(y *hh)
			//trace( "mc.y : " + mc.y );
			

			//全部图像的宽/2-屏幕的宽/2
			
		var wwh2=x+1;//横共几个
		var hhh2 = y + 1
		wwh=wwh2
		hhh = hhh2
			
			
			//以中心点为准，左几个，右几个
			for (var i = y-1 ; i<=y+1; i++) {
				
			
				for (var j = x-1; j<=x+1; j++) {
					var aa=new MapMc();
			
					mc.addChild(aa);
					aa.idX=j;
					aa.idY=i
					aa.name="a_"+aa.idX+"_"+aa.idY;
			
					var url=host+"baiduMap/"+aa.idX+"_"+aa.idY+"[1].png";
					aa.st(url);
					aa.x = ww * j;
			
					aa.y = hh *((y+1)-i);
					
					//aa.tt.text=aa.name
					;
					if (i==y-1&&j==x-1) {
						arr[3]=aa;//左下
					}
					if (i==y-1&&j==x+1) {
						arr[2]=aa;//右下
					}
					if (i==y+1&&j==x+1) {
						arr[1]=aa;//右上
					}
					if (i==y+1&&j==x-1) {
						arr[0]=aa;//左上
					}
				}
			}
			for (var u=0; u<arr.length; u++) {
				//trace(arr[u].name);
			}
		}
		
		private function check4Dir() {
			for (var g=0; g<4; g++) {
				var av=mc.getChildByName(arr[g].name);
				var point:Point=new Point(av.x,av.y);

				var newPo:Point=mc.localToGlobal (point);
				var checked=false;
				var dirx=0;
				var diry=0;
				if (dir[g][1]==0) {//往左右
					if (dir[g][0]<0) {//往右边拖
						if (newPo.x>0) {

							checked=true;
							dirx=-1;
							diry=-1;
							
							for (var p1=av.idY; p1<av.idY+3; p1++) {

								var a21=new MapMc();

								a21.idX=av.idX+dirx;
								a21.idY=p1;
								
								if(av.idX<=LeftAll){
									//a21.idX=RightAll
									
								}
								a21.x=av.x+dirx*ww;
								a21.y=hh*(hhh-p1);

								a21.name="a_"+a21.idX+"_"+a21.idY;
								a21.tt.text=a21.name;
								var url=host+"baiduMap/"+a21.idX+"_"+a21.idY+"[1].png";
								a21.st(url);
								mc.addChild(a21);
								if (p1==av.idY) {
									arr[g]=a21;
								}
							}
							//把右面的移除掉
							
							var avT=mc.getChildByName(arr[1].name);
							var avB=mc.getChildByName(arr[2].name);
							
							
							arr[1]=mc.getChildByName("a_"+(avT.idX-1)+"_"+(avT.idY));
							arr[2]=mc.getChildByName("a_"+(avB.idX-1)+"_"+(avB.idY))
							
							if(avT.idX==LeftAll){
								//arr[1]=mc.getChildByName("a_"+(RightAll)+"_"+(avT.idY));
								//arr[2]=mc.getChildByName("a_"+(RightAll)+"_"+(avB.idY))
								
							}

							for (var p3=avB.idY; p3<=avT.idY; p3++) {
								var av2=mc.getChildByName("a_"+avT.idX+"_"+p3);
								//trace(av2.name);
								mc.removeChild(av2);
							}
							arr[0]=a21;
							dirLen[0]=dirLen[0]+1;
							
						}
					} else {//往左边r拖
						if (newPo.x<550-av.width) {
							checked=true;
							dirx=1;
							for (var p2=av.idY; p2>av.idY-3; p2--) {

								var a22=new MapMc();

								a22.idX=av.idX+dirx;
								a22.idY = p2;
								if (av.idX >=RightAll) {
									//a22.idX = LeftAll;
								}
								a22.x=av.x+dirx*ww;
								a22.y=hh*(hhh-p2);

								a22.name="a_"+a22.idX+"_"+a22.idY;
								a22.tt.text=a22.name;
								var url="baiduMap/"+a22.idX+"_"+a22.idY+"[1].png";
								a22.st(url);
								mc.addChild(a22);
								if (p2==av.idY) {
									arr[g]=a22;
									//trace(a22.name+"---------")
								}
							}
							//把左面的移除掉
							var avT=mc.getChildByName(arr[0].name);
							var avB=mc.getChildByName(arr[3].name);
							arr[0]=mc.getChildByName("a_"+(avT.idX+1)+"_"+(avT.idY));
							arr[3]=mc.getChildByName("a_"+(avB.idX+1)+"_"+(avB.idY))
							if (avT.idX == RightAll) {
							
								//arr[0]=mc.getChildByName("a_"+(LeftAll)+"_"+(avT.idY));
								//arr[3]=mc.getChildByName("a_"+(LeftAll)+"_"+(avB.idY))
								
							}
							for (var p3=avT.idY; p3>=avB.idY; p3--) {
								var av2=mc.getChildByName("a_"+avT.idX+"_"+p3);
								//trace(av2.name);
								mc.removeChild(av2);
							}
							dirLen[0]=dirLen[0]+1;
							arr[2]=a22;
						}
					}
				}
				if (dir[g][0]==0) {//上下

					if (dir[g][1]<0) {//往下拖
						if (newPo.y>0) {
							checked=true;
							diry=1;
							for (var p3=av.idX; p3<av.idX+3; p3++) {
								var a23=new MapMc();

								a23.idX=p3;
								a23.idY = av.idY + diry;
								
								if (av.idY >= TopAll) {
									//a23.idY = BottomAll;
								}

								
								a23.x=(ww)*p3;
								a23.y=av.y-hh;

								a23.name="a_"+a23.idX+"_"+a23.idY;
								a23.tt.text=a23.name;
								var url="baiduMap/"+a23.idX+"_"+a23.idY+"[1].png";
								a23.st(url);
								mc.addChild(a23);
								if (p3==av.idX) {
									arr[g]=a23;
								}
							}
							//把下面的移除掉
							var avR=mc.getChildByName(arr[2].name);
							var avL=mc.getChildByName(arr[3].name);
							arr[2]=mc.getChildByName("a_"+avR.idX+"_"+(avR.idY+1));
							arr[3] = mc.getChildByName ("a_" + avL.idX + "_" + (avL.idY + 1));
							if (avR.idY==TopAll) {
								//arr[2]=mc.getChildByName("a_"+avR.idX+"_"+(BottomAll));
								//arr[3] = mc.getChildByName ("a_" + avL.idX + "_" + (BottomAll));
							}
							
							
							for (var p3=avL.idX; p3<=avR.idX; p3++) {
								var av2=mc.getChildByName("a_"+p3+"_"+avR.idY);
								mc.removeChild(av2);
							}
							dirLen[1]=dirLen[1]+1;
							arr[1]=a23;
						}
					} else {//往上拖
						if (newPo.y<400-av.height) {
							checked=true;
							diry=-1;
							//trace("下面:"+av.name)
							//trace(dirLen[0]+"--"+av.name)
							for (var p4=av.idX; p4>av.idX-3; p4--) {
								var a24=new MapMc();

								a24.idX=p4;
								a24.idY = av.idY + diry;
								if (av.idY<=BottomAll) {
									//a24.idY =TopAll;
								}
								a24.x=ww*p4;

								a24.y=av.y+hh;

								a24.name="a_"+a24.idX+"_"+a24.idY;
								//trace(a24.name);
								a24.tt.text=a24.name;
								var url="baiduMap/"+a24.idX+"_"+a24.idY+"[1].png";
								a24.st(url);

								mc.addChild(a24);
								if (p4==av.idX) {
									arr[g]=a24;
								}
							}
							/*for (var u=0; u<arr.length; u++) {
							trace(arr[u].name);
							}*/


							//把上面的移除掉
							var avR=mc.getChildByName(arr[1].name);
							var avL=mc.getChildByName(arr[0].name);
							arr[1]=mc.getChildByName("a_"+avR.idX+"_"+(avR.idY-1));
							arr[0] = mc.getChildByName ("a_" + avL.idX + "_" + (avL.idY - 1));
							if (avR.idY==BottomAll) {
								//arr[1]=mc.getChildByName("a_"+avR.idX+"_"+(TopAll));
								//arr[0] = mc.getChildByName ("a_" + avL.idX + "_" + (TopAll));								
							}
							
							
							for (var p3=avL.idX; p3<=avR.idX; p3++) {
								var av2=mc.getChildByName("a_"+p3+"_"+avR.idY);
								//trace(av2.name)
								mc.removeChild(av2);
							}
							dirLen[1]=dirLen[1]+1;
							arr[3]=a24;
						}
					}
				}
				if (checked) {
					checked=false;
				}
			}
			//trace(dirLen);
		}
		private function mcMOUSE_DOWN(e:MouseEvent) {
			draging=true;
			mc.startDrag();
		}
		private function mcMOUSE_UP(e:MouseEvent) {
			mc.stopDrag();
			check4Dir();
			draging=false;
		}
		private function mcMOUSE_MOVE(e:MouseEvent) {
			if (draging) {
				check4Dir();
			}
		}
		
	}
	
}
