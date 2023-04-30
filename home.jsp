<%@ page import="java.sql.*" %>
<html>
<center>
<%
	if(request.getParameter("dt")!=null)
	{
		try{
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			String url="jdbc:mysql://localhost:3306/ashu13july22";
			String un="root",pw="abc456";	
			Connection con=DriverManager.getConnection(url,un,pw);
			String sql2="delete from tasks where id=?";
			PreparedStatement pst2=con.prepareStatement(sql2);
			pst2.setString(1,request.getParameter("dt"));
			pst2.executeUpdate();
			out.println("task deleted");
			con.close();
		}catch(SQLException e){
			out.println("Issue: "+e);
		}
	}
%>
</center>
<head>
	<title> Todo project </title>
	<style>
		*{ font-color: #000000; font-size:19px; font-family: tahoma; } 
		body { background-color: #5FED5A; }
		.nav a{ color:black; text-decoration:none; padding:50px; }
		td { text-align:center }
		a:hover { color: blue; }
		a { padding:20px; }
	</style>
</head>
<body>
	<center>
	<div class="nav">
	<a href="home.jsp"> Home</a>
	<a href="add.jsp"> Add a task</a>
	</div>
		<table width="750px;" border="2px;">
		<tr>
			<th> Task </th>
			<th> Date </th>
			<th> Time </th>
			<th> Status </th>
			<th> Edit </th>
			<th> Delete </th>
		</tr>
		<br>
		<%
			if(session.getAttribute("user")!=null){
			String user=(String)session.getAttribute("user");
			out.println("Welcome,"+user);
			}else{
				response.sendRedirect("index.jsp");
			}
		%>
		<br><br>
		<%
			try{
			DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
			String url="jdbc:mysql://localhost:3306/ashu13july22";
			String un="root",pw="abc456";	
			Connection con=DriverManager.getConnection(url,un,pw);
			String sql1="select id,task,exedate,exetime,status from tasks";
			PreparedStatement pst1=con.prepareStatement(sql1);
			ResultSet rs=pst1.executeQuery();
			while(rs.next()){
				int id=rs.getInt(1);
				String task=rs.getString(2);
				String date=rs.getString(3);
				String time=rs.getString(4);
				String status=rs.getString(5);
		%>
			<tr>
				<td><%= task %></td>
				<td><%= date %></td>
				<td><%= time %></td>
				<td><%= status %> </td>
			<td><a href="edit.jsp?id=<%= id %>">Edit</a></td>
      <td><a href="?dt=<%= id %>" onclick="return confirm('are you sure???')">Delete</a></td>
			</tr>
		<%
			}
			con.close();	
		}catch(SQLException e){
			out.println("Issue: "+e);
		}	
		%>
		</table>
		<br><br>
		<form method="POST">
		<input type="submit" name="btnLogout" value="Logout">
		</form>
		<%
			if(request.getParameter("btnLogout")!=null){
				request.getSession().invalidate();
				response.sendRedirect("index.jsp");
			}
		%>
	</center>
</body>
</html>