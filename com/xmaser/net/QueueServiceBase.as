package com.xmaser.net
{
   
	import com.xmaser.net.interfaceClass.IQueue;
	import com.xmaser.net.interfaceClass.IQueueVO;
    import flash.events.*;

    public class QueueServiceBase extends EventDispatcher implements IQueue
    {
        protected var _list:Array;
        protected var _queueList:Array;
        private var _errorList:Array;
        protected var _isLoading:Boolean = false;
		public var needCheckCache:Boolean = true;
        public var isAuto:Boolean = true;

        public function QueueServiceBase()
        {
            this._list = [];
            this._queueList = [];
            this._errorList = [];
            return;
        }

        public function add(param1:IQueueVO) : void
        {
            this._queueList.push(param1);
            if (this.isAuto == false)
            {
                return;
            }
            this._start();
            return;
        }
		
		public function remove(param1:IQueueVO):void
		{
			for (var i:int = 0; i < this._list.length; i++) 
			{
				var item:IQueueVO = this._list[i];
				if (item == param1)
				{
					item = null;
					this._list.splice(i, 1);
					break;
				}
				
			}
		}
        public function start() : void
        {
            this._start();
            return;
        }

        private function _start() : void
        {
            var qvo:IQueueVO;
            if (this._isLoading)
            {
                return;
            }
            if (this._queueList.length == 0)
            {
				
				
                if (this.isAuto == false)
                {
                    dispatchEvent(new Event(Event.COMPLETE));
                }
                return;
            }
           qvo= this._queueList[0];
           //trace("this._queueList.length: " + this._queueList.length);
			if (needCheckCache)
			{
				var sameVO:* = this.checkCache(qvo);
				if (sameVO)
				{
					qvo = this._queueList.shift();
					qvo.isReady = true;
					this.showReadyItemFromSame(qvo,sameVO);
					this._isLoading = false;
					this._start();
					return;
				}
			}
            this._isLoading = true;
            this.exectue(this._queueList[0]);
           
        }
		
		public function showReadyItemFromSame(qvo:IQueueVO, same:IQueueVO):void 
		{
			
		}		
		
		 
		
        protected function exectue(param1:IQueueVO) : void
        {
           
        }

        protected function handleComplete() : void
        {
            var qvo:IQueueVO = this._queueList.shift();
            qvo.isReady = true;
			qvo.isProcessing = false;
            this._list.push(qvo);
            this.showReadyItem(qvo);
            this._isLoading = false;
            this._start();
           
        }

        protected function handleError() : void
        {
            this._isLoading = false;
            var qvo:IQueueVO = this._queueList[0];
           
           qvo.errorTotalNum +=1
            
            if (qvo.errorTotalNum >= 3)
            {
                qvo.errorTotalNum = 0;
                this._queueList.shift();
                this._errorList.push(qvo);
				handleErrorEvent(qvo)
            }
            this._start();
            
        }
		
		protected function handleErrorEvent(qvo:IQueueVO):void 
		{
			
		}

        protected function checkCache(param1:IQueueVO) : IQueueVO
        {
            return null;
        }

        public function showReadyItem(param1:IQueueVO) : void
        {
            if (param1.callBackFunction != null)
            {
                param1.callBackFunction.apply(null, [param1]);
            }
          
        }

    }
}
