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
            function rejectFriendRequest(fid,btn){
                var formdata = new FormData();
                formdata.append("fid",fid);
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        var result = JSON.parse(this.responseText);
                        
                        if(result["type"]==="Success"){
                            handleReject(btn);
                        }
                    }
                };
                xmlhttp.open("POST","./rejectFriendRequestServlet", true);
                xmlhttp.send(formdata);
            }
            
            function acceptFriendRequest(fid,btn){
                var formdata = new FormData();
                formdata.append("fid",fid);
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        var result = JSON.parse(this.responseText);
                        if(result["type"]==="Success"){
                            handleAccept(btn);
                        }
                        else{
                            alert(result["message"]);
                        }
                    }
                };
                xmlhttp.open("POST","./acceptFriendRequestServlet", true);
                xmlhttp.send(formdata);
            }
            
            addEventListener("load", function () {
                setTimeout(hideURLbar, 0);
            }, false);

            function hideURLbar() {
                window.scrollTo(0, 1);
            }

            function handleReject(btn) {
              const card = btn.closest('.card');
              card.classList.add('remove');
              setTimeout(() => {
                card.classList.add('d-none');
              }, 1000);
            }

            function handleAccept(btn) {
              const card = btn.closest('.card');
              card.classList.add('accept');
              setTimeout(() => {
                card.classList.add('d-none');
              }, 1000);
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
          @keyframes accept {
            from {
              right: 0;
            }
            to {
              right: 200%;
            }
          }
          @keyframes remove {
            from {
              left: 0;
            }
            to {
              left: 200%;
            }
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
                                      <a class="dropdown-item" href="./userLogout">Logout</a>
                                    </div>
                                </div>
                        </div>
                    </nav>
                </div>
            </header>
        </div>
    <!-- //header -->
    
    <h1 class="heading my-3">Friend Requests</h1>
    
    <section style="max-width: 800px; margin: 0 auto; margin-bottom: 20%">
    <%  
        try{
            ResultSet rs = DBLoader.executeSQl("select * from friends where requestto='"+sessionusername.toString()+"' and status='pending'");
            
                while(rs.next()){
                    String user = rs.getString("requestfrom");
                    int fid = rs.getInt("fid");
                    try{
                        ResultSet rs2 = DBLoader.executeSQl("select * from users where username='"+user+"'");
                        if(rs2.next()){
                            String photo = rs2.getString("photo");
                            String name = rs2.getString("name");
                            String gender = rs2.getString("gender");
    %>
    
                            <div class="card shadow my-4 mx-3">
                                <div class="row align-items-center px-3 py-3 py-md-2 justify-content-center justify-content-md-start">
                                  <div class="col-12 col-md-3 my-1 text-center">
                                      <img class="rounded-circle" style="width: 130px; height: 130px;" src="./myuploads/<%=photo%>" alt="Card image cap">
                                  </div>
                                  <div class="col-12 col-md-3">
                                    <p class="card-text text-center text-md-left font-md"><span class="font-weight-bold">Name: </span> <%=name%></p>
                                    <p class="card-text text-center text-md-left font-md"><span class="font-weight-bold">Gender: </span> <%=gender%></p>
                                  </div>
                                  <div class="col-12 col-md-6 d-flex justify-content-center justify-content-md-end d-flex mt-2">
                                    <button class="btn mx-3 btn-lg" style="background-color: #17a2b8; color: white;" onclick="acceptFriendRequest(<%=fid%>,this)">Accept</button>
                                    <button class="btn mx-3 btn-danger btn-lg" onclick="rejectFriendRequest(<%=fid%>,this)">Reject</button>
                                  </div>
                                </div>
                            </div>
        
        
        
    <%
                        }
                    }
                    catch(Exception e2){
                        e2.printStackTrace();
                    }
                }
            
        }
        catch(Exception e){
            e.printStackTrace();
        }
    
    %>
    </section>
<!--    <section style="max-width: 800px; margin: 0 auto;">
      <div class="card shadow my-4 mx-3">
        <div class="row align-items-center px-3 py-3 py-md-2 justify-content-center justify-content-md-start">
          <div class="col-12 col-md-3 my-1 text-center">
            <img class="rounded-circle" style="width: 130px; height: 130px;" src="./test.jpeg" alt="Card image cap">
          </div>
          <div class="col-12 col-md-3">
            <p class="card-text text-center text-md-left font-md"><span class="font-weight-bold">Name: </span> Bharat</p>
            <p class="card-text text-center text-md-left font-md"><span class="font-weight-bold">Gender: </span> Male</p>
          </div>
          <div class="col-12 col-md-6 d-flex justify-content-center justify-content-md-end d-flex mt-2">
            <button class="btn mx-3 btn-lg" style="background-color: #17a2b8; color: white;" onclick="handleAccept(this)">Accept</button>
            <button class="btn mx-3 btn-danger btn-lg" onclick="handleReject(this)">Reject</button>
          </div>
        </div>
      </div>

      <div class="card shadow my-4 mx-3">
        <div class="row align-items-center px-3 py-3 py-md-2 justify-content-center justify-content-md-start">
          <div class="col-12 col-md-3 my-1 text-center">
            <img class="rounded-circle" style="max-width: 130px;" src="https://lh3.googleusercontent.com/proxy/XuMNMYmhrurh0gKIhhb_tiX4H9nY5P7YN77H96R-egkyHwZWwFzp85KW7QxoTH-6CVnHodT-yqE2A8JiQeGidRlC7K4PlM6FGeZycBr5Ugh9Ya8pcBI5kF0" alt="Card image cap">
          </div>
          <div class="col-12 col-md-3">
            <p class="card-text text-center text-md-left font-md"><span class="font-weight-bold">Name: </span> Bharat</p>
            <p class="card-text text-center text-md-left font-md"><span class="font-weight-bold">Gender: </span> Male</p>
          </div>
          <div class="col-12 col-md-6 d-flex justify-content-center justify-content-md-end d-flex mt-2">
            <button class="btn mx-3 btn-lg" style="background-color: #17a2b8; color: white;" onclick="handleAccept(this)">Accept</button>
            <button class="btn mx-3 btn-danger btn-lg" onclick="handleReject(this)">Reject</button>
          </div>
        </div>
      </div>
    </section>-->
  <%@include file="footer.html" %>  
  </body>
  <%@include file="footerfiles.html" %>
</html>


<%
    }
%>
