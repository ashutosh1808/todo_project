<%@ page import="java.sql.*" %>
<%@ page import="java.time.*" %>
<html>
<head>
<title> Edit a task </title>
	<style>
		*{ font-color: #000000; font-size:19px; font-family: tahoma; } 
		body { background-color: #5FED5A; }
		.nav a{ color:black; text-decoration:none; padding:50px; }
		a:hover { color: blue; }
		textarea { resize:none; }
	</style>
</head>
<body>
	<center>
	<div class="nav">
	<a href="home.jsp"> Home</a>
	<a href="add.jsp"> Add a task</a>
	<br><br>
	</div>	
		<%
			if(session.getAttribute("user")!=null){
			String user=(String)session.getAttribute("user");
			//out.println("Welcome,"+user);
			}else{
				response.sendRedirect("index.jsp");
			}
		%>
		<%
		if(request.getParameter("btnEdit")!=null)
		{
			int id=Integer.parseInt(request.getParameter("id"));
			String task=request.getParameter("task");
			String date=request.getParameter("date");
			String time=request.getParameter("time");
			String status=request.getParameter("status");
			try{
				DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
				String url="jdbc:mysql://localhost:3306/ashu13july22";
				String un="root",pw="abc456";	
				Connection con=DriverManager.getConnection(url,un,pw);
				String sq1="update tasks set task=?,status=?,exedate=?,exetime=? where id=?";
				PreparedStatement ps1=con.prepareStatement(sq1);
				ps1.setString(1,task);
				ps1.setString(2,status);
				ps1.setString(3,date);
				ps1.setString(4,time);
				ps1.setInt(5,id);
				ps1.executeUpdate();
				out.println("task updated");
				con.close();
			}catch(SQLException e){
				out.println("Issue: "+e);
			}
		}
	%>
	<form method="POST">
	<%
	int id=Integer.parseInt(request.getParameter("id"));
	try{
		DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
		String url="jdbc:mysql://localhost:3306/ashu13july22";
		String un="root",pw="abc456";	
		Connection con=DriverManager.getConnection(url,un,pw);	
		String sq2="select * from tasks where id=?";
		PreparedStatement ps2=con.prepareStatement(sq2);
		ps2.setInt(1,id);
		ResultSet rs2=ps2.executeQuery();
		while(rs2.next()){
			String task=rs2.getString("task");
			String date=rs2.getString("exedate");
			String time=rs2.getString("exetime");
			String status=rs2.getString("status");
	%>
	<textarea name="task" rows="4" cols="30" id="task"><%=task %></textarea>
	<br><br>
	<%
			LocalDate ld=LocalDate.now();
	%>
	<input type="date" name="date" min="<%= date %>" value="<%= date %>" required>
	<input type="time" name="time" min="00:00" max="23:59" value="<%= time %>" required>	
	<br><br>	
	<%
		}
		con.close();
	}catch(SQLException e){
		out.println("Issue: "+e);
	}
	%>
	<label for="status">
	<select name="status">
	<option value="pending" selected>Pending</option>
	<option value="ongoing">Ongoing</option>
	<option value="completed">Completed</option>
	</select>
   	<br><br>
	<input type="submit" name="btnEdit" value="Edit task">
	<br>
	</form>
	</center>
</body>
</html>