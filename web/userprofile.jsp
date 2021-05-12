<%@page import="utility.DBLoader"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Code Cloud User Profile</title>
    <%@include file="headerfiles.html" %>
    
    <script>
        function addFriendLogic(){
            var profileusername = document.getElementById("profileusername").value;
            console.log(profileusername); 
            
            var formdata = new FormData();
            formdata.append("requestto",profileusername);
            
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                        var response = JSON.parse(this.responseText);
                        if(response["type"]==="Error"){
                            alert(response["message"]);
                        }
                        else if(response["type"]==="Already Friend"){
                            alert(response["message"]);
                        }
                        else if(response["type"]==="Request Sent"){
                            document.getElementById("addFriendBtn").value="Pending Request";
                        }
                }
            };
            xmlhttp.open("POST","./addFriendServlet", true);
            xmlhttp.send(formdata);
        }
        
        function deleteFriendRequest(){
            var profileusername = document.getElementById("profileusername").value;
            console.log(profileusername); 
            
            var formdata = new FormData();
            formdata.append("requestto",profileusername);
            
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                        var response = JSON.parse(this.responseText);
                        if(response["type"]==="Success"){
                            document.getElementById("deleteFriendRequest").value="Add Friend";
                        }
                        else{
                            alert(response["message"]);
                        }
                }
            };
            xmlhttp.open("POST","./deleteFriendRequestFromProfileServlet", true);
            xmlhttp.send(formdata);
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
        .card{
            position: relative;
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
                                  <a class="dropdown-item" href="./viewFriendRequests.jsp">View Friend Requests</a>
                                  <a class="dropdown-item" href="./viewSentRequests.jsp">View Sent Requests</a>
                                  <a class="dropdown-item" href="./userLogout">Logout</a>
                                </div>
                            </div>
                    </div>
                </nav>
            </div>
        </header>
        <!-- //header --> 
        
        <%
            String profileusername = request.getParameter("username");
            try{
                ResultSet rs = DBLoader.executeSQl("select name,photo,email,primarylanguage from users where username=\""+profileusername+"\"");
                ResultSet friendset = DBLoader.executeSQl("select * from friends where requestfrom = '"+sessionusername.toString()+"' and requestto = '"+profileusername+"'");
                if(rs.next()){
                    String name = rs.getString("name");
                    String photo = rs.getString("photo");
                    String email = rs.getString("email");
                    String primarylanguage = rs.getString("primarylanguage");
        %>
                    
                    <section style="max-width: 1000px; margin: 0 auto; margin-top:30px; margin-bottom: 50px;">
                        <div class="card shadow my-4 mx-3">
                          <div class="row align-items-center px-3 py-3 py-md-2 justify-content-center justify-content-md-start">
                            <div class="col-12 col-md-3 my-1 text-center">
                              <img class="rounded-circle" style="width: 130px; height: 130px;" src="./myuploads/<%=photo%>" alt="Profile image cap">
                            </div>
                            <div class="col-12 col-md-3">
                              <p class="card-text text-center text-md-left font-md"><span class="font-weight-bold">Name: </span> <%=name%></p>
                              <p class="card-text text-center text-md-left font-md"><span class="font-weight-bold">Email: </span> <%=email%></p>
                              <p class="card-text text-center text-md-left font-md"><span class="font-weight-bold">Primary Language: </span> <%=primarylanguage%></p>
                              <input type="hidden" id="profileusername" value="<%=profileusername%>" />
                            </div>
                            <div class="col-12 col-md-6 d-flex justify-content-center justify-content-md-end d-flex mt-2">
                                        <%
                                            if(friendset.next()){
                                                String status = friendset.getString("status");
                                                if(status.equals("pending")){
                                        %>
                                             <!--<button class="btn mx-3 btn-lg" style="background-color: #17a2b8; color: white;">Accept</button>-->       
                                             <input type="button" class="btn mx-3 btn-lg" style="background-color: #17a2b8; color: white;" onclick="deleteFriendRequest()" id="deleteFriendRequest" value="Pending Request" />  
                                        <%
                                                }
                                                else{
                                        %>
                                                
                                             <input type="button" class="btn mx-3 btn-lg" style="background-color: #17a2b8; color: white;" value="Friends" /> 
                                        <%
                                                }
                                            }
                                            else{
                                        %>    
                                        
                                        <input type="button" onclick="addFriendLogic()" class="btn mx-3 btn-lg" id="addFriendBtn" style="background-color: #17a2b8; color: white;" value="Add Friend" />
                                        <%
                                            }
                                        %>
                            </div>
                          </div>
                        </div>
                    </section>
        <%            
                }
                else{
                    response.sendRedirect("./index.jsp");
                }
        %>
                   
        <% 
            }
            catch(Exception e){
                e.printStackTrace();
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

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
  <!--<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>-->