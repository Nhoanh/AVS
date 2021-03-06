/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DBContext.DBContext;
import Entity.Likenews;
import Entity.News;
import Entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author quang
 */
public class NewsModel {

    //Like comment
    public ArrayList<Likenews> getTotalLikeNewsByNewsId(int newsid) throws Exception {
        String query = "SELECT  u.user_FullName fullname,u.user_Name username, ln.[user_ID] userid,ln.news_ID newsid,ln.[Status] cmtstatus FROM LikeNews ln\n"
                + " inner join Users u on u.user_ID= ln.user_ID where ln.news_ID= ? order by ln.news_ID asc";
        ArrayList<Likenews> listalllikenewbynewstid = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, newsid);
            rs = ps.executeQuery();

            while (rs.next()) {
                Likenews likenew = new Likenews();
                likenew.setUserid(rs.getInt("userid"));
                likenew.setFullname(rs.getString("fullname"));
                likenew.setUsername(rs.getString("username"));
                likenew.setStatus(rs.getInt("cmtstatus"));
                likenew.setNewsid(rs.getInt("newsid"));
                listalllikenewbynewstid.add(likenew);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listalllikenewbynewstid;
    }

    //Like comment
    public ArrayList<Likenews> getAllLikeNews() throws Exception {
        String query = "SELECT  u.user_FullName fullname,u.user_Name username, ln.[user_ID] userid,ln.news_ID newsid,ln.[Status] cmtstatus \n"
                + " FROM LikeNews ln inner join Users u on u.user_ID= ln.user_ID\n"
                + " inner join News n on n.news_ID= ln.news_ID\n"
                + "order by ln.news_ID asc";
        ArrayList<Likenews> listalllikenews = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);

            rs = ps.executeQuery();

            while (rs.next()) {
                Likenews likenew = new Likenews();
                likenew.setUserid(rs.getInt("userid"));
                likenew.setFullname(rs.getString("fullname"));
                likenew.setUsername(rs.getString("username"));
                likenew.setStatus(rs.getInt("cmtstatus"));
                likenew.setNewsid(rs.getInt("newsid"));
                listalllikenews.add(likenew);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listalllikenews;
    }

    //like comment
    public void saveLikeNews(int userid, int newsid) throws Exception {
        //excute update
        String query = "INSERT INTO [LikeNews]([user_ID],[news_ID]) VALUES (?,?)";
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userid);
            ps.setInt(2, newsid);
            int executeUpdate;
            executeUpdate = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //delete cua like comment by comment id
    public void deleteLikeNewsByNewsId(int newsid,int userid) throws Exception {
        //excute update
        String query = "DELETE FROM LikeNews WHERE news_ID = ? and user_ID= ?";
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, newsid);
            ps.setInt(2, userid);
            int executeUpdate;
            executeUpdate = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //
    public ArrayList<News> searchNews(int from, int to, String searchtxt) throws Exception {
        System.out.println(searchtxt);
        String query = "Select n.delete_Status delete_Status, u.user_ID userid,u.user_Name username,u.user_FullName fullname, n.news_ID newsid,n.news_Content content,n.news_DateRealease daterelease,n.news_Imgs,n.news_Resource newsresource,n.news_Tittles newstitle \n"
                + "from (select *, ROW_NUMBER() over(order by news_DateRealease DESC) as rownumber from News  where ((news_Tittles like ? OR news_Content like ?)) )\n"
                + "as n inner join Users u on u.user_ID= n.user_ID\n"
                + " and n.rownumber >= ? and n.rownumber <= ?";
        ArrayList<News> listallnews = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + searchtxt + "%");
            ps.setString(2, "%" + searchtxt + "%");
            ps.setInt(3, from);
            ps.setInt(4, to);

            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("userid"));
                user.setFullname(rs.getString("fullname"));
                user.setUsername(rs.getString("username"));
                News news = new News();
                news.setNewsID(rs.getInt("newsid"));
                news.setNewstittles(rs.getString("newstitle"));
                news.setNewscontent(rs.getString("content"));
                news.setNewsdaterealease(rs.getString("daterelease"));
                news.setNewsresource(rs.getString("newsresource"));
                news.setNews_Imgs(rs.getString("news_Imgs"));
                news.setDeleted(rs.getInt("delete_Status"));
                news.setUser(user);
                listallnews.add(news);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            new CloseConnection().close(conn, ps, rs);
        }
        return listallnews;
    }

    public int countDBresultsearch(String searchtxt) throws Exception {
        String query = "select COUNT(*) as numberrecord from News n where n.news_Tittles like ? OR n.news_Content like ?";
        int numberofrecord = 0;
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, "%" + searchtxt + "%");
            ps.setString(2, "%" + searchtxt + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                numberofrecord = rs.getInt("numberrecord");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            new CloseConnection().close(conn, ps, rs);
        }

        return numberofrecord;
    }
//count number of record in News table

    public int countDB() throws Exception {
        String query = "select COUNT(*) as numberrecord from News";
        int numberofrecord = 0;
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                numberofrecord = rs.getInt("numberrecord");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            new CloseConnection().close(conn, ps, rs);
        }

        return numberofrecord;
    }

    public ArrayList<News> getNewsFromTo(int from, int to) throws SQLException, Exception {
        ArrayList<News> arrayofnews = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement("Select u.user_Name username,u.user_FullName userfullname,n.news_ID newsid,n.delete_Status delete_Status,n.news_Content content,n.news_DateRealease newsdaterelease,n.news_Imgs newsimg,n.news_Resource newsresource,n.news_Tittles newstitle,n.user_ID userid from (select *, ROW_NUMBER() over(order by news_DateRealease DESC) as rownumber from News) \n"
                    + "as n inner join Users u on u.user_ID= n.user_ID where n.rownumber >= ? and n.rownumber <= ?");
            ps.setInt(1, from);
            ps.setInt(2, to);
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setId(rs.getInt("userid"));
                user.setFullname(rs.getString("userfullname"));
                News news = new News();
                news.setNewsID(rs.getInt("newsid"));
                news.setNews_Imgs(rs.getString("newsimg"));
                news.setNewscontent(rs.getString("content"));
                news.setNewsdaterealease(rs.getString("newsdaterelease"));
                news.setNewsresource(rs.getString("newsresource"));
                news.setNewstittles(rs.getString("newstitle"));
                news.setDeleted(rs.getInt("delete_Status"));
                news.setUser(user);
                arrayofnews.add(news);
            }

        } catch (Exception e) {
            throw e;
        } finally {
            new CloseConnection().close(conn, ps, rs);
        }
        return arrayofnews;
    }

    public ArrayList<News> getAllNews() throws Exception {
        String query = "select n.delete_Status delete_Status, u.user_ID userid,u.user_Name username,u.user_FullName fullname, n.news_ID newsid,n.news_Content content,n.news_DateRealease daterelease,n.news_Imgs,n.news_Resource newsresource,n.news_Tittles newstitle from News n\n"
                + "inner join Users u on u.user_ID= n.user_ID";
        ArrayList<News> listallnews = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("userid"));
                user.setFullname(rs.getString("fullname"));
                user.setUsername(rs.getString("username"));
                News news = new News();
                news.setNewsID(rs.getInt("newsid"));
                news.setNewstittles(rs.getString("newstitle"));
                news.setNewscontent(rs.getString("content"));
                news.setNewsdaterealease(rs.getString("daterelease"));
                news.setNewsresource(rs.getString("newsresource"));
                news.setNews_Imgs(rs.getString("news_Imgs"));
                news.setDeleted(rs.getInt("delete_Status"));
                news.setUser(user);
                listallnews.add(news);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            new CloseConnection().close(conn, ps, rs);
        }

        return listallnews;
    }

    public ArrayList<News> getAllNewsButDeleted() throws Exception {
        String query = "select n.delete_Status delete_Status, u.user_ID userid,u.user_Name username,\n"
                + "u.user_FullName fullname, n.news_ID newsid,n.news_Content content,n.news_DateRealease daterelease,\n"
                + "n.news_Imgs,n.news_Resource newsresource,n.news_Tittles newstitle \n"
                + "from News n \n"
                + "inner join Users u on u.user_ID= n.user_ID\n"
                + "where delete_status != 1";
        ArrayList<News> listallnews = new ArrayList<>();
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("userid"));
                user.setFullname(rs.getString("fullname"));
                user.setUsername(rs.getString("username"));
                News news = new News();
                news.setNewsID(rs.getInt("newsid"));
                news.setNewstittles(rs.getString("newstitle"));
                news.setNewscontent(rs.getString("content"));
                news.setNewsdaterealease(rs.getString("daterelease"));
                news.setNewsresource(rs.getString("newsresource"));
                news.setNews_Imgs(rs.getString("news_Imgs"));
                news.setDeleted(rs.getInt("delete_Status"));
                news.setUser(user);
                listallnews.add(news);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            new CloseConnection().close(conn, ps, rs);
        }

        return listallnews;
    }

    public News getNewsByID(int newsid) throws Exception {
        String query = "SELECT u.user_FullName fullname,u.user_Name username, [delete_Status],[news_ID],[news_Tittles],[news_Content],[news_DateRealease],[news_Resource],[news_Imgs],n.user_ID userid FROM [News] n \n"
                + "inner join Users u on n.user_ID= u.user_ID where news_ID=?";
        News news = new News();
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        ResultSet rs = null;
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, newsid);
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("userid"));
                user.setUsername(rs.getString("username"));
                user.setFullname(rs.getString("fullname"));
                news.setNewsID(rs.getInt("news_ID"));
                news.setNewstittles(rs.getString("news_Tittles"));
                news.setNewscontent(rs.getString("news_Content"));
                news.setNewsdaterealease(rs.getString("news_DateRealease"));
                news.setNewsresource(rs.getString("news_Resource"));
                news.setNews_Imgs(rs.getString("news_Imgs"));
                news.setDeleted(rs.getInt("delete_Status"));
                news.setUser(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            new CloseConnection().close(conn, ps, rs);
        }

        return news;
    }

    //chuc nang edit new,su dung cho admin cung can viet lai ben trong 
    public void UpdateNewbyNewId(String title, String newcontent, String newdate, String newresource, String newimage, int newsid) {
        try {
            String query = "UPDATE [AVS_Database_Final].[dbo].[News]  SET [new_Tittles] = ?,[new_Content] =?,"
                    + "[new_DateRealease] =?,[new_Resource] = ?,[new_Imgs] =? WHERE new_ID= ?";
            DBContext dbManager = new DBContext();
            Connection conn = null;
            PreparedStatement ps = null; //de nhan paramenter
            try {
                conn = dbManager.getConnection();
                ps = conn.prepareStatement(query);
                ps.setString(1, title);
                ps.setString(2, newcontent);
                ps.setString(3, newdate);
                ps.setString(4, newresource);
                ps.setString(5, newimage);
                ps.setInt(6, newsid);
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }

        } catch (Exception ex) {
            Logger.getLogger(CommentModel.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    /*
     public void deleteNewById(int newid) throws Exception {
     //excute update
     String query = "";
     DBContext dbManager = new DBContext();
     Connection conn = null;
     PreparedStatement ps = null; //de nhan paramenter
     try {
     conn = dbManager.getConnection();
     ps = conn.prepareStatement(query);
     ps.setInt(1, newid);
     int executeUpdate;
     executeUpdate = ps.executeUpdate();
     } catch (SQLException e) {
     e.printStackTrace();
     }
     }
     */
//tao ra new, phai sua code ben trong truoc khi su dung

    public void createNews(String title, String newcontent, String newdate, String newresource, String newimage, int newsid) throws Exception {
        //excute insert
        String query = "INSERT INTO [AVS_Database_Final].[dbo].[News] VALUES  (?,?,?,?,?,?)";
        DBContext dbManager = new DBContext();
        Connection conn = null;
        PreparedStatement ps = null; //de nhan paramenter
        try {
            conn = dbManager.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, title);
            ps.setString(2, newcontent);
            ps.setString(3, newdate);
            ps.setString(4, newresource);
            ps.setString(5, newimage);
            ps.setInt(6, newsid);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
