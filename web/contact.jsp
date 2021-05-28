<!DOCTYPE html>
<html lang="zxx">

<head>
    <title>Contact Us</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <script>
        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
        }
    </script>
    <!-- Custom Theme files -->
    <link href="css/bootstrap.min.css" type="text/css" rel="stylesheet" media="all">
    <link href="css/style.css" type="text/css" rel="stylesheet" media="all">
    <!-- font-awesome icons -->
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <!-- //Custom Theme files -->
    <!-- online-fonts -->
    <link href="//fonts.googleapis.com/css?family=Source+Sans+Pro:200,200i,300,300i,400,400i,600,600i,700,700i,900,900i"
        rel="stylesheet">
    
    
    <script>
        function validateEmail(email) {
            const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(String(email).toLowerCase());
        }                                    
            
        function contact(){
            var firstname=document.getElementById("firstname").value;
            var lastname=document.getElementById("lastname").value;
            var email=document.getElementById("email").value;
            var phoneno=document.getElementById("phoneno").value;
            var message=document.getElementById("message").value;
            
            if (firstname==="" || lastname==="" || email==="" || phoneno==="" || message===""){
                alert("All Fields Are Necessary");
                return;
            }
            
            if(!(validateEmail(email))){
                alert("Invalid Email ID");
                return;
            }
            
            for(var i=0;i<phoneno.length;i++){
                if(!(phoneno[i]>='0' && phoneno[i]<='9')){
                    alert("Invalid Phone Number");
                    return;
                }
            }
            
            if(phoneno.length!=10){
                alert("Phone Number Must Have 10 Digits");
                return;
            }
            
            var formdata=new FormData();
            formdata.append("firstname",firstname);
            formdata.append("lastname",lastname);
            formdata.append("email",email);
            formdata.append("phoneno",phoneno);
            formdata.append("message",message);
            
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                        var response = JSON.parse(this.responseText);
                        alert( response["type"]+" : "+response["message"]  );
                }
            };
            xmlhttp.open("POST","./contactServlet", true);
            xmlhttp.send(formdata);
        }
        
        function validateEmail(email) {
            const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return re.test(String(email).toLowerCase());
        }                                    
                                        
        function userSignupLogic(){
            var username=document.getElementById("username").value;
            var name=document.getElementById("name").value;
            var email=document.getElementById("email").value;
            var phoneno=document.getElementById("phoneno").value;
            var gender=document.getElementById("gender").value;
            var primarylanguage=document.getElementById("primarylanguage").value;
            var password1=document.getElementById("password1").value;
            var password2=document.getElementById("password2").value;
            var photo=document.getElementById("photo").files[0];
            
            if (username==="" || name==="" || email==="" || phoneno==="" || gender==="" || primarylanguage==="" || password1==="" || password2===""){
                document.getElementById("signupMsgType").innerHTML = "Error : ";
                document.getElementById("signupMsg").innerHTML = "All Fields Are Necessary";
                document.getElementById("signupMsgDisplay").style.display="block";
                document.getElementById("signupMsgDisplay").style.transition="all 1s ease-out";
                document.getElementById("signupMsgDisplay").style.background="#ff3333";
                setTimeout(function(){
                    document.getElementById("signupMsgDisplay").style.display="none";
                }, 2000); 
                
                return;
            }
            
            if(!(validateEmail(email))){
                document.getElementById("signupMsgType").innerHTML = "Error : ";
                document.getElementById("signupMsg").innerHTML = "Invalid Email ID";
                document.getElementById("signupMsgDisplay").style.display="block";
                document.getElementById("signupMsgDisplay").style.background="#ff3333";
                setTimeout(function(){
                    document.getElementById("signupMsgDisplay").style.display="none";
                }, 2000); 
                
                return;
            }
            
            for(var i=0;i<phoneno.length;i++){
                if(!(phoneno[i]>='0' && phoneno[i]<='9')){
                    document.getElementById("signupMsgType").innerHTML = "Error : ";
                    document.getElementById("signupMsg").innerHTML = "Invalid Phone Number";
                    document.getElementById("signupMsgDisplay").style.display="block";
                    document.getElementById("signupMsgDisplay").style.background="#ff3333";
                    setTimeout(function(){
                        document.getElementById("signupMsgDisplay").style.display="none";
                    }, 2000); 
                    
                    return;
                }
            }
            
            if(phoneno.length!=10){
                document.getElementById("signupMsgType").innerHTML = "Error : ";
                document.getElementById("signupMsg").innerHTML = "Phone Number Must Have 10 Digits";
                document.getElementById("signupMsgDisplay").style.display="block";
                document.getElementById("signupMsgDisplay").style.background="#ff3333";    
                setTimeout(function(){
                   document.getElementById("signupMsgDisplay").style.display="none";
                }, 2000); 
                
                return;
            }
            
            if (!(password1 === password2)){
                document.getElementById("signupMsgType").innerHTML = "Error : ";
                document.getElementById("signupMsg").innerHTML = "Passwords Do Not Match";
                document.getElementById("signupMsgDisplay").style.display="block";
                document.getElementById("signupMsgDisplay").style.background="#ff3333";   
                setTimeout(function(){
                    document.getElementById("signupMsgDisplay").style.display="none";
                }, 2000); 
                
                return;
            }
            
            if (password1.length<8){
                document.getElementById("signupMsgType").innerHTML = "Error : ";
                document.getElementById("signupMsg").innerHTML = "Password should have more than 7 characters";
                document.getElementById("signupMsgDisplay").style.display="block";
                document.getElementById("signupMsgDisplay").style.background="#ff3333";
                setTimeout(function(){
                    document.getElementById("signupMsgDisplay").style.display="none";
                }, 2000); 
                
                return;
            }
            
            if(photo==null){
                document.getElementById("signupMsgType").innerHTML = "Error : ";
                document.getElementById("signupMsg").innerHTML = "Upload Profile Photo";
                document.getElementById("signupMsgDisplay").style.display="block";
                document.getElementById("signupMsgDisplay").style.background="#ff3333";
                setTimeout(function(){
                    document.getElementById("signupMsgDisplay").style.display="none";
                }, 2000); 
                
                return;
            }

            var formdata = new FormData();
            formdata.append("username",username);
            formdata.append("name",name);
            formdata.append("email",email);
            formdata.append("phoneno",phoneno);
            formdata.append("gender",gender);
            formdata.append("primarylanguage",primarylanguage);
            formdata.append("password1",password1);            
            formdata.append("password2",password2);
            formdata.append("photo",photo);
            
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                        var response = JSON.parse(this.responseText);
                        var msgtype = response["type"];
                        var message = response["message"];
                        
                        if(msgtype=="Error"){
                            document.getElementById("signupMsgDisplay").style.background="#ff3333";
                        }
                        else if(msgtype=="Success"){
                            document.getElementById("signupMsgDisplay").style.background="#99ff99";
                            
                        }
                        document.getElementById("signupMsgType").innerHTML = msgtype+" : ";
                        document.getElementById("signupMsg").innerHTML = message;
                        document.getElementById("signupMsgDisplay").style.display="block";
                        
                        if(msgtype=="Error"){
                            setTimeout(function(){
                                document.getElementById("signupMsgDisplay").style.display="none";
                            }, 2000); 
                        }
                        else if(msgType="Success"){
                            setTimeout(function(){
                                document.getElementById("signupMsgDisplay").style.display="none";
                                $("#userSignupModal").modal("hide");                                
                                $("#userLoginModal").modal("show");
                            }, 2000);
                            
                        }
                }
            };
            xmlhttp.open("POST","./userSignupServlet", true);
            xmlhttp.send(formdata);
        }
        
        function userLoginLogic(){
            var lusername=document.getElementById("lusername").value;
            var lpassword=document.getElementById("lpassword").value;
            
            if(lusername==="" || lpassword==""){
                document.getElementById("loginMsgDisplay").style.background="#ff3333";
                document.getElementById("loginMsgType").innerHTML = "Error : ";
                document.getElementById("loginMsg").innerHTML = "All Fields Are Mandatory";
                document.getElementById("loginMsgDisplay").style.display="block";
                return;
            }
            
            var formdata = new FormData();
            formdata.append("lusername",lusername);
            formdata.append("lpassword",lpassword);
            
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                        var response = JSON.parse(this.responseText);
                        var msgtype = response["type"];
                        var message = response["message"];
                        
                        if(msgtype=="Error"){
                            document.getElementById("loginMsgDisplay").style.background="#ff3333";
                        }
                        else if(msgtype=="Success"){
                            document.getElementById("loginMsgDisplay").style.background="#99ff99";
                            
                        }
                        document.getElementById("loginMsgType").innerHTML = msgtype+" : ";
                        document.getElementById("loginMsg").innerHTML = message;
                        document.getElementById("loginMsgDisplay").style.display="block";
                        
                        if(msgtype=="Error"){
                            setTimeout(function(){
                                document.getElementById("loginMsgDisplay").style.display="none";
                                $("#userLoginModal").modal("hide");
                            }, 2000); 
                        }
                        else if(msgType="Success"){
                            setTimeout(function(){
                                document.getElementById("loginMsgDisplay").style.display="none";
                                $("#userLoginModal").modal("hide");
                                location.reload();
                            }, 2000);  
                        }
                        
                }
            };
            xmlhttp.open("POST","./userLoginServlet", true);
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

<body>
    <!-- header -->
        <header>
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
                            <%
                                Object sessionuname = session.getAttribute("username");
                                if (sessionuname!=null){
                            %>
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
                            <%
                                }
                            %>
                            <li class="nav-item active mr-lg-4 my-lg-0 mb-sm-4 mb-3">
                                <a href="./contact.jsp">contact</a>
                            </li>
                        </ul>
                        <%
                            Object sessionusername = session.getAttribute("username");
                                
                            if (sessionusername!=null){
                        
                        %>
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
                        <% 
                            }
                            else{
                        %>
                        
                        <button type="button" class="btn w3ls-btn text-uppercase font-weight-bold d-block" data-toggle="modal"
                            aria-pressed="false" data-target="#userSignupModal">
                            Register
                        </button>
                        <button type="button" class="btn w3ls-btn btn-2 ml-lg-1 text-uppercase font-weight-bold d-block"
                            data-toggle="modal" aria-pressed="false" data-target="#userLoginModal">
                            Sign in
                        </button>
                        <%
                            }
                        %>
                    </div>
                </nav>
            </div>
        </header>
        <!-- //header -->
    <div class="inner-banner-w3ls">
    </div>
    <!-- breadcrumbs -->
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb d-flex justify-content-center bg-theme">
            <li class="breadcrumb-item">
                <a href="./index.jsp" class="text-white">Home</a>
            </li>
            <li class="breadcrumb-item active text-white font-weight-bold" aria-current="page">Contact Us</li>
        </ol>
    </nav>
    <!-- //breadcrumbs -->
    <!-- contact -->
    <section class="contact-w3pvt py-lg-5">
        <div class="container py-md-5">
            <div class="address-w3layouts">
                <div class="title-sec-w3layouts_pvt text-center">
                    <span class="title-wthree">A Flexible And Accessible Platform for Coders</span>
                    <h4 class="w3layouts_pvt-head">our contact info</h4>
                </div>
                <div class="row py-md-5 pt-4">
                    <div class="col-lg-4">
                        <div class="row fv3-contact">
                            <div class="col-4  text-center">
                                <span class="fa fa-envelope-open ml-2"></span>
                            </div>
                            <div class="col-8">
                                <a href="mailto:example@email.com" class="d-block text-secondary">kritirikhi1999@gmail.com</a>
                                <a href="mailto:example@email.com" class="d-block text-secondary">2017csa1110@gndu.ac.in</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 my-lg-0 my-4">
                        <div class="row  fv3-contact">
                            <div class="col-4 my-2 text-center">
                                <span class="fa fa-phone ml-2"></span>
                            </div>
                            <div class="col-8">
                                <p>9812398340</p>
                                <p>9923541109</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="row fv3-contact">
                            <div class="col-4  text-center">
                                <span class="fa fa-home ml-2"></span>
                            </div>
                            <div class="col-8">
                                <p>Guru Nanak Dev University,
                                    <br>GT Road Amritsar</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-12 mx-auto">
                    
                    <!-- contact form grid -->
                    <div class="register-top1 py-lg-3">
                        <div class="title-sec-w3layouts_pvt text-center">
                            <h4 class="w3layouts_pvt-head">How Can We Help You?</h4>
                        </div>
                        <form class="register-wthree pt-md-5 pb-md-0 py-4">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>
                                            First name
                                        </label>
                                        <input class="form-control" type="text" placeholder="First Name" id="firstname" required>
                                    </div>
                                    <div class="col-md-6 mt-md-0 mt-4">
                                        <label>
                                            Last name
                                        </label>
                                        <input class="form-control" type="text" placeholder="Last Name" id="lastname" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-6">
                                        <label>
                                            Mobile
                                        </label>
                                        <input class="form-control" type="tel" maxlength="10" placeholder="xxxxxxxxxx" id="phoneno" required>
                                    </div>
                                    <div class="col-md-6 mt-md-0 mt-4">
                                        <label>
                                            Email
                                        </label>
                                        <input class="form-control" type="email" placeholder="example@email.com" id="email" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label>
                                            Your message
                                        </label>
                                        <textarea placeholder="Type your message here" class="form-control" id="message" required></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-md-12">
                                    <button type="button" class="btn btn-agile btn-block w-100 font-weight-bold text-uppercase bg-theme" onclick="contact()">Send</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!--  //register form grid ends here -->
                    <div class="border-pos-wthree border-exp"></div>
                </div>
            </div>
        </div>
    </section>
    <!-- //contact -->
    <!-- map -->
    <div class="map px-2">
        <iframe src="https://maps.google.com/maps?q=Guru%20Nanak%20Dev%20University,%20Amritsar&t=&z=13&ie=UTF8&iwloc=&output=embed"
                allowfullscreen></iframe>
    </div>
    <!-- // map -->
    
    <%@include file='footer.html' %>
    
    <!-- login modal -->
    <div class="modal fade" id="userLoginModal" tabindex="-1" role="dialog" aria-labelledby="exampleuserLoginModal"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header bg-theme1">
                    <h5 class="modal-title" id="exampleModalLabel">Login</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container" style="display:none" id="loginMsgDisplay">
                        <div class="row">
                            <div class="col-sm-1"></div>
                            <div class="col-sm-10" style="text-align: center">
                                <h5 style="padding: 2% 0% 2% 0%"><span id="loginMsgType"></span>  <span id="loginMsg"></span></h5>
                            </div>
                            <div class="col-sm-1"></div>
                        </div>
                    </div>
                    <form class="p-3">
                        <div class="form-group">
                            <label for="lusername" class="col-form-label">Username</label>
                            <input type="text" class="form-control" placeholder="Username" name="lusername" id="lusername"
                                required="">
                        </div>
                        <div class="form-group">
                            <label for="lpassword" class="col-form-label">Password</label>
                            <input type="password" class="form-control" placeholder="Password" name="lpassword" id="lpassword"
                                required="">
                        </div>
                        <div class="right-w3l">
                            <input type="button" class="form-control bg-theme" value="Login" onclick="userLoginLogic()">
                        </div>
                        <div class="row sub-w3l my-3">
                            <div class="col forgot-w3l text-right">
                                <a href="./forgotPassword.jsp" class="text-dark">Forgot Password?</a>
                            </div>
                        </div>
                        <p class="text-center dont-do">Don't have an account?
                            <a href="#" data-toggle="modal" data-target="#userSignupModal" class="text-dark">
                                <strong>Register Now</strong></a>
                        </p>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- //login modal -->
    
    <!-- register modal -->
    <div class="modal fade" id="userSignupModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel1"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header bg-theme1">
                    <h5 class="modal-title" id="exampleModalLabel1">Register</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container" style="display:none" id="signupMsgDisplay">
                        <div class="row">
                            <div class="col-sm-1"></div>
                            <div class="col-sm-10" style="text-align: center">
                                <h5 style="padding: 2% 0% 2% 0%"><span id="signupMsgType"></span>  <span id="signupMsg"></span></h5>
                            </div>
                            <div class="col-sm-1"></div>
                        </div>
                    </div>
                    <form class="p-3">
                        <div class="row">
                            <div class="col-sm">
                                <div class="form-group">
                                    <label for="username" class="col-form-label">Username</label>
                                    <input type="text" class="form-control" placeholder="Username" name="username" id="username"
                                        required="">
                                </div>
                            </div>
                            <div class="col-sm">
                                <div class="form-group">
                                    <label for="name" class="col-form-label">Name</label>
                                    <input type="text" class="form-control" placeholder="Name" name="name" id="name"
                                        required="">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-sm">     
                                <div class="form-group">
                                        <label for="email" class="col-form-label">Email</label>
                                        <input type="email" class="form-control" placeholder="Email" name="email" id="email"
                                            required="">
                                </div>
                            </div>
                            <div class="col-sm">
                                <div class="form-group">
                                    <label for="phoneno" class="col-form-label">Phone Number</label>
                                    <input type="tel" maxlength="10" class="form-control" placeholder="Phone Number" name="phoneno" id="phoneno"
                                        required="">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-sm">
                                <div class="form-group">
                                    <label for="gender" class="col-form-label">Gender</label>
                                        <select id="gender" class="form-control" name="gender" id="gender">
                                            <option>Male</option>
                                            <option>Female</option>
                                        </select>
                                </div>
                            </div>
                            <div class="col-sm">
                                <div class="form-group">
                                    <label for="primarylanguage" class="col-form-label">Primary Language</label>
                                        <select id="primarylanguage" class="form-control" name="primarylanguage" id="primarylanguage">
                                            <option>C</option>
                                            <option>C++</option>
                                            <option>Java</option>
                                            <option>Python</option>
                                        </select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-sm">
                                <div class="form-group">
                                    <label for="password1" class="col-form-label">Password</label>
                                    <input type="password" class="form-control" placeholder="Password" name="password1" id="password1"
                                        required="">
                                </div>
                            </div>
                            <div class="col-sm">
                                <div class="form-group">
                                    <label for="password2" class="col-form-label">Confirm Password</label>
                                    <input type="password" class="form-control" placeholder="Confirm Password" name="password2" id="password2"
                                        required="">
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="photo" class="col-form-label">Upload Profile Photo</label>
                            <input type="file" class="form-control" name="photo" id="photo"
                                required="">
                        </div>
                        <div class="right-w3l">
                            <input type="button" class="form-control bg-theme" value="Register" onclick="userSignupLogic()">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- //register modal -->
    
    <!-- js -->
    <script src="js/jquery-2.2.3.min.js"></script>
    
    <script src="js/move-top.js"></script>
    <script src="js/easing.js"></script>
    <script>
        jQuery(document).ready(function ($) {
            $(".scroll").click(function (event) {
                event.preventDefault();

                $('html,body').animate({
                    scrollTop: $(this.hash).offset().top
                }, 1000);
            });
        });
    </script>
    <!-- //end-smooth-scrolling -->
    <!-- smooth-scrolling-of-move-up -->
    <script>
        $(document).ready(function () {
           
            $().UItoTop({
                easingType: 'easeOutQuart'
            });

        });
    </script>
    <script src="js/SmoothScroll.min.js"></script>
    <!-- //smooth-scrolling-of-move-up -->
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/bootstrap.min.js"></script>
    <script>
        $('#userSignupModal').on('hide.bs.modal', function (e) {
            document.getElementById("username").value="";
            document.getElementById("name").value="";
            document.getElementById("email").value="";
            document.getElementById("password1").value="";
            document.getElementById("password2").value="";
            document.getElementById("phoneno").value="";
            document.getElementById("gender").value="Male";
            document.getElementById("primarylanguage").value="C";
            document.getElementById("photo").value="";
        }) 
        
        
        $('#userLoginModal').on('hide.bs.modal',function(e){
            document.getElementById("lusername").value="";
            document.getElementById("lpassword").value="";
            document.getElementById("loginMsgDisplay").style.display="none";
        })
        
       
        
    </script>
</body>

</html>