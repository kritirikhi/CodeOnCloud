<!--Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->

<!DOCTYPE html>
<html lang="zxx">

<head>
    <title>About</title>
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
                            <li class="nav-item active  mr-lg-4 mt-lg-0 mt-sm-4 mt-3">
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
                            <li class="nav-item mr-lg-4 my-lg-0 mb-sm-4 mb-3">
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
            <li class="breadcrumb-item active text-white font-weight-bold" aria-current="page">About Us</li>
        </ol>
    </nav>
    <!-- //breadcrumbs -->
    
    <!-- about -->
    <section class="about-wthree py-3">
        <div class="container  py-sm-5">
            <div class="title-sec-w3layouts_pvt text-center">
                <span class="title-wthree">A Flexible And Accessible Platform for Coders</span>
                <h4 class="w3layouts_pvt-head">allowing you to code in multiple languages at one time easily</h4>
            </div>
            <div class="row head-row-home">
                <div class="col-md-4 my-4 home-grid">
                    <span class="head-line"></span>
                    <span class="fa fa-info-circle" aria-hidden="true"></span>
                    <h4 class="home-title my-3">why choose us</h4>
                    <p style="text-align: justify">If you are a person who wants to code and share the code with multiple users at one 
                        time then you are at right place. We provide you the platform where you can code 
                        in any language of your choice at your ease and you can also share the code with 
                        other users by sending them the friend request and sharing your code with them.
                    </p>
                </div>
                <div class="col-md-4 my-4 home-grid">
                    <span class="head-line"></span>
                    <span class="fa fa-connectdevelop" aria-hidden="true"></span>
                    <h4 class="home-title my-3">what we do</h4>
                    <p style="text-align: justify"> 
                        We provide you the best coding experience which you want while coding. 
                        The code editor is quite simple. You just have to click on the compile code 
                        option under your name at top right corner of the navbar and then 
                        you just have to select the language of your own choice and 
                        then you can compile , run and save your code.
                    </p>
                </div>
                <div class="col-md-4 my-4 home-grid">
                    <span class="fa fa-users" aria-hidden="true"></span>
                    <h4 class="home-title my-3">explore yourself</h4>
                    <p style="text-align: justify">
                        Now You will be able to explore various coding languages. You can learn and 
                        practice coding in multiple languages and also you can get ratings for your 
                        code from other users. The rating involves likes, comments etc. This rating will 
                        be given only by your friends at out platform. So you can improve yourself in any
                        language of your choice.
                    </p>
                </div>
            </div>
        </div>
    </section>
    <!-- //about -->
    
    <%@ include file='footer.html' %>
    
    <!-- js -->
    <script src="js/jquery-2.2.3.min.js"></script>
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
</body>

</html>