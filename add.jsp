<%@ page import="java.sql.*" %>
<%@ page import="java.time.*" %>
<html>
<head>
<title> Add a task </title>
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
	</div>	
	<br><br>
	<form method="POST">
    <textarea name="task" rows="4" cols="30" placeholder="enter your task" id="task" required></textarea>
		<br><br>
		<%
			if(session.getAttribute("user")!=null){
			String user=(String)session.getAttribute("user");
			//out.println("Welcome,"+user);
			}else{
				response.sendRedirect("index.jsp");
			}
		%>
		<%
			LocalDate ld=LocalDate.now();
		%>
		<input type="date" name="date" min="<%= ld %>" required>
		<input type="time" name="time" min="00:00" max="23:59" required>
		<br><br>
		<label for="status">
		<select name="status">
		<option value="pending" selected>Pending</option>
		<option value="ongoing">Ongoing</option>
		<option value="completed">Completed</option>
		</select>
		<br><br>
		<input type="submit" name="btnAdd" onclick="allLetter(document.form1.text1)" value="Add task">
		<br>
	</form>
		<%
			if(request.getParameter("btnAdd")!=null)
			{
				String task="";
				try{
				task=request.getParameter("task");
				if(!(task.matches("[A-Za-z ]+"))) //matches has regexps
					throw new Exception("task shud have letters only");
				}catch(Exception e){
					out.println("Issue: "+e.getMessage());
					return;	
				}
				String date=request.getParameter("date");
				String time=request.getParameter("time");
				String status=request.getParameter("status");
				try{
					DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
					String url="jdbc:mysql://localhost:3306/ashu13july22";
					String un="root",pw="abc456";	
					Connection con=DriverManager.getConnection(url,un,pw);
		String sql="insert into tasks(task,exedate,exetime,status) values(?,?,?,?)";
					PreparedStatement pst=con.prepareStatement(sql);
					pst.setString(1,task);
					pst.setString(2,date);
					pst.setString(3,time);
					pst.setString(4,status);
					pst.executeUpdate();
					out.println("task added");
					con.close();
				}catch(SQLException e){
					out.println("Issue: "+e.getMessage());
				}catch(Exception e){
					out.println("Issue: "+e.getMessage());
				}
			}
		%>
	</center>
</body>
</html>