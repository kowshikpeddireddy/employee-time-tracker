<%
    response.setHeader("Cache-Control","no-store");
    response.setHeader("Pragma","no-cache"); 
    response.setHeader ("Expires", "0"); //prevents caching at the proxy server
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Task</title>
    <link rel="stylesheet" type="text/css" href="./css/addTask.css">

    <script>
        function calculateDuration() {
            var startTime = document.getElementById("startTime").value;
            var endTime = document.getElementById("endTime").value;

            var startHours = parseInt(startTime.split(":")[0]);
            var startMinutes = parseInt(startTime.split(":")[1]);
            var endHours = parseInt(endTime.split(":")[0]);
            var endMinutes = parseInt(endTime.split(":")[1]);

            var durationMinutes = (endHours * 60 + endMinutes) - (startHours * 60 + startMinutes);
            var absDurationMinutes = Math.abs(durationMinutes);
            var durationHours = absDurationMinutes / 60.0;
            durationHours = durationHours.toFixed(1);

            document.getElementById("duration").value = durationHours;
        }

        function printTaskType() {
            var taskType = document.getElementById("taskType").value;
            console.log("Task Type: " + taskType);
        }
    </script>
</head>
<body>
    <h2>Add Task</h2>

    <form action="AddTaskServlet" method="post" onsubmit="calculateDuration(); printTaskType();">
        <label for="taskType">Task Type:</label>
        <select id="taskType" name="taskType">
            <%
                String userRole = (String) session.getAttribute("role");
                if (userRole != null && userRole.equals("developer")) {
            %>
                    <option value="Development">Development</option>
                    <option value="Bug Fixing">Bug Fixing</option>
                    <option value="Code Review">Code Review</option>
            <%
                } else if (userRole != null && userRole.equals("Quality Assurance Engineer")) {
            %>
                    <option value="Testing">Testing</option>
                    <option value="Test Automation">Test Automation</option>
                    <option value="Defect Reporting">Defect Reporting</option>
            <%
                }
                // Add more conditions for other roles if necessary
            %>
        </select>

        <label for="date">Date:</label>
        <input type="date" id="date" name="date" required>

        <label for="startTime">Start Time:</label>
        <input type="time" id="startTime" name="startTime" required>

        <label for="endTime">End Time:</label>
        <input type="time" id="endTime" name="endTime" required onchange="calculateDuration()">

        <label for="description">Description:</label>
        <textarea id="description" name="description" rows="4" cols="50" required></textarea>

        <input type="hidden" id="employeeId" name="employeeId" value="<%= session.getAttribute("employeeId") %>">
        <input type="hidden" id="duration" name="duration">
        <input type="submit" value="Add Task">
    </form>
</body>
</html>
