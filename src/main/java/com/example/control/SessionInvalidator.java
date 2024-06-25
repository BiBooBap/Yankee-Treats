package com.example.control;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;

public class SessionInvalidator implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        System.out.println("ServletContext initialized.");
        invalidateSessions(servletContextEvent);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        System.out.println("ServletContext destroyed.");
        invalidateSessions(servletContextEvent);
    }

    private void invalidateSessions(ServletContextEvent servletContextEvent) {
        javax.servlet.ServletContext ctx = servletContextEvent.getServletContext();
        if (ctx == null) {
            System.err.println("ServletContext is null. Unable to invalidate sessions.");
            return;
        }

        java.util.Enumeration<String> attributeNames = ctx.getAttributeNames();

        while (attributeNames.hasMoreElements()) {
            String attributeName = attributeNames.nextElement();
            Object attributeValue = ctx.getAttribute(attributeName);

            if (attributeValue instanceof HttpSession) {
                HttpSession session = (HttpSession) attributeValue;
                session.invalidate();
                System.out.println("Invalidated session: " + session.getId());
            }
        }
        System.out.println("All sessions invalidated.");
    }
}
