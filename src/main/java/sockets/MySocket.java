package sockets;

import java.util.HashMap;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;

//@ServerEndpoint(value = "/chat/{clientId}")
public class MySocket {

	private static Map<String, Session> userSessions = new HashMap<String, Session>();

	@OnOpen
	public void abrir(@PathParam("clientId") String clientId, Session userSession) {
		System.out.println("Nova solicitação recebida. Id: " + userSession.getId());
		userSessions.put(clientId, userSession);
	}

	@OnClose
    public void fechar(Session userSession) {
        System.out.println("Conexão encerrada. Id: " + userSession.getId());
        userSessions.remove(userSession);
    }

    @OnMessage
    public void recebeMensagem(String mensagem, Session userSession, @PathParam("clientId") String clientId) {
        System.out.println("Mensagem Recebida: " + mensagem);
        userSessions.get(clientId).getAsyncRemote().sendText(mensagem);
    }
}
