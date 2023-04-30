<%@ page import="java.sql.*" %>
<html>
<head>
	<title> Sign-Up </title>
	<style>
		*{ font-color: #000000; font-size:19px; font-family: tahoma; } 
		.nav a{ color:black; text-decoration:none; padding:50px; }
		a:hover{ color:blue; }
		body { background-color: #5FED5A; }
	</style>	
<script>
	function RestrictSpace() {
    	if (event.keyCode == 32) {
        return false;
   }
}
</script>
</head>
<body>
<center>
	<div class="nav">
	<a href="index.jsp"> Login</a>
	<a href="register.jsp">Sign-Up</a>
	</div>
	<br>	
	<form method="POST">
	<input type="text" placeholder="enter your name" name="name" required>
	<br><br>	
	 <input type="text" placeholder="enter username" name="username" minlength="2" maxlength="20" required>
	<br><br>
<input type="password" placeholder="enter password" minlength="6" maxlength="20" name="pw1" id="pw1" required>
	<br><br>
 <input type="password" placeholder="confirm password" minlength="6" maxlength="20" name="pw2" id="pw2" required>
	<br><br>
	<input type="submit" value="Register" name="btn">
	<br><br>
	<a href="index.jsp"> Already Registered? </a>
	</form>
	<%
		if(request.getParameter("btn")!=null)
		{
			String name=request.getParameter("name");
			if(!name.matches("[a-zA-Z]+"))
				out.println("invalid name");
			String username=request.getParameter("username");
			String pw1=request.getParameter("pw1");
			String pw2=request.getParameter("pw2");
			if(pw1.equals(pw2))
			{
				DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
				String url="jdbc:mysql://localhost:3306/ashu13july22";
				String un="root",pw="abc456";	
				Connection con=DriverManager.getConnection(url,un,pw);
				String sq1="select * from users where username=?";
				PreparedStatement ps1=con.prepareStatement(sq1);
				ps1.setString(1,username);
				ResultSet rs1=ps1.executeQuery();
				if(rs1.next())
					out.println(username+" already used ");
				else{
					String sql="insert into users values(?,?,?)";
					PreparedStatement pst=con.prepareStatement(sql);
					pst.setString(1,name);
					pst.setString(2,username);	
					pst.setString(3,pw1);
					pst.executeUpdate();
					response.sendRedirect("index.jsp");
				}
				con.close();
			}else{
				out.println("passwords did not match");
			}
		}
	%>
</center>
</body>
</html>