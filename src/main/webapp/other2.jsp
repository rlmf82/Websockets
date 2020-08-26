<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tomcat WebSocket</title>
</head>
<body>

	<form>
		<label>Message</label>
		<input id="message" type="text"><br>
		<label>Queue</label>
		<input id="queue" type="text"><br>
		
		<textarea id="echoText" rows="5" cols="30"></textarea><br><br>
		
		<input onclick="wsOpenConnection();" value="Connect" type="button">
		<input onclick="wsSendMessage();" value="Echo" type="button">
		<input onclick="wsCloseConnection();" value="Disconnect" type="button">
	</form>

	<br>

	<script type="text/javascript">
		var webSocket = null;
		var message = document.getElementById("message");
		var queue = document.getElementById("queue");
		
		webSocket.onopen = function(message) {
			wsOpen(message);
		};
		webSocket.onmessage = function(message) {
			console.log(message.value);
			wsGetMessage(message);
		};
		webSocket.onclose = function(message) {
			wsClose(message);
		};
		webSocket.onerror = function(message) {
			wsError(message);
		};

		function wsOpenConnection() {
			webSocket = new WebSocket("ws://localhost:8080/Sockets-Server/chat/"+queue.value);
		}

		function wsSendMessage() {
			console.log(message.value);
			webSocket.send(message.value);
			//echoText.value += "Message sended to the server : " + message.value + "\n";
			message.value = "";
		}
		function wsCloseConnection() {
			webSocket.close();
		}
		function wsGetMessage(message) {
			console.log("chamou");
			echoText.value += message.data + "\n";
		}
		function wsClose(message) {
			echoText.value += "Disconnect ... \n";
		}

		function wsError(message) {
			echoText.value += "Error ... \n";
		}
	</script>
</body>
</html>