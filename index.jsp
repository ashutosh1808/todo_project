<%@ page import="java.sql.*" %>
<html>
<head>
	<title> Login </title>
	<style>
		*{ font-color: #000000; font-size:19px; font-family: tahoma; } 
		body { background-color: #5FED5A; }
		.nav a{ color:black; text-decoration:none; padding:50px; }
		a:hover { color: blue; }
	</style>
</head>
<body>
	<center>
	<div class="nav">
	<a href="index.jsp">Login</a>
	<a href="register.jsp">Sign-Up</a>
	</div>
	<form method="POST">
	<br>
	<input type="text" name="username" placeholder="enter username" minlength="2" maxlength="20" required>
		<br><br>
<input type="password" name="password" placeholder="enter password" minlength="6" maxlength="20" required>
		<br><br>
		<input type="submit" name="btn" value="Login">
		<br><br>
		<a href="rpw.jsp"> Forgot Password? </a>
	</form>
	<%
		if(request.getParameter("btn")!=null)
		{
			String username=request.getParameter("username");
			String password=request.getParameter("password");
			try{
				DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
				String url="jdbc:mysql://localhost:3306/ashu13july22";
				String un="root",pw="abc456";	
				Connection con=DriverManager.getConnection(url,un,pw);
				String sq="select * from users where username=? and passwd=?";
				PreparedStatement pst1=con.prepareStatement(sq);
				pst1.setString(1,username);
				pst1.setString(2,password);
				ResultSet rs1=pst1.executeQuery();
				if(rs1.next()){
					request.getSession().setAttribute("user",username);
					response.sendRedirect("home.jsp");
				}else{
					out.println("invalid login");
				}
				con.close();
			}catch(SQLException e){
				out.println("Issue: "+e);
			}
		}
	%>
	</center>
</body>
</html>