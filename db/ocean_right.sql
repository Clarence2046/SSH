INSERT INTO `ocean_right` VALUES (0, -1, '后台权限', '/app/mgr', NULL, 0, 0, '');
INSERT INTO `ocean_right` VALUES (100100000, 0, '用户管理', '/app/mgr/user/list*', '/app/mgr/user/list', 1, 0, '');
INSERT INTO `ocean_right` VALUES (100100001, 100100000, '用户ajax校验', '/app/mgr/ajaxuser*', NULL, 3, 0, '');
INSERT INTO `ocean_right` VALUES (100100002, 100100000, '用户添加', '/app/mgr/user/add*', NULL, 3, 0, '');
INSERT INTO `ocean_right` VALUES (100100003, 100100000, '用户删除', '/app/mgr/user/delete*', NULL, 3, 0, '');
INSERT INTO `ocean_right` VALUES (100200000, 0, '权限管理', '/app/mgr/right/list*', '/app/mgr/right/list', 1, 0, '');
INSERT INTO `ocean_right` VALUES (100200001, 100200000, '权限ajax校验', '/app/mgr/ajaxright*', NULL, 3, 0, '');
INSERT INTO `ocean_right` VALUES (100200002, 100200000, '权限添加', '/app/mgr/right/add*', NULL, 3, 0, '');
INSERT INTO `ocean_right` VALUES (100200003, 100200000, '权限删除', '/app/mgr/right/delete*', NULL, 3, 0, '');
INSERT INTO `ocean_right` VALUES (100300000, 0, '角色管理', '/app/mgr/role/list', '/app/mgr/role/list', 1, 0, '');
INSERT INTO `ocean_right` VALUES (100300100, 100300000, '角色列表', '/app/mgr/role/list', '/app/mgr/role/list', 2, 0, '');
INSERT INTO `ocean_right` VALUES (100300101, 100300100, '角色删除', '/app/mgr/role/delete*', NULL, 3, 0, '');
INSERT INTO `ocean_right` VALUES (100300102, 100300100, '角色更新', '/app/mgr/role/edit*', NULL, 3, 0, '');
INSERT INTO `ocean_right` VALUES (100300200, 100300000, '角色添加', '/app/mgr/role/add*', '/app/mgr/role/addpage', 2, 0, '');
INSERT INTO `ocean_right` VALUES (100400000, 0, '博客文章', '/app/mgr/blog/list*', '/app/mgr/blog/list', 1, 0, '');
INSERT INTO `ocean_right` VALUES (100400100, 100400000, '博客列表', '/app/mgr/blog/list*', '/app/mgr/blog/list', 2, 0, '');
INSERT INTO `ocean_right` VALUES (100400200, 100400000, '博客添加', '/app/mgr/blog/add*', '/app/mgr/blog/addpage', 2, 0, '');
INSERT INTO `ocean_right` VALUES (100400300, 100400000, '标签管理', '/app/mgr/blog/label', '/app/mgr/blog/labelpage', 2, 0, '');
INSERT INTO `ocean_right` VALUES (100400301, 100400300, '标签添加', '/app/mgr/blog/labeladd', '/app/mgr/blog/labeladd', 3, 0, '');
INSERT INTO `ocean_right` VALUES (100400302, 100400300, '标签删除', '/app/mgr/blog/labeldelete', '/app/mgr/blog/labeldelete', 3, 0, '');
INSERT INTO `ocean_right` VALUES (100500000, 0, '评论管理', '/app/mgr/comment/list', '/app/mgr/comment/list', 1, 0, '');
