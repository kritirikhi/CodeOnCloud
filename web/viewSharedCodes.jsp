<%
    Object sessionusername = session.getAttribute("username");           
    if (sessionusername==null){
        response.sendRedirect("./index.jsp");
    }             
    else{
%>


<%@page import="utility.DBLoader"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html lang="zxx">

  <head>
      <title>Code On Cloud</title>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta charset="utf-8" />
      <script>
          
          function likeCode(shid){
              console.log(shid);
              var formdata = new FormData();
              formdata.append("shid",shid);
              var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        var response = JSON.parse(this.responseText);
                        if(response["type"]==="Success"){
                            window.location.reload()
                        }
                    }
                };
                xmlhttp.open("POST","./likeCodeServlet", true);
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
         
          .card{
            position: relative;
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
    
    <h1 class="heading my-3">Shared Codes</h1>
    
    <section style="max-width: 800px; margin: 0 auto; margin-bottom: 20%">
    <%  
        try{
            ResultSet rs = DBLoader.executeSQl("select * from sharedcodes where sharedwith='"+sessionusername.toString()+"'");  
                while(rs.next()){
                    String ownedby = rs.getString("ownedby");
                    int scid = rs.getInt("scid");
                    int shid = rs.getInt("shid");
                    
                    try{
                        ResultSet rs2 = DBLoader.executeSQl("select * from savedcodes where scid='"+scid+"'");
                        if(rs2.next()){
                            String filepath = rs2.getString("filepath");
                            String title = rs2.getString("title");
                            title=title.toUpperCase();
                            String codetext="";
                            FileReader fr = new FileReader(filepath);
                            int line = fr.read();
                            while (line != -1) {
                                System.out.print((char) line);
                                if((char)line == '\n'){
                                    System.out.println("jdfb");
                                    codetext+="<br>";
                                }
                                else{
                                    codetext+=(char) line;
                                }
                                line = fr.read();
                            }
                            fr.close(); 
    %>
                                  
                            <div class="container mb-3 card shadow">
                                <div class="container  brown-text">
                                    <div class="col-sm mt-5">
                                        <div class="blog-post">
                                            
                                            <!--style="color:#5c6acb"-->
                                            <h2 class="blog-post-title" style="color:#0d2865"><%=title%></h2>
                                            <p class="blog-post-meta">(June 30, 2020, 5:51 a.m.)<b>by</b> <%=ownedby%> </p>
                                            <hr>
                                            <div class="preview" style="font-size:18px">
                                              <p class="text-dark" style="text-align:justify"> <%=codetext%> </p>
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                </div>


                                <div class="container">
                                  <form class="form-group mt-4" action="bookmark" method="POST">
                                    <input type="hidden" name="csrfmiddlewaretoken" value="tDao2bX1oiTYS09JoOfwE7aXH2rt7gsPNnPRhASse7ivyCCCvXqBquHazQ4Mc5aW">
                                        <div class="form-group col-sm mb-2">
                                            <input type="hidden" class="form-control" id="postsno" name="postsno" value="1" >
                                        </div>
                                        <div class="form-group col-sm mb-2">
                                            <%
                                               try{
                                                ResultSet likeset = DBLoader.executeSQl("select * from liketable where likedby='"+sessionusername.toString()+"' and shid='"+shid+"'");
                                                ResultSet likeset2 = DBLoader.executeSQl("select count(*) from liketable where shid='"+shid+"'");
                                                int totalLikes=0;
                                                if(likeset2.next()){
                                                    totalLikes=likeset2.getInt(1);
                                                }
                                                if(likeset.next()){
                                            %>
                                            
                                                    <button type="button" id="likedBtn" class="btn btn-danger mb-4" onclick="likeCode(<%=shid%>)">Liked</button>
                                            
                                            
                                            <%        
                                                }
                                                else{
                                            %>
                                            
                                                    <button type="button" id="likeBtn" class="btn btn-danger mb-4" onclick="likeCode(<%=shid%>)" style="background: white; color:black">Like</button>
                                                    
                                            <%
                                                }
                                            %>
                                            
                                            <button type="button" id="totalLikes" class="btn mb-4" style="background:white; color:black" disabled><%=totalLikes%> <span>Likes</span></button>
                                                    
                                            <%
                                               }
                                               catch(Exception e){
                                                   
                                               }
                                            %>
                                          
                                        </div>       
                                  </form>
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
  <%@include file="footer.html" %>  
  </body>
  <%@include file="footerfiles.html" %>
</html>


<%
    }
%>
