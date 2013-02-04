package hcxm.cn.util
{
	public class Eval
	{
		public function Eval()
		{
			
		}
		/**
		 * 计算字符串表达式
		 * 例如这样一个字符串: "1*5+6-7/2"; 把它传到 infix  最后会返回 7.5
		 * */
		public static function evalString(infix) {
        var tempString:String = new String();

        var opArray = new Array();
        var postfix = new Array();
        var post;

        //栈底标记
        opArray[0] = '@';
        var op = 1;
        post = 0;

        //保存计算结果
        var res = 0;

        //trace("计算表达式:" + infix);
       
        var l=0,r=0;
        for(i=0;i <infix.length;i++)
        {
            if(infix.charAt(i) == "(")
            l++;
            if(infix.charAt(i) == ")")
            r++;
            if(l!=r)
            {
                //return "括号不匹配";
            }
        }
        if (infix.charAt(0) == "-") {
            infix = "0"+infix;
        }
       
        while(infix.indexOf("(-")>-1) {
            infix = infix.substr(0, infix.indexOf("(-")+1)+"0"+infix.substr(infix.indexOf("(-")+1, infix.length);
        }
       
        var i, j;

        //计算两个数
        function Caculate(opSign) {
            //trace("opSign" + opSign);
            if (opSign == '+') {
                res = postfix[post-2]+postfix[post-1];
            } else if (opSign == '-') {
                res = postfix[post-2]-postfix[post-1];
            } else if (opSign == '*') {
                res = postfix[post-2]*postfix[post-1];
            } else if (opSign == '/') {
                if (!postfix[post-1]) {
                    trace("Expression Error!");
                } else {
                    res = postfix[post-2]/postfix[post-1];
                }
            }
            //trace("计算前opArray:"+opArray); 
            //trace("计算前postfix:"+postfix);
            postfix[post-1] = 0;
            postfix[post-2] = res;
            post--;
        }
        //扫描中缀表达式
        for (i=0; i <infix.length; i++) {
            switch (infix.charAt(i)) {

                case '(' ://左括号就直接入栈
                    opArray[op] = infix.charAt(i);
                    op++;
                    break;

                case ')' ://右括号则退栈计算，直到遇见一个左括号
                    for (j=op-1; j>0; j--) {
                        if (opArray[j] != '(') {
                            Caculate(opArray[j]);
                            opArray[j] = '#';
                        } else {
                            opArray[j] = '#';
                            break;
                        }
                    }
                    op = j;
                    break;
                case '*' :
                case '/' ://如果栈顶的运算符为*或/，则先退栈，再入栈，否则直接入栈
                    if (opArray[op-1] == '*') {
                        op--;
                        Caculate(opArray[op]);
                        opArray[op] = '#';
                    } else if (opArray[op-1] == '/') {
                        op--;
                        Caculate(opArray[op]);
                        opArray[op] = '#';
                    }
                    opArray[op] = infix.charAt(i);

                    op++;
                    break;
                case '+' :
                case '-' ://如果栈顶的运算符不是左括号也不是栈底，则先退栈计算，再入栈
                    //trace("op:" + op);
                    while (opArray[op-1] != '(' && opArray[op-1] != '@') {
                        op--;
                        Caculate(opArray[op]);
                        opArray[op] = '#';
                    }
                    opArray[op] = infix.charAt(i);
                    op++;
                    break;
                default ://如果是数字字符或者小数点则转化为数字存入数组
                    tempString += infix.charAt(i);

                    //如果下一个字符是运算符则把当前数字存入数组
                    var temp:String = new String();
                    temp = infix.charAt(i+1);
                    if (temp != '.' && (temp>'9' || temp <'0')) {
                        postfix[post] = parseFloat(tempString);
                        post++;
                        tempString = "";
                    }
            }
        }

        //trace("扫描完成后postfix:" + postfix);
        //trace("扫描完成后opArray:" + opArray);

        //扫描完成，全部退栈
        for (j=op-1; j>=0; j--) {
            if (opArray[j] != '@') {
                Caculate(opArray[j]);
                opArray[j] = '#';
            } else {
                break;
            }
        }
        //trace("返回前postfix:" + postfix);
        //trace("返回前opArray:" + opArray);
        //返回结果
        return postfix[0];
    } 			
	}
}