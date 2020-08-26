package sockets;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/chat/{clientId}")
public class MySocket2 {

	private static Map<String, Set<Session>> userSessions = new HashMap<String, Set<Session>>();

	@OnOpen
	public void abrir(@PathParam("clientId") String clientId, Session userSession) {
		System.out.println("Nova solicitação recebida. Id: " + userSession.getId());
		
		if(!userSessions.containsKey(clientId)) {
			userSessions.put(clientId, new HashSet<Session>());
		} 

		userSessions.get(clientId).add(userSession);
	}

	@OnClose
    public void fechar(Session userSession) {
        System.out.println("Conexão encerrada. Id: " + userSession.getId());
//        userSessions.remove(userSession);
    }

    @OnMessage
    public void recebeMensagem(String mensagem, Session userSession, @PathParam("clientId") String clientId) {
        System.out.println("Mensagem Recebida: \"" + mensagem + "\" de id: " + userSession.getId());
        
        if(userSessions.containsKey(clientId)) {
        	for(Session session: userSessions.get(clientId)) {
        		
        		if(!session.getId().equals(userSession.getId()) && session.isOpen()) {
        			System.out.println("Enviando mensagem para id: " + session.getId());
        			session.getAsyncRemote().sendText(mensagem);	
        		}
        	}
        }
    }
}
