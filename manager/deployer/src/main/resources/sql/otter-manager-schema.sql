CREATE DATABASE /*!32312 IF NOT EXISTS*/ `udip_otter` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;

USE `udip_otter`;

CREATE TABLE `ALARM_RULE` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `MONITOR_NAME` varchar(1024) DEFAULT NULL,
  `RECEIVER_KEY` varchar(1024) DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `PIPELINE_ID` bigint(20) NOT NULL,
  `DESCRIPTION` varchar(256) DEFAULT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MATCH_VALUE` varchar(1024) DEFAULT NULL,
  `PARAMETERS` text DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `AUTOKEEPER_CLUSTER` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CLUSTER_NAME` varchar(200) NOT NULL,
  `SERVER_LIST` varchar(1024) NOT NULL,
  `DESCRIPTION` varchar(200) DEFAULT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `CANAL` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(200) DEFAULT NULL,
  `DESCRIPTION` varchar(200) DEFAULT NULL,
  `PARAMETERS` text DEFAULT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CANALUNIQUE` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `CHANNEL` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(200) DEFAULT NULL,
  `PARAMETERS` text DEFAULT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CHANNELUNIQUE` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `COLUMN_PAIR` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `SOURCE_COLUMN` varchar(200) DEFAULT NULL,
  `TARGET_COLUMN` varchar(200) DEFAULT NULL,
  `DATA_MEDIA_PAIR_ID` bigint(20) NOT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_DATA_MEDIA_PAIR_ID` (`DATA_MEDIA_PAIR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `COLUMN_PAIR_GROUP` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DATA_MEDIA_PAIR_ID` bigint(20) NOT NULL,
  `COLUMN_PAIR_CONTENT` text DEFAULT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_DATA_MEDIA_PAIR_ID` (`DATA_MEDIA_PAIR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `DATA_MEDIA` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(200) NOT NULL,
  `NAMESPACE` varchar(200) NOT NULL,
  `PROPERTIES` varchar(1000) NOT NULL,
  `DATA_MEDIA_SOURCE_ID` bigint(20) NOT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `DATAMEDIAUNIQUE` (`NAME`,`NAMESPACE`,`DATA_MEDIA_SOURCE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `DATA_MEDIA_PAIR` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PULLWEIGHT` bigint(20) DEFAULT NULL,
  `PUSHWEIGHT` bigint(20) DEFAULT NULL,
  `RESOLVER` text DEFAULT NULL,
  `FILTER` text DEFAULT NULL,
  `SOURCE_DATA_MEDIA_ID` bigint(20) DEFAULT NULL,
  `TARGET_DATA_MEDIA_ID` bigint(20) DEFAULT NULL,
  `PIPELINE_ID` bigint(20) NOT NULL,
  `COLUMN_PAIR_MODE` varchar(20) DEFAULT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_PipelineID` (`PIPELINE_ID`,`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `DATA_MEDIA_SOURCE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(200) NOT NULL,
  `TYPE` varchar(20) NOT NULL,
  `PROPERTIES` varchar(1000) NOT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `DATAMEDIASOURCEUNIQUE` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `DELAY_STAT` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DELAY_TIME` int(21) NOT NULL,
  `DELAY_NUMBER` bigint(20) NOT NULL,
  `PIPELINE_ID` bigint(20) NOT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_PipelineID_GmtModified_ID` (`PIPELINE_ID`,`GMT_MODIFIED`,`ID`),
  KEY `idx_Pipeline_GmtCreate` (`PIPELINE_ID`,`GMT_CREATE`),
  KEY `idx_GmtCreate_id` (`GMT_CREATE`,`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `LOG_RECORD` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NID` varchar(200) DEFAULT NULL,
  `CHANNEL_ID` varchar(200) NOT NULL,
  `PIPELINE_ID` varchar(200) NOT NULL,
  `TITLE` varchar(1000) DEFAULT NULL,
  `MESSAGE` text DEFAULT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `logRecord_pipelineId` (`PIPELINE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `NODE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(200) NOT NULL,
  `IP` varchar(200) NOT NULL,
  `PORT` bigint(20) NOT NULL,
  `DESCRIPTION` varchar(200) DEFAULT NULL,
  `PARAMETERS` text DEFAULT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NODEUNIQUE` (`NAME`,`IP`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `PIPELINE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(200) DEFAULT NULL,
  `PARAMETERS` text DEFAULT NULL,
  `CHANNEL_ID` bigint(20) NOT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PIPELINEUNIQUE` (`NAME`,`CHANNEL_ID`),
  KEY `idx_ChannelID` (`CHANNEL_ID`,`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `PIPELINE_NODE_RELATION` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NODE_ID` bigint(20) NOT NULL,
  `PIPELINE_ID` bigint(20) NOT NULL,
  `LOCATION` varchar(20) NOT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_PipelineID` (`PIPELINE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `SYSTEM_PARAMETER` (
  `ID` bigint(20) unsigned NOT NULL,
  `VALUE` text DEFAULT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `TABLE_HISTORY_STAT` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `FILE_SIZE` bigint(20) DEFAULT NULL,
  `FILE_COUNT` bigint(20) DEFAULT NULL,
  `INSERT_COUNT` bigint(20) DEFAULT NULL,
  `UPDATE_COUNT` bigint(20) DEFAULT NULL,
  `DELETE_COUNT` bigint(20) DEFAULT NULL,
  `DATA_MEDIA_PAIR_ID` bigint(20) DEFAULT NULL,
  `PIPELINE_ID` bigint(20) DEFAULT NULL,
  `START_TIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `END_TIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_DATA_MEDIA_PAIR_ID_END_TIME` (`DATA_MEDIA_PAIR_ID`,`END_TIME`),
  KEY `idx_GmtCreate_id` (`GMT_CREATE`,`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `TABLE_STAT` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `FILE_SIZE` bigint(20) NOT NULL,
  `FILE_COUNT` bigint(20) NOT NULL,
  `INSERT_COUNT` bigint(20) NOT NULL,
  `UPDATE_COUNT` bigint(20) NOT NULL,
  `DELETE_COUNT` bigint(20) NOT NULL,
  `DATA_MEDIA_PAIR_ID` bigint(20) NOT NULL,
  `PIPELINE_ID` bigint(20) NOT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_PipelineID_DataMediaPairID` (`PIPELINE_ID`,`DATA_MEDIA_PAIR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `THROUGHPUT_STAT` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE` varchar(20) NOT NULL,
  `NUMBER` bigint(20) NOT NULL,
  `SIZE` bigint(20) NOT NULL,
  `PIPELINE_ID` bigint(20) NOT NULL,
  `START_TIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `END_TIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idx_PipelineID_Type_GmtCreate_ID` (`PIPELINE_ID`,`TYPE`,`GMT_CREATE`,`ID`),
  KEY `idx_PipelineID_Type_EndTime_ID` (`PIPELINE_ID`,`TYPE`,`END_TIME`,`ID`),
  KEY `idx_GmtCreate_id` (`GMT_CREATE`,`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `USER` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(20) NOT NULL,
  `PASSWORD` varchar(20) NOT NULL,
  `AUTHORIZETYPE` varchar(20) NOT NULL,
  `DEPARTMENT` varchar(20) NOT NULL,
  `REALNAME` varchar(20) NOT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USERUNIQUE` (`USERNAME`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE  `DATA_MATRIX` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `GROUP_KEY` varchar(200) DEFAULT NULL,
  `MASTER` varchar(200) DEFAULT NULL,
  `SLAVE` varchar(200) DEFAULT NULL,
  `DESCRIPTION` varchar(200) DEFAULT NULL,
  `GMT_CREATE` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `GMT_MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `GROUPKEY` (`GROUP_KEY`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


insert into USER(ID,USERNAME,PASSWORD,AUTHORIZETYPE,DEPARTMENT,REALNAME,GMT_CREATE,GMT_MODIFIED) values(null,'admin','801fc357a5a74743894a','ADMIN','admin','admin',now(),now());
insert into USER(ID,USERNAME,PASSWORD,AUTHORIZETYPE,DEPARTMENT,REALNAME,GMT_CREATE,GMT_MODIFIED) values(null,'guest','471e02a154a2121dc577','OPERATOR','guest','guest',now(),now());




create table LOAD_ROUTE (
  ID bigint not null auto_increment comment '主键',
  PIPELINE_ID bigint not null comment '管道主键',
  TABLE_ID bigint not null comment '表id',
  LOAD_DATA_MEDIA_ID bigint not null comment '类型为mq service redis id',
  TYPE INTEGER not null DEFAULT 1 comment '1:加载单表索引，2：不加载单表索引',
  DESCRIPTION varchar(200) default null,
  CREATED timestamp not null default '0000-00-00 00:00:00'  comment '创建时间',
  MODIFIED timestamp not null default current_timestamp on update current_timestamp   comment '修改时间',
  primary key (ID)
)engine=innodb default charset=utf8  comment='元数据存储路由表';

create table WIDE_TABLE (
  ID bigint not null auto_increment comment '主键',
  WIDE_TABLE_NAME varchar(100) not null comment '宽表名称',
  MAIN_TABLE_ID bigint not null comment '主表id',
  MAIN_TABLE_PKID_NAME varchar(100) not null comment '主表主键名称',
  SLAVE_TABLE_ID bigint not null comment '从表主键',
  SLAVE_TABLE_PKID_NAME varchar(100) not null comment '从表主键名称',
  REAL_TABLE_FKID_NAME varchar(100) not null comment '关联键名称',
  REAL_FKID_TABLE_ID bigint not null comment '关联键对应的表id',
  TARGET_ID bigint not null comment '索引配置对象',
  DESCRIPTION varchar(200) default null,
  CREATED timestamp null comment '创建时间',
  MODIFIED timestamp null comment '修改',
  unique key LOAD_WIDE_TABLE_UKEY (TARGET_ID,MAIN_TABLE_ID,SLAVE_TABLE_ID),
  primary key (ID)
)engine=innodb default charset=utf8  comment='宽表';

ALTER TABLE WIDE_TABLE ADD SLAVE_MAIN_FKID_NAME varchar(100) default null comment '主表外键id名称';
ALTER TABLE WIDE_TABLE MODIFY REAL_FKID_TABLE_ID bigint DEFAULT 0  ;
ALTER TABLE WIDE_TABLE change SLAVE_TABLE_PKID_NAME SLAVE_TABLE_FKID_NAME varchar(100) not null comment '从表外键名称';
ALTER TABLE WIDE_TABLE ADD SLAVE_TABLE_PKID_NAME varchar(100) default null comment '从表主键键名称';




# test data
#insert into load_route values (null,1,2,100,1,'load_route cl index ',now(),now());
#insert into DATA_MEDIA_SOURCE values(100,'cl_index','ES','{"clusterName":"es","clusterNodes":"127.0.0.1:9300",id:100,"name":"cl_index","type":"ES"}',now(),now());
#insert into DATA_MEDIA values(100,'udip','cl-index','{"mode":"SINGLE","name":"udip","namespace":"cl-index","source":{"clusterName":"es","clusterNodes":"127.0.0.1:9300",id:100,"name":"cl_index","type":"ES"}}',100,now(),now());




