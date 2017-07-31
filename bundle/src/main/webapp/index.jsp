<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>聊天室 - editor:yinq</title>
    <link rel="shortcut icon" href="favicon.png">
    <link rel="icon" href="favicon.png" type="image/x-icon">
    <link type="text/css" rel="stylesheet" href="css/style.css">
    <link type="text/css" rel="stylesheet" href="css/login.css">
    <link type="text/css" rel="stylesheet" href="css/bootstrap.css">
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
</head>
<body class="signin">
<div class="signinpanel">
    <div class="row">
        <div class="col-sm-7">
            <div class="signin-info">
                <div class="m-b">
                    <h2>欢迎使用 <strong>MM 世界</strong></h2>
                    <strong>还没有账号？ <a href="#">立即注册&raquo;</a></strong>
                </div>

            </div>
        </div>
        <div class="col-sm-5">
            <form id="loginForm" method="post" action="/login" >
                <h2 class="no-margins"> 登录：</h2>
                <input type="text" id="username" name="username" onclick="getSubmit()" class="form-control uname" placeholder="用户名" />
                <input type="password" id="password" name="password"  onclick="getSubmit()" class="form-control pword m-b" placeholder="密码" />
                <p>
                    <label style="color:#000;">验证码：</label>
                    <input id="code"  style="color:#000;" onclick="getSubmit()" type="text" size="5" name="code"/>
                    <span id="imageMaskSpan">
							<img src="/ImageMaskServlet" title="单击图片更换" width="75" height="24" id="imageMask" onclick="myReload()"/>
						</span>
                </p>
                <h3><input type="submit" class="btn btn-success btn-block" value="登录"/></h3>
                <b id="unamemsg" style="color:red; font-size: 12px;">${msg}</b>
            </form>
        </div>
    </div>
</div>
</body>
<script>
    $(function(){
        $("input[type='submit']").click(checkContent);
        
    });
    function checkContent(){
        var username=$("#username").val();
        var userpwd=$("#password").val();
        var code=$("#code").val();
        if($.trim(username)==""){
            $("#unamemsg").html("请输入用户名！！！");
            $("input[type='submit']").attr("disabled",true);
            myReload();
        }else if($.trim(userpwd)==""){
            $("#unamemsg").html("请输入密码！！！");
            $("input[type='submit']").attr("disabled",true);
            myReload();
        }else if($.trim(code)==""){
            $("#unamemsg").html("请输入验证码！！！");
            $("input[type='submit']").attr("disabled",true);
            myReload();
        }else{
            $("#unamemsg").html("");
            $("input[type='submit']").attr("disabled",false);
        }
    }
    function getSubmit() {
        $("#unamemsg").html("");
        $("input[type='submit']").attr("disabled",false);
    }

    /* 点击回车登陆 */
    $(window).keydown(function (e) {
        if (e.which == 13) {
            $("#loginForm").submit();
        }
    });
    //用于刷新验证码
    function myReload(){
        document.getElementById("imageMask").src=document.getElementById("imageMask").src+"?nocache="+new Date().getTime();
    }
    $(function(){
        $('#imageMaskSpan').mouseover(function(){
            $(this).css("cursor","pointer");
        });
        myReload();
    });
</script>

</html>
