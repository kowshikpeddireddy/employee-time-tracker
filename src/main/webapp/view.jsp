<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache"); 
    response.setHeader ("Expires", "0"); //prevents caching at the proxy server
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Tasks</title>
    <!-- Include Chart.js library -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" type="text/css" href="./css/view.css">

</head>
<body>
    <div class="container">
        <h2>View Tasks</h2>

        <form action="ViewTasksServlet" method="get">
            <label for="timePeriod">Select Time Period:</label>
            <select id="timePeriod" name="timePeriod">
                <option value="daily">Daily</option>
                <option value="weekly">Weekly</option>
                <option value="monthly">Monthly</option>
            </select>
            <input type="hidden" name="employeeId" value="<%= session.getAttribute("employeeId") %>">
            <input type="submit" value="Submit" href="#tasksContainer">
        </form>

        <div id="tasksContainer">
            <!-- Tasks will be displayed here -->
            <% java.sql.ResultSet resultSet = (java.sql.ResultSet)request.getAttribute("tasksResultSet");
            ArrayList<String> taskNames = new ArrayList<>();
            ArrayList<Double> durations = new ArrayList<>();

            if(resultSet != null) {
                try {
                    while(resultSet.next()) {
                        // Add task name and duration to the ArrayLists
                        taskNames.add(resultSet.getString("task_name"));
                        durations.add(resultSet.getDouble("duration"));
                    } %>
                    <table>
                        <tr>
                            <th>Task Name</th>
                            <th>Duration (hours)</th>
                        </tr>
                        <% for (int i = 0; i < taskNames.size(); i++) { %>
                            <tr>
                                <td><%= taskNames.get(i) %></td>
                                <td><%= durations.get(i) %></td>
                            </tr>
                        <% } %>
                    </table>
                    <% String jsonTasks = convertResultSetToJsonString(resultSet); %>
                    <!-- Display the pie chart only if time period is "Daily" -->
                    <% if ("daily".equals(request.getParameter("timePeriod"))) { %>
                    
                    <div>
                    <div class="canvas-container">
                            <canvas id="taskPieChart"></canvas>
                        </div>
                         <div class="canvas-container">
    <canvas id="taskDoughnutChart"></canvas>
</div>
                    </div>
                        
                        <script>
                            var taskNamesArray = [<% for (String taskName : taskNames) { %>
                                '<%= taskName %>', <% } %>];
                            var durationsArray = <%= Arrays.toString(durations.toArray(new Double[0])) %>;

                            var ctx = document.getElementById('taskPieChart').getContext('2d');
                            var myPieChart = new Chart(ctx, {
                                type: 'pie',
                                data: {
                                    labels: taskNamesArray,
                                    datasets: [{
                                        data: durationsArray,
                                        backgroundColor: [
                                            'rgba(255, 99, 132, 0.7)',
                                            'rgba(54, 162, 235, 0.7)',
                                            'rgba(255, 206, 86, 0.7)',
                                            'rgba(75, 192, 192, 0.7)',
                                            'rgba(153, 102, 255, 0.7)'
                                        ],
                                        borderColor: [
                                            'rgba(255, 99, 132, 1)',
                                            'rgba(54, 162, 235, 1)',
                                            'rgba(255, 206, 86, 1)',
                                            'rgba(75, 192, 192, 1)',
                                            'rgba(153, 102, 255, 1)'
                                        ],
                                        borderWidth: 1
                                    }]
                                },
                                options: {
                                    responsive: false, // Disable responsiveness
                                    maintainAspectRatio: false, // Disable aspect ratio
                                    canvas: {
                                        width: 400, // Specify width
                                        height: 400 // Specify height
                                    }
                                }
                            });
                        </script>
                        
                       
<script>
    var taskNamesArray = [<% for (String taskName : taskNames) { %>
        '<%= taskName %>', <% } %>];
    var durationsArray = <%= Arrays.toString(durations.toArray(new Double[0])) %>;
	let map = {}
	for (let i = 0; i < taskNamesArray.length; i++ ) {
		map[taskNamesArray[i]] = (map[taskNamesArray[i]] || 0) + durationsArray[i]
	}
	
	console.log(map)
	
    var ctx = document.getElementById('taskDoughnutChart').getContext('2d');
    var myDoughnutChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: taskNamesArray,
            datasets: [{
                data: durationsArray,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.7)',
                    'rgba(54, 162, 235, 0.7)',
                    'rgba(255, 206, 86, 0.7)',
                    'rgba(75, 192, 192, 0.7)',
                    'rgba(153, 102, 255, 0.7)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: false, // Disable responsiveness
            maintainAspectRatio: false, // Disable aspect ratio
            canvas: {
                width: 400, // Specify width
                height: 400 // Specify height
            }
        }
    });
</script>
                        
                    <% } else if ("weekly".equals(request.getParameter("timePeriod")) || "monthly".equals(request.getParameter("timePeriod"))) { %>
                    
                    <div>
                    <div class="canvas-container">
<canvas id="taskDoughnutChart" width="500" height="500" style="display: block;box-sizing: border-box;height: 400px;width: 400px;"></canvas>  					<div class="canvas-container">
                        <canvas id="taskBarChart"></canvas>
                    </div>
                        
                   </div>
<script>
    var taskNamesArray = [<% for (String taskName : taskNames) { %>
        '<%= taskName %>', <% } %>];
    var durationsArray = <%= Arrays.toString(durations.toArray(new Double[0])) %>;

    var taskNamesArray = [<% for (String taskName : taskNames) { %>
    '<%= taskName %>', <% } %>];
var durationsArray = <%= Arrays.toString(durations.toArray(new Double[0])) %>;
let map = {}
for (let i = 0; i < taskNamesArray.length; i++ ) {
	map[taskNamesArray[i]] = (map[taskNamesArray[i]] || 0) + durationsArray[i]
}

taskNamesArray = Object.keys(map)
durationsArray = Object.values(map)

console.log(map)
    
    var ctx = document.getElementById('taskDoughnutChart').getContext('2d');
    var myDoughnutChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: taskNamesArray,
            datasets: [{
                data: durationsArray,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.7)',
                    'rgba(54, 162, 235, 0.7)',
                    'rgba(255, 206, 86, 0.7)',
                    'rgba(75, 192, 192, 0.7)',
                    'rgba(153, 102, 255, 0.7)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: false, // Disable responsiveness
            maintainAspectRatio: false, // Disable aspect ratio
            canvas: {
                width: 400, // Specify width
                height: 400 // Specify height
            }
        }
    });
</script>
                    
                      
                        <script>
                            var taskNamesArray = [<% for (String taskName : taskNames) { %>
                                '<%= taskName %>', <% } %>];
                            var durationsArray = <%= Arrays.toString(durations.toArray(new Double[0])) %>;

                            var ctx = document.getElementById('taskBarChart').getContext('2d');
                            var myBarChart = new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: taskNamesArray,
                                    datasets: [{
                                        label: 'Duration (hours)',
                                        data: durationsArray,
                                        backgroundColor: 'rgba(54, 162, 235, 0.7)',
                                        borderColor: 'rgba(54, 162, 235, 1)',
                                        borderWidth: 1
                                    }]
                                },
                                options: {
                                    scales: {
                                        yAxes: [{
                                            ticks: {
                                                beginAtZero: true
                                            }
                                        }]
                                    }
                                }
                            });
                        </script>
                        
                    <% } %>
                <% }  catch (java.sql.SQLException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        resultSet.close();
                    } catch (java.sql.SQLException e) {
                        e.printStackTrace();
                    }
                }
            } %>
        </div>
    </div>

<%!
    // Helper method to convert ResultSet to JSON string
    private String convertResultSetToJsonString(java.sql.ResultSet resultSet) throws java.sql.SQLException {
        StringBuilder json = new StringBuilder("[");
        java.sql.ResultSetMetaData metaData = resultSet.getMetaData();
        int columns = metaData.getColumnCount();
        boolean isFirstRow = true;
        while (resultSet.next()) {
            if (!isFirstRow) {
                json.append(",");
            } else {
                isFirstRow = false;
            }
            json.append("{");
            for (int i = 1; i <= columns; ++i) {
                String columnName = metaData.getColumnName(i);
                Object value = resultSet.getObject(i);
                if (i > 1) {
                    json.append(",");
                }
                json.append("\"").append(columnName).append("\":");
                if (value == null) {
                    json.append("null");
                } else if (value instanceof Number) {
                    json.append(value);
                } else {
                    json.append("\"").append(value).append("\"");
                }
            }
            json.append("}");
        }
        json.append("]");
        return json.toString();
    }
%>
</body>
</html>
