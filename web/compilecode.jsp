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
      <title>Compile Code</title>
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta charset="utf-8" />
      <script>
          
            function runCode(){
                var language = document.getElementById("language").value;
                var codetext = document.getElementById("codetext").value;
                var commandargs = document.getElementById("commandargs").value;
                
                if(language==="Java"){
                    language="java";
                    var formdata = new FormData();
                    formdata.append("language",language);
                    formdata.append("codetext",codetext);
                    formdata.append("commandargs",commandargs);
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.onreadystatechange = function() {
                        if (this.readyState == 4 && this.status == 200) {
                            document.getElementById("codeoutput").innerHTML = this.responseText;
                        }
                    };
                    xmlhttp.open("POST","./runJavaCodeServlet", true);
                    xmlhttp.send(formdata);
                }
                if(language==="C" || language==="C++"){
                    if(language==="C++"){
                        language="cpp";
                    }
                    if(language==="C"){
                        language="c";
                    }
                    var formdata = new FormData();
                    formdata.append("language",language);
                    formdata.append("codetext",codetext);
                    formdata.append("commandargs",commandargs);
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.onreadystatechange = function() {
                        if (this.readyState == 4 && this.status == 200) {
                            console.log(this.responseText);
                            document.getElementById("codeoutput").innerHTML = this.responseText;
                        }
                    };
                    xmlhttp.open("POST","./runCppCodeServlet", true);
                    xmlhttp.send(formdata);
                }
            }
          
            function compile_code_step1(){
                var codetext = document.getElementById("codetext").value;
                var language = document.getElementById("language").value;
                language = language.toLowerCase();
                
                if(codetext===""){
                    alert("enter code");
                    return;
                }
                
                if(language==="Java"){
                    if(!(codetext.includes("class"))){
                        alert("Enter Valid Java Code");
                        return;
                    }
                }
                if(language==="c++"){
                    language="cpp";
                }
                
                var formdata = new FormData();
                formdata.append("codetext",codetext);
                formdata.append("language",language);
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        console.log(this.responseText);
                        if(language==="java"){
                            var formdata2 = new FormData();
                            formdata2.append("language",language);
                            var xmlhttp2 = new XMLHttpRequest();
                            xmlhttp2.onreadystatechange = function() {
                                if (this.readyState == 4 && this.status == 200) {
                                    document.getElementById("codeoutput").innerHTML = this.responseText;
                                }
                            };
                            xmlhttp2.open("POST","./compile_code_step2_servlet", true);
                            xmlhttp2.send(formdata2);
                        }
                        else if(language==="c"){
                            var formdata2 = new FormData();
                            formdata2.append("language",language);
                            var xmlhttp2 = new XMLHttpRequest();
                            xmlhttp2.onreadystatechange = function() {
                                if (this.readyState == 4 && this.status == 200) {
                                    document.getElementById("codeoutput").innerHTML = this.responseText;
                                }
                            };
                            xmlhttp2.open("POST","./c_compile_code_step2_servlet", true);
                            xmlhttp2.send(formdata2);
                        }
                        else if(language==="cpp"){
                            language="cpp";
                            var formdata2 = new FormData();
                            formdata2.append("language",language);
                            var xmlhttp2 = new XMLHttpRequest();
                            xmlhttp2.onreadystatechange = function() {
                                if (this.readyState == 4 && this.status == 200) {
                                    document.getElementById("codeoutput").innerHTML = this.responseText;
                                }
                            };
                            xmlhttp2.open("POST","./cpp_compile_code_step2_servlet", true);
                            xmlhttp2.send(formdata2);
                        }
                    }
                };
                xmlhttp.open("POST","./compile_code_step1_servlet", true);
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
              background: #e7e4e4!important;
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
                                    <a href="about.html">about</a>
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
    
    <h1 class="heading my-3">Compile Code</h1>
    
    <section style="max-width: 800px; margin: 0 auto; margin-bottom: 20%">
        
        <form>
            <div class="form-group">
              <label for="language">Choose Language</label>
              <select class="form-control" id="language">
                <option>Java</option>
                <option>Python</option>
                <option>C</option>
                <option>C++</option>
              </select>
            </div>
            <div class="form-group">
              <label for="codetext">Write Code Here</label>
              <textarea class="form-control" id="codetext" rows="10"></textarea>
            </div>
            <button type="button" class="btn btn-primary" onclick="compile_code_step1()">Compile</button>
            <button type="button" class="btn btn-primary" onclick="runCode()">Run</button>
            <div class="form-group mt-5">
              <label for="commandargs">Enter space separated Command Line Arguments</label>
              <textarea class="form-control" id="commandargs" rows="2"></textarea>
            </div>
            <div class="form-group mt-5">
                <label for="codeoutput">Output</label>
                <textarea id="codeoutput" class="form-control" rows="10"></textarea>
            </div>
        </form>
    
    </section>
  <%@include file="footer.html" %>  
  </body>
  <%@include file="footerfiles.html" %>
</html>


<%
    }
%>