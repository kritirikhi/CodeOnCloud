<%@page import="utility.DBLoader"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8" />
    <script>
    </script>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.3.0/chart.min.js"></script>
    
    <%@include file="headerfiles.html" %>
    
    <script>
        function viewcode(filepath){
                console.log(filepath);
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        var response = this.responseText;
                        document.getElementById("codeDisplay").innerHTML=response;
                        $("#viewCodeModal").modal("show");
                    }
                };
                xmlhttp.open("GET","./all_users_data/"+filepath, true);
                xmlhttp.send();
            }
            function shareCode(scid,username){
                var scid = scid;
                var sharedwith = username;
                
                var formdata = new FormData();
                formdata.append("scid",scid);
                formdata.append("sharedwith",sharedwith);
                
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        var response = JSON.parse(this.responseText);
                        console.log(response);
                        $("#friendListModal").modal("hide");
                    }
                };
                xmlhttp.open("POST","./shareCodeServlet", true);
                xmlhttp.send(formdata);
                
            }
            function getAllFriendsList(scid){
                var scid = scid;
                var formdata=new FormData();
                formdata.append("scid",scid);
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        var response = JSON.parse(this.responseText);
                        console.log(response);
                        
                        var arr = response["ans"];
                        console.log(arr);
                        var output='<section style="max-width: 800px; margin: 0 auto;">';
                        for(var i=0;i<arr.length;i++){
                            var username = arr[i].requestto;
                            output+='<div class="card shadow my-4 mx-3">'
                                output+='<div class="row align-items-center px-3 py-3 py-md-2 justify-content-center justify-content-md-start">';
                                output+='<div class="col-12 col-md-4 my-1">'
                                    output+=username
                                output+='</div>'
                                
                                output+='<div class="col-12 col-md-2">'
                                output+='</div>'
                                
                                output+='<div class="col-12 col-md-6 d-flex justify-content-center justify-content-md-end d-flex mt-2">'
                                  output+='<button class="btn mx-3" style="background-color: #17a2b8; color: white;" onclick="shareCode('+scid+','+'\''+username+'\''+')">Share</button>'
                                output+='</div>'
                                output+='</div>'    
                            output+='</div>';
                        }
                        output+='</section>';
                        
                        document.getElementById("displayFriends").innerHTML=output;
                        $("#friendListModal").modal("show");
                    }
                };
                xmlhttp.open("POST","./getAllFriendsListServlet", true);
                xmlhttp.send(formdata);
            }
        
    </script>
    
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
         .view-show:hover{
            background:#e7e4e4!important;
        }
        .mutual-friends-wrapper{
            overflow-y: scroll; 
            height:250px;
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
        @media screen and (max-width: 767px){
            .mutual-friends-wrapper{
                height:unset;
            }
        }
        
    </style>
</head>

<%
        Object sessionusername = session.getAttribute("username");           
        if (sessionusername==null){
%>

<body>
            
    <div class="content container" style="margin-top:8%;margin-bottom:10%">
        <div style="text-align: center">
            <h1 class="errorMsg" >Login To View Your Profile</h1>
            <a href="./index.jsp" style="color:white; font-weight:bold">
                <div class="homeLink">HOME</div>
            </a>
        </div>
    </div>
    
<%
        }
        else{
%>
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
        
        <%
            try{
                ResultSet rs = DBLoader.executeSQl("select name,photo,email,primarylanguage from users where username=\""+sessionusername.toString()+"\"");
                if(rs.next()){
                    String name = rs.getString("name");
                    String photo = rs.getString("photo");
                    String email = rs.getString("email");
                    String primarylanguage = rs.getString("primarylanguage");
        %>
                    
                    <section style="max-width: 1200px; margin: 0 auto; margin-top:30px; margin-bottom: 50px;">
                        <div class="card shadow my-4 mx-3">
                          <div class="row align-items-center px-3 py-3 py-md-2 justify-content-center justify-content-md-start">
                            <div class="col-12 col-md-3 my-1 text-center">
                              <img class="rounded-circle" style="width: 130px; height: 130px;" src="./myuploads/<%=photo%>" alt="Profile image cap">
                            </div>
                            <div class="col-12 col-md-3">
                              <p class="card-text text-center text-md-left font-md"><span class="font-weight-bold">Name: </span> <%=name%></p>
                              <p class="card-text text-center text-md-left font-md"><span class="font-weight-bold">Email: </span> <%=email%></p>
                              <p class="card-text text-center text-md-left font-md"><span class="font-weight-bold">Primary Language: </span> <%=primarylanguage%></p>
                              <input type="hidden" id="sessionusername" value="<%=sessionusername.toString()%>" />
                            </div>
                            <div class="col-12 col-md-6 d-flex justify-content-center justify-content-md-end d-flex mt-2">
                                  
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
        
    <div class="container mb-5">
        <div class="row">
            <div class="col-sm-6 mutual-friends-wrapper">
                <h3 class="ml-3" style="color:#0d2865">Your Friends</h3>
                <section class="shadow" style="margin: 0 auto; margin-top:30px; margin-bottom: 50px; padding:2px">
                <%
                    try{ 
                        ResultSet mutualFriends = DBLoader.executeSQl("select * from friends where status='friends' and requestfrom='"+sessionusername.toString()+"'");
                        while(mutualFriends.next()){
                            String username = mutualFriends.getString("requestto");
                            ResultSet userphoto = DBLoader.executeSQl("select photo from users where username='"+username+"'");
                            String mutualphoto="";
                            if(userphoto.next()){
                                mutualphoto = userphoto.getString(1);
                            }
                %>
                        
                        <div class="card shadow my-4 mx-3">
                            <div class="row align-items-center px-3 py-3 py-md-2 justify-content-center justify-content-md-start">
                              <div class="col-12 col-md-3 my-1 text-center">
                                <img class="rounded-circle" style="width: 50px; height: 50px;" src="./myuploads/<%=mutualphoto%>" alt="Profile image cap">
                              </div>
                              <div class="col-12 col-md-6">
                                <p class="card-text text-center text-md-left font-md"><span class="font-weight-bold">Name: </span> <%=username%></p>
                                
                              </div>
                              <div class="col-12 col-md-3 d-flex justify-content-center justify-content-md-end d-flex mt-2">
                                  <a href="./userprofile.jsp?username=<%=username%>" class="btn mx-3 btn-sm" style="background-color: #17a2b8; color: white;">Profile</a>      
                              </div>
                           </div>
                        </div>
                
                <%
                        }
                    }
                    catch(Exception e){
                        e.printStackTrace();
                    }
                
                %>
                </section>
            </div>
                
             <%
             
                try{
                    
                    ResultSet cCount = DBLoader.executeSQl("select count(*) from savedcodes where lang='c' and username='"+sessionusername.toString()+"'");
                        int c_count=0,cpp_count=0,java_count=0,python_count=0;
                        if(cCount.next()){
                            c_count = Integer.parseInt(cCount.getString(1));
                        }

                        ResultSet cppCount = DBLoader.executeSQl("select count(*) from savedcodes where lang='cpp' and username='"+sessionusername.toString()+"'");
                        if(cppCount.next()){
                            cpp_count = Integer.parseInt(cppCount.getString(1));
                        }

                        ResultSet javaCount = DBLoader.executeSQl("select count(*) from savedcodes where lang='java' and username='"+sessionusername.toString()+"'");
                        if(javaCount.next()){
                            java_count = Integer.parseInt(javaCount.getString(1));
                        }

                        ResultSet pythonCount = DBLoader.executeSQl("select count(*) from savedcodes where lang='python' and username='"+sessionusername.toString()+"'");
                        if(pythonCount.next()){
                            python_count = Integer.parseInt(pythonCount.getString(1));
                        }
                    
                    
             %>
                <div class="col-sm-6">
                    <canvas id="myChart"></canvas>
                </div>
                
                <script>
                    let myChart = document.getElementById("myChart").getContext('2d');
                    let barChart = new Chart();

                    let massPopChart = new Chart(myChart,{
                       type:'bar',
                       data:{
                           labels:["C","C++","Python","Java"],
                           datasets:[{
                              label:'Code Contribution',
                              data:["<%=c_count%>","<%=cpp_count%>","<%=python_count%>","<%=java_count%>"],
                              backgroundColor:['rgba(255,99,132,0.6)','rgba(54,162,235,0.6)','rgba(255,206,86,0.6)','rgba(75,192,192,0.6)']

                           }]
                       },
                       options:{

                       }
                    });
                </script>
            
            
            <%
                    
                }
                catch(Exception e){
                    e.printStackTrace();
                }
             
             %>
            
            
        </div>
    </div>
             
             
             
    <div class="container">
        <h3 class="ml-3" style="color:#0d2865">Recent Saved Codes</h3>
        <section style="max-width: 1200px; margin: 0 auto; margin-bottom: 20%">
            <%  
        try{
            ResultSet rs = DBLoader.executeSQl("select * from savedcodes where username = '"+sessionusername.toString()+"' order by scid desc limit 5 ");
                while(rs.next()){
                    String lang=rs.getString("lang");
                    String title=rs.getString("title");
                    String filepath =rs.getString("filepath");
                    filepath=filepath.replace("\\","\\\\");
                    int scid = rs.getInt("scid");
                
    %>
    
                            <div class="card shadow my-4 mx-3">
                                <div class="row align-items-center px-3 py-3 py-md-2 justify-content-center justify-content-md-start">
                                    <div class="col-12 col-md-3 my-1 text-center">
                                        <%
                                            if (lang.equals("java")){
                                        %>
                                        
                                        <img class="rounded-circle" src="./images/javaLogo.png" style="width: 130px; height: 130px;" alt="Card image cap">
                                        
                                        <%
                                            }
                                            else if(lang.equals("python")){
                                        %>
                                        
                                        <img class="rounded-circle" src="./images/pythonLogo.png" style="width: 130px; height: 130px;" alt="Card image cap">
                                        
                                        <%
                                            }
                                            else if(lang.equals("c")){
                                        %>
                                        
                                        <img class="rounded-circle" src="./images/cLogo.png" style="width: 130px; height: 130px;" alt="Card image cap">
                                        
                                        
                                        <%
                                            }
                                            else if(lang.equals("cpp")){
                                        %>
                                        
                                        <img class="rounded-circle" src="./images/cppLogo.png" style="width: 130px; height: 130px;" alt="Card image cap">
                                        
                                        <% 
                                            }
                                        %>
                                      
                                    </div>
                                  <div class="col-12 col-md-3">
                                    <p class="card-text text-center text-md-left font-md"><span class="font-weight-bold">Language: </span> <%=lang%></p>
                                    <p class="card-text text-center text-md-left font-md"><span class="font-weight-bold">Title: </span> <%=title%></p>
                                  </div>
                                  <div class="col-12 col-md-6 d-flex justify-content-center justify-content-md-end d-flex mt-2">
                                      <button class="btn mx-3 btn-lg" style="background-color: #17a2b8; color: white;" onclick="viewcode('<%=filepath%>')">View Code</button>
                                    <button class="btn mx-3 btn-lg" style="background-color: #17a2b8; color: white;" onclick="getAllFriendsList(<%=scid%>)">Share Code</button>
                                  </div>
                                </div>
                            </div>
                                  
    <% 
                }
        }
        catch(Exception e){
            e.printStackTrace();
        }
    
    %>
        </section>
    </div>
    <%@include file="footer.jsp" %>   
    
    <!-- View Code Modal -->
    <div class="modal fade" id="viewCodeModal" tabindex="-1" role="dialog" aria-labelledby="viewCodeModal" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLongTitle">Code</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
              <p id="codeDisplay" style="white-space: pre-wrap"></p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
    <!-- view code modal -->
    
    <!-- Modal to show friend list -->
        <div class="modal fade" id="friendListModal" tabindex="-1" role="dialog" aria-labelledby="friendListModalTitle" aria-hidden="true">
          <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="friendListModalTitle">Share Code With Friends</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body" id="displayFriends">
                
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              </div>
            </div>
          </div>
        </div>
    <!-- modal to show friend list -->
    </body>
<%
    }
%>
    

<%@include file="footerfiles.html" %>

<script>
      
        $('#friendListModal').on('hide.bs.modal',function(e){
            document.getElementById("displayFriends").innerHTML="";
        })
      
  </script>

</html>
