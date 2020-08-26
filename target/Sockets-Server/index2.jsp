<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tomcat WebSocket</title>
</head>
<body>

	<form>
		<input id="message" type="text"> 
		<input onclick="wsOpenConnection();" value="Connect" type="button">
		<input onclick="wsSendMessage();" value="Echo" type="button">
		<input onclick="wsCloseConnection();" value="Disconnect" type="button">
	</form>

	<br>

	<script type="text/javascript">
		var webSocket = null;
		var message = document.getElementById("message");


		
		webSocket.onopen = function(message) {
			wsOpen(message);
		};
		webSocket.onmessage = function(message) {
			wsGetMessage(message);
		};
		webSocket.onclose = function(message) {
			wsClose(message);
		};
		webSocket.onerror = function(message) {
			wsError(message);
		};

		function wsOpen(message){
            echoText.value += "Connected ... \n";
        }
		
		function wsOpenConnection() {
			webSocket = new WebSocket("ws://localhost:8080/Sockets-Server/chat/rafael");
		}

		function wsSendMessage() {
			webSocket.send(message.value);
			//echoText.value += "Message sended to the server : " + message.value + "\n";
			message.value = "";
		}
		function wsCloseConnection() {
			webSocket.close();
		}
		function wsGetMessage(message) {
			//echoText.value += "Message received from to the server : " + message.data + "\n";
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