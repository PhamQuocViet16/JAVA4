package servlet;

import java.util.List;
import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

public class Test_Ket_Noi {

    public static void main(String[] args) {
        // Gọi hàm test ở đây
//		create();
//        update();
        delete();
//        findByRole(true);
//        findByFullname("A");
//        findPage(0, 3);
		findAll();
    }

    private static void findAll() {
        EntityManagerFactory emf = null;
        EntityManager em = null;
        try {
            emf = Persistence.createEntityManagerFactory("PolyOE");
            em = emf.createEntityManager();

            String jpql = "SELECT u FROM User u";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            List<User> list = query.getResultList();

            for (User user : list) {
                System.out.println(">> ID: " + user.getId());
                System.out.println(">> Password: " + user.getPassword());
                System.out.println(">> Fullname: " + user.getFullname());
                System.out.println(">> Email: " + user.getEmail());
                System.out.println(">> Admin: " + user.isAdmin());
                System.out.println("----------------------------");
            }
            System.out.println("✅ Truy vấn thành công!");
        } catch (Exception e) {
            System.out.println("❌ Truy vấn thất bại!");
            e.printStackTrace();
        } finally {
            if (em != null) em.close();
            if (emf != null) emf.close();
        }
    }

    private static void create() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("PolyOE");
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();

            User entity = new User();
            entity.setId("nv06");
            entity.setPassword("123456");
            entity.setFullname("Nguyễn Văn V");
            entity.setEmail("nguyenvanv@fe.edu.vn");
            entity.setAdmin(true);

            em.persist(entity);
            em.getTransaction().commit();

            System.out.println("✅ Thêm thành công!");
        } catch (Exception e) {
            em.getTransaction().rollback();
            System.out.println("❌ Thêm thất bại!");
            e.printStackTrace();
        } finally {
            em.close();
            emf.close();
        }
    }
    
    private static void update() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("PolyOE");
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            User entity = em.find(User.class, "nv06");
            entity.setPassword("ILOVEYOU");
            entity.setFullname("Nguyễn Văn Tèo");
            entity.setAdmin(false);
            em.merge(entity);
            em.getTransaction().commit();
            System.out.println("✅ Update thành công!");
        } catch (Exception e) {
            em.getTransaction().rollback();
            System.out.println("❌ Update thất bại!");
        } finally {
            em.close();
            emf.close();
        }
    }

    private static void delete() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("PolyOE");
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            User entity = em.find(User.class, "nv06");
            if (entity != null) {
                em.remove(entity);
                System.out.println("✅ Xóa thành công!");
            } else {
                System.out.println("⚠️ Không tìm thấy user cần xóa!");
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            System.out.println("❌ Xóa thất bại!");
        } finally {
            em.close();
            emf.close();
        }
    }

    private static void findByRole(boolean role) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("PolyOE");
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT o FROM User o WHERE o.admin = :role";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("role", role);
            List<User> list = query.getResultList();

            for (User user : list) {
            	System.out.println(">> ID: " + user.getId());
                System.out.println(">> Email: " + user.getEmail());
                System.out.println(">> Is Admin: " + user.isAdmin());
            }
            System.out.println("✅ Truy vấn thành công!");
        } catch (Exception e) {
            System.out.println("❌ Truy vấn lỗi!");
        } finally {
            em.close();
            emf.close();
        }
    }

    private static void findByFullname(String fullname) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("PolyOE");
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT o FROM User o WHERE o.fullname LIKE :fullname";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("fullname", "%" + fullname + "%");
            List<User> list = query.getResultList();

            for (User user : list) {
                System.out.println(">> Email: " + user.getEmail());
                System.out.println(">> Fullname: " + user.getFullname());
            }
            System.out.println("✅ Truy vấn thành công!");
        } catch (Exception e) {
            System.out.println("❌ Truy vấn thất bại!");
        } finally {
            em.close();
            emf.close();
        }
    }

    private static void findPage(int page, int size) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("PolyOE");
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT o FROM User o";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setFirstResult(page * size);
            query.setMaxResults(size);

            List<User> list = query.getResultList();
            for (User user : list) {
                System.out.println(">> Email: " + user.getEmail());
                System.out.println(">> Is Admin: " + user.isAdmin());
            }
            System.out.println("✅ Truy vấn thành công!");
        } catch (Exception e) {
            System.out.println("❌ Truy vấn thất bại!");
        } finally {
            em.close();
            emf.close();
        }
    }
}
