<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tomcat WebSocket</title>
</head>
<body>

	<form>
		<label>Room</label>
		<input id="room" type="text">
		<input onclick="wsOpenConnection();" value="Connect" type="button"><br><br>		
		
		<label>Message</label>
		<input id="message" type="text">
		<input onclick="wsSendMessage();" value="Echo" type="button"><br><br>
		
		<label>Chat</label>
		<textarea id="echoText" rows="5" cols="30"></textarea><br>
		
		<input onclick="wsCloseConnection();" value="Disconnect" type="button">
	</form>

	<br>

	<script type="text/javascript">
		var webSocket = null;
		var message = document.getElementById("message");
		var room = document.getElementById("room");
		var echoText = document.getElementById("echoText");
		
		function wsOpenConnection() {
			if(room.value === null || room.value.trim().length === 0){
				alert("informe a sala");
			} else {
				webSocket = new WebSocket("ws://solutions-dev.primeit.pt:8080/Sockets-Server/chat/"+room.value);

				webSocket.onopen = function(message){wsOpen(message);};
				webSocket.onmessage = function(message) {wsGetMessage(message);};
				webSocket.onclose = function(message) {wsClose(message);};
				webSocket.onerror = function(message) {wsError(message);};
			}
		}

		function wsOpen(message){
            echoText.value += "Connected ... \n";
        }

        function wsSendMessage(){
            webSocket.send(message.value);
            echoText.value += "Message sended to the server : " + message.value + "\n";
        }

        function wsCloseConnection(){
            webSocket.close();
        }

        function wsGetMessage(message){
            echoText.value += "Message received from the server : " + message.data + "\n";
        }

        function wsClose(message){
            echoText.value += "Disconnect ... \n";
        }
 
        function wsError(message){
            echoText.value += "Error ... \n";
        }
	</script>
</body>
</html>