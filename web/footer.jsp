<script>
function validateEmail(email) {
    const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
}                                    
           
function subscribe(){
    var email = document.getElementById("subscribeemail").value;
    if (email===""){
        alert("Pleae Fill The Email Id");
        return;
    }
    if(!(validateEmail(email))){
        alert("Invalid Email ID");
        return;
    }
    
    var formdata = new FormData();
    formdata.append("email",email);
    
    var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    var response = JSON.parse(this.responseText);
                    document.getElementById("subscribeemail").value="";
                    alert(response["type"]+": "+response["message"]);
                }
            };
            xmlhttp.open("POST","./subscribeServlet", true);
            xmlhttp.send(formdata);
}


</script>



<!-- Footer -->
    <footer id="footer" class="py-sm-5 py-4 bg-theme">
        <div class="container">
            <div class="footer-top-w3ls">
                <h2><a href="index.html" class="navbar-brand">Code On Cloud</a></h2>
                <p class="text-white">
                    This is the platform where you can code in any language of your choice. You can
                    also save your codes and share with your friends on the platform. One can make any user his/her
                    friend by sending and aceepting the friend request. 
                </p>
            </div>
            <div class="row  pt-5">
                <div class="col-lg-3 col-sm-6 footer_grid1">
                    <h5>Final Year Project</h5>
                    <div class="d-flex align-items-center">
                        <span class="fa fa-building mr-4"></span>
                        <p>University :
                            <br>Guru Nanak Dev University</p>
                    </div>
                    <div class="d-flex mt-3 align-items-center">
                        <span class="fa fa-building mr-4"></span>
                        <p>Department :
                            <br>Computer Engineering And Technology</p>
                    </div>
                </div>
                <%
                    Object footersessionusername = session.getAttribute("username");
                    if (footersessionusername==null){
                %>  
                <div class="col-lg-3 col-sm-6 mt-sm-0 mt-5">
                    <h5>Quick links</h5>
                    <ul class="list-unstyled quick-links">
                        <li>
                            <a href="./index.jsp">
                                <span class="fa fa-play"></span>Home</a>
                        </li>
                        <li>
                            <a href="./about.jsp">
                                <span class="fa fa-play"></span>About</a>
                        </li>
                        <li>
                            <a href="./index.jsp">
                                <span class="fa fa-play"></span>Search Users</a>
                        </li>
                        <li>
                            <a href="./contact.jsp">
                                <span class="fa fa-play"></span>Contact</a>
                        </li>
                    </ul>
                </div>

                <div class="col-lg-3 col-sm-6 mt-lg-0 mt-5">
                    <h5>Quick links</h5>
                    <ul class="list-unstyled quick-links">
                        <li>
                            <a href="./index.jsp">
                                <span class="fa fa-play"></span>Login</a>
                        </li>
                        <li>
                            <a href="./index.jsp">
                                <span class="fa fa-play"></span>Sign Up</a>
                        </li>
                        <li>
                            <a href="./forgotPassword.jsp">
                                <span class="fa fa-play"></span>Forgot Password</a>
                        </li>
                        <li>
                            <a href="./compilecode.jsp">
                                <span class="fa fa-play"></span>Compile Code</a>
                        </li>
                    </ul>
                </div>
                <%
                    }
                    else{
                %>
                
                <div class="col-lg-3 col-sm-6 mt-sm-0 mt-5">
                    <h5>Quick links</h5>
                    <ul class="list-unstyled quick-links">
                        <li>
                            <a href="./index.jsp">
                                <span class="fa fa-play"></span>Home</a>
                        </li>
                        <li>
                            <a href="./about.jsp">
                                <span class="fa fa-play"></span>About</a>
                        </li>
                        <li>
                            <a href="./index.jsp">
                                <span class="fa fa-play"></span>Search Users</a>
                        </li>
                        <li>
                            <a href="./contact.jsp">
                                <span class="fa fa-play"></span>Contact</a>
                        </li>
                    </ul>
                </div>

                <div class="col-lg-3 col-sm-6 mt-lg-0 mt-5">
                    <h5>Quick links</h5>
                    <ul class="list-unstyled quick-links">
                        <li>
                            <a href="./userLogout">
                                <span class="fa fa-play"></span>Logout</a>
                        </li>
                        <li>
                            <a href="./viewFriends.jsp">
                                <span class="fa fa-play"></span>View Friends</a>
                        </li>
                        <li>
                            <a href="./myprofile.jsp">
                                <span class="fa fa-play"></span>My Profile</a>
                        </li>
                        <li>
                            <a href="./compilecode.jsp">
                                <span class="fa fa-play"></span>Compile Code</a>
                        </li>
                    </ul>
                </div>
                
                <%

                    }
                %>
                <div class="col-lg-3 col-sm-6 mt-lg-0 mt-5">
                    <h5>Subscribe To Get Notifications</h5>
                    <form>
                        <div class="form-group">
                            <input type="email" class="form-control  border-0 border-rounded" id="subscribeemail" placeholder="Enter email" required>
                        </div>
                        <div class="form-group">
                            <input type="button" class="form-control bg-light-theme  border-0 border-rounded" value="Subscribe" onclick="subscribe()">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </footer>
    <!-- /Footer -->
    
    <div class="cpy-right text-center py-4">
        <p class="text-dark">? 2021 CodeOnCloud. Coding Platform | Made by
            <a class="text-theme"> Kriti Rikhi (2017CSA1110).</a>
        </p>
    </div>