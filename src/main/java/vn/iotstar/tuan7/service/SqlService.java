package vn.iotstar.tuan7.service;

import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.sql.*;

@Service
public class SqlService {

    private final DataSource dataSource;


    public SqlService(Environment env) {
        DriverManagerDataSource ds = new DriverManagerDataSource();
        ds.setDriverClassName(env.getProperty("spring.datasource.driver-class-name", "com.mysql.cj.jdbc.Driver"));
        ds.setUrl(env.getProperty("spring.datasource.url"));
        ds.setUsername(env.getProperty("spring.datasource.username"));
        ds.setPassword(env.getProperty("spring.datasource.password"));
        this.dataSource = ds;
    }

    public String executeSql(String sql) {
        if (sql == null || sql.trim().isEmpty()) {
            return "<div class=\"sql-error\">No SQL provided.</div>";
        }

        String trimmed = sql.trim();
        boolean isSelect = trimmed.regionMatches(true, 0, "select", 0, 6);

        try (Connection conn = dataSource.getConnection()) {
            if (isSelect) {
                try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
                    return renderResultSetAsHtmlTable(rs);
                }
            } else {
                try (Statement stmt = conn.createStatement()) {
                    int updated = stmt.executeUpdate(sql);
                    return "<div class=\"sql-update\">Executed. Affected rows: " + updated + "</div>";
                }
            }
        } catch (SQLException ex) {
            return "<div class=\"sql-error\">Error: " + escapeHtml(ex.getMessage()) + "</div>";
        }
    }

    private String renderResultSetAsHtmlTable(ResultSet rs) throws SQLException {
        StringBuilder sb = new StringBuilder();
        ResultSetMetaData md = rs.getMetaData();
        int cols = md.getColumnCount();

        sb.append("<table class=\"sql-table\">\n");
        sb.append("<thead><tr>");
        for (int i = 1; i <= cols; i++) {
            sb.append("<th>").append(escapeHtml(md.getColumnLabel(i))).append("</th>");
        }
        sb.append("</tr></thead>\n");

        sb.append("<tbody>\n");
        int rowCount = 0;
        while (rs.next()) {
            rowCount++;
            sb.append("<tr>");
            for (int i = 1; i <= cols; i++) {
                Object val = rs.getObject(i);
                sb.append("<td>").append(escapeHtml(val == null ? "NULL" : String.valueOf(val))).append("</td>");
            }
            sb.append("</tr>\n");
        }
        if (rowCount == 0) {
            sb.append("<tr><td colspan=\"").append(cols).append("\">0 rows.</td></tr>\n");
        }
        sb.append("</tbody></table>");
        return sb.toString();
    }

    private String escapeHtml(String s) {
        if (s == null) return "";
        return s.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}
