-- 用户表
CREATE TABLE `ocean_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET gbk DEFAULT NULL,
  `password` varchar(255) CHARACTER SET gbk DEFAULT NULL,
  `type` int(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

--角色表
CREATE TABLE `ocean_role` (
  `roleid` bigint(20) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`roleid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--权限表
CREATE TABLE `ocean_right` (
  `authid` bigint(10) NOT NULL,
  `parentauthid` bigint(10) DEFAULT NULL,
  `authname` varchar(64) DEFAULT NULL,
  `authurl` varchar(255) DEFAULT NULL,
  `visiturl` varchar(255) DEFAULT NULL,
  `authlevel` int(1) DEFAULT NULL,
  `authstatus` int(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`authid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--用户角色关联表
CREATE TABLE `ocean_user_role` (
  `userid` bigint(20) NOT NULL,
  `roleid` bigint(20) NOT NULL,
  PRIMARY KEY (`userid`,`roleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--角色权限关联表
CREATE TABLE `ocean_role_right` (
  `roleid` bigint(20) NOT NULL,
  `rightid` bigint(20) NOT NULL,
  PRIMARY KEY (`roleid`,`rightid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--博客标签管理表
CREATE TABLE `ocean_label` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--博客表
CREATE TABLE `ocean_blog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL,
  `createdate` datetime DEFAULT NULL COMMENT '创建时间',
  `publishdate` datetime DEFAULT NULL COMMENT '发布时间',
  `modifydate` datetime DEFAULT NULL COMMENT '修改时间',
  `visible` int(1) DEFAULT NULL COMMENT '前台是否可见 0：可见 1：不可见',
  `lockComment` int(1) DEFAULT NULL COMMENT '锁住评论，不能继续评论 0:开放  1：锁住',
  `content` blob,
  `labels` varchar(255) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `views` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--评论表
CREATE TABLE `ocean_comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `blogid` bigint(20) DEFAULT NULL,
  `replyid` bigint(20) DEFAULT NULL COMMENT '回复的评论id',
  `commentcontent` blob,
  `type` int(1) DEFAULT NULL COMMENT '评论类型 0:主评论  1：回复',
  `createdate` datetime DEFAULT NULL,
  `blobContent` longblob,
  `floor` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
