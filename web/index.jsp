<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <title>Code Cloud</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8" />
    <script>
        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);
            
        function hideURLbar() {
            window.scrollTo(0, 1);
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
        
        function searchuserlogic(){
            var keyword = document.getElementById("searchkeyword").value;
            if(keyword===""){
                document.getElementById("searchresults").innerHTML = "";
                return;
            }
            
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    var result = JSON.parse(this.responseText);
                    var property="type";
                    if(result.hasOwnProperty(property)){
                          alert("Login To View User Profile");
                    }
                    else{
                        var jsonarray = result["ans"];
                        var searchresults="";
                        for(var i=0;i<jsonarray.length;i++){
                            var jsonobj = jsonarray[i];
                            searchresults += "<p class='searchitem' onclick=\"gotouserprofile(\'"+jsonobj.username+"\')\">"+jsonobj.name+"</p>";
                        }
                        document.getElementById("searchresults").innerHTML = searchresults;
                    }
                }
            };
            xmlhttp.open("GET","./searchUserServlet?keyword="+keyword, true);
            xmlhttp.send();
            
        }
        function gotouserprofile(username){
            location.href="userprofile.jsp?username="+username;
        
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
    
    <style>
        
        .searchbar{
            position:absolute;
            top:60%;
            left:50%;
            transform: translate(-50%,-50%);
            z-index:10;
            width:500px!important;
        }
        #searchresults{
            position:absolute;
            top:calc(59% + 2.5rem);
            left:50%;
            transform: translate(-50%,0);
            z-index:10;
            max-height:220px;
            overflow-y:scroll;
            width:500px!important;
            background: white;
            z-index:10;
            
        }
        .searchitem{
            padding-left:10px;
            text-transform: capitalize;
            font-family: Source Sans Pro, sans-serif;
        }
        .searchitem:hover{
            background:#0d2865;
            color:white;
        }
        
        .mainpageheading{
            position:relative;
            top:-100px;
        }
        .mainHeading{
            letter-spacing: 2px!important;
            text-shadow: 2px 2px #4e4b4b;
        }
        .callbacks_tabs{
            z-index:9;
        }
        
        .languageIconsDiv{
            padding:2%;
            background:white;
            border-radius:5px;
        }
        
        .languageIconsDiv:hover{
            box-shadow: 10px 10px 5px 0px rgba(0,0,0,0.7)!important;
            transform:scale(1.1);
        }
        
        .languageIcons{
            height: 70px;
            width : 70px;
        }
        
        .languageIconsHeading{
            font-family: Source Sans Pro, sans-serif;
            font-size: 0.5rem;
        }
        
        @media screen and (max-width: 768px){
            #navbarSupportedContent{
                margin:0 auto;
            }
            .searchbar{
                width:250px!important;
            }
            #searchresults{
                width:250px!important;
                max-height:100px;
            }
        }
        
    </style>
</head>

<body>
    <!-- Slider -->
    <div class="w3-banner-info-w3ltd position-relative">
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
                            <li class="nav-item active  mr-lg-4 mt-lg-0 mt-sm-4 mt-3">
                                <a href="./index.jsp">Home</a>
                            </li>
                            <li class="nav-item  mr-lg-4 mt-lg-0 mt-sm-4 mt-3">
                                <a href="about.html">about</a>
                            </li>
                            <li class="nav-item dropdown mr-lg-4 my-lg-0 my-sm-4 my-3">
                                <a href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true"
                                    aria-expanded="false">
                                    View
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <a href="job_list.html">Friend Requests</a>
                                    <a href="job_single.html">Sent Requests</a>
                                    <a href="job_single.html">Friends</a>
                                </div>
                            </li>
                            <li class="nav-item mr-lg-4 my-lg-0 mb-sm-4 mb-3">
                                <a href="contact.html">contact</a>
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
                                <div class="dropdown-menu" aria-labelledby="usernameMenuButton">
                                  <a class="dropdown-item" href="./changePassword.jsp">Change Password</a>
                                  <a class="dropdown-item" href="./viewFriendRequests.jsp">View Friend Requests</a>
                                  <a class="dropdown-item" href="./viewSentRequests.jsp">View Sent Requests</a>
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
        <div class="slider" style="position:relative!important">
            <%  
                
                if(sessionusername!=null){
            %>
                    <div id="searchbarsection" class="searchbar">
                        <input type="text" placeholder="Search Users" id="searchkeyword" class="form-control" onkeyup="searchuserlogic()"/>
                    </div>
                    <div id="searchresults"></div>
            <%
                }
                else{
            %>
                    <div id="searchbarsection" class="searchbar">
                        <input type="text" placeholder="Login To Search Users And Make Friends" class="form-control" disabled="true"/>
                    </div>
                    <div id="searchresults"></div>
            <%
                }
            %>
            <ul class="rslides" id="slider">
                <li>
                    <div class="d-flex banner-w3pvt-bg1 common-bg">
                        <div class="mainpageheading d-flex mx-auto align-items-center justify-content-center flex-column">
                            <div class="bnr-w3pvt">
                                <h3 class="mainHeading">Code &nbsp; On &nbsp; Cloud</h3>
                                <br>
                                <div class="d-flex justify-content-between bnr-sub-txt align-items-center">
                                    <span></span>
                                    <p class="text-uppercase text-white">Make Friends And Share Code</p>
                                    <span></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="d-flex banner-w3pvt-bg2 common-bg">
                        <div class="mainpageheading d-flex mx-auto align-items-center justify-content-center flex-column">
                            <div class="bnr-w3pvt">
                                <h3 class="mainHeading" >Code &nbsp; On &nbsp; Cloud</h3>
                                <div class="d-flex justify-content-between bnr-sub-txt align-items-center">
                                    <span></span>
                                    <p class="text-uppercase text-white">Make Friends And Share Code</p>
                                    <span></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="d-flex banner-w3pvt-bg3 common-bg">
                        <div class="mainpageheading d-flex mx-auto align-items-center justify-content-center flex-column">
                            <div class="bnr-w3pvt">
                                <h3 class="mainHeading">Code &nbsp; On &nbsp; Cloud</h3>
                                <div class="d-flex justify-content-between bnr-sub-txt align-items-center">
                                    <span></span>
                                    <p class="text-uppercase text-white">Make Friends And Share Code</p>
                                    <span></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <!-- //Slider -->    
    <!--partners  -->
    <div class="w3ltdits-partners bg-theme" id="partners">
        <div class="container pt-4">
            <div class="title-wthree text-center">
                <h3 class="w3ltd-title">
                    You Can Code In Any Language Of Your Choice
                </h3>
            </div>
            <ul class="list-unstyled py-md-5 py-3 partners-icon text-center">
                
                <li>
                    <div class="container languageIconsDiv shadow p-3 mb-5 bg-body rounded">
                        <img class="img-fluid languageIcons" src="./images/javaLogo.png" />
                    </div>
                </li>
                <li>
                    <div class="container languageIconsDiv shadow p-3 mb-5 bg-body rounded">
                        <img class="img-fluid languageIcons" src="./images/cppLogo.png" />
                    </div>
                </li>
                <li>
                    <div class="container languageIconsDiv shadow p-3 mb-5 bg-body rounded">
                        <img class="img-fluid languageIcons" src="./images/cLogo.png" />
                    </div>
                </li>
                <li>
                    <div class="container languageIconsDiv shadow p-3 mb-5 bg-body rounded">
                        <img class="img-fluid languageIcons" src="./images/pythonLogo.png" />
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <!-- //partners -->
    <!-- about -->
    <section class="about-wthree py-3">
        <div class="container  py-sm-5">
            <div class="title-sec-w3layouts_pvt text-center">
                <span class="title-wthree">a world full of possibilities</span>
                <h4 class="w3layouts_pvt-head">allowing you to expand quickly.</h4>
            </div>
            <div class="row head-row-home">
                <div class="col-md-4 my-4 home-grid">
                    <span class="head-line"></span>
                    <span class="fa fa-info-circle" aria-hidden="true"></span>
                    <h4 class="home-title my-3">why choose us</h4>
                    <p> Pellentesque in ipsum id orci porta dapibus roined magna orem ipsum dolor sit amet,consetetur.</p>
                    <a href="about.html" class="btn wthree-bnr-btn">Read more</a>
                </div>
                <div class="col-md-4 my-4 home-grid">
                    <span class="head-line"></span>
                    <span class="fa fa-connectdevelop" aria-hidden="true"></span>
                    <h4 class="home-title my-3">what we do</h4>
                    <p> Pellentesque in ipsum id orci porta dapibus roined magna orem ipsum dolor sit amet,consetetur.</p>
                    <a href="about.html" class="btn wthree-bnr-btn">Read more</a>
                </div>
                <div class="col-md-4 my-4 home-grid">
                    <span class="fa fa-users" aria-hidden="true"></span>
                    <h4 class="home-title my-3">explore yourself</h4>
                    <p> Pellentesque in ipsum id orci porta dapibus roined magna orem ipsum dolor sit amet,consetetur.</p>
                    <a href="about.html" class="btn wthree-bnr-btn">Read more</a>
                </div>
            </div>
        </div>
    </section>
    <!-- //about -->
    <!-- services -->
    <section class="bg-theme position-relative" id="services">
        <div class="container">
            <div class="title-sec-w3layouts_pvt text-center">
                <span class="title-wthree text-white">a world full of possibilities</span>
                <h4 class="w3layouts_pvt-head">allowing you to expand quickly.</h4>
            </div>
            <div class="row head-row-home">
                <div class="col-lg-8">
                    <div class="row">
                        <div class="col-md-6 service-title my-sm-5 my-4">
                            <h4 class="home-title text-white">Job by Category</h4>
                            <p class="sec-4">Itaque earum rerum hic tenetur a sapiente delectusum hic
                                tenetur a
                                sapiente delectus reiciendis maiores alias consequatur.
                            </p>
                        </div>
                        <div class="col-md-6 service-title my-md-5">
                            <h4 class="home-title text-white">Job by Company</h4>
                            <p class="sec-4">Itaque earum rerum hic tenetur a sapiente delectusum hic
                                tenetur a
                                sapiente delectus reiciendis maiores alias consequatur.
                            </p>
                        </div>
                        <div class="col-md-6 service-title mt-md-0 mt-sm-5 mt-4">
                            <h4 class="home-title text-white">Job by Skill</h4>
                            <p class="sec-4">Itaque earum rerum hic tenetur a sapiente delectusum hic
                                tenetur a
                                sapiente delectus reiciendis maiores alias consequatur.
                            </p>
                        </div>
                        <div class="col-md-6 service-title mt-md-0 mt-sm-5 mt-4">
                            <h4 class="home-title text-white">Job by Opening</h4>
                            <p class="sec-4">Itaque earum rerum hic tenetur a sapiente delectusum hic
                                tenetur a
                                sapiente delectus reiciendis maiores alias consequatur.
                            </p>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="job_list.html" class="btn wthree-bnr-btn">Read more</a>
                    </div>
                </div>
                <div class="offset-lg-4"></div>
            </div>
        </div>
        <img src="images/services.jpg" alt="" class="img-fluid">
    </section>
    <!-- //services -->
    <!-- job roles -->
    <div class="wthreepvt-pos py-md-5 py-5" id="positions">
        <div class="container py-lg-5">
            <div class="wthreepvt-pos-row row  text-center">
                <div class="col-lg-4 col-sm-6 wthreepvt-pos-grids">
                    <div class="p-md-5 p-sm-3">
                        <span class="fa fa-check-square" aria-hidden="true"></span>
                        <h4 class="mt-2 mb-3">Computer & IT</h4>
                        <p>Itaque earum rerum hic tenetur a sapiente delectus reiciendis maiores alias consequatur aut</p>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6 wthreepvt-pos-grids  border-left border-right my-sm-0 my-5">
                    <div class="p-md-5 p-sm-3">
                        <span class="fa fa-suitcase" aria-hidden="true"></span>
                        <h4 class="mt-2 mb-3">Marketing</h4>
                        <p>Itaque earum rerum hic tenetur a sapiente delectus reiciendis maiores alias consequatur aut</p>
                    </div>
                </div>
                <div class="col-lg-4 wthreepvt-pos-grids">
                    <div class="p-md-5 p-sm-3">
                        <span class="fa fa-thumbs-up" aria-hidden="true"></span>
                        <h4 class="mt-2 mb-3">Insurance</h4>
                        <p>Itaque earum rerum hic tenetur a sapiente delectus reiciendis maiores alias consequatur aut</p>
                    </div>
                </div>
            </div>
            <div class="wthreepvt-pos-row border-top row text-center pb-lg-5 pt-md-0 pt-5 mt-md-0 mt-sm-5 mt-4">
                <div class="col-lg-4 col-sm-6 wthreepvt-pos-grids">
                    <div class="p-md-5 p-sm-3 col-label">
                        <span class="fa fa-thumb-tack" aria-hidden="true"></span>
                        <h4 class="mt-2 mb-3">Customer Service</h4>
                        <p>Itaque earum rerum hic tenetur a sapiente delectus reiciendis maiores alias consequatur aut</p>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6 wthreepvt-pos-grids mt-lg-0 mt-md-3 border-left border-right pt-sm-0 pt-5">
                    <div class="p-md-5 p-sm-3 col-label">
                        <span class="fa fa-external-link" aria-hidden="true"></span>
                        <h4 class="mt-2 mb-3">health care</h4>
                        <p>Itaque earum rerum hic tenetur a sapiente delectus reiciendis maiores alias consequatur aut</p>
                    </div>
                </div>
                <div class="col-lg-4 wthreepvt-pos-grids pt-md-0 pt-5">
                    <div class="p-md-5 p-sm-3 col-label">
                        <span class="fa fa-cog" aria-hidden="true"></span>
                        <h4 class="mt-2 mb-3">automotive</h4>
                        <p>Itaque earum rerum hic tenetur a sapiente delectus reiciendis maiores alias consequatur aut</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- //job roles -->
    <!-- services bottom -->
    <section class="bg-theme position-relative" id="services-bot">
        <div class="container-fluid px-0">
            <div class="title-sec-w3layouts_pvt text-center">
                <span class="title-wthree text-white">a world full of possibilities</span>
                <h4 class="w3layouts_pvt-head">allowing you to expand quickly.</h4>
            </div>
            <img src="images/services.jpg" alt="" class="img-fluid">
            <div class="row head-row-home mx-0">
                <div class="offset-5"></div>
                <div class="col-lg-5">
                    <div class="row">
                        <div class="col-md-6 service-title my-sm-5 my-4">
                            <h4 class="home-title text-white">Job by Category</h4>
                            <p class="sec-4">Itaque earum rerum hic tenetur a sapiente delectusum hic
                                tenetur a
                                sapiente delectus reiciendis maiores alias consequatur.
                            </p>
                        </div>
                        <div class="col-md-6 service-title my-md-5">
                            <h4 class="home-title text-white">Job by Company</h4>
                            <p class="sec-4">Itaque earum rerum hic tenetur a sapiente delectusum hic
                                tenetur a
                                sapiente delectus reiciendis maiores alias consequatur.
                            </p>
                        </div>
                        <div class="col-md-6 service-title mt-md-0 mt-sm-5 mt-4">
                            <h4 class="home-title text-white">Job by Skill</h4>
                            <p class="sec-4">Itaque earum rerum hic tenetur a sapiente delectusum hic
                                tenetur a
                                sapiente delectus reiciendis maiores alias consequatur.
                            </p>
                        </div>
                        <div class="col-md-6 service-title mt-md-0 mt-sm-5 mt-4">
                            <h4 class="home-title text-white">Job by Opening</h4>
                            <p class="sec-4">Itaque earum rerum hic tenetur a sapiente delectusum hic
                                tenetur a
                                sapiente delectus reiciendis maiores alias consequatur.
                            </p>
                        </div>
                    </div>
                    <div class="mt-4">
                        <a href="job_list.html" class="btn wthree-bnr-btn">Read more</a>
                    </div>
                </div>
                <div class="offset-2"></div>
            </div>
        </div>
    </section>
    <!-- //services bottom-->
    <!-- blog -->
    <section class="blog_w3ls py-lg-5">
        <div class="container py-5">
            <div class="title-sec-w3layouts_pvt text-center">
                <span class="title-wthree">a world full of possibilities</span>
                <h4 class="w3layouts_pvt-head">allowing you to expand quickly.</h4>
            </div>
            <div class="row head-row-home">
                <!-- blog grid -->
                <div class="col-lg-4 col-md-6 mt-sm-0 mt-4">
                    <div class="card border-0">
                        <div class="card-header p-0">
                            <a href="#exampleModal2" data-toggle="modal" aria-pressed="false" data-target="#exampleModal2"
                                role="button">
                                <img class="card-img-bottom" src="images/b1.jpg" alt="Card image cap">
                            </a>
                        </div>
                        <div class="card-body border-0 px-0">
                            <div class="blog_w3icon d-flex justify-content-between">
                                <span>
                                    By: Admin</span>
                                <span>
                                    20/6/2018</span>
                            </div>
                            <div class="pt-4">
                                <h5 class="blog-title card-title font-weight-bold">
                                    <a href="#exampleModal2" data-toggle="modal" aria-pressed="false" data-target="#exampleModal2"
                                        role="button">Cras ultricies ligula sed magna dictum porta auris blandita.</a>
                                </h5>
                                <p>At vero eos et accusam et justo duo dolores et ea rebum. Lorem ipsum dolor sit
                                    ametLorem ipsum dolor sit amet,sed diam nonumy.</p>
                            </div>
                            <button type="button" class="btn blog-btn wthree-bnr-btn" data-toggle="modal" aria-pressed="false"
                                data-target="#exampleModal2">
                                Read more
                            </button>
                        </div>
                    </div>
                </div>
                <!-- //blog grid -->
                <!-- blog grid -->
                <div class="col-lg-4 col-md-6 mt-md-0 mt-sm-5 mt-4">
                    <div class="card border-0">
                        <div class="card-header p-0">
                            <a href="#exampleModal3" data-toggle="modal" aria-pressed="false" data-target="#exampleModal3"
                                role="button">
                                <img class="card-img-bottom" src="images/b2.jpg" alt="Card image cap">
                            </a>
                        </div>
                        <div class="card-body border-0">
                            <div class="blog_w3icon d-flex justify-content-between">
                                <span>
                                    By: Admin</span>
                                <span>
                                    20/6/2018</span>
                            </div>
                            <div class="pt-4">
                                <h5 class="blog-title card-title font-weight-bold">
                                    <a href="#exampleModal3" data-toggle="modal" aria-pressed="false" data-target="#exampleModal3"
                                        role="button">Cras ultricies ligula sed magna dictum porta auris blandita.</a>
                                </h5>
                                <p>At vero eos et accusam et justo duo dolores et ea rebum. Lorem ipsum dolor sit
                                    ametLorem ipsum dolor sit amet,sed diam nonumy.</p>
                            </div>
                            <button type="button" class="btn blog-btn wthree-bnr-btn" data-toggle="modal" aria-pressed="false"
                                data-target="#exampleModal3">
                                Read more
                            </button>
                        </div>
                    </div>
                </div>
                <!-- //blog grid -->
                <!-- blog grid -->
                <div class="col-lg-4 col-md-6 mt-lg-0 mt-5 mx-auto">
                    <div class="card border-0">
                        <div class="card-header p-0">
                            <a href="#exampleModal4" data-toggle="modal" aria-pressed="false" data-target="#exampleModal4"
                                role="button">
                                <img class="card-img-bottom" src="images/b3.jpg" alt="Card image cap">
                            </a>
                        </div>
                        <div class="card-body border-0">
                            <div class="blog_w3icon d-flex justify-content-between">
                                <span>
                                    By: Admin</span>
                                <span>
                                    20/6/2018</span>
                            </div>
                            <div class="pt-4">
                                <h5 class="blog-title card-title font-weight-bold">
                                    <a href="#exampleModal4" data-toggle="modal" aria-pressed="false" data-target="#exampleModal4"
                                        role="button">Cras ultricies ligula sed magna dictum porta auris blandita.</a>
                                </h5>
                                <p>At vero eos et accusam et justo duo dolores et ea rebum. Lorem ipsum dolor sit
                                    ametLorem ipsum dolor sit amet,sed diam nonumy.</p>
                            </div>
                            <button type="button" class="btn blog-btn wthree-bnr-btn" data-toggle="modal" aria-pressed="false"
                                data-target="#exampleModal4">
                                Read more
                            </button>
                        </div>
                    </div>
                </div>
                <!-- //blog grid -->
            </div>
        </div>
    </section>
    <!-- //blog -->
    <!-- Footer -->
    <footer id="footer" class="py-sm-5 py-4 bg-theme">
        <div class="container">
            <div class="footer-top-w3ls">
                <h2><a href="index.html" class="navbar-brand">Code On Cloud</a></h2>
                <p class="text-white">
                    This is the platform where you can code in any language of your choice. You can
                    also save your codes and share with your friends on the platform. One can make any user his/her
                    friend by sending and aceepting the friend request. 
                </p>
            </div>
            <div class="row  pt-5">
                <div class="col-lg-3 col-sm-6 footer_grid1">
                    <h5>Address</h5>
                    <div class="d-flex align-items-center">
                        <span class="fa fa-building mr-4"></span>
                        <p>90 Street, landmark
                            <br>City State 34189.</p>
                    </div>
                    <div class="d-flex mt-3 align-items-center">
                        <span class="fa fa-building mr-4"></span>
                        <p>16 Street, landmark
                            <br>City State 74789.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6 mt-sm-0 mt-5">
                    <h5>Quick links</h5>
                    <ul class="list-unstyled quick-links">
                        <li>
                            <a href="./index.jsp">
                                <span class="fa fa-play"></span>Home</a>
                        </li>
                        <li>
                            <a href="#">
                                <span class="fa fa-play"></span>About</a>
                        </li>
                        <li>
                            <a href="#">
                                <span class="fa fa-play"></span>Job List</a>
                        </li>
                        <li>
                            <a href="#">
                                <span class="fa fa-play"></span>Job Single</a>
                        </li>
                        <li>
                            <a href="#">
                                <span class="fa fa-play"></span>Contact</a>
                        </li>
                    </ul>
                </div>

                <div class="col-lg-3 col-sm-6 mt-lg-0 mt-5">
                    <h5>Quick links</h5>
                    <ul class="list-unstyled quick-links">
                        <li>
                            <a href="index.html">
                                <span class="fa fa-play"></span>Home</a>
                        </li>
                        <li>
                            <a href="about.html">
                                <span class="fa fa-play"></span>About</a>
                        </li>
                        <li>
                            <a href="job_list.html">
                                <span class="fa fa-play"></span>Job List</a>
                        </li>
                        <li>
                            <a href="job_single.html">
                                <span class="fa fa-play"></span>Job Single</a>
                        </li>
                        <li>
                            <a href="contact.html">
                                <span class="fa fa-play"></span>Contact</a>
                        </li>
                    </ul>
                </div>
                <div class="col-lg-3 col-sm-6 mt-lg-0 mt-5">
                    <h5>Subscribe To Get Notifications</h5>
                    <form action="#" method="post">
                        <div class="form-group">
                            <input type="email" class="form-control  border-0 border-rounded" id="emailid" placeholder="Enter email"
                                name="email" required>
                        </div>
                        <div class="form-group">
                            <input type="Submit" class="form-control bg-light-theme  border-0 border-rounded" id="sub"
                                value="Submit" name="sub">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </footer>
    <!-- /Footer -->
    <div class="cpy-right text-center py-4">
        <p class="text-dark">© 2018 Recruit. All rights reserved | Design by
            <a href="http://w3layouts.com" class="text-theme"> W3layouts.</a>
        </p>
    </div>
    <!-- blog modal1 -->
    <div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel2"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header bg-theme1">
                    <h5 class="modal-title" id="exampleModalLabel2">Cras ultricies ligula sed magna dictum porta auris
                        blandita.</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-center">
                    <img src="images/b1.jpg" class="img-fluid" alt="" />
                    <p class="text-left my-4">
                        Quisque velit nisi, pretium ut lacinia in, elementum id enim. Curabitur non nulla sit amet nisl
                        tempus convallis quis ac
                        lectus. Cras ultricies ligula sed magna dictum porta.
                    </p>
                </div>
            </div>
        </div>
    </div>
    <!-- //blog modal1 -->
    <!-- blog modal2 -->
    <div class="modal fade" id="exampleModal3" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel3"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header bg-theme1">
                    <h5 class="modal-title" id="exampleModalLabel3">Cras ultricies ligula sed magna dictum porta auris
                        blandita.</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-center">
                    <img src="images/b2.jpg" class="img-fluid" alt="" />
                    <p class="text-left my-4">
                        Quisque velit nisi, pretium ut lacinia in, elementum id enim. Curabitur non nulla sit amet nisl
                        tempus convallis quis ac
                        lectus. Cras ultricies ligula sed magna dictum porta.
                    </p>
                </div>
            </div>
        </div>
    </div>
    <!-- //blog modal2 -->
    <!-- blog modal3 -->
    <div class="modal fade" id="exampleModal4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel4"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header bg-theme1">
                    <h5 class="modal-title" id="exampleModalLabel4">Cras ultricies ligula sed magna dictum porta auris
                        blandita.</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-center">
                    <img src="images/b3.jpg" class="img-fluid" alt="" />
                    <p class="text-left my-4">
                        Quisque velit nisi, pretium ut lacinia in, elementum id enim. Curabitur non nulla sit amet nisl
                        tempus convallis quis ac
                        lectus. Cras ultricies ligula sed magna dictum porta.
                    </p>
                </div>
            </div>
        </div>
    </div>
    <!-- //blog modal3-->
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
                                <a href="#" class="text-dark">Forgot Password?</a>
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
    <!-- Slider-JavaScript -->
    <script src="js/responsiveslides.min.js"></script>
    <script>
        $(function () {
            $("#slider, #slider1").responsiveSlides({
                auto: true,
                nav: false,
                speed: 1500,
                namespace: "callbacks",
                pager: true,
            });
        });
    </script>
    <!-- //Slider-JavaScript -->
    <!-- script for password match -->
    <script>
        window.onload = function () {
            document.getElementById("password1").onchange = validatePassword;
            document.getElementById("password2").onchange = validatePassword;
        }

        function validatePassword() {
            var pass2 = document.getElementById("password2").value;
            var pass1 = document.getElementById("password1").value;
            if (pass1 != pass2)
                document.getElementById("password2").setCustomValidity("Passwords Don't Match");
            else
                document.getElementById("password2").setCustomValidity('');
            //empty string means no validation error
        }
    </script>
    <!-- script for password match -->
    <!-- //js -->
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
            /*
            var defaults = {
                containerID: 'toTop', // fading element id
                containerHoverID: 'toTopHover', // fading element hover id
                scrollSpeed: 1200,
                easingType: 'linear' 
            };
            */

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