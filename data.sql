/*
 Navicat Premium Data Transfer

 Source Server         : 111
 Source Server Type    : MySQL
 Source Server Version : 80035
 Source Host           : localhost:3306
 Source Schema         : library

 Target Server Type    : MySQL
 Target Server Version : 80035
 File Encoding         : 65001

 Date: 12/01/2024 17:49:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for alembic_version
-- ----------------------------
DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE `alembic_version`  (
  `version_num` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`version_num`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of alembic_version
-- ----------------------------
INSERT INTO `alembic_version` VALUES ('2fb35d94ed43');

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `book_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ISBN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `location` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `manager_id` int NOT NULL,
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '不外借 未借出 已预约 已借出',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `book_id`(`book_id` ASC) USING BTREE,
  INDEX `ISBN`(`ISBN` ASC) USING BTREE,
  INDEX `manager_id`(`manager_id` ASC) USING BTREE,
  CONSTRAINT `book_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `booktable` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `book_ibfk_2` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `check_book_location` CHECK (`location` in (_utf8mb3'图书阅览室',_utf8mb3'图书流通室')),
  CONSTRAINT `check_book_location_status` CHECK (((`location` = _utf8mb3'图书阅览室') and (`status` = _utf8mb3'不外借')) or (`location` <> _utf8mb3'图书阅览室')),
  CONSTRAINT `check_book_status` CHECK (`status` in (_utf8mb3'不外借',_utf8mb3'未借出',_utf8mb3'已预约',_utf8mb3'已借出'))
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, 'C101.1', 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (2, 'C106.2', 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (3, 'C106.5', 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book` VALUES (4, 'C106.6', 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (5, 'C107.3', 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book` VALUES (6, 'C103.1', 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (7, 'C107.1', 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book` VALUES (8, 'C102.3', 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book` VALUES (9, 'C106.1', 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book` VALUES (10, 'C102.4', 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (11, 'C105.3', 'ISBN7-302-02368-105', '图书流通室', 1, '已预约');
INSERT INTO `book` VALUES (12, 'C104.2', 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (13, 'C108.1', 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book` VALUES (14, 'C107.5', 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book` VALUES (15, 'C104.3', 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book` VALUES (16, 'C103.3', 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (17, 'C102.1', 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book` VALUES (18, 'C105.1', 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (19, 'C107.2', 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (20, 'C106.7', 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book` VALUES (21, 'C101.3', 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (22, 'C103.2', 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book` VALUES (23, 'C101.2', 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (24, 'C108.2', 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book` VALUES (25, 'C102.5', 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (26, 'C107.6', 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book` VALUES (27, 'C108.5', 'ISBN7-302-02368-108', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (28, 'C105.4', 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (29, 'C105.2', 'ISBN7-302-02368-105', '图书流通室', 1, '未借出');
INSERT INTO `book` VALUES (30, 'C106.3', 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book` VALUES (31, 'C106.4', 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (32, 'C108.3', 'ISBN7-302-02368-108', '图书流通室', 1, '已借出');
INSERT INTO `book` VALUES (33, 'C102.2', 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book` VALUES (34, 'C107.4', 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book` VALUES (35, 'C103.4', 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book` VALUES (36, 'C109.6', 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book` VALUES (37, 'C104.4', 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book` VALUES (38, 'C107.7', 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book` VALUES (39, 'C108.4', 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book` VALUES (40, 'C104.1', 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');

-- ----------------------------
-- Table structure for booktable
-- ----------------------------
DROP TABLE IF EXISTS `booktable`;
CREATE TABLE `booktable`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ISBN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` float NOT NULL,
  `publish` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pub_date` date NOT NULL,
  `manager_id` int NULL DEFAULT NULL,
  `num` int NOT NULL,
  `version` int NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ISBN`(`ISBN` ASC) USING BTREE,
  UNIQUE INDEX `label`(`label` ASC) USING BTREE,
  INDEX `manager_id`(`manager_id` ASC) USING BTREE,
  CONSTRAINT `booktable_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of booktable
-- ----------------------------
INSERT INTO `booktable` VALUES (1, '计算机网络', '谢希仁', 'ISBN7-302-02368-101', 51, '清华大学出版社', '2002-09-01', 1, 3, 6, 'https://shudb.oss-cn-beijing.aliyuncs.com/ks/%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%BD%91%E7%BB%9C.jpg', 'C101');
INSERT INTO `booktable` VALUES (2, '计算机操作系统慕课版', '汤小丹 王红玲 姜华 汤子瀛', 'ISBN7-302-02368-102', 52, '人民邮电出版社', '2005-11-01', 1, 5, 1, 'https://shudb.oss-cn-beijing.aliyuncs.com/ks/%E8%AE%A1%E7%AE%97%E6%9C%BA%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F.jpg', 'C102');
INSERT INTO `booktable` VALUES (3, '软件工程', '齐治昌 谭庆平 宁洪等', 'ISBN7-302-02368-103', 53, '高等教育出版社', '2008-03-01', 1, 4, 4, 'https://shudb.oss-cn-beijing.aliyuncs.com/ks/%E8%BD%AF%E4%BB%B6%E5%B7%A5%E7%A8%8B.jpg', 'C103');
INSERT INTO `booktable` VALUES (4, '算法导论', 'Thomas H. Cormen', 'ISBN7-302-02368-104', 54, '机械工业出版社', '2010-06-01', 1, 4, 3, 'https://shudb.oss-cn-beijing.aliyuncs.com/ks/%E7%AE%97%E6%B3%95%E5%AF%BC%E8%AE%BA.jpg', 'C104');
INSERT INTO `booktable` VALUES (5, '人工智能导论（Python版）微课视频版', '姜春茂', 'ISBN7-302-02368-105', 55, '清华大学出版社', '2013-08-01', 1, 4, 1, 'https://shudb.oss-cn-beijing.aliyuncs.com/ks/%E4%BA%BA%E5%B7%A5%E6%99%BA%E8%83%BD.jpg', 'C105');
INSERT INTO `booktable` VALUES (6, '计算机图形学', '张燕 李楠 潘晓光', 'ISBN7-302-02368-106', 56, '清华大学出版社', '2016-02-01', 1, 7, 8, 'https://shudb.oss-cn-beijing.aliyuncs.com/ks/%E8%AE%A1%E7%AE%97%E6%9C%BA%E5%9B%BE%E5%BD%A2%E5%AD%A6.jpg', 'C106');
INSERT INTO `booktable` VALUES (7, '数据挖掘原理', '麦克斯·布拉默', 'ISBN7-302-02368-107', 57, '机械工业出版社', '2018-04-01', 1, 7, 3, 'https://shudb.oss-cn-beijing.aliyuncs.com/ks/%E6%95%B0%E6%8D%AE%E6%8C%96%E6%8E%98%E5%8E%9F%E7%90%86.jpg', 'C107');
INSERT INTO `booktable` VALUES (8, '计算机组成原理', '白中英 戴志涛等', 'ISBN7-302-02368-108', 58, '科学出版社', '2021-07-01', 1, 5, 6, 'https://shudb.oss-cn-beijing.aliyuncs.com/ks/%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%BB%84%E6%88%90%E5%8E%9F%E7%90%86.jpg', 'C108');
INSERT INTO `booktable` VALUES (9, '计算机体系结构', 'Gerard Blanchet Bertrand Dupouy', 'ISBN7-302-02368-109', 59, '清华大学出版社', '2017-09-01', 1, 1, 1, 'https://shudb.oss-cn-beijing.aliyuncs.com/ks/%E8%AE%A1%E7%AE%97%E6%9C%BA%E4%BD%93%E7%B3%BB%E7%BB%93%E6%9E%84.jpg', 'C109');

-- ----------------------------
-- Table structure for captcha
-- ----------------------------
DROP TABLE IF EXISTS `captcha`;
CREATE TABLE `captcha`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of captcha
-- ----------------------------

-- ----------------------------
-- Table structure for lend
-- ----------------------------
DROP TABLE IF EXISTS `lend`;
CREATE TABLE `lend`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `book_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `reader_id` int NULL DEFAULT NULL,
  `lend_date` datetime NULL DEFAULT NULL,
  `return_date` datetime NULL DEFAULT NULL COMMENT '实际还书日期',
  `due_date` datetime NULL DEFAULT NULL COMMENT '应还日期',
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '已还 未还  超期未还',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `book_id`(`book_id` ASC) USING BTREE,
  INDEX `reader_id`(`reader_id` ASC) USING BTREE,
  CONSTRAINT `lend_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lend_ibfk_2` FOREIGN KEY (`reader_id`) REFERENCES `reader` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `check_lend_status` CHECK (`status` in (_utf8mb3'未还',_utf8mb3'已还',_utf8mb3'超期未还'))
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lend
-- ----------------------------

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES (1, '张三', '123456', '789456@shu.edu.cn');

-- ----------------------------
-- Table structure for reader
-- ----------------------------
DROP TABLE IF EXISTS `reader`;
CREATE TABLE `reader`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fine` decimal(6, 2) NOT NULL,
  `borrow_num` int NOT NULL COMMENT '一名读者最多只能借阅十本图书，且每本图书最多只能借两个月',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE,
  CONSTRAINT `check_fine` CHECK (`fine` >= 0),
  CONSTRAINT `check_reader_borrow_num` CHECK ((`borrow_num` >= 0) and (`borrow_num` <= 10))
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reader
-- ----------------------------
INSERT INTO `reader` VALUES (1, '孙杰宏', 'FxPyLpRVS3', 'sunjiehong@gmail.com', '182-9818-4821', 28.59, 0);
INSERT INTO `reader` VALUES (2, '毛云熙', 'GE7N9jSOso', 'mayun@gmail.com', '760-630-5412', 18.25, 8);
INSERT INTO `reader` VALUES (3, '吕云熙', '2pm8klwbtx', 'yunxil1@gmail.com', '755-397-9742', 13.76, 0);
INSERT INTO `reader` VALUES (4, '曹震南', 'uCSLIToGiv', 'zhennan7@gmail.com', '760-4125-9007', 18.10, 0);
INSERT INTO `reader` VALUES (5, '黄安琪', 'EZqNtDAGta', 'hanqi64@mail.com', '21-8075-7669', 13.50, 7);
INSERT INTO `reader` VALUES (6, '金子异', 'PvvlbON8wD', 'ziyi207@icloud.com', '131-5574-4012', 49.57, 0);
INSERT INTO `reader` VALUES (7, '汤宇宁', 'ZUdnp0Laaj', 'tangy@yahoo.com', '21-7224-4932', 21.11, 0);
INSERT INTO `reader` VALUES (8, '丁致远', 'xJLo4EcHks', 'zdin@yahoo.com', '160-9445-0554', 27.76, 0);
INSERT INTO `reader` VALUES (9, '龚秀英', '5ctcAbQbxf', 'gonxiuying419@gmail.com', '198-2369-5767', 32.08, 9);
INSERT INTO `reader` VALUES (10, '杨璐', 'cRHyR3jiPS', 'luyang929@mail.com', '769-1991-2806', 1.93, 0);

-- ----------------------------
-- Table structure for reserve
-- ----------------------------
DROP TABLE IF EXISTS `reserve`;
CREATE TABLE `reserve`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `ISBN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `reader_id` int NULL DEFAULT NULL,
  `reserve_date` datetime NOT NULL COMMENT '预约日期',
  `reserve_deadline` int NOT NULL COMMENT '预约期限（天）',
  `book_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ISBN`(`ISBN` ASC) USING BTREE,
  INDEX `book_id`(`book_id` ASC) USING BTREE,
  INDEX `reader_id`(`reader_id` ASC) USING BTREE,
  CONSTRAINT `reserve_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `booktable` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reserve_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reserve_ibfk_3` FOREIGN KEY (`reader_id`) REFERENCES `reader` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `check_reserve_deadline` CHECK (`reserve_deadline` <= 10)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reserve
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
