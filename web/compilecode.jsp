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
            let editor;

            window.onload = function() {
                console.log("in editor onload function")
                editor = ace.edit("codetext");
                editor.setTheme("ace/theme/monokai");
                editor.session.setMode("ace/mode/java");
            }
            
            function changeTheme(){
                var theme = document.getElementById("theme").value;
                console.log(theme);
                if(theme==="Dark"){
                    document.getElementById("commandargs").style.background="#272822";
                    document.getElementById("commandargs").style.color="white";
                    document.getElementById("codeoutput").style.background="#272822";
                    document.getElementById("codeoutput").style.color="white";
                    editor.setTheme("ace/theme/monokai");
                }
                else if(theme==="Light"){
                    document.getElementById("commandargs").style.background="white";
                    document.getElementById("commandargs").style.color="black";
                    document.getElementById("codeoutput").style.background="white";
                    document.getElementById("codeoutput").style.color="black";
                    editor.setTheme("ace/theme/clouds");
                }
            }

            function changeLanguage() {
                console.log("change lang func");
                var language = document.getElementById("language").value;
                if(language == 'C' || language == 'C++'){
                    console.log("c")
                    editor.session.setMode("ace/mode/c_cpp");
                }
                else if(language == 'Python'){
                    console.log("python")
                    editor.session.setMode("ace/mode/python");
                }    
                else if(language == 'Java'){
                    console.log("java")
                    editor.session.setMode("ace/mode/java");
                }

            }
            
            function saveCode(){
                var codeTitle = document.getElementById("saveCodeTitle").value;                
                var language = document.getElementById("language").value;
                language=language.toLowerCase();
                
                if(codeTitle===""){
                    alert("Please Write The Code");
                    return;
                }
                if(codeTitle.length>300){
                    alert("Title can't be too long");
                    return;
                }
                
                if(language==="c++"){
                    language="cpp";
                }
                
                var formdata = new FormData();
                formdata.append("language",language);
                formdata.append("codeTitle",codeTitle);
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                        var response = JSON.parse(this.responseText);
                        if(response["type"]==="Success"){
                            document.getElementById("saveCodeMessage").style.display="block";
                            document.getElementById("saveCodeMessage").style.background="#99ff99";
                            document.getElementById("saveCodeMessageDisplay").innerHTML=response["message"];
                            
                            setTimeout(function(){
                                console.log("y sabe")
                                document.getElementById("saveCodeMessage").style.display="none";
                                $("#saveCodeModal").modal("hide");
                            }, 2000); 
                        }
                        else if(response["type"]==="Error"){
                            document.getElementById("saveCodeMessage").style.display="block";
                            document.getElementById("saveCodeMessage").style.background="#ff3333";
                            document.getElementById("saveCodeMessageDisplay").innerHTML=response["message"];
                            
                            setTimeout(function(){
                                document.getElementById("saveCodeMessage").style.display="none";
                                $("#saveCodeModal").modal("hide");
                            }, 2000); 
                        }
                    }
                };
                xmlhttp.open("POST","./saveCodeServlet", true);
                xmlhttp.send(formdata);
                
            }
            function runCode(){
                var language = document.getElementById("language").value;
                var codetext = editor.getSession().getValue();
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
                            console.log(this.responseText);
                            document.getElementById("codeoutput").innerHTML = this.responseText;
                        }
                    };
                    xmlhttp.open("POST","./runJavaCodeServlet", true);
                    xmlhttp.send(formdata);
                }
                else if(language==="C" || language==="C++"){
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
                            document.getElementById("codeoutput").innerHTML = this.responseText;
                        }
                    };
                    xmlhttp.open("POST","./runCppCodeServlet", true);
                    xmlhttp.send(formdata);
                }
                else if(language==="Python"){
                    language="python";
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
                    xmlhttp.open("POST","./runPythonCodeServlet", true);
                    xmlhttp.send(formdata);
                }
            }
          
            function compile_code_step1(){
                var codetext = editor.getSession().getValue();
                var language = document.getElementById("language").value;
                language = language.toLowerCase();
                
                if(codetext===""){
                    alert("enter code");
                    return;
                }
                
                if(language==="java"){
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
                        if(language==="java"){
                            var formdata2 = new FormData();
                            formdata2.append("language",language);
                            var xmlhttp2 = new XMLHttpRequest();
                            xmlhttp2.onreadystatechange = function() {
                                if (this.readyState == 4 && this.status == 200) {
                                    document.getElementById("codeoutput").innerHTML = this.responseText;
                                    var s1=this.responseText
                                    var s2="File Saved And Compiled Successfully";
                                    s1=s1.trim();
                                    s2=s2.trim();
                                    if(s1==s2){
                                        document.getElementById("runBtn").disabled=false;
                                        document.getElementById("saveBtn").style.display="inline-block";
                                        document.getElementById("saveBtn").disabled=false;
                                    }
                                    else{
                                        document.getElementById("runBtn").disabled=true;
                                        document.getElementById("saveBtn").disabled=true;
                                    }
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
                                    var s1=this.responseText
                                    var s2="File Saved And Compiled Successfully";
                                    s1=s1.trim();
                                    s2=s2.trim();
                                    if(s1==s2){
                                        document.getElementById("runBtn").disabled=false;
                                        document.getElementById("saveBtn").style.display="inline-block";
                                        document.getElementById("saveBtn").disabled=false;
                                    }
                                    else{
                                        document.getElementById("runBtn").disabled=true;
                                        document.getElementById("saveBtn").disabled=true;
                                    }
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
                                    var s1=this.responseText
                                    var s2="File Saved And Compiled Successfully";
                                    s1=s1.trim();
                                    s2=s2.trim();
                                    if(s1==s2){
                                        document.getElementById("runBtn").disabled=false;
                                        document.getElementById("saveBtn").style.display="inline-block";
                                        document.getElementById("saveBtn").disabled=false;
                                    }
                                    else{
                                        document.getElementById("runBtn").disabled=true;
                                        document.getElementById("saveBtn").disabled=true;
                                    }
                                }
                            };
                            xmlhttp2.open("POST","./cpp_compile_code_step2_servlet", true);
                            xmlhttp2.send(formdata2);
                        }
                        else if(language==="python"){
                            document.getElementById("codeoutput").innerHTML = "File Saved Successfully";
                            var s1=this.responseText
                            var s2="success";
                            s1=s1.trim();
                            s2=s2.trim();
                            if(s1==s2){
                                document.getElementById("runBtn").disabled=false;
                                document.getElementById("saveBtn").style.display="inline-block";
                                document.getElementById("saveBtn").disabled=false;
                            }
                            else{
                                document.getElementById("runBtn").disabled=true;
                                document.getElementById("saveBtn").disabled=true;
                            }
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
          .textarea-for-code{
              resize:none;
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
    
    
    <section class="mt-2" style="max-width: 1350px; margin: 0 auto; margin-bottom: 20%; padding: 5px;">
        <form>
            <div class="row" style="align-items: center">
                <div class="col-12 col-md-6">
                    <div class="form-group" style="display: inline-block">
                      <label for="language" class="font-weight-bold">Choose Language</label>
                      <select class="form-control" id="language" onchange="changeLanguage()">
                        <option>Java</option>
                        <option>Python</option>
                        <option>C</option>
                        <option>C++</option>
                      </select>
                    </div>
                    <div class="form-group ml-3" style="display:inline-block">
                      <label for="theme" class="font-weight-bold">Change Theme</label>
                      <select class="form-control" id="theme" onchange="changeTheme()">
                        <option>Dark</option>
                        <option>Light</option>
                      </select>
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <div class="d-flex flex-md-row-reverse">
                        <button type="button" id="saveBtn" style="display:none; background-color:#0d2865; border: 1px solid #0d2865" class="btn btn-success mx-3" data-toggle="modal" data-target="#saveCodeModal">
                          Save
                        </button>
                        <button type="button" class="btn btn-danger mx-3" onclick="runCode()" id="runBtn" disabled>Run</button>
                        <button type="button" class="btn btn-info mx-3" onclick="compile_code_step1()">Compile</button>
                    </div>
                </div>
            </div>
<!--            <div class="form-group">
              <label for="codetext" class="font-weight-bold">Write Code Here</label>
              <textarea class="form-control textarea-for-code" id="codetext" rows="12" spellcheck="false"></textarea>
            </div>-->
            
            <div class="editor mt-2" id="codetext" style="height:360px;"></div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="commandargs" class="font-weight-bold">Enter space separated Command Line Arguments</label>
                        <textarea class="form-control textarea-for-code" id="commandargs" rows="4" spellcheck="false" style="background-color:#272822; color:white"></textarea>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="codeoutput" class="font-weight-bold">Output</label>
                        <textarea id="codeoutput" class="form-control textarea-for-code" rows="4" readonly style="background-color:#272822; color:white"></textarea>
                    </div>
                </div>
            </div>
        </form>
    </section>
    
    <!-- Modal for input title for save code-->
    <div class="modal fade" id="saveCodeModal" tabindex="-1" role="dialog" aria-labelledby="saveCodeModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="saveCodeLabel">Save Code</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                      <div class="container" id="saveCodeMessage" style="text-align:center;padding-top:5px; padding-bottom:5px; display:none"><b id="saveCodeMessageDisplay"></b></div>
                      <label for="saveCodeTitle" id="saveCodeTitleLabel">Enter Title For The Code</label>
                      <input type="text" id="saveCodeTitle" class="form-control"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="saveCode()">Save changes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- modal close -->
    
  <%@include file="footer.html" %>  
  </body>
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="js/lib/ace.js"></script>
  <script src="js/lib/theme-monokai.js"></script>
  
  <%@include file="footerfiles.html" %>
  <script>
        $('#saveCodeModal').on('hide.bs.modal',function(e){
            document.getElementById("saveCodeTitle").value="";
            document.getElementById("saveCodeMessage").style.display="none";
        })
        
//        Array.from(document.getElementsByClassName("textarea-for-code")).forEach(el=>el.addEventListener("keydown",function(e){
//          
//            if(e.which==9){
//                e.preventDefault();
//                var cursorPos = e.target.selectionStart;
//                e.target.value=e.target.value.substr(0,cursorPos)+"    "+e.target.value.substr(cursorPos);
//                e.target.selectionEnd = cursorPos+4; 
//            }
//        }))
 
  </script>
  
</html>


<%
    }
%>
