<%@page import="utility.DBLoader"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Code Cloud User Profile</title>
    <%@include file="headerfiles.html" %>
    
    <script>
        function addFriendLogic(){
            var sessionusername = document.getElementById("sessionusername").value;
            var profileusername = document.getElementById("profileusername").value;
            console.log(sessionusername);
            console.log(profileusername); 
        }
    </script>
</head>

<%
        Object sessionusername = session.getAttribute("username");           
        if (sessionusername==null){
%>

<body>
    
    <style>
        .content{
            background:#34495e;
            padding-top:50px;
            padding-bottom:50px;
        }
        .errorMsg{
            margin-bottom: 5%; 
            color: white;
        }
        .homeLink{
            background-color:#007bff ; 
            color:white; 
            display:inline-block; 
            padding:1% 2% 1% 2%;
            border-radius: 2px;
            
        }
        .homeLink:hover{
            background:white;
            color:#007bff;
        }
    </style>
            
    <div class="content container" style="margin-top:8%;margin-bottom:10%">
        <div style="text-align: center">
            <h1 class="errorMsg" >Login To View User's Profile</h1>
            <a href="./index.jsp" style="color:white; font-weight:bold">
                <div class="homeLink">HOME</div>
            </a>
        </div>
    </div>
    
</body>
<%
        }
        else{
%>
    <body>
        <!-- header -->
        <header style="position:relative; margin-bottom:0px">
            <div class="container">
                <nav class="navbar navbar-expand-lg navbar-light p-0">
                    <h1><a class="navbar-brand" href="./index.jsp">Code On Cloud</a></h1>
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
                                <a href="about.html">about</a>
                            </li>
                            <li class="nav-item dropdown mr-lg-4 my-lg-0 my-sm-4 my-3">
                                <a href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true"
                                    aria-expanded="false">
                                    Pages
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <a href="job_list.html">Job List</a>
                                    <a href="job_single.html">Job Single</a>
                                </div>
                            </li>
                            <li class="nav-item mr-lg-4 my-lg-0 mb-sm-4 mb-3">
                                <a href="contact.html">contact</a>
                            </li>
                        </ul>
                            <div class="dropdown">
                                <button class="btn dropdown-toggle w3ls-btn text-uppercase font-weight-bold d-block" type="button" id="usernameMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                  Welcome &nbsp;<%=(session.getAttribute("username")).toString()%>
                                </button>
                                <div class="dropdown-menu" aria-labelledby="usernameMenuButton">
                                  <a class="dropdown-item" href="./changePassword.jsp">Change Password</a>
                                  <a class="dropdown-item" href="./viewSentRequests.jsp">View Sent Requests</a>
                                  <a class="dropdown-item" href="./userLogout">Logout</a>
                                </div>
                            </div>
                    </div>
                </nav>
            </div>
        </header>
        <!-- //header --> 
        <style>
                    .profileCard{
                            margin-bottom:10%; 
                            margin-top:2%;
                        }
                        .cardContent{
                            background:#34495e;
                        }
                        .userdetail{
                            font-weight: 600;
                            font-family: Source Sans Pro, sans-serif;
                            letter-spacing: 2px;
                            font-size: 14px; 
                            color:white;
                        }
                        .addFriendBtn{
                            position: absolute; 
                            bottom:2%;
                            background:gba(65, 216, 209, 0.82);
                            color:white;
                        }
                        .addFriendBtn:hover{
                            background:white;
                            color:rgba(65, 216, 209, 0.82);
                        }
                        
                    </style>

        
        <%
            String profileusername = request.getParameter("username");
            try{
                ResultSet rs = DBLoader.executeSQl("select name,photo,email,primarylanguage from users where username=\""+profileusername+"\"");
                if(rs.next()){
                    String name = rs.getString("name");
                    String photo = rs.getString("photo");
                    String email = rs.getString("email");
                    String primarylanguage = rs.getString("primarylanguage");
        %>
                    
                    <div class="container profileCard">
                        <div class="card mb-3 cardContent" style="max-width:100%">
                            <div class="row g-0">
                                <div class="col-md-4" style="height:200px">
                                    <img src="./myuploads/<%=photo%>" style="height:100%;width:100%"/>
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="userdetail">Name : <span style="text-transform: capitalize;"><%=name%></span></h5>
                                      <p class="userdetail">Email : <%=email%></p>
                                      <p class="userdetail">Primary Language : <%=primarylanguage%></p>
                                    
                                      <input type="hidden" id="profileusername" value="<%=profileusername%>" />
                                      <input type="hidden" id="sessionusername" value='<%=session.getAttribute("username").toString()%>' />
                                      <button type="button" onclick="addFriendLogic()" class="btn btn-info addFriendBtn"> Add Friend </Button>
                                    
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
        <%            
                }
                else{
                    response.sendRedirect("./index.jsp");
                }
        %>
                   
        <% 
            }
            catch(Exception e){
        %>
                <style>
                    .content{
                        background:#34495e;
                        padding-top:50px;
                        padding-bottom:50px;
                    }
                    .errorMsg{
                        margin-bottom: 5%; 
                        color: white;
                    }
                    .homeLink{
                        background-color:#007bff ; 
                        color:white; 
                        display:inline-block; 
                        padding:1% 2% 1% 2%;
                        border-radius: 2px;

                    }
                    .homeLink:hover{
                        background:white;
                        color:#007bff;
                    }
                </style>
            
                <div class="content container" style="margin-top:8%;margin-bottom:10%">
                    <div style="text-align: center">
                        <h1 class="errorMsg" >Server Error</h1>
                        <a href="./index.jsp" style="color:white; font-weight:bold">
                            <div class="homeLink">HOME</div>
                        </a>
                    </div>
                </div>
        
        <%
            }
        %>
 
    <%@include file="footer.html" %>    
    </body>
<%
    }
%>


<%@include file="footerfiles.html" %>

</html>