<%@ page import="java.sql.*" %>
<html>
<head>
	<title> Reset Password </title>
	<style>
		*{ font-color: #000000; font-size:19px; font-family: tahoma; } 
		.nav a{ color:black; text-decoration:none; padding:50px; }
		a:hover{ color:blue; }
		body { background-color: #5FED5A; }
	</style>
</head>
<body>
	<center>
	<div class="nav">
	<a href="index.jsp"> Home</a>
	<a href="register.jsp">Sign-Up</a>
	</div>
	<br>
	<form method="POST">
	<input type="text" name="username" placeholder="enter username" required>
	<br><br>
	<input type="password" name="pw1" placeholder="enter new password" required>
	<br><br>
	<input type="password" name="pw2" placeholder="confirm new password" required>
	<br><br>
	<input type="submit" name="btn" value="Reset Password">
	</form>		
	<br><br>
	<%
		if(request.getParameter("btn")!=null){			
		String username=request.getParameter("username");
		String pw1=request.getParameter("pw1");
		String pw2=request.getParameter("pw2");	
		if(pw1.equals(pw2)){
			try{
				DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
				String url="jdbc:mysql://localhost:3306/ashu13july22";
				String un="root",pw="abc456";	
				Connection con=DriverManager.getConnection(url,un,pw);
				String sq1="select * from users where username=?";
				PreparedStatement ps1=con.prepareStatement(sq1);
				ps1.setString(1,username);
				ResultSet rs1=ps1.executeQuery();
				if(rs1.next())
				{
					String sql1="update users set passwd=? where username=?";
					PreparedStatement pst1=con.prepareStatement(sql1);
					pst1.setString(1,pw1);
					pst1.setString(2,username);
					int r=pst1.executeUpdate();
					if(r==1)
						out.println("password reset successful");
					else
						out.println("password reset failed");
				}else{
					out.println(username+" does not exists ");
				}
				con.close();
			}catch(Exception e){
				out.println("Issue: "+e);
			}
		}else{
			out.println("passwords do not match");
		}	
	}
	%>
</center>
</body>
</html>