package servlets;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;
import java.util.UUID;

import dao.ShareDAO;
import dao.ShareDAOImpl;
import entity.Share;
import entity.User;
import entity.Video;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/Share")
public class ShareServlet extends HttpServlet {

	ShareDAO shareDao = new ShareDAOImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// ❌ Không cho vào Share.jsp nữa
		resp.sendRedirect("Home");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("user");

		String videoId = req.getParameter("videoId");

		if (user == null) {
			resp.sendRedirect(req.getContextPath() + "/Home?shareError=notLogin");
			return;
		}

		try {
			String email = req.getParameter("email");

			Share share = new Share();
			share.setEmail(email);
			share.setShareDate(new Date());
			share.setUser(user);

			Video v = new Video();
			v.setId(videoId);
			share.setVideo(v);

			shareDao.create(share);

			sendShareEmail(req, email, videoId);

			resp.sendRedirect(req.getContextPath() + "/Home?shareSuccess=true");

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect(req.getContextPath() + "/Home?shareError=true");
		}
	}

	private void sendShareEmail(HttpServletRequest req, String recipientEmail, String videoId)
			throws MessagingException {

		String host = "smtp.gmail.com";
		String fromEmail = "thephuong2204@gmail.com";
		String password = "zqag ffui wncy exkr";

		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.port", "587");

		Session session = Session.getInstance(properties, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		});

		String videoUrl = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort()
				+ req.getContextPath() + "/VideoDetail?id=" + videoId;

		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(fromEmail));
		message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
		message.setSubject("Check out this video!");
		String content = "<html><body>" + "<h2>Check out this awesome video!</h2>" + "<p>Video Link: <a href='"
				+ videoUrl + "'>" + videoUrl + "</a></p>" + "</body></html>";
		message.setContent(content, "text/html");

		Transport.send(message);
	}
}
