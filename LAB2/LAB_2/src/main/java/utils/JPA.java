package utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPA {
	private static EntityManagerFactory factory;
	
	public static EntityManager getEntityManager() {
		if(factory == null || factory.isOpen()) {
			factory = Persistence.createEntityManagerFactory("PolyOE");
		}
		return factory.createEntityManager();
	}
	
	public static void shutDown() {
		if(factory == null && factory.isOpen()) {
			factory.close();
		}
		factory = null;
	}
}
