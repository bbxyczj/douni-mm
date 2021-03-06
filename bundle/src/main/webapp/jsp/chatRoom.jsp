<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>聊天室 - SIX</title>
<link rel="shortcut icon" href="../favicon.png">
<link rel="icon" href="../favicon.png" type="image/x-icon">
<link type="text/css" rel="stylesheet" href="../css/chat.css">
<script type="text/javascript" src="../js/jquery.min.js"></script>
</head>

<body>
<div class="chatbox">
  <div class="chat_top fn-clear">
    <div class="logo"><img src="../images/logo.png" width="190" height="60" alt=""/></div>
    <div class="uinfo fn-clear">
      <div class="uface"><img src="../images/hetu.jpg" width="40" height="40" alt=""/></div>
      <div class="uname">
        河图<i class="fontico down"></i>
        <ul class="managerbox">
          <li><a href="#"><i class="fontico lock"></i>修改密码</a></li>
          <li><a href="#"><i class="fontico logout"></i>退出登录</a></li>
        </ul>
      </div>
    </div>
  </div>
  <div class="chat_message fn-clear">
    <div class="chat_left">
      <div class="message_box" id="message_box">
        <div class="msg_item fn-clear">
          <div class="uface"><img src="../images/53f44283a4347.jpg" width="40" height="40" alt=""/></div>
          <div class="item_right">
            <div class="msg">近日，TIOBE发布了2014年9月的编程语言排行榜，Java、C++跌至历史最低点，前三名则没有变化，依旧是C、Java、Objective-C。</div>
            <div class="name_time">猫猫 · 3分钟前</div>
          </div>
        </div>
        
        <div class="msg_item fn-clear">
          <div class="uface"><img src="../images/53f442834079a.jpg" width="40" height="40" alt=""/></div>
          <div class="item_right">
            <div class="msg">(Visual) FoxPro, 4th Dimension/4D, Alice, APL, Arc, Automator, Awk, Bash, bc, Bourne shell, C++CLI, CFML, cg, CL (OS/400), Clean, Clojure, Emacs Lisp, Factor, Forth, Hack, Icon, Inform, Io, Ioke, J, JScript.NET, LabVIEW, LiveCode, M4, Magic, Max/MSP, Modula-2, Moto, NATURAL, OCaml, OpenCL, Oz, PILOT, Programming Without Coding Technology, Prolog, Pure Data, Q, RPG (OS/400), S, Smalltalk, SPARK, Standard ML, TOM, VBScript, Z shell</div>
            <div class="name_time">白猫 · 1分钟前</div>
          </div>
        </div>
        
        <div class="msg_item fn-clear">
          <div class="uface"><img src="../images/hetu.jpg" width="40" height="40" alt=""/></div>
          <div class="item_right">
            <div class="msg own">那个统计表也不能说明一切</div>
            <div class="name_time">河图 · 30秒前</div>
          </div>
        </div>
      </div>
      <div class="write_box">
        <textarea id="message" name="message" class="write_area" placeholder="说点啥吧..."></textarea>
        <input type="hidden" name="fromname" id="fromname" value="河图" />
        <input type="hidden" name="to_uid" id="to_uid" value="0">
        <div class="facebox fn-clear">
          <div class="expression"></div>
          <div class="chat_type" id="chat_type">群聊</div>
          <button name="" class="sub_but">提 交</button>
        </div>
      </div>
    </div>
    <div class="chat_right">
      <ul class="user_list" title="双击用户私聊">
        <li class="fn-clear selected"><em>所有用户</em></li>
        <li class="fn-clear" data-id="1"><span><img src="../images/hetu.jpg" width="30" height="30" alt=""/></span><em>河图</em><small class="online" title="在线"></small></li>
        <li class="fn-clear" data-id="2"><span><img src="../images/53f44283a4347.jpg" width="30" height="30" alt=""/></span><em>猫猫</em><small class="online" title="在线"></small></li>
        <li class="fn-clear" data-id="3"><span><img src="../images/53f442834079a.jpg" width="30" height="30" alt=""/></span><em>白猫</em><small class="offline" title="离线"></small></li>
      </ul>
    </div>
  </div>
</div>
<script type="text/javascript">
$(document).ready(function(e) {
	$('#message_box').scrollTop($("#message_box")[0].scrollHeight + 20);
	$('.uname').hover(
	    function(){
		    $('.managerbox').stop(true, true).slideDown(100);
	    },
		function(){
		    $('.managerbox').stop(true, true).slideUp(100);
		}
	);
	
	var fromname = $('#fromname').val();
	var to_uid   = 0; // 默认为0,表示发送给所有用户
	var to_uname = '';
	$('.user_list > li').dblclick(function(){
		to_uname = $(this).find('em').text();
		to_uid   = $(this).attr('data-id');
		if(to_uname == fromname){
		    alert('您不能和自己聊天!');
			return false;
		}
		if(to_uname == '所有用户'){
		    $("#toname").val('');
			$('#chat_type').text('群聊');
		}else{
		    $("#toname").val(to_uid);
			$('#chat_type').text('您正和 ' + to_uname + ' 聊天');
		}
		$(this).addClass('selected').siblings().removeClass('selected');
	    $('#message').focus().attr("placeholder", "您对"+to_uname+"说：");
	});
	
	$('.sub_but').click(function(event){
	    sendMessage(event, fromname, to_uid, to_uname);
	});
	
	/*按下按钮或键盘按键*/
	$("#message").keydown(function(event){
		var e = window.event || event;
        var k = e.keyCode || e.which || e.charCode;
		//按下ctrl+enter发送消息
		if((event.ctrlKey && (k == 13 || k == 10) )){
			sendMessage(event, fromname, to_uid, to_uname);
		}
	});
});
function sendMessage(event, from_name, to_uid, to_uname){
    var msg = $("#message").val();
	if(to_uname != ''){
	    msg = '您对 ' + to_uname + ' 说： ' + msg;
	}
    send(msg);
	var htmlData =   '<div class="msg_item fn-clear">'
                   + '   <div class="uface"><img src="../images/hetu.jpg" width="40" height="40"  alt=""/></div>'
			       + '   <div class="item_right">'
			       + '     <div class="msg own">' + msg + '</div>'
			       + '     <div class="name_time">' + from_name + ' · 30秒前</div>'
			       + '   </div>'
			       + '</div>';
	$("#message_box").append(htmlData);
	$('#message_box').scrollTop($("#message_box")[0].scrollHeight + 20);
	$("#message").val('');
}



var websocket = null;
//判断当前浏览器是否支持WebSocket
if ('WebSocket' in window) {
    websocket = new WebSocket("ws://localhost:8876/websocket");
}
else {
    alert('当前浏览器 Not support websocket')
}

//连接发生错误的回调方法
websocket.onerror = function () {
    setMessageInnerHTML("WebSocket连接发生错误");
};

//连接成功建立的回调方法
websocket.onopen = function () {
    setMessageInnerHTML("WebSocket连接成功");
}

//接收到消息的回调方法
websocket.onmessage = function (event) {
    setMessageInnerHTML(event.data);
    $('.sub_but').onclick();
}

//连接关闭的回调方法
websocket.onclose = function () {
    setMessageInnerHTML("WebSocket连接关闭");
}

//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
window.onbeforeunload = function () {
    closeWebSocket();
}

//将消息显示在网页上
function setMessageInnerHTML(innerHTML) {
    document.getElementById('message').innerHTML += innerHTML + '<br/>';
}

//关闭WebSocket连接
function closeWebSocket() {
    websocket.close();
}

//发送消息
function send(message) {
    websocket.send(message);
}



</script>
</body>
</html>
