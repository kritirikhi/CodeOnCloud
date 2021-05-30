<%
    Object sessionusername = session.getAttribute("username");           
    if (sessionusername==null){
        response.sendRedirect("./index.jsp");
    }             
    else{
%>

<%@page import="utility.DBLoader"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="zxx">
  <head>
      <title>Code On Cloud</title>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta charset="utf-8" />
        <script>
            function viewcode(filepath){
                console.log(filepath);
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        var response = this.responseText;
                        response = response.replace("<","&lt;");
                        response = response.replace(">","&gt;");
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
      
      <%@include file="headerfiles.html" %>
      
        <style>
          .font-md{
            font-size: 1.2rem;
          }
          .heading{
            text-align: center;
            font-size: 3rem;
            font-weight: 600;
            font-family: 'Source Sans Pro', sans-serif;
            color: #17a2b8;
          }
          .remove{
            animation: remove 1.5s ease-out;
          }
          .accept{
            animation: accept 1.5s ease-out;
          }
          .card{
            position: relative;
          }
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
        </div>
    <!-- //header -->
    
    <h1 class="heading my-3">Saved Codes</h1>
    
    <section style="max-width: 800px; margin: 0 auto; margin-bottom: 20%">
   
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
        
    <%  
        try{
            ResultSet rs = DBLoader.executeSQl("select * from savedcodes where username = '"+sessionusername.toString()+"' order by scid desc");
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

  <%@include file="footer.jsp" %>  
  </body>
  <%@include file="footerfiles.html" %>
  <script>
      
        $('#friendListModal').on('hide.bs.modal',function(e){
            document.getElementById("displayFriends").innerHTML="";
        })
      
  </script>
</html>


<%
    }
%>
