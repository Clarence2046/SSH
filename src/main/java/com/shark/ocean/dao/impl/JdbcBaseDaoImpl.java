package com.shark.ocean.dao.impl;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.ConnectionCallback;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.stereotype.Repository;

import com.shark.ocean.dao.IJdbcBaseDao;
import com.shark.ocean.util.MenuUtil;

@Repository("jdbcDao")
public class JdbcBaseDaoImpl extends JdbcDaoSupport implements IJdbcBaseDao {
	@Autowired
	public JdbcBaseDaoImpl(DataSource dataSource) {
		setDataSource(dataSource);
	}
	

	public List<MenuUtil> getAllMenus() {
		/**
		 * 先使用查询数据库的方式查询权限,并分类
		 */
		//one
		String sql = "select authid,authurl,authname,visiturl from ocean_right where authlevel = 1 and authstatus=0 ";
		List<MenuUtil> oneMenus = getMenuBySql(sql);
		for (MenuUtil menuUtil : oneMenus) {
			//two
			sql = "select authid,authurl,authname,visiturl from ocean_right where  authstatus=0 and parentauthid='"+menuUtil.getId()+"'";
			List<MenuUtil> twoMenus = getMenuBySql(sql);
			menuUtil.setChildrenMenu(twoMenus);
			for (MenuUtil menuUtil2 : twoMenus) {
				//three
				sql = "select authid,authurl,authname,visiturl from ocean_right where  authstatus=0 and parentauthid='"+menuUtil2.getId()+"'";
				List<MenuUtil> threeMenus = getMenuBySql(sql);
				menuUtil2.setChildrenMenu(threeMenus);
			}
		}
		return oneMenus;
	}

	/**
	 * 查询权限
	 * @param sql
	 * @return
	 */
	protected List<MenuUtil> getMenuBySql(String sql){
		List<MenuUtil> menus = getJdbcTemplate().query(sql, new RowMapper<MenuUtil>() {
			public MenuUtil mapRow(ResultSet rs, int rowNum) throws SQLException {
				MenuUtil right = new MenuUtil();
				
				right.setId(String.valueOf(rs.getLong("AUTHID")));
				right.setAuthUrl(rs.getString("AUTHURL"));
				right.setTitle(rs.getString("AUTHNAME"));
				right.setUrl(rs.getString("VISITURL"));
				return right;
			}
		});
		return menus;
	}


	public void saveRoleRights(String roleId, String[] rightIds) {
		String deleteSql = "delete from ocean_role_right where roleid=?";
		try{
			int update = getJdbcTemplate().update(deleteSql,roleId );
		}catch(Exception e){
			e.printStackTrace();
			return;
		}
		try{
			//插入
			String insertSql = "insert into ocean_role_right (roleid,rightid) values (?,?)";
			for (String rightId : rightIds) {
				if(StringUtils.isNoneEmpty(rightId)){
					getJdbcTemplate().update(insertSql, roleId,rightId);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			return;
		}
		
	}


	public List<Map<String, String>> getBySql(String sql) {
		List<Map<String,String>> query = getJdbcTemplate().query(sql, new RowMapper<Map<String, String>>() {
			public Map<String, String> mapRow(ResultSet rs, int rowNum)
					throws SQLException {
				ResultSetMetaData metaData = rs.getMetaData();
				int columnCount = metaData.getColumnCount();
				Map<String, String>  map = new HashMap<String, String>();
				for (int i = 1; i <= columnCount; i++) {
					map.put(metaData.getColumnName(i), rs.getString(i));
				}
				return map;
			}
		});
		
		return query;
	}


	public void saveUserRoles(String userId, String[] roleIds) {
		String deleteSql = "delete from ocean_user_role where userid=?";
		try{
			int update = getJdbcTemplate().update(deleteSql,userId );
		}catch(Exception e){
			e.printStackTrace();
			return;
		}
		try{
			//插入
			String insertSql = "insert into ocean_user_role (userid,roleid) values (?,?)";
			for (String roleId : roleIds) {
				if(StringUtils.isNoneEmpty(roleId)){
					getJdbcTemplate().update(insertSql, userId,roleId);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			return;
		}
	}


	public List<MenuUtil> getAllRoles() {
		String sql= "select * from ocean_role";
		List<MenuUtil> menus = getJdbcTemplate().query(sql, new RowMapper<MenuUtil>() {
			public MenuUtil mapRow(ResultSet rs, int rowNum) throws SQLException {
				MenuUtil right = new MenuUtil();
				right.setId(String.valueOf(rs.getLong("ROLEID")));
				right.setTitle(rs.getString("ROLENAME"));
				return right;
			}
		});
		return menus;
	}

	
	/**
	 * 添加标签
	 */
	public void addLabel(String name) {
		try {
			String sql = "insert into ocean_label (name) values (?)";
			getJdbcTemplate().update(sql, name);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	/**
	 * 删除标签
	 */
	public void deleteLabel(Integer id) {
		try {
			String sql = "delete from  ocean_label where id=?";
			getJdbcTemplate().update(sql, id);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}


	public void updateBlog(Integer id, Object[] columns, Object[] params) {
		try {
			Object[] values = new Object[params.length+1];
			StringBuilder sb = new StringBuilder("update ocean_blog set ");
			
			for (int i = 0; i < columns.length; i++) {
				sb.append(columns[i]).append("=?");
				if(i<columns.length-1){
					sb.append(",");
				}
				values[i] = params[i];
			}
			sb.append(" where id=?");
			System.out.println("更新语句:"+sb.toString());
			values[params.length] = id;
			
			getJdbcTemplate().update(sb.toString(), values);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}

	
}
