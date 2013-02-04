 package hcxm.cn.skin {  
     import mx.skins.halo.LinkButtonSkin;  
   
     public class ToggleLinkButtonSkin extends LinkButtonSkin {  
         public function ToggleLinkButtonSkin() {  
             super();  
         }  
  
         override protected function updateDisplayList(w:Number, h:Number):void {  
             super.updateDisplayList(w, h);  
   
             var cornerRadius:Number = getStyle("cornerRadius");  
             var rollOverColor:uint = getStyle("rollOverColor");  
             var selectionColor:uint = getStyle("selectionColor");  
   
             graphics.clear();  
   
             switch (name) {  
                 case "upSkin":  
                     // 画一个不可见矩形，作为用户的点击区域  
                     drawRoundRect(  
                         0, 0, w, h, cornerRadius,  
                         0, 0);  
                     break;  
                 //增加了selectedUpSkin和selectedOverSkin两种状态，实际上和原来的overSkin一样   
                 case "selectedUpSkin":  
                 case "selectedOverSkin":  
                 case "overSkin":  
                     drawRoundRect(  
                         0, 0, w, h, cornerRadius,  
                         rollOverColor, 1);  
                     break;  
               //增加了selectedDownSkin状态，实际上和原来的downSkin是一样的外观  
                 case "selectedDownSkin":  
                 case "downSkin":  
                     drawRoundRect(  
                         0, 0, w, h, cornerRadius,  
                         selectionColor, 1);  
                     break;  
                 //增加了selectedDisabledSkin状态，实际上和原来的disabledSkin一样  
                 case "selectedDisabledSkin":  
                 case "disabledSkin":  
                     // Draw invisible shape so we have a hit area.  
                     drawRoundRect(  
                         0, 0, w, h, cornerRadius,  
                         0, 0);  
                     break;  
             }  
         }  
     }  
 }  