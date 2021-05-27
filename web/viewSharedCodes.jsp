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
      <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
      <script>
            function viewcomments(shid){
                var formdata = new FormData();
                formdata.append("shid",shid);
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        var response = JSON.parse(this.responseText);
                        var arr = response["ans"];
                        console.log(arr);
                        
                        var output="";
                        output+='<section style="max-width: 800px; margin: 0 auto; margin-bottom: 20%">';
                        for(var i=0;i<arr.length;i++){
                            var username = arr[i].commentedby;
                            var commenttext = arr[i].commenttext;
                            
                            output+='<div class="card shadow my-4 mx-3">'
                                output+='<div class="row align-items-center px-3 py-3 py-md-2 justify-content-center justify-content-md-start">';
                                output+='<div class="col-12 col-md-3 my-1">'
                                    output+="By: "
                                    output+="<strong>"
                                    output+=username
                                    output+="</strong>"
                                output+='</div>'
                                
                                output+='<div class="col-12 col-md-9">'
                                output+='<p style="text-align: justify">'
                                    output+=commenttext
                                output+='</p>'
                                output+='</div>'
                                
                                output+='<div class="col-12 col-md-2 d-flex justify-content-center justify-content-md-end d-flex mt-2">'
                                output+='</div>'
                                output+='</div>'    
                            output+='</div>';
                            
                        }
                        output+='</section>'
                        
                        document.getElementById("commentsDisplay").innerHTML=output;
                        $("#viewCommentsModal").modal("show");
                    }
                };
                xmlhttp.open("POST","./viewcommentsServlet", true);
                xmlhttp.send(formdata); 
            }
          
            function addcomment(shid){
                var shid = shid
                var commenttext = document.getElementById("commenttext"+shid).value
                if(commenttext===""){
                    alert("Please Write The Comment");
                    return;
                }
                if(commenttext.length>400){
                    alert("Comment can't be too long");
                    return;
                }
                var formdata = new FormData()
                formdata.append("shid",shid)
                formdata.append("commenttext",commenttext)
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        var response=JSON.parse(this.responseText);
                        if(response["type"]==="Success"){
                            document.getElementById("commenttext"+shid).value="";
                            $("#addcommentSuccess").modal("show");
                        }
                        else{
                            document.getElementById("commentMessage").innerHTML=response["message"];
                            $("#addcommentFail").modal("show");
                        }
                    }
                };
                xmlhttp.open("POST","./addCommentServlet", true);
                xmlhttp.send(formdata);
            }
          
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
          .view-show:hover{
              background: #e7e4e4!important;
          }
          .like-color{
              color:red;
              vertical-align: middle;
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
    
    <section style="max-width: 1200px; margin: 0 auto; margin-bottom: 20%">
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
                            String absolutepath = request.getServletContext().getRealPath("/all_users_data");
                            filepath = absolutepath+"\\"+filepath;
                            String title = rs2.getString("title");
                            title=title.toUpperCase();
                            String codetext="";
                            FileReader fr = new FileReader(filepath);
                            int line = fr.read();
                            while (line != -1) {
                                codetext+=(char) line;
                                line = fr.read();
                            }
                            fr.close(); 
    %>
                                  
                            <div class="container mb-3 card shadow">
                                <div class="container  brown-text">
                                    <div class="col-sm mt-5">
                                        <div class="blog-post">
                                            <h2 class="blog-post-title" style="color:#0d2865"><%=title%></h2>
                                            <p class="blog-post-meta">(<%=rs.getDate("dateandtime")%> , <%=rs.getTime("dateandtime")%>) &nbsp;<b>by</b> &nbsp;<%=ownedby%> </p>
                                            <hr>
                                            <div class="preview" style="font-size:18px">
                                              <p class="text-dark" style="text-align:justify; white-space:pre-wrap"> <%=codetext%> </p>
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                </div>


                                <div class="container">
                                  <form class="form-group">
                                            <%
                                               try{
                                                ResultSet likeset = DBLoader.executeSQl("select * from liketable where likedby='"+sessionusername.toString()+"' and shid='"+shid+"'");
                                                ResultSet likeset2 = DBLoader.executeSQl("select count(*) from liketable where shid='"+shid+"'");
                                                int totalLikes=0;
                                                if(likeset2.next()){
                                                    totalLikes=likeset2.getInt(1);
                                                }
                                                String likeClassName="";
                                                if(likeset.next()){
                                                    likeClassName="fas";
                                                }
                                                else{
                                                    likeClassName="far";
                                                }
                                            %>
                                                   <div class="container">
                                                    <i class="<%=likeClassName%> fa-heart like-color" id="likedBtn" onclick="likeCode(<%=shid%>)"></i>
                                            
                                                    <button type="button" id="totalLikes" class="btn" style="background:white; color:black" disabled><%=totalLikes%> <span>Likes</span></button>
                                                    </div>
                                            <%
                                               }
                                               catch(Exception e){
                                                   
                                               }
                                            %>
                                    </form>
                                    <div class="container" style="position:relative">
                                        <label for="commenttext" >Post Your Comment Here</label>
                                        <input type="text" class="form-control" id="commenttext<%=shid%>" aria-describedby="commenttext" placeholder="Your Comment">
                                        <button type="button" class="btn btn-dark mt-3 mb-5" onclick="addcomment(<%=shid%>)">Comment</button>
                                        <button type="button" class="btn btn-dark mt-3 mb-5" style="position:absolute; right:15px" onclick="viewcomments(<%=shid%>)">View Comments</button>
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
  

    <!-- Comment add success Modal -->
    <div class="modal fade" id="addcommentSuccess" tabindex="-1" role="dialog" aria-labelledby="addcommentSuccess" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body" style="background:#99ff99">
              <span>Comment Added Successfully</span>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Comment add fail Modal -->
    <div class="modal fade" id="addcommentFail" tabindex="-1" role="dialog" aria-labelledby="addcommentFail" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body" style="background:#ff3333">
              <span id="commentMessage"></span>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
    
    
    <!-- View Comments Modal -->
    <div class="modal fade" id="viewCommentsModal" tabindex="-1" role="dialog" aria-labelledby="viewCommentsModal" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="viewCommentsModalTitle">Comments</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body" id="commentsDisplay">
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
  <%@include file="footer.html" %>  
  </body>
  <%@include file="footerfiles.html" %>
</html>


<%
    }
%>
