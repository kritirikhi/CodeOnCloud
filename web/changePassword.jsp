<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <title>Code Cloud</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="keywords" />
    <%@include file="headerfiles.html" %>
    <script>
        
        function userChangePassword(){
            console.log("password changed function");
            var username = document.getElementById("username").value;
            var oldpassword = document.getElementById("oldpassword").value;
            var newpassword = document.getElementById("newpassword").value;
            var confirmnewpassword = document.getElementById("confirmnewpassword").value;
            
            if(username==="" || oldpassword==="" || newpassword==="" || confirmnewpassword===""){
                document.getElementById("msgDisplay").style.background="#ff3333";
                document.getElementById("msgType").innerHTML = "Error : ";
                document.getElementById("msg").innerHTML = "All Fields Are Mandatory";  
                return;
            }
            else if(!(newpassword===confirmnewpassword)){
                document.getElementById("msgDisplay").style.background="#ff3333";
                document.getElementById("msgType").innerHTML = "Error : ";
                document.getElementById("msg").innerHTML = "New And Confirm Passwords do not Match";  
                return;
            }
            else if( newpassword.length<7 ){
                document.getElementById("msgDisplay").style.background="#ff3333";
                document.getElementById("msgType").innerHTML = "Error : ";
                document.getElementById("msg").innerHTML = "Password must have more than 7 characters";  
                return;
            }
            
            
            var formdata = new FormData();
            formdata.append("username",username);
            formdata.append("oldpassword",oldpassword);
            formdata.append("newpassword",newpassword);
            formdata.append("confirmnewpassword",confirmnewpassword);
            
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                        var response = JSON.parse(this.responseText);
                        var msgtype = response["type"];
                        var message = response["message"];
                        
                        if(msgtype=="Error"){
                            document.getElementById("msgDisplay").style.background="#ff3333";
                        }
                        else if(msgtype=="Success"){
                            document.getElementById("msgDisplay").style.background="#99ff99";
                            
                        }
                        document.getElementById("msgType").innerHTML = msgtype+" : ";
                        document.getElementById("msg").innerHTML = message;
                        
                        if(msgtype=="Success"){
                            console.log("in successs")
                            setTimeout(function(){
                                window.location.replace("./index.jsp");
                            }, 2000);  
                        }
                        else if(msgtype=="Error"){
                            console.log("in erro")
                            setTimeout(function(){
                                document.getElementById("msgDisplay").innerHTML="";
                                document.getElementById("msgDisplay").style.background="white";
                            }, 2000);  
                        }
                        
                }
            };
            xmlhttp.open("POST","./userChangePasswordServlet", true);
            xmlhttp.send(formdata);
        }
        
    </script>
    
    
    <style>
        .view-show:hover{
            background:#e7e4e4!important;
        }
        @media screen and (max-width: 768px){
            #navbarSupportedContent{
                margin:0 auto;
            }
            .view-menu{
                background: transparent;
                border:none;
            }
            .view-menu a{
                color:white!important;
            }
            .view-menu a:hover{
                color:#0d2865!important;
            }
            .session-user-menu{
                left:50%;
                transform:translateX(-50%);
                z-index: 11;
            }
            
        }
    </style>
    </head>
    
    <%
        Object sessionusername = session.getAttribute("username");           
            if (sessionusername==null){
                response.sendRedirect("./index.jsp");
            }             
        else{
    %>
    <body>
        <!-- header -->
        <div class="w3-banner-info-w3ltd position-relative; margin-bottom:0px;">
            <header style="position:relative; margin-bottom:0px">
                <div class="container">
                    <nav class="navbar navbar-expand-lg navbar-light p-0">
                        <h1><a class="navbar-brand" href="./index.jsp">Code On Cloud

                            </a></h1>
                        <button class="navbar-toggler ml-lg-auto ml-sm-5 bg-light" type="button" data-toggle="collapse"
                            data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                            aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="ml-lg-5 navbar-nav mr-lg-auto">
                                <li class="nav-item  mr-lg-4 mt-lg-0 mt-sm-4 mt-3">
                                    <a href="./index.jsp">Home</a>
                                </li>
                                <li class="nav-item  mr-lg-4 mt-lg-0 mt-sm-4 mt-3">
                                    <a href="./about.jsp">about</a>
                                </li>
                                
                                    <li class="nav-item dropdown mr-lg-4 my-lg-0 my-sm-4 my-3">
                                        <a href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true"
                                            aria-expanded="false">
                                            View 
                                            <i class="fas fa-caret-down"></i>
                                        </a>
                                        <div class="dropdown-menu view-menu" aria-labelledby="navbarDropdown">
                                            <a class="view-show" href="./viewFriendRequests.jsp">Friend Requests</a>
                                            <a class="view-show" href="./viewSentRequests.jsp">Sent Requests</a>
                                            <a class="view-show" href="./viewFriends.jsp">Friends</a>                                
                                            <a class="view-show" href="./usersavedCodes.jsp">View Saved Codes</a>                              
                                            <a class="view-show" href="./viewSharedCodes.jsp">View Shared Codes</a>
                                        </div>
                                    </li>
                            
                                <li class="nav-item mr-lg-4 my-lg-0 mb-sm-4 mb-3">
                                    <a href="./contact.jsp">contact</a>
                                </li>
                            </ul>
                                <div class="dropdown">
                                    <button class="btn dropdown-toggle w3ls-btn text-uppercase font-weight-bold d-block" type="button" id="usernameMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                      Welcome &nbsp;<%=(session.getAttribute("username")).toString()%>
                                    </button>
                                    <div class="dropdown-menu session-user-menu" aria-labelledby="usernameMenuButton">
                                      <a class="dropdown-item" href="./changePassword.jsp">Change Password</a>
                                      <a class="dropdown-item" href="./compilecode.jsp">Compile Code</a>
                                      <a class="dropdown-item" href="./myprofile.jsp">My Profile</a>
                                      <hr>
                                      <a class="dropdown-item" href="./userLogout">Logout</a>
                                    </div>
                                </div>
                        </div>
                    </nav>
                </div>
            </header>
            <!-- //header -->
            <div class="slider" style="margin-bottom:10%">
                <ul class="rslides" id="slider">
                    <li>
                        <div class="d-flex banner-w3pvt-bg1 common-bg">
                            <div class="d-flex mx-auto flex-column">
                                <div class="bnr-w3pvt" style="margin-top:10px;">
                                    <h3>Change Password</h3>
                                </div>
                                <div class="row bnr-form-w3ls" style="margin-top:5%; padding:1%">
                                    <div class="col-sm-12">
                                        <div class="container mt-2" id="msgDisplay" style="padding:2%">
                                            <div class="row">
                                                <div class="col-sm-1"></div>
                                                <div class="col-sm-10" style="text-align: center">
                                                    <h5 style="padding: 2% 0% 2% 0%"><span id="msgType"></span>  <span id="msg"></span></h5>
                                                </div>
                                                <div class="col-sm-1"></div>
                                            </div>  
                                        </div>    
                                        <form class="p-3 bnr-field">
                                            <div class="form-group">
                                                <label for="username" class="col-form-label">Username</label>
                                                <input type="text" class="form-control" placeholder="Username" name="username" id="username"
                                                    required="">
                                            </div>
                                            <div class="form-group">
                                                <label for="oldpassword" class="col-form-label">Old Password</label>
                                                <input type="password" class="form-control" placeholder="Old Password" name="oldpassword" id="oldpassword"
                                                    required="">
                                            </div>
                                            <div class="form-group">
                                                <label for="newpassword" class="col-form-label">New Password</label>
                                                <input type="password" class="form-control" placeholder="New Password" name="newpassword" id="newpassword"
                                                    required="">
                                            </div>
                                            <div class="form-group">
                                                <label for="confirmnewpassword" class="col-form-label">Confirm New Password</label>
                                                <input type="password" class="form-control" placeholder="Confirm New Password" name="confirmnewpassword" id="confirmnewpassword"
                                                    required="">
                                            </div>
                                            <div class="right-w3l">
                                                <input type="button" class="form-control bg-theme" value="Change Password" onclick="userChangePassword()">
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
                                    
    <%@include file="footer.html" %>
                                    
    
    </body>
    <%
        }
    %>
    
    <%@include file="footerfiles.html" %>
</html>
