package com.wdcgame.battle 
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author wdc
	 */
	public class BattleUnit extends Sprite implements IBattleUnit,ICollide
	{
		private var _life:Number;
		private var _isDie:Boolean;
		private var _deleted:Boolean
		private var _power:Number;
		public function BattleUnit() 
		{
			
		}
		
		/* INTERFACE com.wdcgame.battle.IBattleUnit */
		
		public function hurt(n:Number):void 
		{
			_life-= n;
			 
			if (_life<=0) 
			{
				_life = 0;
				_isDie = true;
			}
		}
		
		public function attack():void 
		{
			
		}
		
		 
		
		/* INTERFACE com.wdcgame.battle.ICollide */
		
		public function collided(b:ICollide):void 
		{
			
		}
		
		/* INTERFACE com.wdcgame.battle.ICollide */
		
		public function getCollidedWidth(b:ICollide):Boolean 
		{
			if(this.bounds.intersects(DisplayObject(b).bounds))
			{
				return true;
			}
			return false;
		}
		
		/* INTERFACE com.wdcgame.battle.ICollide */
		
		public function canCollide():Boolean 
		{
			return true;
		}
		
		/* INTERFACE com.wdcgame.battle.IBattleUnit */
		
		public function destroy():void 
		{
			
		}
		
		/* INTERFACE com.wdcgame.battle.ICollide */
		
		public function canCollideNull():Boolean 
		{
			return false;
		}
		
		/* INTERFACE com.wdcgame.battle.ICollide */
		
		public function get power():Number 
		{
			return _power;
		}
		
		public function set power(value:Number):void 
		{
			_power = value;
		}
		
		/* INTERFACE com.wdcgame.battle.IBattleUnit */
		
		public function set life(value:Number):void 
		{
			_life = value;
		}
		
		public function get life():Number 
		{
			return _life;
		}
		
		public function set isDie(value:Boolean):void 
		{
			_isDie = value;
		}
		
		public function get isDie():Boolean 
		{
			return _isDie;
		}
		
		public function get deleted():Boolean 
		{
			return _deleted;
		}
		
		public function set deleted(value:Boolean):void 
		{
			_deleted = value;
		}
		
	}

}