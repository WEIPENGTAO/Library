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

 Date: 05/01/2024 19:46:10
*/

# SET NAMES utf8mb4;
# SET FOREIGN_KEY_CHECKS = 0;
#
# -- ----------------------------
# -- Table structure for alembic_version
# -- ----------------------------
# DROP TABLE IF EXISTS `alembic_version`;
# CREATE TABLE `alembic_version`
# (
#     `version_num` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
#     PRIMARY KEY (`version_num`) USING BTREE
# ) ENGINE = InnoDB
#   CHARACTER SET = utf8mb4
#   COLLATE = utf8mb4_0900_ai_ci
#   ROW_FORMAT = Dynamic;
#
# -- ----------------------------
# -- Records of alembic_version
# -- ----------------------------
# INSERT INTO `alembic_version`
# VALUES ('ce6e7740ba40');
#
#

-- ----------------------------
-- Table structure for manager
-- ----------------------------
# DROP TABLE IF EXISTS `manager`;
# CREATE TABLE `manager`
# (
#     `id`       int                                                          NOT NULL AUTO_INCREMENT,
#     `name`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
#     `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
#     `email`    varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
#     PRIMARY KEY (`id`) USING BTREE,
#     UNIQUE INDEX `email` (`email` ASC) USING BTREE
# ) ENGINE = InnoDB
#   AUTO_INCREMENT = 1
#   CHARACTER SET = utf8mb4
#   COLLATE = utf8mb4_0900_ai_ci
#   ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager`
VALUES (1, '张三', '123456', '123456@shu.edu.cn');

# -- ----------------------------
# -- Table structure for booktable
# -- ----------------------------
# DROP TABLE IF EXISTS `booktable`;
# CREATE TABLE `booktable`
# (
#     `id`         int                                                           NOT NULL AUTO_INCREMENT,
#     `name`       varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
#     `author`     varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
#     `ISBN`       varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
#     `price`      float                                                         NOT NULL,
#     `publish`    varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
#     `pub_date`   date                                                          NOT NULL,
#     `manager_id` int                                                           NULL DEFAULT NULL,
#     `num`        int                                                           NOT NULL,
#     `version`    int                                                           NOT NULL,
#     PRIMARY KEY (`id`) USING BTREE,
#     UNIQUE INDEX `ISBN` (`ISBN` ASC) USING BTREE,
#     INDEX `manager_id` (`manager_id` ASC) USING BTREE,
#     CONSTRAINT `booktable_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
# ) ENGINE = InnoDB
#   AUTO_INCREMENT = 1
#   CHARACTER SET = utf8mb4
#   COLLATE = utf8mb4_0900_ai_ci
#   ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of booktable
-- ----------------------------
INSERT INTO `booktable`
VALUES (11, '数据库原理', '王珊', 'ISBN7-302-02368-100', 50, '高等教育出版社', '2000-05-01', 1, 0, 2);
INSERT INTO `booktable`
VALUES (12, '计算机网络', '谢希仁', 'ISBN7-302-02368-101', 51, '清华大学出版社', '2002-09-01', 1, 0, 3);
INSERT INTO `booktable`
VALUES (13, '操作系统', '汤小丹', 'ISBN7-302-02368-102', 52, '电子工业出版社', '2005-11-01', 1, 0, 4);
INSERT INTO `booktable`
VALUES (14, '软件工程', '李云峰', 'ISBN7-302-02368-103', 53, '机械工业出版社', '2008-03-01', 1, 0, 6);
INSERT INTO `booktable`
VALUES (15, '算法导论', 'Thomas H. Cormen', 'ISBN7-302-02368-104', 54, '机械工业出版社', '2010-06-01', 1, 0, 6);
INSERT INTO `booktable`
VALUES (16, '人工智能', '周志华', 'ISBN7-302-02368-105', 55, '清华大学出版社', '2013-08-01', 1, 0, 7);
INSERT INTO `booktable`
VALUES (17, '计算机图形学', 'Hearn', 'ISBN7-302-02368-106', 56, '机械工业出版社', '2016-02-01', 1, 0, 8);
INSERT INTO `booktable`
VALUES (18, '数据挖掘', 'Ian H. Witten', 'ISBN7-302-02368-107', 57, '机械工业出版社', '2018-04-01', 1, 0, 9);
INSERT INTO `booktable`
VALUES (19, '计算机组成原理', 'David A. Patterson', 'ISBN7-302-02368-108', 58, '电子工业出版社', '2021-07-01', 1, 0, 6);
INSERT INTO `booktable`
VALUES (20, '计算机体系结构', '王爱民', 'ISBN7-302-02368-109', 59, '高等教育出版社', '2017-09-01', 1, 0, 2);

-- ----------------------------
-- Table structure for book
-- ----------------------------
# DROP TABLE IF EXISTS `book`;
# CREATE TABLE `book`
# (
#     `id`         int                                                           NOT NULL AUTO_INCREMENT,
#     `ISBN`       varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
#     `location`   varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NOT NULL,
#     `manager_id` int                                                           NOT NULL,
#     `status`     varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NOT NULL COMMENT '不外借 未借出 已预约 已借出',
#     PRIMARY KEY (`id`) USING BTREE,
#     INDEX `ISBN` (`ISBN` ASC) USING BTREE,
#     INDEX `manager_id` (`manager_id` ASC) USING BTREE,
#     CONSTRAINT `book_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `booktable` (`ISBN`) ON DELETE RESTRICT ON UPDATE RESTRICT,
#     CONSTRAINT `book_ibfk_2` FOREIGN KEY (`manager_id`) REFERENCES `manager` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
#     CONSTRAINT `check_book_location` CHECK (`location` in (_utf8mb4'图书阅览室', _utf8mb4'图书流通室'))
# ) ENGINE = InnoDB
#   AUTO_INCREMENT = 1
#   CHARACTER SET = utf8mb4
#   COLLATE = utf8mb4_0900_ai_ci
#   ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book`
VALUES (1, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (2, 'ISBN7-302-02368-100', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (3, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (4, 'ISBN7-302-02368-101', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (5, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (6, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (7, 'ISBN7-302-02368-106', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (8, 'ISBN7-302-02368-109', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (9, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (10, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (11, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (12, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (13, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (14, 'ISBN7-302-02368-100', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (15, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (16, 'ISBN7-302-02368-105', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (17, 'ISBN7-302-02368-107', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (18, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (19, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (20, 'ISBN7-302-02368-109', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (21, 'ISBN7-302-02368-100', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (22, 'ISBN7-302-02368-108', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (23, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (24, 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (25, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (26, 'ISBN7-302-02368-109', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (27, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (28, 'ISBN7-302-02368-102', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (29, 'ISBN7-302-02368-103', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (30, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (31, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (32, 'ISBN7-302-02368-109', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (33, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (34, 'ISBN7-302-02368-107', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (35, 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (36, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (37, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (38, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (39, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (40, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (41, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (42, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (43, 'ISBN7-302-02368-106', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (44, 'ISBN7-302-02368-108', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (45, 'ISBN7-302-02368-109', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (46, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (47, 'ISBN7-302-02368-103', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (48, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (49, 'ISBN7-302-02368-102', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (50, 'ISBN7-302-02368-109', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (51, 'ISBN7-302-02368-109', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (52, 'ISBN7-302-02368-109', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (53, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (54, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (55, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (56, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (57, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (58, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (59, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (60, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (61, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (62, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (63, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (64, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (65, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (66, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (67, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (68, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (69, 'ISBN7-302-02368-101', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (70, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (71, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (72, 'ISBN7-302-02368-104', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (73, 'ISBN7-302-02368-107', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (74, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (75, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (76, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (77, 'ISBN7-302-02368-109', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (78, 'ISBN7-302-02368-100', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (79, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (80, 'ISBN7-302-02368-104', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (81, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (82, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (83, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (84, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (85, 'ISBN7-302-02368-103', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (86, 'ISBN7-302-02368-100', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (87, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (88, 'ISBN7-302-02368-103', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (89, 'ISBN7-302-02368-107', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (90, 'ISBN7-302-02368-102', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (91, 'ISBN7-302-02368-104', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (92, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (93, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (94, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (95, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (96, 'ISBN7-302-02368-107', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (97, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (98, 'ISBN7-302-02368-100', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (99, 'ISBN7-302-02368-100', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (100, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (101, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (102, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (103, 'ISBN7-302-02368-109', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (104, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (105, 'ISBN7-302-02368-100', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (106, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (107, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (108, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (109, 'ISBN7-302-02368-104', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (110, 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (111, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (112, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (113, 'ISBN7-302-02368-103', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (114, 'ISBN7-302-02368-109', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (115, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (116, 'ISBN7-302-02368-108', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (117, 'ISBN7-302-02368-101', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (118, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (119, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (120, 'ISBN7-302-02368-100', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (121, 'ISBN7-302-02368-104', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (122, 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (123, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (124, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (125, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (126, 'ISBN7-302-02368-100', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (127, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (128, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (129, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (130, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (131, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (132, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (133, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (134, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (135, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (136, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (137, 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (138, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (139, 'ISBN7-302-02368-102', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (140, 'ISBN7-302-02368-109', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (141, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (142, 'ISBN7-302-02368-105', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (143, 'ISBN7-302-02368-107', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (144, 'ISBN7-302-02368-107', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (145, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (146, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (147, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (148, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (149, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (150, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (151, 'ISBN7-302-02368-106', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (152, 'ISBN7-302-02368-109', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (153, 'ISBN7-302-02368-108', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (154, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (155, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (156, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (157, 'ISBN7-302-02368-109', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (158, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (159, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (160, 'ISBN7-302-02368-102', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (161, 'ISBN7-302-02368-109', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (162, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (163, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (164, 'ISBN7-302-02368-104', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (165, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (166, 'ISBN7-302-02368-108', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (167, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (168, 'ISBN7-302-02368-105', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (169, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (170, 'ISBN7-302-02368-105', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (171, 'ISBN7-302-02368-106', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (172, 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (173, 'ISBN7-302-02368-103', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (174, 'ISBN7-302-02368-106', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (175, 'ISBN7-302-02368-100', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (176, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (177, 'ISBN7-302-02368-100', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (178, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (179, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (180, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (181, 'ISBN7-302-02368-105', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (182, 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (183, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (184, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (185, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (186, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (187, 'ISBN7-302-02368-107', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (188, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (189, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (190, 'ISBN7-302-02368-106', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (191, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (192, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (193, 'ISBN7-302-02368-108', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (194, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (195, 'ISBN7-302-02368-100', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (196, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (197, 'ISBN7-302-02368-107', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (198, 'ISBN7-302-02368-106', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (199, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (200, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (201, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (202, 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (203, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (204, 'ISBN7-302-02368-107', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (205, 'ISBN7-302-02368-101', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (206, 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (207, 'ISBN7-302-02368-101', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (208, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (209, 'ISBN7-302-02368-109', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (210, 'ISBN7-302-02368-108', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (211, 'ISBN7-302-02368-105', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (212, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (213, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (214, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (215, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (216, 'ISBN7-302-02368-104', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (217, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (218, 'ISBN7-302-02368-104', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (219, 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (220, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (221, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (222, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (223, 'ISBN7-302-02368-100', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (224, 'ISBN7-302-02368-100', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (225, 'ISBN7-302-02368-108', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (226, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (227, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (228, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (229, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (230, 'ISBN7-302-02368-106', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (231, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (232, 'ISBN7-302-02368-105', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (233, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (234, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (235, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (236, 'ISBN7-302-02368-104', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (237, 'ISBN7-302-02368-103', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (238, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (239, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (240, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (241, 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (242, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (243, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (244, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (245, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (246, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (247, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (248, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (249, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (250, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (251, 'ISBN7-302-02368-100', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (252, 'ISBN7-302-02368-100', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (253, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (254, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (255, 'ISBN7-302-02368-108', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (256, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (257, 'ISBN7-302-02368-108', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (258, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (259, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (260, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (261, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (262, 'ISBN7-302-02368-109', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (263, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (264, 'ISBN7-302-02368-100', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (265, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (266, 'ISBN7-302-02368-101', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (267, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (268, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (269, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (270, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (271, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (272, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (273, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (274, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (275, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (276, 'ISBN7-302-02368-107', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (277, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (278, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (279, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (280, 'ISBN7-302-02368-106', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (281, 'ISBN7-302-02368-100', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (282, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (283, 'ISBN7-302-02368-100', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (284, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (285, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (286, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (287, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (288, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (289, 'ISBN7-302-02368-104', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (290, 'ISBN7-302-02368-109', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (291, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (292, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (293, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (294, 'ISBN7-302-02368-106', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (295, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (296, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (297, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (298, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (299, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (300, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (301, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (302, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (303, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (304, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (305, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (306, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (307, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (308, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (309, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (310, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (311, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (312, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (313, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (314, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (315, 'ISBN7-302-02368-101', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (316, 'ISBN7-302-02368-105', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (317, 'ISBN7-302-02368-109', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (318, 'ISBN7-302-02368-108', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (319, 'ISBN7-302-02368-104', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (320, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (321, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (322, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (323, 'ISBN7-302-02368-109', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (324, 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (325, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (326, 'ISBN7-302-02368-105', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (327, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (328, 'ISBN7-302-02368-100', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (329, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (330, 'ISBN7-302-02368-109', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (331, 'ISBN7-302-02368-109', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (332, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (333, 'ISBN7-302-02368-106', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (334, 'ISBN7-302-02368-100', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (335, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (336, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (337, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (338, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (339, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (340, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (341, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (342, 'ISBN7-302-02368-100', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (343, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (344, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (345, 'ISBN7-302-02368-108', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (346, 'ISBN7-302-02368-100', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (347, 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (348, 'ISBN7-302-02368-108', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (349, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (350, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (351, 'ISBN7-302-02368-106', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (352, 'ISBN7-302-02368-103', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (353, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (354, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (355, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (356, 'ISBN7-302-02368-109', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (357, 'ISBN7-302-02368-105', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (358, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (359, 'ISBN7-302-02368-101', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (360, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (361, 'ISBN7-302-02368-105', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (362, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (363, 'ISBN7-302-02368-106', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (364, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (365, 'ISBN7-302-02368-109', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (366, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (367, 'ISBN7-302-02368-108', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (368, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (369, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (370, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (371, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (372, 'ISBN7-302-02368-104', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (373, 'ISBN7-302-02368-100', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (374, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (375, 'ISBN7-302-02368-101', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (376, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (377, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (378, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (379, 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (380, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (381, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (382, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (383, 'ISBN7-302-02368-102', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (384, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (385, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (386, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (387, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (388, 'ISBN7-302-02368-109', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (389, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (390, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (391, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (392, 'ISBN7-302-02368-103', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (393, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (394, 'ISBN7-302-02368-101', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (395, 'ISBN7-302-02368-105', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (396, 'ISBN7-302-02368-106', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (397, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (398, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (399, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (400, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (401, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (402, 'ISBN7-302-02368-105', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (403, 'ISBN7-302-02368-109', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (404, 'ISBN7-302-02368-108', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (405, 'ISBN7-302-02368-106', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (406, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (407, 'ISBN7-302-02368-109', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (408, 'ISBN7-302-02368-105', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (409, 'ISBN7-302-02368-105', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (410, 'ISBN7-302-02368-101', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (411, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (412, 'ISBN7-302-02368-105', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (413, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (414, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (415, 'ISBN7-302-02368-105', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (416, 'ISBN7-302-02368-105', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (417, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (418, 'ISBN7-302-02368-105', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (419, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (420, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (421, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (422, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (423, 'ISBN7-302-02368-101', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (424, 'ISBN7-302-02368-101', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (425, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (426, 'ISBN7-302-02368-108', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (427, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (428, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (429, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (430, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (431, 'ISBN7-302-02368-109', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (432, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (433, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (434, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (435, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (436, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (437, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (438, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (439, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (440, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (441, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (442, 'ISBN7-302-02368-102', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (443, 'ISBN7-302-02368-105', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (444, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (445, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (446, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (447, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (448, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (449, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (450, 'ISBN7-302-02368-108', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (451, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (452, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (453, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (454, 'ISBN7-302-02368-100', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (455, 'ISBN7-302-02368-101', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (456, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (457, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (458, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (459, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (460, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (461, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (462, 'ISBN7-302-02368-104', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (463, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (464, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (465, 'ISBN7-302-02368-100', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (466, 'ISBN7-302-02368-107', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (467, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (468, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (469, 'ISBN7-302-02368-102', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (470, 'ISBN7-302-02368-101', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (471, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (472, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (473, 'ISBN7-302-02368-109', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (474, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (475, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (476, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (477, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (478, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (479, 'ISBN7-302-02368-104', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (480, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (481, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (482, 'ISBN7-302-02368-105', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (483, 'ISBN7-302-02368-108', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (484, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (485, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (486, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (487, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (488, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (489, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (490, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (491, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (492, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (493, 'ISBN7-302-02368-102', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (494, 'ISBN7-302-02368-109', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (495, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (496, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (497, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (498, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (499, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (500, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (501, 'ISBN7-302-02368-107', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (502, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (503, 'ISBN7-302-02368-100', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (504, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (505, 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (506, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (507, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (508, 'ISBN7-302-02368-105', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (509, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (510, 'ISBN7-302-02368-104', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (511, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (512, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (513, 'ISBN7-302-02368-109', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (514, 'ISBN7-302-02368-105', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (515, 'ISBN7-302-02368-108', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (516, 'ISBN7-302-02368-107', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (517, 'ISBN7-302-02368-108', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (518, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (519, 'ISBN7-302-02368-105', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (520, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (521, 'ISBN7-302-02368-108', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (522, 'ISBN7-302-02368-105', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (523, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (524, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (525, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (526, 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (527, 'ISBN7-302-02368-100', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (528, 'ISBN7-302-02368-106', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (529, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (530, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (531, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (532, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (533, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (534, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (535, 'ISBN7-302-02368-107', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (536, 'ISBN7-302-02368-100', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (537, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (538, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (539, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (540, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (541, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (542, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (543, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (544, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (545, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (546, 'ISBN7-302-02368-109', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (547, 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (548, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (549, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (550, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (551, 'ISBN7-302-02368-107', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (552, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (553, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (554, 'ISBN7-302-02368-100', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (555, 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (556, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (557, 'ISBN7-302-02368-109', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (558, 'ISBN7-302-02368-101', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (559, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (560, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (561, 'ISBN7-302-02368-105', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (562, 'ISBN7-302-02368-100', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (563, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (564, 'ISBN7-302-02368-105', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (565, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (566, 'ISBN7-302-02368-109', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (567, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (568, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (569, 'ISBN7-302-02368-103', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (570, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (571, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (572, 'ISBN7-302-02368-108', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (573, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (574, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (575, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (576, 'ISBN7-302-02368-109', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (577, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (578, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (579, 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (580, 'ISBN7-302-02368-100', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (581, 'ISBN7-302-02368-105', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (582, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (583, 'ISBN7-302-02368-106', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (584, 'ISBN7-302-02368-109', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (585, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (586, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (587, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (588, 'ISBN7-302-02368-102', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (589, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (590, 'ISBN7-302-02368-101', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (591, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (592, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (593, 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (594, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (595, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (596, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (597, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (598, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (599, 'ISBN7-302-02368-106', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (600, 'ISBN7-302-02368-104', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (601, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (602, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (603, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (604, 'ISBN7-302-02368-102', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (605, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (606, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (607, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (608, 'ISBN7-302-02368-100', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (609, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (610, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (611, 'ISBN7-302-02368-109', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (612, 'ISBN7-302-02368-105', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (613, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (614, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (615, 'ISBN7-302-02368-109', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (616, 'ISBN7-302-02368-109', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (617, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (618, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (619, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (620, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (621, 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (622, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (623, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (624, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (625, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (626, 'ISBN7-302-02368-106', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (627, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (628, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (629, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (630, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (631, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (632, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (633, 'ISBN7-302-02368-101', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (634, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (635, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (636, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (637, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (638, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (639, 'ISBN7-302-02368-105', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (640, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (641, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (642, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (643, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (644, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (645, 'ISBN7-302-02368-108', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (646, 'ISBN7-302-02368-100', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (647, 'ISBN7-302-02368-108', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (648, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (649, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (650, 'ISBN7-302-02368-100', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (651, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (652, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (653, 'ISBN7-302-02368-108', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (654, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (655, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (656, 'ISBN7-302-02368-105', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (657, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (658, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (659, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (660, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (661, 'ISBN7-302-02368-103', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (662, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (663, 'ISBN7-302-02368-105', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (664, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (665, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (666, 'ISBN7-302-02368-109', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (667, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (668, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (669, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (670, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (671, 'ISBN7-302-02368-104', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (672, 'ISBN7-302-02368-105', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (673, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (674, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (675, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (676, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (677, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (678, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (679, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (680, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (681, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (682, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (683, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (684, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (685, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (686, 'ISBN7-302-02368-105', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (687, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (688, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (689, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (690, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (691, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (692, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (693, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (694, 'ISBN7-302-02368-105', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (695, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (696, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (697, 'ISBN7-302-02368-109', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (698, 'ISBN7-302-02368-107', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (699, 'ISBN7-302-02368-109', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (700, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (701, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (702, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (703, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (704, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (705, 'ISBN7-302-02368-104', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (706, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (707, 'ISBN7-302-02368-102', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (708, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (709, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (710, 'ISBN7-302-02368-105', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (711, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (712, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (713, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (714, 'ISBN7-302-02368-109', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (715, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (716, 'ISBN7-302-02368-109', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (717, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (718, 'ISBN7-302-02368-107', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (719, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (720, 'ISBN7-302-02368-106', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (721, 'ISBN7-302-02368-103', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (722, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (723, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (724, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (725, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (726, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (727, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (728, 'ISBN7-302-02368-100', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (729, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (730, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (731, 'ISBN7-302-02368-108', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (732, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (733, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (734, 'ISBN7-302-02368-100', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (735, 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (736, 'ISBN7-302-02368-105', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (737, 'ISBN7-302-02368-102', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (738, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (739, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (740, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (741, 'ISBN7-302-02368-100', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (742, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (743, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (744, 'ISBN7-302-02368-107', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (745, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (746, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (747, 'ISBN7-302-02368-105', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (748, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (749, 'ISBN7-302-02368-109', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (750, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (751, 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (752, 'ISBN7-302-02368-109', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (753, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (754, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (755, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (756, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (757, 'ISBN7-302-02368-100', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (758, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (759, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (760, 'ISBN7-302-02368-102', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (761, 'ISBN7-302-02368-106', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (762, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (763, 'ISBN7-302-02368-102', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (764, 'ISBN7-302-02368-104', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (765, 'ISBN7-302-02368-104', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (766, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (767, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (768, 'ISBN7-302-02368-108', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (769, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (770, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (771, 'ISBN7-302-02368-105', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (772, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (773, 'ISBN7-302-02368-105', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (774, 'ISBN7-302-02368-108', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (775, 'ISBN7-302-02368-109', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (776, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (777, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (778, 'ISBN7-302-02368-109', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (779, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (780, 'ISBN7-302-02368-102', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (781, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (782, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (783, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (784, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (785, 'ISBN7-302-02368-101', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (786, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (787, 'ISBN7-302-02368-103', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (788, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (789, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (790, 'ISBN7-302-02368-106', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (791, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (792, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (793, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (794, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (795, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (796, 'ISBN7-302-02368-104', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (797, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (798, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (799, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (800, 'ISBN7-302-02368-107', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (801, 'ISBN7-302-02368-105', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (802, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (803, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (804, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (805, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (806, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (807, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (808, 'ISBN7-302-02368-100', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (809, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (810, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (811, 'ISBN7-302-02368-109', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (812, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (813, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (814, 'ISBN7-302-02368-108', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (815, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (816, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (817, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (818, 'ISBN7-302-02368-104', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (819, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (820, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (821, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (822, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (823, 'ISBN7-302-02368-103', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (824, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (825, 'ISBN7-302-02368-103', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (826, 'ISBN7-302-02368-105', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (827, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (828, 'ISBN7-302-02368-108', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (829, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (830, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (831, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (832, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (833, 'ISBN7-302-02368-105', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (834, 'ISBN7-302-02368-106', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (835, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (836, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (837, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (838, 'ISBN7-302-02368-104', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (839, 'ISBN7-302-02368-109', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (840, 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (841, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (842, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (843, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (844, 'ISBN7-302-02368-100', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (845, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (846, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (847, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (848, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (849, 'ISBN7-302-02368-106', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (850, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (851, 'ISBN7-302-02368-103', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (852, 'ISBN7-302-02368-101', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (853, 'ISBN7-302-02368-100', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (854, 'ISBN7-302-02368-109', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (855, 'ISBN7-302-02368-109', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (856, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (857, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (858, 'ISBN7-302-02368-107', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (859, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (860, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (861, 'ISBN7-302-02368-107', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (862, 'ISBN7-302-02368-104', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (863, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (864, 'ISBN7-302-02368-107', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (865, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (866, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (867, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (868, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (869, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (870, 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (871, 'ISBN7-302-02368-105', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (872, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (873, 'ISBN7-302-02368-100', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (874, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (875, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (876, 'ISBN7-302-02368-103', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (877, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (878, 'ISBN7-302-02368-100', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (879, 'ISBN7-302-02368-100', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (880, 'ISBN7-302-02368-100', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (881, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (882, 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (883, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (884, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (885, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (886, 'ISBN7-302-02368-108', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (887, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (888, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (889, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (890, 'ISBN7-302-02368-102', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (891, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (892, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (893, 'ISBN7-302-02368-105', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (894, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (895, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (896, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (897, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (898, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (899, 'ISBN7-302-02368-101', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (900, 'ISBN7-302-02368-105', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (901, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (902, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (903, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (904, 'ISBN7-302-02368-109', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (905, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (906, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (907, 'ISBN7-302-02368-102', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (908, 'ISBN7-302-02368-109', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (909, 'ISBN7-302-02368-109', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (910, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (911, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (912, 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (913, 'ISBN7-302-02368-104', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (914, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (915, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (916, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (917, 'ISBN7-302-02368-101', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (918, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (919, 'ISBN7-302-02368-104', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (920, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (921, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (922, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (923, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (924, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (925, 'ISBN7-302-02368-105', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (926, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (927, 'ISBN7-302-02368-106', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (928, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (929, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (930, 'ISBN7-302-02368-105', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (931, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (932, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (933, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (934, 'ISBN7-302-02368-106', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (935, 'ISBN7-302-02368-104', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (936, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (937, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (938, 'ISBN7-302-02368-109', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (939, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (940, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (941, 'ISBN7-302-02368-104', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (942, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (943, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (944, 'ISBN7-302-02368-101', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (945, 'ISBN7-302-02368-100', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (946, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (947, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (948, 'ISBN7-302-02368-105', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (949, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (950, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (951, 'ISBN7-302-02368-101', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (952, 'ISBN7-302-02368-105', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (953, 'ISBN7-302-02368-104', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (954, 'ISBN7-302-02368-108', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (955, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (956, 'ISBN7-302-02368-107', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (957, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (958, 'ISBN7-302-02368-108', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (959, 'ISBN7-302-02368-108', '图书阅览室', 1, '未借出');
INSERT INTO `book`
VALUES (960, 'ISBN7-302-02368-103', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (961, 'ISBN7-302-02368-106', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (962, 'ISBN7-302-02368-105', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (963, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (964, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (965, 'ISBN7-302-02368-100', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (966, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (967, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (968, 'ISBN7-302-02368-102', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (969, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (970, 'ISBN7-302-02368-100', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (971, 'ISBN7-302-02368-103', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (972, 'ISBN7-302-02368-106', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (973, 'ISBN7-302-02368-105', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (974, 'ISBN7-302-02368-105', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (975, 'ISBN7-302-02368-108', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (976, 'ISBN7-302-02368-100', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (977, 'ISBN7-302-02368-103', '图书阅览室', 1, '已预约');
INSERT INTO `book`
VALUES (978, 'ISBN7-302-02368-102', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (979, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (980, 'ISBN7-302-02368-102', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (981, 'ISBN7-302-02368-105', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (982, 'ISBN7-302-02368-107', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (983, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (984, 'ISBN7-302-02368-101', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (985, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (986, 'ISBN7-302-02368-103', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (987, 'ISBN7-302-02368-107', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (988, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (989, 'ISBN7-302-02368-108', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (990, 'ISBN7-302-02368-109', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (991, 'ISBN7-302-02368-101', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (992, 'ISBN7-302-02368-100', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (993, 'ISBN7-302-02368-101', '图书流通室', 1, '未借出');
INSERT INTO `book`
VALUES (994, 'ISBN7-302-02368-102', '图书阅览室', 1, '已借出');
INSERT INTO `book`
VALUES (995, 'ISBN7-302-02368-100', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (996, 'ISBN7-302-02368-109', '图书阅览室', 1, '不外借');
INSERT INTO `book`
VALUES (997, 'ISBN7-302-02368-107', '图书流通室', 1, '已预约');
INSERT INTO `book`
VALUES (998, 'ISBN7-302-02368-102', '图书流通室', 1, '已借出');
INSERT INTO `book`
VALUES (999, 'ISBN7-302-02368-104', '图书流通室', 1, '不外借');
INSERT INTO `book`
VALUES (1000, 'ISBN7-302-02368-107', '图书流通室', 1, '未借出');

-- ----------------------------
-- Table structure for captcha
-- ----------------------------
# DROP TABLE IF EXISTS `captcha`;
# CREATE TABLE `captcha`
# (
#     `id`    int                                                          NOT NULL AUTO_INCREMENT,
#     `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
#     `code`  varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NOT NULL,
#     PRIMARY KEY (`id`) USING BTREE,
#     UNIQUE INDEX `email` (`email` ASC) USING BTREE
# ) ENGINE = InnoDB
#   AUTO_INCREMENT = 1
#   CHARACTER SET = utf8mb4
#   COLLATE = utf8mb4_0900_ai_ci
#   ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of captcha
-- ----------------------------
# INSERT INTO `captcha`
# VALUES (1, '3240327913@qq.com', '802075');

-- ----------------------------
-- Table structure for lend
-- ----------------------------
# DROP TABLE IF EXISTS `lend`;
# CREATE TABLE `lend`
# (
#     `id`          int                                                          NOT NULL AUTO_INCREMENT,
#     `book_id`     int                                                          NULL DEFAULT NULL,
#     `reader_id`   int                                                          NULL DEFAULT NULL,
#     `lend_date`   datetime                                                     NULL DEFAULT NULL,
#     `return_date` datetime                                                     NULL DEFAULT NULL COMMENT '实际还书日期',
#     `due_date`    datetime                                                     NULL DEFAULT NULL COMMENT '应还日期',
#     `status`      varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '已还 未还  超期未还',
#     PRIMARY KEY (`id`) USING BTREE,
#     INDEX `book_id` (`book_id` ASC) USING BTREE,
#     INDEX `reader_id` (`reader_id` ASC) USING BTREE,
#     CONSTRAINT `lend_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
#     CONSTRAINT `lend_ibfk_2` FOREIGN KEY (`reader_id`) REFERENCES `reader` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
#     CONSTRAINT `check_lend_status` CHECK (`status` in (_utf8mb4'未还', _utf8mb4'已还', _utf8mb4'超期未还'))
# ) ENGINE = InnoDB
#   AUTO_INCREMENT = 1
#   CHARACTER SET = utf8mb4
#   COLLATE = utf8mb4_0900_ai_ci
#   ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lend
-- ----------------------------
INSERT INTO `lend`
VALUES (1, 200, 6, '2011-10-08 18:53:54', '2008-06-11 13:45:47', '2009-05-31 19:58:19', '超期未还');
INSERT INTO `lend`
VALUES (2, 628, 4, '2008-12-25 10:08:22', '2020-01-16 09:45:29', '2010-08-30 15:50:21', '超期未还');
INSERT INTO `lend`
VALUES (3, 131, 1, '2018-07-30 03:19:27', '2014-11-05 07:39:45', '2021-07-01 20:32:04', '未还');
INSERT INTO `lend`
VALUES (4, 422, 12, '2007-06-02 02:44:35', '2014-08-17 09:40:53', '2003-06-02 01:45:50', '超期未还');
INSERT INTO `lend`
VALUES (5, 11, 12, '2000-10-09 11:09:01', '2019-06-27 19:01:14', '2012-12-06 04:12:31', '未还');
INSERT INTO `lend`
VALUES (6, 611, 7, '2005-05-28 05:08:38', '2000-11-21 07:27:23', '2012-03-12 15:45:04', '超期未还');
INSERT INTO `lend`
VALUES (7, 490, 11, '2011-10-20 11:30:37', '2017-06-06 03:17:01', '2003-01-10 20:24:09', '未还');
INSERT INTO `lend`
VALUES (8, 89, 9, '2019-12-12 08:17:47', '2016-03-10 19:54:35', '2017-05-24 23:30:47', '已还');
INSERT INTO `lend`
VALUES (9, 932, 8, '2022-06-22 06:44:40', '2013-03-14 18:07:34', '2004-03-11 04:19:59', '未还');
INSERT INTO `lend`
VALUES (10, 263, 6, '2005-06-10 07:22:09', '2017-07-22 22:29:42', '2016-03-27 14:00:31', '未还');
INSERT INTO `lend`
VALUES (11, 622, 1, '2010-07-31 18:49:25', '2006-12-14 00:12:16', '2008-05-24 15:57:56', '未还');
INSERT INTO `lend`
VALUES (12, 436, 3, '2005-08-06 22:06:31', '2007-01-17 02:55:32', '2005-02-11 01:47:38', '超期未还');
INSERT INTO `lend`
VALUES (13, 735, 9, '2013-10-30 16:53:35', '2001-11-12 20:25:36', '2008-06-10 04:02:14', '超期未还');
INSERT INTO `lend`
VALUES (14, 265, 10, '2002-02-23 22:10:28', '2008-01-10 10:36:59', '2020-04-01 17:14:12', '已还');
INSERT INTO `lend`
VALUES (15, 140, 3, '2013-07-24 19:09:46', '2003-04-09 07:26:35', '2017-11-03 09:15:00', '超期未还');
INSERT INTO `lend`
VALUES (16, 574, 7, '2009-03-18 16:09:38', '2022-11-23 00:53:02', '2018-10-21 01:35:08', '已还');
INSERT INTO `lend`
VALUES (17, 35, 10, '2012-03-01 19:29:27', '2009-11-19 07:38:46', '2006-12-14 17:13:57', '未还');
INSERT INTO `lend`
VALUES (18, 376, 10, '2010-08-22 22:16:43', '2017-12-19 19:56:23', '2004-03-12 08:26:34', '未还');
INSERT INTO `lend`
VALUES (19, 17, 7, '2009-06-18 22:07:40', '2016-11-29 21:36:49', '2008-12-05 15:12:47', '超期未还');
INSERT INTO `lend`
VALUES (20, 328, 10, '2021-02-22 00:53:12', '2017-10-16 18:08:35', '2003-08-30 05:07:11', '未还');
INSERT INTO `lend`
VALUES (21, 967, 10, '2007-02-15 05:58:37', '2003-04-10 20:25:40', '2023-03-16 09:54:28', '超期未还');
INSERT INTO `lend`
VALUES (22, 585, 2, '2000-09-17 03:57:06', '2009-08-25 19:20:02', '2008-12-02 12:34:14', '超期未还');
INSERT INTO `lend`
VALUES (23, 294, 7, '2019-01-30 06:20:17', '2004-08-17 10:55:56', '2000-07-20 16:04:23', '超期未还');
INSERT INTO `lend`
VALUES (24, 126, 6, '2006-01-13 09:43:55', '2009-10-23 19:28:41', '2016-02-09 15:49:52', '超期未还');
INSERT INTO `lend`
VALUES (25, 19, 8, '2012-11-05 13:02:42', '2005-07-31 02:15:51', '2014-02-03 01:40:12', '已还');
INSERT INTO `lend`
VALUES (26, 862, 3, '2005-08-22 17:44:32', '2002-08-19 08:09:25', '2021-08-18 15:39:51', '未还');
INSERT INTO `lend`
VALUES (27, 177, 3, '2004-01-18 10:53:50', '2010-06-25 05:19:16', '2011-08-05 14:17:34', '超期未还');
INSERT INTO `lend`
VALUES (28, 3, 12, '2013-10-29 01:29:57', '2002-12-18 09:47:39', '2013-05-14 07:04:57', '未还');
INSERT INTO `lend`
VALUES (29, 642, 7, '2015-11-25 19:41:41', '2016-11-28 15:56:26', '2003-03-01 14:35:24', '超期未还');
INSERT INTO `lend`
VALUES (30, 223, 6, '2004-04-20 10:05:19', '2023-08-11 10:24:16', '2016-10-18 22:57:45', '已还');
INSERT INTO `lend`
VALUES (31, 282, 2, '2021-09-13 10:04:53', '2001-05-03 00:47:57', '2002-07-17 00:59:01', '未还');
INSERT INTO `lend`
VALUES (32, 997, 4, '2004-06-26 17:54:20', '2001-02-23 00:10:24', '2006-09-14 11:52:47', '未还');
INSERT INTO `lend`
VALUES (33, 888, 10, '2002-04-25 02:14:46', '2010-01-16 00:54:27', '2006-10-14 08:39:05', '未还');
INSERT INTO `lend`
VALUES (34, 402, 2, '2013-04-26 01:42:09', '2011-01-24 10:27:34', '2021-10-27 21:36:56', '未还');
INSERT INTO `lend`
VALUES (35, 156, 8, '2003-02-03 23:27:20', '2018-03-17 21:08:30', '2006-09-07 13:15:20', '未还');
INSERT INTO `lend`
VALUES (36, 525, 6, '2003-01-15 05:04:48', '2008-06-06 15:32:22', '2017-08-23 22:48:05', '超期未还');
INSERT INTO `lend`
VALUES (37, 497, 9, '2010-02-13 01:24:10', '2023-11-15 05:06:10', '2020-05-03 20:55:54', '未还');
INSERT INTO `lend`
VALUES (38, 85, 2, '2017-05-01 09:28:46', '2013-10-07 09:43:31', '2007-04-14 19:13:37', '未还');
INSERT INTO `lend`
VALUES (39, 882, 3, '2018-12-27 20:54:25', '2008-02-17 06:50:00', '2011-03-24 06:49:19', '已还');
INSERT INTO `lend`
VALUES (40, 59, 3, '2002-10-30 09:43:41', '2005-06-04 01:54:59', '2017-05-13 14:38:09', '超期未还');
INSERT INTO `lend`
VALUES (41, 102, 4, '2018-04-30 11:47:07', '2012-01-02 09:47:49', '2010-11-26 20:33:09', '未还');
INSERT INTO `lend`
VALUES (42, 516, 10, '2006-11-30 15:47:36', '2021-10-28 02:11:32', '2005-10-03 01:24:53', '超期未还');
INSERT INTO `lend`
VALUES (43, 394, 9, '2019-05-02 20:44:44', '2011-01-27 18:43:05', '2020-07-15 18:27:43', '已还');
INSERT INTO `lend`
VALUES (44, 296, 11, '2019-07-09 01:11:30', '2012-01-12 08:23:10', '2005-12-13 22:26:42', '未还');
INSERT INTO `lend`
VALUES (45, 188, 8, '2019-11-25 00:37:52', '2011-01-13 13:34:46', '2017-04-22 00:58:48', '未还');
INSERT INTO `lend`
VALUES (46, 391, 9, '2014-05-15 11:56:25', '2015-04-03 22:04:15', '2011-12-30 15:32:20', '超期未还');
INSERT INTO `lend`
VALUES (47, 100, 2, '2009-01-24 05:01:05', '2001-08-05 02:02:16', '2010-06-12 23:26:42', '超期未还');
INSERT INTO `lend`
VALUES (48, 717, 6, '2016-10-04 23:56:22', '2010-12-28 00:17:22', '2013-03-16 15:17:34', '已还');
INSERT INTO `lend`
VALUES (49, 177, 3, '2001-06-10 14:16:00', '2008-09-16 07:40:07', '2020-05-16 23:33:41', '已还');
INSERT INTO `lend`
VALUES (50, 943, 6, '2020-11-15 16:27:04', '2000-03-07 01:06:31', '2014-01-22 17:23:41', '未还');
INSERT INTO `lend`
VALUES (51, 636, 12, '2011-05-23 15:53:59', '2014-04-10 21:51:27', '2001-12-27 11:02:01', '未还');
INSERT INTO `lend`
VALUES (52, 768, 6, '2000-09-04 09:34:53', '2014-10-21 14:43:05', '2016-06-17 15:10:23', '已还');
INSERT INTO `lend`
VALUES (53, 810, 9, '2005-10-25 14:36:30', '2019-12-29 15:21:03', '2016-02-10 21:51:50', '未还');
INSERT INTO `lend`
VALUES (54, 418, 10, '2006-02-20 10:03:36', '2004-06-10 09:16:50', '2001-10-05 11:09:04', '已还');
INSERT INTO `lend`
VALUES (55, 792, 10, '2004-03-01 22:49:51', '2008-07-06 08:36:28', '2011-10-28 21:12:13', '未还');
INSERT INTO `lend`
VALUES (56, 292, 7, '2007-08-27 13:00:23', '2019-06-11 21:30:23', '2002-07-27 22:41:31', '未还');
INSERT INTO `lend`
VALUES (57, 222, 8, '2015-05-31 21:10:06', '2005-12-02 18:53:46', '2006-11-22 17:25:10', '已还');
INSERT INTO `lend`
VALUES (58, 340, 3, '2016-11-14 05:36:47', '2021-07-26 16:54:33', '2007-12-11 08:04:38', '未还');
INSERT INTO `lend`
VALUES (59, 453, 8, '2012-06-27 00:28:52', '2014-11-29 02:00:21', '2008-06-07 05:59:53', '未还');
INSERT INTO `lend`
VALUES (60, 89, 6, '2002-10-13 21:42:06', '2018-05-22 01:38:54', '2001-01-08 21:42:13', '已还');
INSERT INTO `lend`
VALUES (61, 941, 11, '2002-08-13 08:42:22', '2014-10-15 23:47:25', '2011-09-06 14:13:37', '未还');
INSERT INTO `lend`
VALUES (62, 525, 4, '2020-11-17 07:38:12', '2023-01-10 22:23:59', '2008-01-10 14:42:24', '已还');
INSERT INTO `lend`
VALUES (63, 96, 7, '2019-09-24 22:26:34', '2011-02-20 11:23:03', '2005-07-02 10:22:46', '超期未还');
INSERT INTO `lend`
VALUES (64, 932, 9, '2020-08-11 07:27:38', '2012-06-07 07:59:11', '2004-02-05 14:32:29', '超期未还');
INSERT INTO `lend`
VALUES (65, 299, 2, '2001-09-01 02:41:39', '2000-04-15 12:26:26', '2016-07-27 15:31:37', '未还');
INSERT INTO `lend`
VALUES (66, 559, 3, '2016-10-30 04:16:27', '2007-09-23 03:31:25', '2018-04-30 16:11:39', '超期未还');
INSERT INTO `lend`
VALUES (67, 652, 5, '2023-08-28 14:37:03', '2021-12-16 22:31:03', '2003-04-10 21:38:59', '超期未还');
INSERT INTO `lend`
VALUES (68, 486, 10, '2004-02-17 02:09:19', '2001-04-25 04:17:51', '2002-01-07 19:50:32', '超期未还');
INSERT INTO `lend`
VALUES (69, 932, 2, '2009-01-05 17:50:33', '2005-11-15 16:06:11', '2000-08-16 11:16:28', '未还');
INSERT INTO `lend`
VALUES (70, 344, 10, '2009-07-15 01:52:09', '2015-08-23 08:28:42', '2010-01-22 00:31:19', '已还');
INSERT INTO `lend`
VALUES (71, 149, 11, '2009-08-27 23:55:56', '2020-03-10 19:03:03', '2007-05-12 09:52:26', '已还');
INSERT INTO `lend`
VALUES (72, 730, 2, '2001-08-29 05:44:07', '2017-01-28 12:42:55', '2002-04-22 11:47:42', '超期未还');
INSERT INTO `lend`
VALUES (73, 345, 3, '2007-12-14 01:22:31', '2014-11-26 07:31:25', '2011-07-17 14:33:25', '已还');
INSERT INTO `lend`
VALUES (74, 956, 12, '2009-06-03 14:05:52', '2009-05-28 04:10:54', '2017-05-27 06:37:43', '超期未还');
INSERT INTO `lend`
VALUES (75, 935, 11, '2003-10-20 15:34:44', '2019-03-04 14:33:03', '2012-08-23 13:28:55', '超期未还');
INSERT INTO `lend`
VALUES (76, 364, 9, '2007-09-17 11:34:39', '2021-04-12 13:49:42', '2021-09-04 13:26:28', '未还');
INSERT INTO `lend`
VALUES (77, 846, 2, '2013-12-28 16:25:32', '2001-01-12 02:15:24', '2014-10-23 03:08:12', '超期未还');
INSERT INTO `lend`
VALUES (78, 271, 10, '2023-06-26 10:39:37', '2002-09-19 00:55:53', '2002-03-10 04:55:16', '已还');
INSERT INTO `lend`
VALUES (79, 298, 6, '2023-07-10 22:49:25', '2004-03-18 07:24:15', '2016-02-04 02:41:44', '已还');
INSERT INTO `lend`
VALUES (80, 865, 5, '2014-09-12 03:12:49', '2009-02-08 03:08:49', '2016-04-29 22:14:40', '超期未还');
INSERT INTO `lend`
VALUES (81, 271, 3, '2007-05-12 01:22:07', '2021-11-08 22:05:23', '2008-08-01 07:28:47', '未还');
INSERT INTO `lend`
VALUES (82, 321, 1, '2022-09-06 15:23:28', '2021-08-19 04:29:58', '2012-04-05 12:23:56', '超期未还');
INSERT INTO `lend`
VALUES (83, 396, 2, '2004-01-30 15:46:08', '2001-12-15 03:59:13', '2011-04-30 06:17:45', '未还');
INSERT INTO `lend`
VALUES (84, 467, 6, '2019-09-28 09:13:40', '2022-05-02 04:51:00', '2003-02-01 07:02:38', '已还');
INSERT INTO `lend`
VALUES (85, 312, 3, '2003-01-17 20:14:06', '2005-10-01 18:14:30', '2021-03-21 02:19:17', '已还');
INSERT INTO `lend`
VALUES (86, 687, 7, '2016-11-12 01:51:17', '2019-08-15 18:21:47', '2012-10-02 11:41:22', '超期未还');
INSERT INTO `lend`
VALUES (87, 818, 5, '2000-11-22 09:14:17', '2018-08-26 17:13:04', '2021-08-22 07:30:55', '已还');
INSERT INTO `lend`
VALUES (88, 171, 7, '2010-08-29 14:19:23', '2021-05-19 21:27:31', '2004-12-27 02:00:36', '未还');
INSERT INTO `lend`
VALUES (89, 420, 8, '2002-07-03 14:17:09', '2010-06-08 11:41:03', '2009-10-10 13:42:11', '超期未还');
INSERT INTO `lend`
VALUES (90, 560, 12, '2011-02-09 07:17:59', '2001-06-30 04:16:30', '2014-07-28 20:02:58', '超期未还');
INSERT INTO `lend`
VALUES (91, 67, 9, '2001-12-13 17:12:46', '2006-05-26 10:51:15', '2001-05-01 11:57:09', '未还');
INSERT INTO `lend`
VALUES (92, 107, 2, '2001-02-21 20:56:47', '2019-12-25 15:52:01', '2006-03-04 17:51:59', '超期未还');
INSERT INTO `lend`
VALUES (93, 710, 1, '2023-07-11 17:36:52', '2004-03-01 10:53:14', '2005-11-27 15:32:29', '已还');
INSERT INTO `lend`
VALUES (94, 437, 10, '2006-03-08 17:14:36', '2002-05-28 04:11:20', '2012-02-24 03:48:20', '超期未还');
INSERT INTO `lend`
VALUES (95, 848, 12, '2019-04-02 15:22:49', '2002-06-23 00:58:43', '2014-10-05 11:27:53', '未还');
INSERT INTO `lend`
VALUES (96, 379, 7, '2013-08-21 16:35:33', '2011-03-23 16:02:58', '2003-10-26 06:35:47', '已还');
INSERT INTO `lend`
VALUES (97, 669, 2, '2001-05-26 14:38:15', '2002-08-13 16:08:06', '2002-04-03 04:26:46', '已还');
INSERT INTO `lend`
VALUES (98, 324, 11, '2000-06-21 18:12:18', '2016-10-22 07:57:43', '2000-10-21 09:09:30', '未还');
INSERT INTO `lend`
VALUES (99, 150, 1, '2000-07-27 22:13:10', '2009-05-23 11:24:42', '2014-10-20 15:01:55', '已还');
INSERT INTO `lend`
VALUES (100, 669, 6, '2013-01-09 05:47:09', '2021-06-08 22:12:11', '2020-10-05 18:11:02', '超期未还');
INSERT INTO `lend`
VALUES (101, 573, 8, '2007-03-03 19:15:45', '2003-06-28 21:30:53', '2003-03-24 23:03:49', '超期未还');
INSERT INTO `lend`
VALUES (102, 525, 11, '2008-02-20 04:49:15', '2007-11-24 15:07:03', '2004-07-06 14:41:16', '未还');
INSERT INTO `lend`
VALUES (103, 410, 3, '2021-02-18 19:18:10', '2008-09-13 00:05:19', '2015-01-19 20:35:17', '超期未还');
INSERT INTO `lend`
VALUES (104, 1, 1, '2020-01-29 22:07:12', '2014-10-31 01:46:42', '2015-03-27 04:26:01', '超期未还');
INSERT INTO `lend`
VALUES (105, 852, 3, '2012-09-10 04:03:54', '2017-02-26 13:21:19', '2019-11-13 11:30:45', '已还');
INSERT INTO `lend`
VALUES (106, 918, 10, '2001-10-07 02:30:42', '2002-02-05 20:46:40', '2005-06-23 13:01:12', '超期未还');
INSERT INTO `lend`
VALUES (107, 446, 12, '2010-08-01 00:48:36', '2023-01-04 02:53:49', '2007-02-27 17:47:51', '超期未还');
INSERT INTO `lend`
VALUES (108, 683, 8, '2014-12-12 10:43:51', '2021-05-05 04:43:24', '2009-11-02 04:11:52', '超期未还');
INSERT INTO `lend`
VALUES (109, 248, 4, '2013-09-24 15:00:01', '2004-10-04 23:02:27', '2013-08-08 10:25:22', '未还');
INSERT INTO `lend`
VALUES (110, 962, 11, '2010-01-17 10:22:14', '2017-10-26 12:18:02', '2008-08-12 15:03:47', '已还');
INSERT INTO `lend`
VALUES (111, 869, 6, '2010-01-18 23:48:14', '2004-11-21 07:36:35', '2005-07-07 12:50:11', '未还');
INSERT INTO `lend`
VALUES (112, 510, 2, '2012-11-01 17:46:59', '2020-08-28 15:04:38', '2004-11-22 12:18:29', '未还');
INSERT INTO `lend`
VALUES (113, 281, 7, '2009-09-07 04:06:39', '2002-10-03 12:28:23', '2020-02-09 02:00:28', '未还');
INSERT INTO `lend`
VALUES (114, 459, 12, '2008-06-10 13:25:23', '2011-10-11 12:31:42', '2002-05-21 07:57:36', '未还');
INSERT INTO `lend`
VALUES (115, 479, 1, '2003-11-03 13:33:32', '2021-07-21 09:18:04', '2010-05-14 01:55:36', '未还');
INSERT INTO `lend`
VALUES (116, 386, 5, '2004-07-07 16:19:25', '2013-02-25 17:02:08', '2003-03-30 00:29:26', '未还');
INSERT INTO `lend`
VALUES (117, 309, 1, '2020-12-26 02:29:27', '2003-06-04 01:27:48', '2013-10-31 20:12:03', '未还');
INSERT INTO `lend`
VALUES (118, 662, 6, '2005-06-07 13:08:01', '2023-06-19 04:36:32', '2010-10-20 18:54:15', '未还');
INSERT INTO `lend`
VALUES (119, 383, 4, '2019-12-10 00:44:27', '2016-09-09 01:32:15', '2014-10-16 10:41:53', '未还');
INSERT INTO `lend`
VALUES (120, 261, 9, '2020-07-07 00:43:50', '2016-08-18 01:13:05', '2017-03-31 17:09:24', '未还');
INSERT INTO `lend`
VALUES (121, 433, 10, '2018-08-20 22:59:53', '2008-08-28 14:31:58', '2010-01-31 18:54:57', '未还');
INSERT INTO `lend`
VALUES (122, 944, 5, '2011-09-11 02:54:56', '2021-05-04 03:03:10', '2007-06-06 14:43:01', '未还');
INSERT INTO `lend`
VALUES (123, 818, 7, '2021-03-22 00:56:51', '2018-12-08 16:42:22', '2010-04-06 17:15:16', '超期未还');
INSERT INTO `lend`
VALUES (124, 704, 5, '2022-05-23 08:20:37', '2021-12-12 11:06:08', '2011-04-15 12:15:52', '未还');
INSERT INTO `lend`
VALUES (125, 608, 1, '2022-05-18 14:17:21', '2022-02-05 04:28:27', '2000-10-05 18:12:27', '未还');
INSERT INTO `lend`
VALUES (126, 500, 8, '2017-01-30 07:31:47', '2016-07-17 18:26:19', '2007-11-30 16:59:26', '超期未还');
INSERT INTO `lend`
VALUES (127, 511, 3, '2004-02-22 02:40:14', '2020-12-20 18:13:39', '2015-06-19 03:12:51', '已还');
INSERT INTO `lend`
VALUES (128, 130, 5, '2021-08-21 23:33:18', '2018-05-20 21:20:19', '2011-11-25 22:39:30', '已还');
INSERT INTO `lend`
VALUES (129, 661, 6, '2008-04-20 12:45:01', '2010-02-18 16:06:38', '2012-03-16 19:42:15', '超期未还');
INSERT INTO `lend`
VALUES (130, 719, 2, '2010-10-24 11:50:17', '2007-11-08 01:20:07', '2018-11-22 19:38:23', '超期未还');
INSERT INTO `lend`
VALUES (131, 493, 3, '2006-06-23 20:04:40', '2019-04-09 06:38:41', '2016-03-04 02:17:30', '超期未还');
INSERT INTO `lend`
VALUES (132, 16, 5, '2004-01-01 07:54:17', '2008-09-06 21:46:00', '2012-03-27 06:41:50', '未还');
INSERT INTO `lend`
VALUES (133, 740, 4, '2021-01-11 10:12:11', '2012-03-30 22:29:56', '2014-03-28 14:17:40', '未还');
INSERT INTO `lend`
VALUES (134, 923, 11, '2019-11-13 07:24:57', '2005-08-15 11:37:38', '2019-12-06 19:44:14', '未还');
INSERT INTO `lend`
VALUES (135, 739, 10, '2015-08-28 16:41:54', '2004-09-12 10:54:16', '2017-07-18 07:52:07', '未还');
INSERT INTO `lend`
VALUES (136, 320, 11, '2011-07-01 02:33:42', '2001-07-26 19:07:33', '2016-12-19 04:34:09', '未还');
INSERT INTO `lend`
VALUES (137, 184, 8, '2001-11-01 06:18:50', '2001-11-30 03:51:05', '2013-01-13 14:13:43', '未还');
INSERT INTO `lend`
VALUES (138, 594, 3, '2009-02-02 01:02:28', '2004-01-09 22:40:16', '2008-06-12 21:44:43', '超期未还');
INSERT INTO `lend`
VALUES (139, 756, 7, '2013-06-21 14:01:48', '2023-03-28 06:24:38', '2010-07-05 17:11:44', '已还');
INSERT INTO `lend`
VALUES (140, 611, 5, '2023-08-19 12:23:36', '2022-10-25 16:53:57', '2015-01-11 22:33:09', '已还');
INSERT INTO `lend`
VALUES (141, 313, 11, '2015-09-24 23:16:44', '2021-11-13 12:04:15', '2018-04-06 03:05:36', '超期未还');
INSERT INTO `lend`
VALUES (142, 561, 12, '2003-05-07 13:36:53', '2012-03-02 16:07:40', '2013-06-13 18:44:18', '超期未还');
INSERT INTO `lend`
VALUES (143, 369, 7, '2013-07-02 01:43:04', '2015-09-30 22:06:17', '2016-09-16 20:20:12', '未还');
INSERT INTO `lend`
VALUES (144, 321, 6, '2009-07-05 15:06:35', '2017-06-26 06:38:37', '2002-03-26 01:13:42', '未还');
INSERT INTO `lend`
VALUES (145, 144, 4, '2007-12-08 03:06:59', '2008-05-12 16:58:14', '2006-01-19 23:54:24', '已还');
INSERT INTO `lend`
VALUES (146, 415, 9, '2004-04-12 23:48:18', '2009-09-26 05:58:50', '2013-12-23 13:08:04', '超期未还');
INSERT INTO `lend`
VALUES (147, 607, 7, '2002-01-10 17:24:44', '2016-06-29 14:27:39', '2022-06-08 00:50:31', '未还');
INSERT INTO `lend`
VALUES (148, 718, 7, '2018-12-14 17:46:20', '2018-07-13 14:47:16', '2018-07-08 03:32:34', '已还');
INSERT INTO `lend`
VALUES (149, 792, 10, '2018-06-19 05:20:02', '2021-10-28 06:45:14', '2012-08-03 13:19:38', '已还');
INSERT INTO `lend`
VALUES (150, 511, 11, '2012-10-31 08:45:15', '2002-07-28 00:17:12', '2019-04-27 05:02:39', '未还');
INSERT INTO `lend`
VALUES (151, 882, 10, '2022-08-17 18:54:46', '2000-12-02 18:36:57', '2020-07-11 13:31:23', '未还');
INSERT INTO `lend`
VALUES (152, 162, 6, '2001-09-10 01:03:54', '2016-12-17 00:36:21', '2014-10-10 20:34:08', '超期未还');
INSERT INTO `lend`
VALUES (153, 66, 1, '2000-11-11 21:09:44', '2009-01-25 19:54:50', '2012-05-17 00:38:31', '未还');
INSERT INTO `lend`
VALUES (154, 869, 6, '2020-07-24 23:59:24', '2023-08-30 12:28:55', '2005-05-25 11:48:52', '未还');
INSERT INTO `lend`
VALUES (155, 267, 10, '2003-08-08 07:55:39', '2015-11-23 11:01:05', '2003-10-19 13:49:40', '已还');
INSERT INTO `lend`
VALUES (156, 226, 9, '2023-03-26 17:22:29', '2020-09-16 09:43:24', '2001-01-18 05:08:37', '未还');
INSERT INTO `lend`
VALUES (157, 626, 1, '2006-12-23 23:44:29', '2006-10-07 19:31:36', '2019-03-17 13:06:50', '超期未还');
INSERT INTO `lend`
VALUES (158, 154, 10, '2010-11-26 02:44:22', '2020-12-05 03:09:59', '2020-03-31 12:25:42', '超期未还');
INSERT INTO `lend`
VALUES (159, 449, 10, '2012-02-29 13:01:51', '2018-10-15 00:34:35', '2007-09-27 05:07:54', '超期未还');
INSERT INTO `lend`
VALUES (160, 481, 11, '2006-12-03 18:20:43', '2009-02-02 18:51:21', '2000-09-22 18:13:36', '未还');
INSERT INTO `lend`
VALUES (161, 894, 12, '2006-02-20 15:36:37', '2005-06-02 04:16:37', '2021-04-23 02:37:31', '已还');
INSERT INTO `lend`
VALUES (162, 836, 1, '2003-11-04 04:29:48', '2016-04-03 02:26:11', '2008-05-18 09:26:32', '已还');
INSERT INTO `lend`
VALUES (163, 287, 9, '2013-11-24 00:03:44', '2007-05-25 21:47:24', '2011-07-18 04:56:49', '已还');
INSERT INTO `lend`
VALUES (164, 289, 10, '2003-08-27 13:52:51', '2022-03-26 20:46:32', '2000-06-06 09:38:36', '未还');
INSERT INTO `lend`
VALUES (165, 605, 8, '2005-03-22 19:24:56', '2000-12-13 23:35:42', '2021-08-24 18:06:00', '未还');
INSERT INTO `lend`
VALUES (166, 989, 8, '2016-02-11 22:11:17', '2002-07-06 23:25:18', '2005-09-17 01:22:33', '已还');
INSERT INTO `lend`
VALUES (167, 250, 11, '2019-02-03 11:12:06', '2014-04-05 18:41:08', '2004-05-13 07:52:18', '超期未还');
INSERT INTO `lend`
VALUES (168, 763, 3, '2005-03-01 15:20:12', '2023-04-02 22:27:31', '2012-10-17 03:21:20', '超期未还');
INSERT INTO `lend`
VALUES (169, 738, 10, '2016-10-09 08:09:27', '2001-02-23 02:24:46', '2003-08-22 22:50:18', '超期未还');
INSERT INTO `lend`
VALUES (170, 502, 12, '2013-12-27 04:54:27', '2015-07-07 21:14:40', '2008-12-03 14:48:38', '已还');
INSERT INTO `lend`
VALUES (171, 844, 2, '2007-05-04 09:19:52', '2007-01-03 20:17:57', '2017-02-06 00:54:09', '已还');
INSERT INTO `lend`
VALUES (172, 863, 8, '2002-02-20 13:20:10', '2001-03-22 20:36:16', '2017-07-03 18:20:38', '已还');
INSERT INTO `lend`
VALUES (173, 456, 11, '2022-10-10 07:52:05', '2013-06-18 18:50:37', '2019-12-08 17:18:52', '未还');
INSERT INTO `lend`
VALUES (174, 935, 11, '2023-07-08 01:08:31', '2013-09-11 23:53:23', '2018-01-22 09:41:49', '超期未还');
INSERT INTO `lend`
VALUES (175, 642, 4, '2019-03-03 18:22:26', '2009-10-16 00:29:48', '2017-04-07 14:58:05', '超期未还');
INSERT INTO `lend`
VALUES (176, 762, 9, '2002-04-11 06:28:24', '2004-03-02 00:37:32', '2008-05-16 12:41:33', '超期未还');
INSERT INTO `lend`
VALUES (177, 541, 6, '2022-05-19 03:26:24', '2018-01-31 01:57:01', '2008-12-19 01:20:34', '已还');
INSERT INTO `lend`
VALUES (178, 504, 10, '2012-06-21 10:49:13', '2022-10-05 01:52:27', '2002-05-29 17:14:47', '未还');
INSERT INTO `lend`
VALUES (179, 525, 11, '2012-06-23 06:09:09', '2014-05-12 08:48:29', '2001-07-18 09:47:14', '已还');
INSERT INTO `lend`
VALUES (180, 540, 4, '2003-07-30 18:27:01', '2012-11-24 13:26:51', '2011-03-16 08:49:18', '未还');
INSERT INTO `lend`
VALUES (181, 970, 7, '2016-01-03 00:50:23', '2012-10-24 02:23:26', '2007-10-06 02:51:50', '已还');
INSERT INTO `lend`
VALUES (182, 518, 3, '2018-05-08 10:23:24', '2013-03-15 04:00:30', '2022-03-14 00:44:39', '已还');
INSERT INTO `lend`
VALUES (183, 303, 6, '2022-09-16 04:02:55', '2009-02-02 10:56:58', '2007-01-28 19:51:09', '已还');
INSERT INTO `lend`
VALUES (184, 743, 3, '2004-08-18 00:05:16', '2008-03-23 14:00:56', '2018-12-26 04:36:29', '超期未还');
INSERT INTO `lend`
VALUES (185, 728, 11, '2019-12-27 15:41:10', '2005-07-11 07:43:01', '2012-01-30 02:25:50', '超期未还');
INSERT INTO `lend`
VALUES (186, 543, 11, '2007-02-24 08:44:53', '2008-01-06 22:29:32', '2016-05-02 01:49:28', '超期未还');
INSERT INTO `lend`
VALUES (187, 550, 4, '2007-05-09 12:20:05', '2015-09-20 03:36:04', '2021-05-31 05:20:53', '未还');
INSERT INTO `lend`
VALUES (188, 981, 5, '2011-03-02 07:55:40', '2021-04-20 07:29:04', '2022-08-20 06:53:12', '已还');
INSERT INTO `lend`
VALUES (189, 160, 9, '2011-05-22 08:02:27', '2006-02-24 09:00:49', '2010-02-09 12:43:30', '已还');
INSERT INTO `lend`
VALUES (190, 383, 4, '2010-09-11 10:30:50', '2005-02-15 22:45:10', '2012-08-02 14:18:30', '未还');
INSERT INTO `lend`
VALUES (191, 528, 6, '2011-03-19 21:38:42', '2002-02-20 00:13:19', '2020-04-02 18:56:25', '已还');
INSERT INTO `lend`
VALUES (192, 843, 2, '2023-05-14 11:44:11', '2014-04-10 05:00:41', '2018-10-29 22:03:52', '已还');
INSERT INTO `lend`
VALUES (193, 149, 6, '2019-07-11 07:59:29', '2012-08-07 07:54:21', '2005-10-19 04:26:41', '已还');
INSERT INTO `lend`
VALUES (194, 316, 8, '2000-08-29 09:51:57', '2009-09-20 09:54:11', '2000-07-06 09:29:17', '超期未还');
INSERT INTO `lend`
VALUES (195, 886, 5, '2014-04-30 17:27:46', '2000-08-15 18:05:07', '2022-06-16 19:48:42', '未还');
INSERT INTO `lend`
VALUES (196, 947, 11, '2018-09-03 02:00:29', '2002-07-13 18:18:30', '2020-09-17 02:43:02', '已还');
INSERT INTO `lend`
VALUES (197, 344, 6, '2015-01-17 21:36:45', '2001-06-23 00:50:35', '2018-10-14 08:37:00', '超期未还');
INSERT INTO `lend`
VALUES (198, 657, 6, '2013-02-28 03:40:07', '2006-07-13 21:22:24', '2008-07-24 17:34:01', '超期未还');
INSERT INTO `lend`
VALUES (199, 513, 11, '2003-02-28 03:26:44', '2006-06-19 18:25:55', '2021-08-09 19:26:01', '未还');
INSERT INTO `lend`
VALUES (200, 334, 6, '2016-01-05 14:29:24', '2004-09-06 20:13:27', '2004-09-04 12:49:06', '超期未还');
INSERT INTO `lend`
VALUES (201, 82, 3, '2020-05-14 19:39:49', '2019-12-27 16:36:59', '2010-11-20 08:25:12', '未还');
INSERT INTO `lend`
VALUES (202, 872, 11, '2019-11-11 10:21:15', '2011-07-12 15:00:28', '2019-03-12 09:48:15', '未还');
INSERT INTO `lend`
VALUES (203, 906, 2, '2017-02-02 20:27:08', '2020-01-18 18:40:03', '2001-07-01 18:27:50', '已还');
INSERT INTO `lend`
VALUES (204, 440, 4, '2000-08-15 02:33:40', '2017-05-19 18:28:15', '2023-08-25 09:12:13', '超期未还');
INSERT INTO `lend`
VALUES (205, 120, 8, '2012-07-26 23:13:55', '2001-02-11 09:34:13', '2010-09-27 08:55:49', '超期未还');
INSERT INTO `lend`
VALUES (206, 968, 7, '2006-05-03 05:36:15', '2007-07-24 14:50:05', '2013-11-11 11:20:52', '未还');
INSERT INTO `lend`
VALUES (207, 675, 10, '2023-07-27 08:06:11', '2019-04-26 04:46:00', '2018-05-05 14:17:21', '未还');
INSERT INTO `lend`
VALUES (208, 117, 8, '2021-04-21 04:32:55', '2003-08-16 17:12:31', '2017-04-23 06:08:25', '超期未还');
INSERT INTO `lend`
VALUES (209, 117, 8, '2010-03-22 20:14:07', '2023-06-30 02:01:42', '2003-07-16 02:25:48', '已还');
INSERT INTO `lend`
VALUES (210, 602, 6, '2002-08-05 06:23:41', '2022-03-06 11:23:52', '2015-05-08 14:54:56', '未还');
INSERT INTO `lend`
VALUES (211, 562, 12, '2023-01-28 13:27:13', '2000-07-18 07:59:29', '2017-06-18 04:48:36', '已还');
INSERT INTO `lend`
VALUES (212, 773, 1, '2022-06-08 11:53:48', '2007-05-28 06:49:34', '2023-06-03 02:39:29', '已还');
INSERT INTO `lend`
VALUES (213, 50, 7, '2013-07-13 18:18:30', '2019-05-23 07:22:17', '2023-06-12 22:37:40', '超期未还');
INSERT INTO `lend`
VALUES (214, 554, 6, '2020-03-05 21:07:31', '2004-08-29 14:18:44', '2006-08-07 11:49:13', '已还');
INSERT INTO `lend`
VALUES (215, 280, 5, '2006-06-11 05:00:37', '2018-01-10 22:15:55', '2012-06-11 10:30:35', '未还');
INSERT INTO `lend`
VALUES (216, 261, 6, '2009-11-02 14:54:06', '2008-11-07 16:06:11', '2012-09-24 05:52:19', '已还');
INSERT INTO `lend`
VALUES (217, 397, 11, '2006-10-03 08:48:57', '2005-03-16 00:45:32', '2004-05-08 07:32:18', '未还');
INSERT INTO `lend`
VALUES (218, 793, 2, '2011-11-24 15:37:50', '2011-08-14 05:42:12', '2017-09-02 10:46:09', '未还');
INSERT INTO `lend`
VALUES (219, 632, 10, '2003-04-01 06:53:38', '2021-11-02 16:11:23', '2014-01-30 05:12:24', '已还');
INSERT INTO `lend`
VALUES (220, 739, 6, '2010-05-10 01:14:33', '2019-09-16 22:19:30', '2004-07-13 01:21:46', '超期未还');
INSERT INTO `lend`
VALUES (221, 940, 7, '2022-10-06 03:38:33', '2019-04-28 02:09:56', '2007-09-05 08:56:16', '超期未还');
INSERT INTO `lend`
VALUES (222, 388, 6, '2016-02-04 19:18:39', '2010-09-08 04:17:45', '2019-10-17 23:14:45', '已还');
INSERT INTO `lend`
VALUES (223, 765, 12, '2003-10-19 09:29:17', '2020-06-06 06:22:14', '2009-02-27 12:42:47', '未还');
INSERT INTO `lend`
VALUES (224, 951, 12, '2008-03-11 18:17:29', '2006-10-16 18:52:18', '2010-04-21 18:04:30', '未还');
INSERT INTO `lend`
VALUES (225, 336, 6, '2002-10-25 21:36:40', '2018-06-05 20:34:41', '2017-02-13 05:11:31', '未还');
INSERT INTO `lend`
VALUES (226, 337, 1, '2020-09-28 17:01:31', '2018-04-24 00:57:20', '2016-06-29 22:16:10', '未还');
INSERT INTO `lend`
VALUES (227, 690, 8, '2010-05-06 06:28:50', '2013-03-01 10:02:12', '2012-04-09 23:14:11', '已还');
INSERT INTO `lend`
VALUES (228, 236, 9, '2021-09-10 23:47:03', '2022-07-25 20:30:17', '2016-09-20 15:53:04', '未还');
INSERT INTO `lend`
VALUES (229, 573, 2, '2012-11-14 09:15:29', '2014-06-23 13:38:06', '2014-01-16 04:15:11', '超期未还');
INSERT INTO `lend`
VALUES (230, 560, 1, '2018-12-08 10:04:13', '2016-04-27 01:43:35', '2003-02-16 23:37:53', '未还');
INSERT INTO `lend`
VALUES (231, 860, 9, '2014-02-04 08:43:15', '2024-01-02 00:38:29', '2022-03-09 17:38:00', '超期未还');
INSERT INTO `lend`
VALUES (232, 113, 6, '2022-05-04 05:50:48', '2008-07-03 01:20:54', '2015-06-27 19:20:29', '超期未还');
INSERT INTO `lend`
VALUES (233, 977, 8, '2010-02-25 09:56:47', '2014-04-19 16:20:16', '2007-01-24 05:15:40', '已还');
INSERT INTO `lend`
VALUES (234, 191, 8, '2019-12-27 17:13:56', '2004-06-10 22:52:38', '2000-05-02 07:39:19', '已还');
INSERT INTO `lend`
VALUES (235, 115, 7, '2022-12-07 17:31:50', '2002-07-20 05:56:42', '2011-10-16 21:37:49', '超期未还');
INSERT INTO `lend`
VALUES (236, 782, 5, '2009-09-17 12:31:17', '2011-09-24 03:13:48', '2019-09-21 12:25:34', '超期未还');
INSERT INTO `lend`
VALUES (237, 109, 11, '2006-05-15 03:59:40', '2013-04-09 22:16:27', '2009-04-16 15:53:51', '超期未还');
INSERT INTO `lend`
VALUES (238, 707, 10, '2002-02-17 03:55:29', '2006-02-24 07:58:52', '2017-01-23 10:20:35', '超期未还');
INSERT INTO `lend`
VALUES (239, 451, 12, '2012-02-08 08:20:54', '2012-06-13 21:00:35', '2007-08-23 16:07:48', '未还');
INSERT INTO `lend`
VALUES (240, 308, 8, '2013-09-23 20:44:43', '2002-12-17 17:45:01', '2014-05-26 06:29:34', '超期未还');
INSERT INTO `lend`
VALUES (241, 891, 12, '2014-11-05 10:39:52', '2007-08-07 18:25:40', '2013-09-07 02:34:28', '未还');
INSERT INTO `lend`
VALUES (242, 581, 9, '2015-05-24 22:11:13', '2017-10-27 01:50:50', '2019-07-16 07:31:52', '超期未还');
INSERT INTO `lend`
VALUES (243, 565, 1, '2021-01-03 09:36:17', '2017-10-22 00:32:18', '2017-10-17 23:12:59', '已还');
INSERT INTO `lend`
VALUES (244, 342, 12, '2022-11-17 00:24:52', '2011-08-11 03:36:01', '2017-06-02 16:41:38', '超期未还');
INSERT INTO `lend`
VALUES (245, 292, 9, '2016-04-11 07:50:42', '2019-01-10 02:41:45', '2014-08-01 17:29:48', '已还');
INSERT INTO `lend`
VALUES (246, 623, 10, '2007-02-27 15:23:28', '2011-02-25 09:18:26', '2011-12-08 03:06:57', '已还');
INSERT INTO `lend`
VALUES (247, 554, 4, '2006-02-18 13:48:53', '2022-12-26 17:50:15', '2006-08-11 23:22:32', '已还');
INSERT INTO `lend`
VALUES (248, 7, 12, '2007-03-13 05:00:48', '2021-12-19 07:00:07', '2003-05-06 01:13:40', '未还');
INSERT INTO `lend`
VALUES (249, 88, 8, '2022-03-20 03:32:17', '2009-05-30 17:01:06', '2005-02-25 11:51:02', '已还');
INSERT INTO `lend`
VALUES (250, 591, 7, '2009-12-04 19:44:21', '2013-01-07 20:32:40', '2012-01-04 05:23:51', '超期未还');
INSERT INTO `lend`
VALUES (251, 434, 9, '2003-10-07 14:17:10', '2011-10-13 16:42:53', '2009-03-06 08:26:05', '未还');
INSERT INTO `lend`
VALUES (252, 649, 6, '2002-08-24 08:16:36', '2020-03-20 22:24:36', '2007-03-19 19:56:25', '超期未还');
INSERT INTO `lend`
VALUES (253, 145, 6, '2013-03-19 08:12:12', '2008-08-03 07:57:41', '2002-07-17 21:16:08', '超期未还');
INSERT INTO `lend`
VALUES (254, 580, 8, '2011-01-31 09:33:02', '2021-06-14 02:14:07', '2002-07-10 10:44:48', '超期未还');
INSERT INTO `lend`
VALUES (255, 852, 8, '2003-08-16 13:49:58', '2021-05-28 07:45:51', '2020-12-29 12:19:32', '已还');
INSERT INTO `lend`
VALUES (256, 740, 12, '2003-04-16 16:01:48', '2015-01-13 00:58:57', '2018-01-30 22:43:42', '未还');
INSERT INTO `lend`
VALUES (257, 79, 5, '2017-10-20 11:06:45', '2021-11-16 14:23:00', '2000-06-26 08:29:46', '超期未还');
INSERT INTO `lend`
VALUES (258, 465, 10, '2014-02-12 08:25:25', '2018-11-13 06:18:58', '2014-05-07 15:41:58', '已还');
INSERT INTO `lend`
VALUES (259, 69, 6, '2007-02-25 06:38:52', '2011-05-29 05:22:58', '2019-01-07 02:35:34', '超期未还');
INSERT INTO `lend`
VALUES (260, 156, 8, '2020-11-11 06:53:47', '2021-12-21 20:21:40', '2011-02-07 03:43:47', '未还');
INSERT INTO `lend`
VALUES (261, 148, 4, '2008-07-20 11:41:39', '2017-05-11 11:38:13', '2022-11-09 08:44:41', '未还');
INSERT INTO `lend`
VALUES (262, 483, 2, '2008-12-26 10:22:48', '2009-09-23 15:42:40', '2017-02-06 11:38:10', '超期未还');
INSERT INTO `lend`
VALUES (263, 23, 5, '2017-07-12 18:22:07', '2018-02-09 00:24:14', '2015-06-28 06:15:04', '已还');
INSERT INTO `lend`
VALUES (264, 249, 2, '2018-07-10 15:50:37', '2012-09-26 05:51:06', '2012-11-17 08:27:55', '已还');
INSERT INTO `lend`
VALUES (265, 678, 6, '2013-07-13 04:12:15', '2023-04-20 10:31:23', '2017-10-21 10:32:11', '已还');
INSERT INTO `lend`
VALUES (266, 954, 1, '2012-04-29 15:26:36', '2016-12-15 06:50:07', '2016-01-10 11:56:17', '超期未还');
INSERT INTO `lend`
VALUES (267, 652, 10, '2006-05-30 03:47:09', '2022-07-28 00:59:40', '2003-08-31 17:26:11', '未还');
INSERT INTO `lend`
VALUES (268, 79, 11, '2013-11-24 19:34:25', '2001-12-16 17:38:45', '2021-02-23 04:46:21', '已还');
INSERT INTO `lend`
VALUES (269, 51, 10, '2017-04-01 10:13:37', '2011-09-17 21:51:00', '2013-03-07 17:40:28', '超期未还');
INSERT INTO `lend`
VALUES (270, 831, 8, '2004-07-30 12:41:09', '2021-03-22 06:20:45', '2022-11-21 02:04:15', '未还');
INSERT INTO `lend`
VALUES (271, 821, 7, '2013-07-30 14:23:38', '2015-12-02 18:15:00', '2020-08-30 08:43:20', '未还');
INSERT INTO `lend`
VALUES (272, 580, 5, '2014-04-22 23:11:15', '2011-04-02 11:32:10', '2003-02-16 08:59:21', '已还');
INSERT INTO `lend`
VALUES (273, 956, 7, '2003-03-31 01:05:17', '2009-12-27 21:54:29', '2003-06-04 05:02:40', '未还');
INSERT INTO `lend`
VALUES (274, 293, 11, '2009-01-21 13:36:41', '2007-04-23 03:52:21', '2022-06-17 01:05:36', '超期未还');
INSERT INTO `lend`
VALUES (275, 738, 5, '2003-12-27 16:17:11', '2004-04-07 16:00:35', '2010-02-21 16:21:00', '未还');
INSERT INTO `lend`
VALUES (276, 722, 2, '2021-12-31 01:25:08', '2002-01-06 23:43:37', '2009-05-13 21:00:43', '超期未还');
INSERT INTO `lend`
VALUES (277, 634, 11, '2008-06-12 15:53:00', '2023-09-09 14:59:09', '2015-06-03 11:50:20', '未还');
INSERT INTO `lend`
VALUES (278, 212, 5, '2001-02-03 14:48:20', '2011-11-20 02:53:44', '2004-02-21 10:13:46', '已还');
INSERT INTO `lend`
VALUES (279, 149, 9, '2019-06-05 16:17:57', '2023-01-14 19:11:59', '2001-03-05 13:27:38', '未还');
INSERT INTO `lend`
VALUES (280, 395, 12, '2014-11-29 22:07:38', '2005-07-16 12:59:52', '2012-06-10 12:59:57', '未还');
INSERT INTO `lend`
VALUES (281, 694, 10, '2020-01-17 16:38:23', '2021-06-07 08:56:33', '2016-07-22 06:18:48', '未还');
INSERT INTO `lend`
VALUES (282, 484, 1, '2014-03-28 18:01:26', '2010-06-29 02:01:16', '2020-04-17 09:11:11', '未还');
INSERT INTO `lend`
VALUES (283, 663, 10, '2017-12-05 09:34:57', '2018-02-06 08:06:51', '2015-04-19 09:30:15', '未还');
INSERT INTO `lend`
VALUES (284, 549, 1, '2010-08-27 11:25:59', '2005-01-06 06:30:37', '2001-05-03 11:29:51', '超期未还');
INSERT INTO `lend`
VALUES (285, 730, 5, '2008-10-10 03:49:34', '2005-05-04 08:40:15', '2007-06-14 07:29:15', '超期未还');
INSERT INTO `lend`
VALUES (286, 467, 8, '2009-09-02 21:51:38', '2023-10-14 07:27:08', '2015-08-09 14:43:01', '未还');
INSERT INTO `lend`
VALUES (287, 811, 10, '2006-09-03 09:33:40', '2013-10-30 03:17:46', '2010-07-03 15:27:05', '超期未还');
INSERT INTO `lend`
VALUES (288, 172, 5, '2000-06-01 20:37:03', '2000-02-02 21:15:19', '2023-07-16 13:39:17', '已还');
INSERT INTO `lend`
VALUES (289, 451, 2, '2001-12-25 10:13:49', '2015-11-28 12:49:45', '2016-04-26 10:42:47', '超期未还');
INSERT INTO `lend`
VALUES (290, 445, 1, '2005-01-10 23:05:29', '2015-01-29 03:34:43', '2008-11-21 09:01:00', '已还');
INSERT INTO `lend`
VALUES (291, 984, 10, '2023-09-30 07:03:40', '2005-01-29 21:20:41', '2000-08-01 06:27:12', '已还');
INSERT INTO `lend`
VALUES (292, 68, 3, '2003-10-15 04:06:01', '2013-12-12 19:59:05', '2015-09-03 01:59:56', '超期未还');
INSERT INTO `lend`
VALUES (293, 421, 1, '2001-05-14 14:09:54', '2013-09-16 18:56:26', '2010-10-09 21:09:46', '超期未还');
INSERT INTO `lend`
VALUES (294, 999, 8, '2015-01-20 13:04:30', '2017-07-21 13:15:12', '2018-01-15 11:48:29', '已还');
INSERT INTO `lend`
VALUES (295, 192, 11, '2006-10-05 00:35:35', '2013-04-20 23:28:10', '2013-02-28 16:52:54', '已还');
INSERT INTO `lend`
VALUES (296, 562, 2, '2022-10-30 03:38:30', '2020-06-25 12:29:03', '2018-04-01 20:18:43', '未还');
INSERT INTO `lend`
VALUES (297, 96, 12, '2015-05-21 21:27:20', '2020-07-17 23:38:12', '2020-04-18 08:58:58', '超期未还');
INSERT INTO `lend`
VALUES (298, 500, 8, '2002-12-16 21:02:27', '2011-01-10 05:35:32', '2000-12-02 15:37:04', '已还');
INSERT INTO `lend`
VALUES (299, 821, 1, '2003-05-30 14:15:03', '2021-02-27 15:47:04', '2019-11-02 00:26:04', '已还');
INSERT INTO `lend`
VALUES (300, 731, 2, '2012-10-29 10:13:15', '2016-07-15 08:24:56', '2000-03-03 02:54:05', '超期未还');
INSERT INTO `lend`
VALUES (301, 217, 5, '2015-06-14 05:43:01', '2008-02-07 19:46:03', '2011-05-24 14:31:39', '超期未还');
INSERT INTO `lend`
VALUES (302, 602, 2, '2012-10-18 21:20:30', '2021-02-01 08:15:31', '2007-02-24 14:28:12', '未还');
INSERT INTO `lend`
VALUES (303, 596, 5, '2014-05-01 11:18:51', '2010-08-12 13:49:47', '2001-04-14 18:42:40', '超期未还');
INSERT INTO `lend`
VALUES (304, 575, 10, '2003-08-09 21:39:07', '2021-05-01 22:14:32', '2012-05-05 19:11:43', '已还');
INSERT INTO `lend`
VALUES (305, 258, 10, '2011-05-14 21:54:45', '2018-05-07 04:16:17', '2002-12-26 03:57:45', '已还');
INSERT INTO `lend`
VALUES (306, 435, 6, '2006-09-02 17:15:16', '2018-03-02 03:25:42', '2009-05-09 07:40:16', '已还');
INSERT INTO `lend`
VALUES (307, 42, 6, '2000-02-20 15:45:20', '2010-06-08 00:42:35', '2006-05-16 11:55:01', '超期未还');
INSERT INTO `lend`
VALUES (308, 74, 12, '2022-05-24 12:11:23', '2015-12-31 06:38:35', '2023-04-22 16:41:06', '未还');
INSERT INTO `lend`
VALUES (309, 383, 11, '2022-06-13 22:31:15', '2018-09-09 15:56:27', '2011-01-06 00:51:30', '已还');
INSERT INTO `lend`
VALUES (310, 463, 6, '2006-09-28 12:27:52', '2016-02-02 21:34:44', '2018-02-08 19:49:50', '未还');
INSERT INTO `lend`
VALUES (311, 997, 7, '2016-07-11 15:51:49', '2014-12-17 02:33:23', '2003-11-14 13:42:22', '已还');
INSERT INTO `lend`
VALUES (312, 424, 5, '2015-10-06 07:51:32', '2014-07-26 19:10:00', '2022-03-18 05:15:28', '超期未还');
INSERT INTO `lend`
VALUES (313, 331, 4, '2013-07-26 18:16:54', '2022-02-07 13:05:36', '2021-09-02 21:11:13', '超期未还');
INSERT INTO `lend`
VALUES (314, 537, 9, '2009-02-19 10:52:34', '2021-11-10 20:02:39', '2016-05-23 14:47:03', '未还');
INSERT INTO `lend`
VALUES (315, 921, 12, '2022-11-23 02:50:57', '2016-08-23 10:58:33', '2005-05-29 08:08:51', '超期未还');
INSERT INTO `lend`
VALUES (316, 147, 8, '2001-02-18 02:43:47', '2022-02-17 11:06:10', '2002-08-05 04:14:42', '已还');
INSERT INTO `lend`
VALUES (317, 731, 11, '2013-11-22 22:07:42', '2021-02-22 11:22:47', '2011-08-14 22:21:53', '已还');
INSERT INTO `lend`
VALUES (318, 305, 11, '2019-06-26 14:41:44', '2002-08-29 16:12:51', '2003-05-31 02:50:51', '未还');
INSERT INTO `lend`
VALUES (319, 300, 8, '2006-03-07 17:37:32', '2010-05-08 14:02:49', '2006-03-18 22:47:57', '已还');
INSERT INTO `lend`
VALUES (320, 681, 1, '2004-02-22 00:40:19', '2003-06-25 03:00:25', '2018-08-22 05:06:23', '超期未还');
INSERT INTO `lend`
VALUES (321, 747, 8, '2012-04-09 12:20:08', '2001-02-10 00:22:58', '2012-07-09 19:44:11', '已还');
INSERT INTO `lend`
VALUES (322, 456, 7, '2001-04-23 13:05:20', '2021-12-19 02:26:29', '2007-01-20 06:36:44', '超期未还');
INSERT INTO `lend`
VALUES (323, 130, 3, '2003-08-20 12:12:30', '2011-04-21 01:14:44', '2011-09-19 22:33:28', '未还');
INSERT INTO `lend`
VALUES (324, 348, 11, '2006-06-28 02:54:34', '2014-01-20 02:09:36', '2017-06-11 21:44:49', '未还');
INSERT INTO `lend`
VALUES (325, 390, 8, '2019-04-06 03:38:33', '2017-09-29 02:04:02', '2011-12-02 21:23:29', '未还');
INSERT INTO `lend`
VALUES (326, 774, 1, '2022-10-02 07:04:07', '2013-08-06 20:04:03', '2005-03-10 22:25:48', '未还');
INSERT INTO `lend`
VALUES (327, 634, 1, '2008-04-23 04:22:59', '2011-09-10 22:18:06', '2002-09-08 15:26:09', '未还');
INSERT INTO `lend`
VALUES (328, 774, 1, '2014-01-07 07:43:25', '2002-09-15 22:50:10', '2004-09-28 12:23:30', '超期未还');
INSERT INTO `lend`
VALUES (329, 240, 2, '2021-07-19 20:06:47', '2007-05-11 00:15:18', '2020-06-11 09:36:44', '未还');
INSERT INTO `lend`
VALUES (330, 938, 1, '2007-03-16 14:37:34', '2019-03-04 23:58:22', '2005-11-05 20:10:10', '超期未还');
INSERT INTO `lend`
VALUES (331, 495, 5, '2001-12-04 05:01:00', '2016-12-05 16:44:50', '2023-05-11 15:26:07', '超期未还');
INSERT INTO `lend`
VALUES (332, 431, 3, '2002-06-25 12:23:44', '2012-01-01 17:57:54', '2011-08-13 13:48:50', '未还');
INSERT INTO `lend`
VALUES (333, 743, 7, '2022-04-17 06:52:27', '2006-02-06 23:43:07', '2001-07-27 10:45:11', '超期未还');
INSERT INTO `lend`
VALUES (334, 718, 1, '2023-06-18 05:57:01', '2008-01-01 15:53:55', '2005-09-09 13:08:17', '未还');
INSERT INTO `lend`
VALUES (335, 412, 3, '2002-12-26 04:17:30', '2013-07-15 14:29:50', '2021-11-10 19:33:28', '未还');
INSERT INTO `lend`
VALUES (336, 617, 9, '2010-08-17 03:11:07', '2006-10-26 10:01:47', '2023-11-16 08:53:41', '已还');
INSERT INTO `lend`
VALUES (337, 308, 1, '2003-07-22 18:11:45', '2013-09-30 23:54:50', '2016-08-31 03:08:42', '未还');
INSERT INTO `lend`
VALUES (338, 903, 4, '2000-10-10 17:58:16', '2020-07-31 11:50:19', '2021-04-23 22:32:07', '超期未还');
INSERT INTO `lend`
VALUES (339, 338, 6, '2000-03-04 23:39:03', '2019-11-24 07:08:52', '2015-03-24 16:11:46', '已还');
INSERT INTO `lend`
VALUES (340, 757, 4, '2002-11-09 07:25:25', '2004-07-07 07:05:26', '2019-06-03 01:32:07', '超期未还');
INSERT INTO `lend`
VALUES (341, 568, 1, '2016-11-20 12:37:57', '2002-12-23 05:19:58', '2006-07-31 19:05:38', '未还');
INSERT INTO `lend`
VALUES (342, 235, 1, '2006-02-08 15:50:42', '2017-08-11 17:11:27', '2023-05-18 23:36:16', '未还');
INSERT INTO `lend`
VALUES (343, 481, 5, '2012-12-29 20:13:48', '2007-11-21 17:28:44', '2000-05-16 21:09:26', '超期未还');
INSERT INTO `lend`
VALUES (344, 440, 6, '2013-09-02 07:56:16', '2018-01-14 16:30:27', '2014-06-18 13:19:17', '超期未还');
INSERT INTO `lend`
VALUES (345, 696, 9, '2007-10-25 21:05:30', '2007-12-03 05:03:14', '2009-11-11 16:44:08', '已还');
INSERT INTO `lend`
VALUES (346, 985, 11, '2003-10-22 22:02:29', '2019-03-26 14:09:21', '2000-06-23 16:39:45', '超期未还');
INSERT INTO `lend`
VALUES (347, 932, 3, '2003-12-28 20:45:01', '2015-01-29 06:04:50', '2019-09-19 23:07:15', '超期未还');
INSERT INTO `lend`
VALUES (348, 707, 6, '2022-12-30 22:41:52', '2006-03-24 11:12:59', '2003-08-10 11:11:59', '未还');
INSERT INTO `lend`
VALUES (349, 117, 8, '2008-04-17 15:20:38', '2006-08-01 12:36:38', '2012-06-23 13:21:18', '未还');
INSERT INTO `lend`
VALUES (350, 866, 4, '2006-11-23 09:49:55', '2012-07-20 05:04:09', '2013-06-12 18:51:00', '超期未还');
INSERT INTO `lend`
VALUES (351, 876, 12, '2019-12-04 21:37:59', '2009-06-27 04:19:01', '2016-01-11 22:20:34', '超期未还');
INSERT INTO `lend`
VALUES (352, 535, 9, '2017-07-21 04:45:39', '2022-10-08 00:54:53', '2013-08-25 21:15:38', '未还');
INSERT INTO `lend`
VALUES (353, 100, 7, '2010-05-05 12:28:34', '2007-01-26 03:19:54', '2009-06-24 06:50:24', '已还');
INSERT INTO `lend`
VALUES (354, 639, 5, '2018-09-02 21:21:24', '2021-09-26 14:19:21', '2017-05-31 02:18:25', '超期未还');
INSERT INTO `lend`
VALUES (355, 45, 8, '2023-11-01 08:48:46', '2023-10-21 17:10:24', '2009-09-15 07:10:57', '超期未还');
INSERT INTO `lend`
VALUES (356, 282, 9, '2017-02-24 17:56:43', '2009-05-19 07:45:40', '2019-11-27 21:50:26', '超期未还');
INSERT INTO `lend`
VALUES (357, 90, 10, '2010-09-29 06:33:59', '2014-12-29 02:00:04', '2003-07-20 07:33:26', '超期未还');
INSERT INTO `lend`
VALUES (358, 213, 4, '2015-11-12 14:13:03', '2019-04-24 15:01:03', '2009-03-19 00:47:16', '未还');
INSERT INTO `lend`
VALUES (359, 234, 10, '2006-07-07 03:54:23', '2013-09-17 00:38:22', '2001-04-15 02:22:52', '超期未还');
INSERT INTO `lend`
VALUES (360, 856, 11, '2021-01-07 11:13:45', '2002-11-21 02:47:24', '2022-03-18 18:26:42', '超期未还');
INSERT INTO `lend`
VALUES (361, 251, 5, '2020-09-30 14:44:32', '2002-06-09 22:08:30', '2001-08-16 16:32:37', '超期未还');
INSERT INTO `lend`
VALUES (362, 782, 5, '2010-07-14 09:26:31', '2003-11-23 00:57:50', '2020-05-20 13:39:17', '超期未还');
INSERT INTO `lend`
VALUES (363, 451, 2, '2002-09-06 08:20:02', '2008-08-17 17:17:07', '2024-01-03 15:19:38', '已还');
INSERT INTO `lend`
VALUES (364, 133, 3, '2002-07-10 01:05:55', '2018-03-01 07:40:54', '2009-01-13 09:03:49', '已还');
INSERT INTO `lend`
VALUES (365, 153, 1, '2015-11-14 19:46:26', '2014-12-23 16:09:14', '2016-10-21 09:29:49', '已还');
INSERT INTO `lend`
VALUES (366, 11, 10, '2015-05-31 17:35:23', '2004-01-23 09:16:04', '2020-12-16 00:04:00', '已还');
INSERT INTO `lend`
VALUES (367, 935, 4, '2000-09-28 14:17:39', '2006-01-11 19:41:43', '2003-03-03 14:09:16', '超期未还');
INSERT INTO `lend`
VALUES (368, 119, 8, '2018-05-27 20:25:38', '2007-03-30 13:24:33', '2004-07-18 08:48:02', '已还');
INSERT INTO `lend`
VALUES (369, 573, 4, '2008-06-05 05:27:54', '2007-08-02 09:24:50', '2009-02-07 11:19:17', '超期未还');
INSERT INTO `lend`
VALUES (370, 974, 7, '2003-05-05 08:44:10', '2001-07-30 08:22:06', '2023-11-23 05:09:50', '未还');
INSERT INTO `lend`
VALUES (371, 835, 9, '2005-11-03 01:26:58', '2001-08-16 06:57:48', '2021-09-05 07:32:41', '超期未还');
INSERT INTO `lend`
VALUES (372, 334, 8, '2016-07-30 07:23:25', '2005-09-22 23:40:49', '2010-06-04 04:01:52', '已还');
INSERT INTO `lend`
VALUES (373, 930, 3, '2018-08-29 20:29:28', '2012-08-17 01:29:10', '2003-10-31 14:02:50', '超期未还');
INSERT INTO `lend`
VALUES (374, 745, 2, '2015-05-03 12:26:25', '2004-06-06 10:30:47', '2012-04-13 16:58:32', '已还');
INSERT INTO `lend`
VALUES (375, 432, 1, '2008-06-16 19:31:18', '2005-09-13 00:14:02', '2016-06-21 09:17:00', '已还');
INSERT INTO `lend`
VALUES (376, 360, 1, '2018-12-07 20:02:20', '2006-02-22 04:32:05', '2006-09-10 04:59:55', '超期未还');
INSERT INTO `lend`
VALUES (377, 6, 12, '2012-06-28 22:05:51', '2001-01-08 12:23:35', '2013-08-02 21:10:21', '超期未还');
INSERT INTO `lend`
VALUES (378, 646, 11, '2013-11-10 13:11:46', '2012-08-30 08:29:12', '2019-03-21 11:15:49', '已还');
INSERT INTO `lend`
VALUES (379, 786, 8, '2015-12-22 18:35:23', '2017-07-10 11:24:23', '2011-06-09 10:32:58', '已还');
INSERT INTO `lend`
VALUES (380, 200, 9, '2010-10-16 04:54:08', '2008-06-02 04:16:03', '2022-10-02 21:12:57', '未还');
INSERT INTO `lend`
VALUES (381, 623, 5, '2015-03-22 11:38:25', '2020-07-13 04:25:33', '2023-01-15 09:14:51', '超期未还');
INSERT INTO `lend`
VALUES (382, 91, 5, '2004-03-05 16:30:51', '2017-07-13 09:28:43', '2005-03-24 13:11:22', '未还');
INSERT INTO `lend`
VALUES (383, 312, 9, '2000-09-21 08:29:47', '2005-04-09 16:01:02', '2000-09-15 03:52:18', '已还');
INSERT INTO `lend`
VALUES (384, 24, 7, '2009-09-21 10:24:18', '2005-12-27 11:22:06', '2006-02-18 01:57:28', '已还');
INSERT INTO `lend`
VALUES (385, 565, 11, '2015-03-24 00:31:12', '2004-10-21 22:31:15', '2001-06-07 08:00:39', '已还');
INSERT INTO `lend`
VALUES (386, 305, 7, '2019-04-04 20:24:09', '2021-07-28 08:06:39', '2023-04-11 18:30:09', '超期未还');
INSERT INTO `lend`
VALUES (387, 260, 10, '2011-10-25 09:51:25', '2021-08-31 14:01:48', '2007-05-05 17:00:28', '未还');
INSERT INTO `lend`
VALUES (388, 585, 7, '2005-04-12 00:49:46', '2018-10-24 14:18:01', '2004-03-31 18:31:46', '超期未还');
INSERT INTO `lend`
VALUES (389, 187, 5, '2011-11-03 20:35:39', '2016-12-13 01:39:08', '2018-07-21 17:15:48', '超期未还');
INSERT INTO `lend`
VALUES (390, 52, 12, '2009-10-23 19:09:31', '2015-10-31 17:57:33', '2010-02-17 14:40:50', '未还');
INSERT INTO `lend`
VALUES (391, 603, 3, '2001-10-27 04:09:39', '2017-05-19 22:44:24', '2008-12-12 18:31:53', '已还');
INSERT INTO `lend`
VALUES (392, 303, 2, '2011-01-08 13:32:08', '2011-04-22 01:58:56', '2010-08-23 15:54:53', '超期未还');
INSERT INTO `lend`
VALUES (393, 927, 4, '2020-07-02 05:21:24', '2018-07-13 00:51:09', '2021-11-06 21:13:12', '超期未还');
INSERT INTO `lend`
VALUES (394, 901, 5, '2021-02-14 16:00:12', '2017-02-15 15:12:05', '2016-09-03 08:30:50', '已还');
INSERT INTO `lend`
VALUES (395, 675, 5, '2019-10-21 15:30:07', '2023-11-03 15:21:14', '2021-08-22 22:29:46', '已还');
INSERT INTO `lend`
VALUES (396, 214, 1, '2013-07-07 13:26:29', '2022-02-03 13:50:55', '2006-04-13 14:50:13', '未还');
INSERT INTO `lend`
VALUES (397, 117, 1, '2002-03-16 11:41:41', '2013-11-20 08:16:16', '2007-07-09 13:33:04', '超期未还');
INSERT INTO `lend`
VALUES (398, 478, 4, '2008-09-18 01:17:01', '2022-05-07 02:17:19', '2005-04-11 19:46:17', '未还');
INSERT INTO `lend`
VALUES (399, 450, 1, '2010-01-27 15:52:25', '2019-02-22 09:37:03', '2000-08-01 16:35:46', '未还');
INSERT INTO `lend`
VALUES (400, 247, 10, '2016-04-12 16:34:07', '2017-05-23 08:29:51', '2019-09-20 16:19:05', '超期未还');
INSERT INTO `lend`
VALUES (401, 406, 9, '2004-01-09 16:55:00', '2004-01-10 01:23:21', '2005-11-24 06:11:51', '未还');
INSERT INTO `lend`
VALUES (402, 694, 8, '2012-10-17 21:58:07', '2015-12-03 17:10:29', '2023-03-16 02:39:28', '未还');
INSERT INTO `lend`
VALUES (403, 79, 12, '2002-04-27 06:58:48', '2005-08-12 15:02:32', '2014-10-05 15:14:17', '超期未还');
INSERT INTO `lend`
VALUES (404, 884, 6, '2022-12-22 20:51:43', '2017-08-05 14:53:41', '2000-09-18 01:32:42', '未还');
INSERT INTO `lend`
VALUES (405, 714, 4, '2007-03-30 11:59:19', '2010-10-04 05:19:52', '2022-06-01 04:47:39', '未还');
INSERT INTO `lend`
VALUES (406, 623, 4, '2015-09-07 03:08:30', '2016-08-31 15:34:27', '2011-10-13 09:56:24', '未还');
INSERT INTO `lend`
VALUES (407, 796, 1, '2018-10-29 10:37:42', '2008-11-27 20:34:58', '2010-06-19 21:48:05', '超期未还');
INSERT INTO `lend`
VALUES (408, 503, 8, '2019-06-17 03:38:08', '2015-07-23 20:45:50', '2003-12-29 23:48:34', '已还');
INSERT INTO `lend`
VALUES (409, 413, 5, '2006-02-28 20:47:25', '2011-06-05 02:20:04', '2023-04-21 10:20:48', '未还');
INSERT INTO `lend`
VALUES (410, 900, 2, '2003-12-16 21:03:43', '2014-04-06 13:06:17', '2016-09-09 19:05:42', '已还');
INSERT INTO `lend`
VALUES (411, 553, 6, '2008-09-24 17:17:55', '2017-05-22 22:51:32', '2002-07-16 21:34:02', '未还');
INSERT INTO `lend`
VALUES (412, 765, 1, '2013-08-23 17:04:48', '2006-11-16 16:02:14', '2009-02-17 21:54:28', '未还');
INSERT INTO `lend`
VALUES (413, 65, 8, '2010-05-21 03:13:47', '2004-01-05 00:54:22', '2014-10-17 21:17:46', '已还');
INSERT INTO `lend`
VALUES (414, 224, 11, '2000-10-09 00:49:35', '2006-04-07 06:38:24', '2020-10-12 21:15:26', '已还');
INSERT INTO `lend`
VALUES (415, 549, 12, '2020-03-25 17:42:18', '2011-03-04 18:33:51', '2020-03-08 13:19:15', '未还');
INSERT INTO `lend`
VALUES (416, 18, 2, '2014-03-14 03:02:00', '2004-07-05 03:52:20', '2015-10-20 08:21:43', '未还');
INSERT INTO `lend`
VALUES (417, 247, 11, '2022-07-05 12:34:44', '2023-12-29 21:49:40', '2003-08-11 09:13:23', '未还');
INSERT INTO `lend`
VALUES (418, 794, 5, '2001-04-02 10:28:34', '2012-12-07 06:23:13', '2006-04-21 14:16:00', '未还');
INSERT INTO `lend`
VALUES (419, 267, 10, '2007-11-17 21:06:48', '2004-01-02 04:34:22', '2016-01-02 13:04:58', '已还');
INSERT INTO `lend`
VALUES (420, 978, 2, '2019-02-12 23:23:18', '2013-03-08 21:23:21', '2022-03-09 11:22:38', '已还');
INSERT INTO `lend`
VALUES (421, 183, 9, '2016-09-18 23:39:35', '2001-06-07 18:47:42', '2009-07-12 22:55:29', '未还');
INSERT INTO `lend`
VALUES (422, 739, 4, '2023-08-21 19:48:41', '2002-09-18 08:32:55', '2003-09-15 18:15:26', '已还');
INSERT INTO `lend`
VALUES (423, 464, 11, '2010-10-08 15:26:48', '2010-04-29 18:43:55', '2019-03-26 07:33:16', '未还');
INSERT INTO `lend`
VALUES (424, 600, 6, '2022-02-15 09:05:39', '2019-05-13 23:40:34', '2007-07-15 04:30:26', '未还');
INSERT INTO `lend`
VALUES (425, 727, 10, '2005-03-01 16:48:55', '2016-02-21 07:16:06', '2002-11-24 16:44:00', '已还');
INSERT INTO `lend`
VALUES (426, 953, 3, '2009-11-11 13:51:18', '2002-05-02 11:29:38', '2000-03-20 11:47:22', '超期未还');
INSERT INTO `lend`
VALUES (427, 896, 8, '2013-12-08 16:31:49', '2010-05-31 22:15:35', '2002-06-21 06:30:04', '超期未还');
INSERT INTO `lend`
VALUES (428, 547, 9, '2016-06-27 20:21:03', '2018-05-02 20:32:35', '2020-10-13 19:22:20', '已还');
INSERT INTO `lend`
VALUES (429, 344, 10, '2011-11-21 18:23:48', '2003-02-28 09:15:12', '2023-05-19 19:54:17', '未还');
INSERT INTO `lend`
VALUES (430, 275, 6, '2012-06-24 04:30:51', '2023-03-06 16:38:28', '2003-04-11 22:12:30', '超期未还');
INSERT INTO `lend`
VALUES (431, 734, 3, '2011-06-08 22:56:20', '2016-11-23 20:23:51', '2008-06-10 08:31:43', '未还');
INSERT INTO `lend`
VALUES (432, 733, 2, '2022-01-01 09:01:48', '2000-03-26 08:41:07', '2009-12-06 12:41:27', '已还');
INSERT INTO `lend`
VALUES (433, 801, 1, '2021-03-18 05:21:49', '2023-02-03 22:00:34', '2019-04-30 01:46:04', '已还');
INSERT INTO `lend`
VALUES (434, 790, 5, '2014-04-02 09:39:30', '2005-09-19 11:52:20', '2001-05-25 16:13:28', '已还');
INSERT INTO `lend`
VALUES (435, 487, 4, '2000-10-09 08:21:29', '2003-06-09 09:38:31', '2019-05-15 11:23:47', '未还');
INSERT INTO `lend`
VALUES (436, 124, 12, '2017-12-28 19:43:42', '2016-12-08 15:38:39', '2017-08-22 10:30:31', '超期未还');
INSERT INTO `lend`
VALUES (437, 368, 1, '2004-11-23 03:16:49', '2019-04-17 10:53:22', '2008-01-03 21:02:54', '未还');
INSERT INTO `lend`
VALUES (438, 470, 2, '2015-12-10 00:15:31', '2013-04-28 16:19:13', '2019-08-01 01:01:02', '未还');
INSERT INTO `lend`
VALUES (439, 461, 11, '2022-10-29 02:08:10', '2000-09-10 11:28:10', '2000-06-10 01:12:42', '未还');
INSERT INTO `lend`
VALUES (440, 695, 1, '2011-01-24 00:44:43', '2008-08-15 16:43:49', '2003-07-07 06:31:48', '未还');
INSERT INTO `lend`
VALUES (441, 581, 3, '2021-03-19 02:34:55', '2002-10-01 22:17:10', '2004-06-24 21:20:29', '已还');
INSERT INTO `lend`
VALUES (442, 887, 3, '2020-07-05 02:11:03', '2018-01-11 12:39:05', '2012-07-05 05:21:30', '未还');
INSERT INTO `lend`
VALUES (443, 624, 8, '2013-04-01 18:47:34', '2007-10-27 00:44:01', '2017-08-03 18:40:13', '超期未还');
INSERT INTO `lend`
VALUES (444, 658, 1, '2002-06-28 01:22:05', '2002-11-24 07:54:32', '2016-04-04 07:10:21', '超期未还');
INSERT INTO `lend`
VALUES (445, 246, 6, '2004-05-28 05:00:42', '2006-06-28 02:29:13', '2011-11-22 08:42:56', '超期未还');
INSERT INTO `lend`
VALUES (446, 884, 8, '2023-11-28 13:46:00', '2014-07-15 06:48:29', '2021-09-29 01:40:22', '已还');
INSERT INTO `lend`
VALUES (447, 318, 3, '2010-10-01 16:03:03', '2015-01-20 03:25:12', '2003-07-08 09:14:01', '已还');
INSERT INTO `lend`
VALUES (448, 105, 2, '2011-11-20 21:39:04', '2008-11-07 00:16:30', '2016-09-09 22:05:01', '超期未还');
INSERT INTO `lend`
VALUES (449, 102, 9, '2007-02-24 09:38:17', '2008-07-23 13:54:45', '2021-08-06 20:19:53', '未还');
INSERT INTO `lend`
VALUES (450, 827, 8, '2022-11-19 03:59:18', '2008-11-21 22:02:06', '2016-05-07 10:14:57', '超期未还');
INSERT INTO `lend`
VALUES (451, 186, 1, '2015-05-18 21:59:20', '2018-01-28 23:04:08', '2023-12-30 23:27:32', '已还');
INSERT INTO `lend`
VALUES (452, 710, 10, '2012-12-04 19:33:37', '2003-08-13 09:43:25', '2016-08-07 12:20:25', '超期未还');
INSERT INTO `lend`
VALUES (453, 679, 4, '2014-04-22 17:24:03', '2018-12-23 17:22:19', '2019-06-11 08:22:25', '已还');
INSERT INTO `lend`
VALUES (454, 440, 4, '2010-09-09 18:20:03', '2013-08-01 08:15:42', '2017-05-03 12:43:24', '未还');
INSERT INTO `lend`
VALUES (455, 842, 7, '2021-01-29 11:14:02', '2004-07-28 14:01:38', '2009-08-02 22:25:51', '未还');
INSERT INTO `lend`
VALUES (456, 582, 8, '2005-02-08 02:31:05', '2019-08-31 02:18:22', '2007-08-23 20:38:22', '已还');
INSERT INTO `lend`
VALUES (457, 501, 10, '2010-06-02 01:12:30', '2020-10-12 01:02:29', '2023-04-30 08:50:03', '超期未还');
INSERT INTO `lend`
VALUES (458, 327, 3, '2006-05-25 23:42:38', '2014-07-13 09:39:28', '2014-12-17 17:58:39', '已还');
INSERT INTO `lend`
VALUES (459, 942, 10, '2010-04-05 10:06:18', '2010-05-05 23:27:17', '2005-01-21 21:43:37', '未还');
INSERT INTO `lend`
VALUES (460, 106, 6, '2003-04-27 05:16:51', '2004-04-03 14:21:43', '2023-07-18 09:17:41', '未还');
INSERT INTO `lend`
VALUES (461, 224, 2, '2005-12-03 15:03:20', '2010-11-13 02:00:48', '2007-01-20 16:33:05', '超期未还');
INSERT INTO `lend`
VALUES (462, 117, 7, '2002-05-18 15:32:48', '2003-06-09 02:16:21', '2020-06-10 02:02:53', '已还');
INSERT INTO `lend`
VALUES (463, 818, 12, '2007-08-08 18:11:37', '2014-10-09 18:46:27', '2005-10-03 08:23:41', '已还');
INSERT INTO `lend`
VALUES (464, 422, 9, '2022-02-28 06:51:42', '2001-09-21 10:52:11', '2002-08-01 09:44:24', '已还');
INSERT INTO `lend`
VALUES (465, 321, 9, '2007-02-05 10:48:24', '2003-08-16 22:12:42', '2009-06-05 15:41:24', '超期未还');
INSERT INTO `lend`
VALUES (466, 14, 8, '2011-12-04 04:50:32', '2005-05-04 16:54:48', '2006-05-16 06:49:39', '超期未还');
INSERT INTO `lend`
VALUES (467, 499, 7, '2015-07-03 17:57:00', '2022-04-04 11:40:42', '2023-02-19 07:16:55', '已还');
INSERT INTO `lend`
VALUES (468, 944, 11, '2023-10-09 09:56:21', '2008-02-08 02:14:57', '2013-04-03 09:33:40', '超期未还');
INSERT INTO `lend`
VALUES (469, 157, 11, '2019-07-23 04:18:34', '2005-07-09 16:22:23', '2016-08-22 07:22:18', '超期未还');
INSERT INTO `lend`
VALUES (470, 784, 2, '2020-01-18 02:50:50', '2002-03-02 06:31:55', '2012-01-13 18:59:15', '超期未还');
INSERT INTO `lend`
VALUES (471, 466, 3, '2009-04-18 12:56:56', '2018-02-25 15:48:50', '2021-10-24 09:48:06', '超期未还');
INSERT INTO `lend`
VALUES (472, 905, 11, '2016-06-24 00:27:46', '2012-10-20 09:08:33', '2010-01-06 06:23:25', '超期未还');
INSERT INTO `lend`
VALUES (473, 954, 8, '2011-07-01 07:09:29', '2023-10-13 13:01:48', '2017-09-08 21:21:57', '已还');
INSERT INTO `lend`
VALUES (474, 352, 7, '2009-12-10 16:28:32', '2010-11-15 03:30:29', '2014-02-27 17:51:35', '已还');
INSERT INTO `lend`
VALUES (475, 129, 2, '2011-04-11 09:37:20', '2019-03-05 21:33:50', '2002-09-11 02:37:27', '超期未还');
INSERT INTO `lend`
VALUES (476, 316, 4, '2010-03-19 17:34:26', '2014-08-23 18:11:19', '2004-11-12 05:48:00', '未还');
INSERT INTO `lend`
VALUES (477, 75, 10, '2010-04-04 18:42:00', '2016-06-06 14:17:19', '2012-08-12 23:52:33', '超期未还');
INSERT INTO `lend`
VALUES (478, 595, 10, '2014-01-23 06:12:08', '2007-11-07 11:32:32', '2019-11-14 23:17:14', '未还');
INSERT INTO `lend`
VALUES (479, 607, 9, '2013-02-13 15:56:28', '2008-06-01 16:00:58', '2022-03-31 16:06:08', '已还');
INSERT INTO `lend`
VALUES (480, 197, 11, '2021-09-17 23:42:27', '2008-12-21 09:18:47', '2023-01-06 16:39:34', '未还');
INSERT INTO `lend`
VALUES (481, 856, 12, '2007-06-18 04:01:46', '2007-05-24 13:11:52', '2004-04-23 23:41:32', '超期未还');
INSERT INTO `lend`
VALUES (482, 760, 3, '2002-10-28 03:47:51', '2007-01-29 14:27:46', '2013-11-27 06:21:36', '未还');
INSERT INTO `lend`
VALUES (483, 509, 10, '2014-08-22 19:46:51', '2001-08-14 02:54:12', '2021-09-19 07:44:49', '超期未还');
INSERT INTO `lend`
VALUES (484, 596, 12, '2009-01-16 05:19:40', '2006-12-31 03:53:08', '2005-07-20 13:19:50', '未还');
INSERT INTO `lend`
VALUES (485, 538, 3, '2003-05-15 11:19:03', '2018-07-17 11:06:39', '2020-11-25 06:50:55', '已还');
INSERT INTO `lend`
VALUES (486, 614, 4, '2013-04-22 05:45:04', '2012-11-02 02:08:17', '2014-03-13 20:26:31', '已还');
INSERT INTO `lend`
VALUES (487, 228, 4, '2021-11-16 09:45:09', '2021-03-01 05:28:54', '2009-05-01 14:55:15', '超期未还');
INSERT INTO `lend`
VALUES (488, 562, 2, '2007-04-17 14:11:41', '2004-09-01 17:26:07', '2013-11-12 01:37:03', '未还');
INSERT INTO `lend`
VALUES (489, 456, 6, '2007-04-28 06:26:23', '2015-04-28 15:01:05', '2015-12-27 09:26:36', '未还');
INSERT INTO `lend`
VALUES (490, 415, 10, '2004-01-28 02:42:19', '2004-09-05 11:04:20', '2023-12-26 07:48:59', '超期未还');
INSERT INTO `lend`
VALUES (491, 888, 10, '2016-06-09 10:35:20', '2019-11-24 02:57:55', '2004-07-18 00:56:41', '已还');
INSERT INTO `lend`
VALUES (492, 676, 12, '2012-07-31 05:19:26', '2020-05-06 22:59:54', '2011-10-05 16:22:43', '未还');
INSERT INTO `lend`
VALUES (493, 681, 4, '2016-06-02 01:50:33', '2005-02-15 12:37:15', '2019-11-24 17:53:07', '已还');
INSERT INTO `lend`
VALUES (494, 216, 11, '2005-07-28 12:45:45', '2001-10-23 08:57:00', '2003-10-07 22:09:53', '超期未还');
INSERT INTO `lend`
VALUES (495, 294, 11, '2003-08-04 10:41:25', '2001-01-13 04:28:51', '2020-07-16 17:39:54', '超期未还');
INSERT INTO `lend`
VALUES (496, 697, 11, '2004-10-09 21:46:28', '2005-08-08 15:50:47', '2013-08-08 09:47:41', '未还');
INSERT INTO `lend`
VALUES (497, 107, 6, '2000-04-08 22:07:12', '2016-09-21 18:44:00', '2022-08-14 04:58:06', '已还');
INSERT INTO `lend`
VALUES (498, 283, 10, '2011-11-05 08:52:46', '2015-03-10 11:26:56', '2013-08-13 13:33:50', '超期未还');
INSERT INTO `lend`
VALUES (499, 392, 3, '2003-09-02 17:49:25', '2016-05-06 10:05:51', '2020-08-12 02:43:09', '未还');
INSERT INTO `lend`
VALUES (500, 717, 10, '2003-07-19 07:34:47', '2020-06-20 12:00:53', '2012-05-31 10:04:07', '已还');
INSERT INTO `lend`
VALUES (501, 190, 4, '2020-09-16 20:05:53', '2018-10-25 06:56:43', '2014-08-28 06:07:14', '已还');
INSERT INTO `lend`
VALUES (502, 221, 11, '2002-01-19 14:20:32', '2023-09-08 10:27:29', '2011-04-05 20:45:26', '已还');
INSERT INTO `lend`
VALUES (503, 850, 8, '2001-10-02 06:40:36', '2018-09-12 03:14:05', '2004-12-09 08:22:01', '已还');
INSERT INTO `lend`
VALUES (504, 399, 11, '2003-09-29 23:56:31', '2014-08-20 14:10:32', '2022-12-10 16:12:23', '已还');
INSERT INTO `lend`
VALUES (505, 66, 4, '2001-10-08 07:12:13', '2015-11-07 09:56:25', '2007-10-15 22:30:01', '超期未还');
INSERT INTO `lend`
VALUES (506, 218, 5, '2022-09-20 14:38:36', '2021-05-07 12:19:07', '2017-12-23 12:23:02', '已还');
INSERT INTO `lend`
VALUES (507, 844, 7, '2013-12-14 18:38:03', '2009-08-27 12:55:11', '2002-08-18 02:22:08', '未还');
INSERT INTO `lend`
VALUES (508, 589, 11, '2014-03-09 20:32:53', '2018-08-12 10:35:18', '2008-04-23 19:51:57', '已还');
INSERT INTO `lend`
VALUES (509, 845, 1, '2023-01-19 17:17:02', '2019-06-01 02:58:36', '2003-05-12 08:16:29', '已还');
INSERT INTO `lend`
VALUES (510, 32, 3, '2019-05-11 19:14:16', '2012-03-31 22:54:19', '2014-09-05 16:42:55', '超期未还');
INSERT INTO `lend`
VALUES (511, 235, 8, '2009-09-14 17:55:48', '2016-03-16 23:25:36', '2018-12-24 09:49:16', '已还');
INSERT INTO `lend`
VALUES (512, 511, 11, '2016-08-03 12:19:25', '2005-11-22 20:37:45', '2012-12-30 06:45:27', '已还');
INSERT INTO `lend`
VALUES (513, 287, 9, '2006-01-08 13:40:58', '2011-12-24 02:54:38', '2011-07-23 20:14:01', '未还');
INSERT INTO `lend`
VALUES (514, 889, 7, '2001-09-18 17:33:54', '2014-10-27 17:50:02', '2013-04-17 00:32:14', '未还');
INSERT INTO `lend`
VALUES (515, 8, 11, '2006-03-10 04:43:22', '2008-05-03 01:15:40', '2021-07-06 00:20:35', '未还');
INSERT INTO `lend`
VALUES (516, 671, 12, '2008-03-29 11:51:34', '2009-11-06 19:54:54', '2014-11-12 15:58:14', '超期未还');
INSERT INTO `lend`
VALUES (517, 46, 9, '2005-07-02 22:51:42', '2019-09-14 22:28:51', '2009-06-02 10:01:47', '超期未还');
INSERT INTO `lend`
VALUES (518, 759, 10, '2002-06-26 05:47:20', '2013-06-22 08:17:21', '2020-09-26 10:39:42', '超期未还');
INSERT INTO `lend`
VALUES (519, 234, 4, '2017-10-03 00:52:39', '2014-04-26 05:35:09', '2011-11-08 20:36:47', '未还');
INSERT INTO `lend`
VALUES (520, 822, 9, '2016-03-26 01:07:01', '2009-01-05 08:33:21', '2008-10-26 09:26:01', '已还');
INSERT INTO `lend`
VALUES (521, 880, 5, '2006-08-11 16:39:44', '2018-04-28 12:07:22', '2020-01-22 05:54:09', '超期未还');
INSERT INTO `lend`
VALUES (522, 523, 1, '2016-11-24 18:02:14', '2022-11-10 05:24:25', '2023-12-01 12:16:05', '已还');
INSERT INTO `lend`
VALUES (523, 337, 4, '2004-09-05 13:50:17', '2004-03-30 08:44:12', '2013-11-03 07:59:58', '未还');
INSERT INTO `lend`
VALUES (524, 444, 3, '2003-02-27 11:55:45', '2020-10-16 11:40:50', '2019-01-04 08:41:47', '已还');
INSERT INTO `lend`
VALUES (525, 179, 4, '2010-07-07 10:19:43', '2015-07-30 14:33:44', '2012-09-28 02:41:39', '已还');
INSERT INTO `lend`
VALUES (526, 471, 8, '2008-05-27 00:28:06', '2011-04-09 20:40:34', '2016-10-09 00:49:46', '未还');
INSERT INTO `lend`
VALUES (527, 816, 4, '2015-10-13 22:29:57', '2016-05-09 03:28:35', '2021-11-23 14:30:30', '已还');
INSERT INTO `lend`
VALUES (528, 224, 9, '2010-03-30 08:18:09', '2004-10-22 20:29:19', '2019-08-18 03:56:06', '已还');
INSERT INTO `lend`
VALUES (529, 817, 11, '2005-06-02 02:27:38', '2018-08-25 10:23:03', '2010-05-29 21:38:40', '超期未还');
INSERT INTO `lend`
VALUES (530, 16, 2, '2009-08-11 10:02:46', '2006-11-03 09:17:21', '2006-02-21 03:19:19', '未还');
INSERT INTO `lend`
VALUES (531, 877, 10, '2021-04-13 16:51:09', '2010-06-09 20:52:18', '2010-08-29 15:32:41', '未还');
INSERT INTO `lend`
VALUES (532, 826, 4, '2002-10-17 23:48:11', '2021-11-02 03:35:43', '2019-07-22 06:54:14', '超期未还');
INSERT INTO `lend`
VALUES (533, 380, 7, '2022-12-29 06:03:49', '2012-10-29 08:58:11', '2022-11-29 17:53:32', '未还');
INSERT INTO `lend`
VALUES (534, 396, 5, '2011-09-12 12:56:08', '2022-03-19 20:10:00', '2006-05-29 11:59:23', '超期未还');
INSERT INTO `lend`
VALUES (535, 427, 11, '2017-08-27 14:03:13', '2020-03-11 03:30:09', '2011-03-14 20:24:15', '已还');
INSERT INTO `lend`
VALUES (536, 263, 9, '2019-04-12 16:08:25', '2016-07-29 06:55:10', '2013-01-18 10:42:23', '超期未还');
INSERT INTO `lend`
VALUES (537, 633, 9, '2007-03-17 10:48:14', '2022-11-24 22:52:35', '2008-04-26 09:28:10', '未还');
INSERT INTO `lend`
VALUES (538, 641, 7, '2007-03-07 06:26:42', '2014-05-24 05:41:01', '2013-06-12 23:49:07', '未还');
INSERT INTO `lend`
VALUES (539, 885, 4, '2019-10-17 22:21:50', '2013-01-02 07:25:48', '2000-05-21 16:06:38', '已还');
INSERT INTO `lend`
VALUES (540, 560, 10, '2009-02-27 07:43:20', '2005-07-17 12:38:00', '2015-03-17 07:25:28', '超期未还');
INSERT INTO `lend`
VALUES (541, 672, 10, '2004-06-23 16:14:21', '2003-01-08 02:21:02', '2019-04-27 17:23:58', '未还');
INSERT INTO `lend`
VALUES (542, 572, 5, '2003-07-03 19:54:49', '2015-04-20 02:33:58', '2012-11-20 10:39:19', '超期未还');
INSERT INTO `lend`
VALUES (543, 13, 7, '2017-09-23 09:06:16', '2021-07-07 22:35:20', '2008-04-10 05:34:41', '未还');
INSERT INTO `lend`
VALUES (544, 524, 4, '2002-05-26 04:18:59', '2000-10-14 04:08:50', '2004-03-10 00:33:03', '未还');
INSERT INTO `lend`
VALUES (545, 682, 3, '2004-11-03 09:17:49', '2008-10-21 00:40:33', '2001-06-22 17:18:43', '超期未还');
INSERT INTO `lend`
VALUES (546, 393, 4, '2007-09-16 07:52:24', '2009-01-07 07:03:02', '2011-10-05 00:23:06', '超期未还');
INSERT INTO `lend`
VALUES (547, 35, 9, '2019-07-19 21:28:40', '2010-02-04 03:57:48', '2004-02-28 09:06:39', '超期未还');
INSERT INTO `lend`
VALUES (548, 914, 1, '2013-06-14 05:33:15', '2012-01-14 22:00:05', '2013-11-11 20:41:21', '未还');
INSERT INTO `lend`
VALUES (549, 65, 9, '2018-02-25 05:12:20', '2010-08-24 21:23:09', '2013-06-08 01:15:41', '已还');
INSERT INTO `lend`
VALUES (550, 343, 5, '2016-06-10 22:05:37', '2018-12-20 19:32:08', '2002-01-25 16:40:31', '已还');
INSERT INTO `lend`
VALUES (551, 535, 3, '2005-09-16 03:40:47', '2012-11-20 02:49:59', '2010-01-28 08:05:22', '超期未还');
INSERT INTO `lend`
VALUES (552, 986, 12, '2010-05-14 22:38:43', '2022-01-16 21:11:44', '2022-10-02 09:59:29', '已还');
INSERT INTO `lend`
VALUES (553, 903, 2, '2014-02-04 20:40:16', '2013-09-24 19:36:09', '2010-12-01 11:44:41', '已还');
INSERT INTO `lend`
VALUES (554, 852, 10, '2020-10-22 06:04:41', '2021-12-18 21:36:28', '2006-12-26 06:19:45', '已还');
INSERT INTO `lend`
VALUES (555, 630, 11, '2018-07-27 08:40:22', '2009-07-17 06:05:35', '2016-05-04 19:05:58', '未还');
INSERT INTO `lend`
VALUES (556, 952, 5, '2015-06-12 22:37:37', '2009-05-22 00:02:40', '2013-11-14 14:48:25', '超期未还');
INSERT INTO `lend`
VALUES (557, 202, 8, '2010-07-30 10:57:39', '2020-10-13 06:55:10', '2013-04-06 09:09:26', '已还');
INSERT INTO `lend`
VALUES (558, 930, 7, '2011-01-24 19:58:58', '2012-12-01 19:03:52', '2019-09-23 05:48:56', '超期未还');
INSERT INTO `lend`
VALUES (559, 97, 2, '2008-06-07 10:40:45', '2014-10-19 17:38:35', '2011-09-14 14:16:02', '超期未还');
INSERT INTO `lend`
VALUES (560, 903, 2, '2015-07-21 17:32:11', '2000-05-07 14:57:44', '2022-10-09 02:18:23', '未还');
INSERT INTO `lend`
VALUES (561, 50, 4, '2010-10-27 03:00:01', '2020-12-09 02:58:49', '2002-05-10 19:33:24', '未还');
INSERT INTO `lend`
VALUES (562, 909, 11, '2010-12-21 12:08:29', '2020-10-07 16:20:05', '2022-03-05 08:56:50', '未还');
INSERT INTO `lend`
VALUES (563, 424, 4, '2009-10-20 20:58:55', '2019-01-13 10:03:30', '2019-10-13 16:19:13', '已还');
INSERT INTO `lend`
VALUES (564, 708, 10, '2010-05-18 11:59:13', '2008-04-25 10:49:44', '2005-01-04 19:53:51', '超期未还');
INSERT INTO `lend`
VALUES (565, 826, 7, '2017-07-09 22:21:59', '2011-01-29 22:28:00', '2011-09-07 04:19:20', '已还');
INSERT INTO `lend`
VALUES (566, 591, 6, '2012-04-15 03:40:09', '2017-09-19 21:38:56', '2012-01-08 05:18:13', '未还');
INSERT INTO `lend`
VALUES (567, 114, 2, '2005-01-17 00:38:02', '2007-08-07 21:59:29', '2000-05-25 11:09:03', '超期未还');
INSERT INTO `lend`
VALUES (568, 512, 7, '2009-05-01 12:18:32', '2020-03-10 15:12:19', '2021-08-24 02:51:45', '超期未还');
INSERT INTO `lend`
VALUES (569, 316, 1, '2006-09-01 05:38:51', '2016-11-17 12:24:46', '2006-10-20 18:03:27', '已还');
INSERT INTO `lend`
VALUES (570, 899, 4, '2005-04-23 04:01:46', '2021-11-25 08:40:56', '2006-10-09 03:22:52', '超期未还');
INSERT INTO `lend`
VALUES (571, 424, 6, '2014-02-10 14:28:29', '2004-10-14 03:46:38', '2021-01-14 15:05:40', '超期未还');
INSERT INTO `lend`
VALUES (572, 148, 10, '2021-05-29 12:16:12', '2008-12-22 09:48:32', '2022-03-16 10:00:28', '未还');
INSERT INTO `lend`
VALUES (573, 186, 5, '2004-09-29 07:14:48', '2023-10-29 13:22:27', '2010-09-28 04:04:13', '已还');
INSERT INTO `lend`
VALUES (574, 560, 7, '2010-12-25 08:33:20', '2019-10-23 17:20:47', '2007-03-13 01:44:47', '超期未还');
INSERT INTO `lend`
VALUES (575, 550, 4, '2016-04-03 09:19:50', '2011-06-20 03:46:15', '2020-11-28 01:39:14', '超期未还');
INSERT INTO `lend`
VALUES (576, 129, 12, '2013-01-02 07:51:34', '2017-10-12 11:31:32', '2014-06-22 12:12:53', '未还');
INSERT INTO `lend`
VALUES (577, 683, 3, '2008-05-17 11:30:35', '2007-03-28 20:37:26', '2018-10-31 20:11:12', '未还');
INSERT INTO `lend`
VALUES (578, 482, 9, '2017-03-19 23:29:51', '2009-02-15 15:22:07', '2005-04-02 04:40:31', '已还');
INSERT INTO `lend`
VALUES (579, 405, 10, '2011-02-17 16:09:03', '2016-08-22 03:28:25', '2020-05-18 10:16:59', '超期未还');
INSERT INTO `lend`
VALUES (580, 750, 6, '2000-02-12 23:36:51', '2023-03-05 20:02:02', '2007-09-23 05:20:27', '超期未还');
INSERT INTO `lend`
VALUES (581, 246, 8, '2018-09-29 02:09:12', '2000-08-07 23:55:47', '2013-01-10 07:11:53', '已还');
INSERT INTO `lend`
VALUES (582, 158, 6, '2004-05-14 04:27:49', '2000-11-30 03:56:34', '2001-06-28 12:21:49', '已还');
INSERT INTO `lend`
VALUES (583, 903, 8, '2002-02-24 16:59:56', '2007-01-08 10:10:55', '2002-07-25 20:21:13', '未还');
INSERT INTO `lend`
VALUES (584, 236, 10, '2014-05-15 07:41:09', '2022-10-23 01:52:32', '2008-12-13 14:56:22', '未还');
INSERT INTO `lend`
VALUES (585, 519, 5, '2002-04-23 15:33:48', '2022-12-16 23:52:48', '2007-09-19 02:40:32', '已还');
INSERT INTO `lend`
VALUES (586, 645, 11, '2000-01-28 08:14:09', '2013-06-06 18:55:10', '2014-11-07 23:41:50', '超期未还');
INSERT INTO `lend`
VALUES (587, 326, 2, '2007-10-31 11:15:13', '2023-08-12 23:40:25', '2020-12-20 06:23:12', '已还');
INSERT INTO `lend`
VALUES (588, 646, 4, '2016-07-21 14:52:32', '2015-05-11 20:52:27', '2016-04-21 21:58:04', '超期未还');
INSERT INTO `lend`
VALUES (589, 232, 3, '2019-01-13 20:13:13', '2003-01-24 07:25:16', '2020-06-28 20:57:47', '未还');
INSERT INTO `lend`
VALUES (590, 154, 1, '2019-08-25 12:38:33', '2015-01-26 12:07:20', '2022-04-24 20:52:19', '超期未还');
INSERT INTO `lend`
VALUES (591, 163, 4, '2002-07-14 01:50:56', '2022-03-08 20:28:26', '2009-01-17 18:50:42', '未还');
INSERT INTO `lend`
VALUES (592, 252, 5, '2020-09-25 18:31:18', '2003-12-15 06:42:21', '2007-08-10 23:28:11', '已还');
INSERT INTO `lend`
VALUES (593, 435, 11, '2023-10-28 09:02:03', '2019-12-04 22:20:40', '2001-08-13 23:21:34', '已还');
INSERT INTO `lend`
VALUES (594, 303, 8, '2014-03-14 21:53:45', '2003-11-19 10:04:39', '2020-08-09 13:08:58', '已还');
INSERT INTO `lend`
VALUES (595, 226, 2, '2014-04-30 07:56:52', '2023-12-09 16:28:16', '2000-08-18 23:20:26', '超期未还');
INSERT INTO `lend`
VALUES (596, 426, 8, '2001-07-25 15:18:24', '2009-11-08 04:26:02', '2012-08-05 13:05:10', '已还');
INSERT INTO `lend`
VALUES (597, 500, 12, '2020-02-28 12:05:57', '2013-05-26 16:50:34', '2019-07-21 07:07:48', '未还');
INSERT INTO `lend`
VALUES (598, 954, 4, '2018-01-15 06:09:03', '2009-07-28 14:31:35', '2008-09-24 10:26:42', '未还');
INSERT INTO `lend`
VALUES (599, 101, 7, '2001-03-02 23:24:54', '2019-04-22 21:30:30', '2020-03-15 05:27:59', '已还');
INSERT INTO `lend`
VALUES (600, 77, 9, '2020-01-20 08:49:39', '2011-06-19 16:28:09', '2003-08-05 00:55:11', '超期未还');
INSERT INTO `lend`
VALUES (601, 250, 11, '2021-08-11 06:22:11', '2013-10-29 11:03:04', '2011-03-10 23:11:42', '未还');
INSERT INTO `lend`
VALUES (602, 670, 6, '2012-03-28 21:58:52', '2000-09-30 08:19:51', '2004-06-11 21:26:12', '未还');
INSERT INTO `lend`
VALUES (603, 441, 11, '2019-06-05 17:53:12', '2020-05-14 15:15:26', '2004-09-21 11:26:32', '已还');
INSERT INTO `lend`
VALUES (604, 31, 10, '2016-01-22 23:46:58', '2019-10-24 03:05:28', '2008-02-07 15:04:23', '未还');
INSERT INTO `lend`
VALUES (605, 921, 4, '2002-04-13 06:42:33', '2004-04-22 08:27:46', '2011-12-19 10:44:24', '未还');
INSERT INTO `lend`
VALUES (606, 167, 8, '2003-01-10 12:30:53', '2017-05-16 19:34:54', '2014-11-22 05:13:52', '未还');
INSERT INTO `lend`
VALUES (607, 267, 9, '2007-12-28 20:11:35', '2019-09-22 13:32:03', '2018-11-08 05:44:59', '未还');
INSERT INTO `lend`
VALUES (608, 642, 11, '2022-07-10 03:33:47', '2004-06-24 15:42:00', '2011-06-06 15:22:58', '未还');
INSERT INTO `lend`
VALUES (609, 42, 7, '2011-05-18 03:51:23', '2000-02-14 18:18:39', '2019-11-27 15:52:57', '已还');
INSERT INTO `lend`
VALUES (610, 643, 5, '2001-03-05 18:16:59', '2020-08-10 21:38:45', '2009-12-15 11:52:46', '未还');
INSERT INTO `lend`
VALUES (611, 156, 7, '2006-09-09 04:14:31', '2002-08-26 20:16:49', '2006-11-08 17:55:56', '未还');
INSERT INTO `lend`
VALUES (612, 777, 2, '2017-04-14 07:51:26', '2022-02-21 05:45:57', '2000-12-29 10:44:07', '已还');
INSERT INTO `lend`
VALUES (613, 624, 3, '2022-09-21 08:47:22', '2017-09-23 13:45:46', '2006-03-09 06:58:52', '超期未还');
INSERT INTO `lend`
VALUES (614, 945, 8, '2023-07-29 17:31:10', '2006-03-30 16:50:50', '2011-03-02 19:18:39', '未还');
INSERT INTO `lend`
VALUES (615, 612, 8, '2004-07-12 10:34:29', '2011-09-05 02:58:10', '2008-04-15 22:11:22', '已还');
INSERT INTO `lend`
VALUES (616, 637, 2, '2005-04-01 20:52:38', '2008-08-24 13:08:35', '2021-09-14 22:26:23', '已还');
INSERT INTO `lend`
VALUES (617, 252, 1, '2015-10-19 11:33:21', '2019-07-19 04:23:36', '2001-05-19 15:00:34', '已还');
INSERT INTO `lend`
VALUES (618, 912, 11, '2002-08-18 21:38:00', '2016-02-20 21:24:59', '2005-05-28 08:32:32', '未还');
INSERT INTO `lend`
VALUES (619, 260, 3, '2021-02-26 04:01:28', '2003-02-22 17:33:49', '2017-08-16 03:38:23', '超期未还');
INSERT INTO `lend`
VALUES (620, 88, 7, '2016-04-16 17:36:48', '2005-02-20 02:46:42', '2012-02-18 12:26:18', '超期未还');
INSERT INTO `lend`
VALUES (621, 532, 2, '2018-02-02 15:09:54', '2003-12-28 05:51:00', '2013-09-28 04:44:46', '已还');
INSERT INTO `lend`
VALUES (622, 223, 11, '2003-01-21 07:37:55', '2010-07-27 18:05:36', '2005-04-26 10:03:31', '超期未还');
INSERT INTO `lend`
VALUES (623, 973, 8, '2008-11-12 18:55:51', '2007-09-16 07:46:00', '2001-12-02 05:30:56', '超期未还');
INSERT INTO `lend`
VALUES (624, 189, 8, '2010-07-06 16:51:38', '2016-01-10 16:01:45', '2006-06-18 14:45:53', '未还');
INSERT INTO `lend`
VALUES (625, 819, 6, '2011-05-04 11:13:59', '2002-11-08 13:06:55', '2023-11-09 07:54:42', '超期未还');
INSERT INTO `lend`
VALUES (626, 427, 11, '2007-07-11 02:11:56', '2022-01-29 13:46:45', '2003-05-11 08:05:02', '未还');
INSERT INTO `lend`
VALUES (627, 816, 2, '2016-12-16 05:58:12', '2000-05-04 16:19:06', '2018-04-27 01:49:39', '已还');
INSERT INTO `lend`
VALUES (628, 788, 10, '2004-07-09 19:30:38', '2003-06-25 15:15:50', '2008-01-08 11:07:05', '未还');
INSERT INTO `lend`
VALUES (629, 946, 3, '2011-05-15 07:47:30', '2015-12-09 17:48:53', '2003-04-20 12:48:22', '已还');
INSERT INTO `lend`
VALUES (630, 159, 6, '2006-10-16 13:58:06', '2022-08-08 18:52:36', '2015-08-30 05:10:01', '未还');
INSERT INTO `lend`
VALUES (631, 995, 9, '2020-03-29 20:02:57', '2020-04-03 17:35:31', '2005-03-25 00:35:34', '已还');
INSERT INTO `lend`
VALUES (632, 774, 6, '2000-04-17 15:05:39', '2000-03-20 02:11:00', '2008-11-18 10:29:00', '超期未还');
INSERT INTO `lend`
VALUES (633, 663, 12, '2008-07-07 08:04:08', '2011-09-20 23:31:39', '2017-05-18 21:26:34', '超期未还');
INSERT INTO `lend`
VALUES (634, 131, 3, '2019-04-09 16:02:58', '2001-08-27 03:41:26', '2014-10-01 08:12:16', '未还');
INSERT INTO `lend`
VALUES (635, 902, 1, '2017-06-25 02:13:06', '2006-09-28 21:47:08', '2014-03-18 07:14:43', '已还');
INSERT INTO `lend`
VALUES (636, 633, 3, '2017-10-08 05:38:42', '2003-10-06 07:17:36', '2014-09-04 11:51:55', '未还');
INSERT INTO `lend`
VALUES (637, 319, 5, '2023-07-10 01:08:33', '2007-05-18 06:01:16', '2021-10-17 14:50:17', '超期未还');
INSERT INTO `lend`
VALUES (638, 157, 2, '2002-10-12 08:48:29', '2007-01-17 15:43:23', '2013-09-02 13:11:57', '已还');
INSERT INTO `lend`
VALUES (639, 288, 3, '2004-03-10 16:43:56', '2012-07-27 02:48:32', '2011-06-06 16:28:37', '未还');
INSERT INTO `lend`
VALUES (640, 836, 4, '2014-10-13 23:59:01', '2018-03-07 05:08:38', '2019-01-06 13:33:05', '超期未还');
INSERT INTO `lend`
VALUES (641, 779, 4, '2007-09-23 09:53:38', '2001-06-07 02:41:20', '2011-12-13 05:24:39', '已还');
INSERT INTO `lend`
VALUES (642, 568, 8, '2022-07-20 08:41:14', '2013-12-06 05:13:45', '2011-12-20 00:05:16', '超期未还');
INSERT INTO `lend`
VALUES (643, 82, 5, '2005-10-09 05:27:41', '2023-05-19 08:47:55', '2007-07-14 13:36:46', '超期未还');
INSERT INTO `lend`
VALUES (644, 808, 6, '2011-07-14 13:37:43', '2006-04-06 21:38:36', '2001-05-12 15:43:26', '未还');
INSERT INTO `lend`
VALUES (645, 562, 11, '2015-04-03 01:45:50', '2005-04-28 17:59:21', '2010-09-08 19:12:44', '未还');
INSERT INTO `lend`
VALUES (646, 200, 8, '2008-06-10 04:39:33', '2007-07-07 18:16:09', '2010-03-09 18:32:17', '未还');
INSERT INTO `lend`
VALUES (647, 60, 7, '2023-04-03 08:51:52', '2003-11-24 03:40:43', '2017-01-26 18:52:07', '超期未还');
INSERT INTO `lend`
VALUES (648, 544, 12, '2005-12-11 08:17:15', '2012-02-17 17:41:33', '2017-07-13 07:55:23', '已还');
INSERT INTO `lend`
VALUES (649, 478, 10, '2008-04-27 20:49:56', '2004-08-26 14:25:18', '2021-12-18 23:53:40', '超期未还');
INSERT INTO `lend`
VALUES (650, 503, 5, '2020-08-28 16:07:27', '2006-01-31 10:48:23', '2012-04-07 01:12:27', '已还');
INSERT INTO `lend`
VALUES (651, 294, 7, '2009-09-02 14:50:22', '2022-10-10 04:27:32', '2006-10-31 00:33:34', '已还');
INSERT INTO `lend`
VALUES (652, 335, 8, '2016-08-07 17:33:07', '2008-07-19 12:41:28', '2016-05-15 20:24:43', '超期未还');
INSERT INTO `lend`
VALUES (653, 264, 6, '2009-01-03 02:26:35', '2020-06-30 03:14:23', '2008-04-10 19:10:31', '超期未还');
INSERT INTO `lend`
VALUES (654, 452, 6, '2013-07-13 20:33:17', '2014-04-06 00:56:07', '2007-09-18 19:59:12', '超期未还');
INSERT INTO `lend`
VALUES (655, 853, 5, '2021-12-25 02:21:41', '2021-11-08 03:59:40', '2022-10-20 08:53:43', '未还');
INSERT INTO `lend`
VALUES (656, 616, 8, '2004-03-11 20:27:43', '2000-03-11 19:42:57', '2020-08-29 17:16:47', '超期未还');
INSERT INTO `lend`
VALUES (657, 976, 10, '2015-10-18 10:41:29', '2022-06-12 14:18:05', '2006-10-13 04:14:47', '超期未还');
INSERT INTO `lend`
VALUES (658, 758, 2, '2015-06-01 00:05:30', '2013-07-07 20:21:22', '2017-05-22 15:35:58', '未还');
INSERT INTO `lend`
VALUES (659, 925, 11, '2003-11-30 15:12:52', '2010-08-17 22:08:41', '2006-11-12 16:41:38', '未还');
INSERT INTO `lend`
VALUES (660, 997, 4, '2011-04-03 13:43:22', '2000-08-24 06:56:34', '2004-05-10 19:10:15', '已还');
INSERT INTO `lend`
VALUES (661, 603, 3, '2014-03-12 23:43:49', '2006-10-30 12:44:47', '2000-02-26 04:27:42', '未还');
INSERT INTO `lend`
VALUES (662, 62, 3, '2022-09-20 05:35:52', '2001-09-07 21:45:11', '2022-08-13 09:28:07', '超期未还');
INSERT INTO `lend`
VALUES (663, 608, 3, '2020-07-08 21:01:53', '2003-09-04 05:25:32', '2019-06-28 05:45:49', '已还');
INSERT INTO `lend`
VALUES (664, 20, 1, '2016-02-14 22:12:23', '2013-02-28 18:00:13', '2017-03-16 08:55:44', '超期未还');
INSERT INTO `lend`
VALUES (665, 438, 9, '2002-12-17 08:04:29', '2020-11-21 02:00:20', '2010-09-17 04:34:31', '未还');
INSERT INTO `lend`
VALUES (666, 334, 11, '2004-06-05 10:12:31', '2023-03-12 17:30:17', '2006-12-02 13:28:53', '未还');
INSERT INTO `lend`
VALUES (667, 843, 7, '2016-09-22 06:57:30', '2012-09-03 01:28:55', '2003-10-02 20:46:05', '已还');
INSERT INTO `lend`
VALUES (668, 344, 9, '2006-07-14 13:33:50', '2004-04-29 09:58:11', '2014-06-04 21:11:26', '已还');
INSERT INTO `lend`
VALUES (669, 405, 12, '2020-04-24 01:43:12', '2022-09-08 19:49:09', '2016-04-05 02:24:35', '未还');
INSERT INTO `lend`
VALUES (670, 786, 9, '2019-12-27 12:58:09', '2017-06-08 06:17:07', '2005-01-16 14:09:41', '未还');
INSERT INTO `lend`
VALUES (671, 202, 2, '2016-04-22 10:34:14', '2005-02-19 11:05:23', '2007-09-30 10:45:14', '未还');
INSERT INTO `lend`
VALUES (672, 80, 3, '2021-04-18 08:50:03', '2015-03-15 20:58:02', '2001-05-02 09:39:21', '已还');
INSERT INTO `lend`
VALUES (673, 691, 5, '2018-02-01 20:04:06', '2008-02-15 13:13:48', '2008-07-29 04:33:53', '已还');
INSERT INTO `lend`
VALUES (674, 925, 6, '2017-01-03 07:01:27', '2003-03-15 09:18:55', '2001-04-13 08:37:53', '未还');
INSERT INTO `lend`
VALUES (675, 433, 3, '2017-09-24 22:23:45', '2005-02-20 19:00:50', '2015-12-18 15:55:07', '已还');
INSERT INTO `lend`
VALUES (676, 327, 8, '2008-07-14 12:49:31', '2007-03-29 03:06:29', '2017-05-10 21:36:10', '超期未还');
INSERT INTO `lend`
VALUES (677, 830, 1, '2015-03-04 17:24:13', '2014-10-13 14:58:12', '2004-10-01 16:57:42', '已还');
INSERT INTO `lend`
VALUES (678, 699, 3, '2016-05-22 12:56:46', '2010-07-14 15:57:19', '2010-06-21 00:56:15', '已还');
INSERT INTO `lend`
VALUES (679, 116, 7, '2013-02-18 05:03:50', '2023-06-10 10:22:08', '2017-06-05 07:29:13', '超期未还');
INSERT INTO `lend`
VALUES (680, 368, 1, '2009-01-23 08:25:54', '2006-03-02 15:36:44', '2023-10-13 05:18:53', '未还');
INSERT INTO `lend`
VALUES (681, 508, 1, '2012-05-02 07:23:30', '2022-08-24 13:52:15', '2021-01-25 02:58:34', '超期未还');
INSERT INTO `lend`
VALUES (682, 176, 11, '2019-01-10 22:58:11', '2019-03-31 21:11:48', '2010-01-27 00:43:39', '已还');
INSERT INTO `lend`
VALUES (683, 343, 10, '2019-01-31 03:52:45', '2021-03-04 10:14:56', '2011-11-26 13:09:24', '未还');
INSERT INTO `lend`
VALUES (684, 532, 4, '2019-04-18 02:51:34', '2018-05-20 14:19:03', '2016-07-07 07:18:30', '未还');
INSERT INTO `lend`
VALUES (685, 994, 2, '2007-04-23 21:14:01', '2009-05-04 17:36:21', '2006-11-24 02:41:43', '已还');
INSERT INTO `lend`
VALUES (686, 496, 3, '2002-01-13 23:50:44', '2003-08-02 10:03:22', '2023-01-04 04:19:00', '未还');
INSERT INTO `lend`
VALUES (687, 182, 7, '2019-01-14 06:49:42', '2005-07-09 05:00:51', '2021-03-23 00:18:02', '未还');
INSERT INTO `lend`
VALUES (688, 777, 11, '2016-07-21 10:20:33', '2023-08-21 21:57:37', '2013-06-22 15:35:06', '未还');
INSERT INTO `lend`
VALUES (689, 171, 2, '2021-10-08 23:16:56', '2003-05-13 04:05:43', '2007-01-23 03:07:23', '未还');
INSERT INTO `lend`
VALUES (690, 341, 8, '2008-04-16 20:57:09', '2007-07-30 13:01:33', '2009-03-15 22:21:03', '未还');
INSERT INTO `lend`
VALUES (691, 763, 8, '2021-10-12 10:17:27', '2005-11-16 12:21:16', '2020-07-11 04:38:19', '未还');
INSERT INTO `lend`
VALUES (692, 543, 2, '2003-05-14 09:56:35', '2006-11-17 16:13:26', '2020-05-01 05:05:43', '超期未还');
INSERT INTO `lend`
VALUES (693, 739, 6, '2015-07-05 17:23:17', '2017-09-23 13:23:48', '2003-04-19 13:09:43', '未还');
INSERT INTO `lend`
VALUES (694, 772, 6, '2005-03-26 02:07:29', '2010-10-12 08:37:13', '2006-01-02 10:36:35', '已还');
INSERT INTO `lend`
VALUES (695, 542, 7, '2010-08-23 12:29:37', '2011-11-18 18:45:33', '2017-10-16 18:39:15', '未还');
INSERT INTO `lend`
VALUES (696, 482, 3, '2004-02-02 07:53:37', '2021-09-05 17:08:07', '2001-07-15 22:12:54', '未还');
INSERT INTO `lend`
VALUES (697, 539, 7, '2023-09-14 19:19:10', '2018-06-11 13:41:28', '2009-11-19 17:14:32', '超期未还');
INSERT INTO `lend`
VALUES (698, 649, 12, '2008-01-31 14:15:21', '2020-01-09 09:56:08', '2018-11-08 11:19:42', '超期未还');
INSERT INTO `lend`
VALUES (699, 839, 1, '2015-05-14 02:45:00', '2019-07-28 00:52:31', '2000-06-10 03:34:23', '超期未还');
INSERT INTO `lend`
VALUES (700, 214, 8, '2018-09-28 20:54:22', '2001-10-01 10:01:35', '2018-01-08 12:53:05', '已还');
INSERT INTO `lend`
VALUES (701, 434, 10, '2009-05-12 05:21:34', '2007-02-28 23:47:03', '2011-10-27 03:00:31', '未还');
INSERT INTO `lend`
VALUES (702, 877, 7, '2005-03-28 10:37:19', '2013-04-30 23:59:12', '2013-02-14 14:43:01', '已还');
INSERT INTO `lend`
VALUES (703, 770, 1, '2021-03-19 22:50:31', '2003-12-22 19:34:54', '2006-06-28 22:30:34', '超期未还');
INSERT INTO `lend`
VALUES (704, 656, 11, '2004-09-10 12:13:00', '2018-04-29 08:22:16', '2003-11-03 19:16:55', '未还');
INSERT INTO `lend`
VALUES (705, 477, 5, '2005-07-11 19:34:33', '2001-10-07 04:23:36', '2000-04-17 07:37:28', '超期未还');
INSERT INTO `lend`
VALUES (706, 60, 11, '2005-01-05 19:37:58', '2003-09-27 22:55:36', '2015-04-06 01:33:04', '未还');
INSERT INTO `lend`
VALUES (707, 377, 11, '2005-03-12 05:47:33', '2010-01-06 02:10:14', '2000-07-28 15:12:21', '已还');
INSERT INTO `lend`
VALUES (708, 112, 1, '2014-09-05 21:48:12', '2017-11-23 00:36:52', '2020-07-05 23:10:41', '超期未还');
INSERT INTO `lend`
VALUES (709, 814, 6, '2003-11-24 10:24:36', '2006-09-10 10:40:42', '2014-03-05 15:15:54', '已还');
INSERT INTO `lend`
VALUES (710, 587, 12, '2000-02-27 03:19:15', '2013-01-30 02:48:40', '2006-11-10 07:10:18', '未还');
INSERT INTO `lend`
VALUES (711, 68, 12, '2004-11-16 10:39:44', '2019-04-22 07:18:19', '2014-02-22 01:35:24', '未还');
INSERT INTO `lend`
VALUES (712, 877, 6, '2002-07-16 05:12:07', '2011-03-13 05:10:48', '2006-08-16 20:19:42', '超期未还');
INSERT INTO `lend`
VALUES (713, 633, 10, '2006-08-23 11:48:55', '2015-09-08 20:46:35', '2004-09-12 16:14:08', '未还');
INSERT INTO `lend`
VALUES (714, 83, 12, '2015-03-14 10:43:28', '2023-01-17 22:45:34', '2020-02-24 23:46:47', '已还');
INSERT INTO `lend`
VALUES (715, 425, 3, '2020-11-13 16:51:23', '2009-08-27 18:44:11', '2021-08-16 01:09:32', '未还');
INSERT INTO `lend`
VALUES (716, 762, 8, '2015-05-07 04:32:15', '2018-11-29 08:05:32', '2018-12-13 22:38:10', '未还');
INSERT INTO `lend`
VALUES (717, 625, 3, '2022-12-15 12:08:12', '2007-09-30 02:40:45', '2014-03-02 17:41:40', '未还');
INSERT INTO `lend`
VALUES (718, 266, 12, '2006-05-26 17:19:28', '2011-11-27 04:05:28', '2017-09-17 20:06:13', '超期未还');
INSERT INTO `lend`
VALUES (719, 661, 8, '2019-02-23 17:33:23', '2020-04-25 16:59:22', '2022-07-04 15:36:02', '未还');
INSERT INTO `lend`
VALUES (720, 326, 11, '2001-04-24 00:08:56', '2005-07-29 02:16:13', '2019-12-05 09:41:56', '超期未还');
INSERT INTO `lend`
VALUES (721, 711, 8, '2012-05-29 21:41:33', '2011-12-14 16:32:50', '2008-10-19 17:30:15', '已还');
INSERT INTO `lend`
VALUES (722, 324, 2, '2013-10-17 02:04:46', '2002-05-15 22:34:05', '2015-05-20 19:42:24', '已还');
INSERT INTO `lend`
VALUES (723, 551, 7, '2014-09-22 05:54:17', '2020-04-10 07:25:39', '2002-12-18 09:35:25', '已还');
INSERT INTO `lend`
VALUES (724, 323, 4, '2004-09-25 09:53:53', '2008-07-13 04:02:33', '2001-01-04 02:18:01', '未还');
INSERT INTO `lend`
VALUES (725, 517, 5, '2011-07-13 18:58:24', '2018-08-17 02:43:28', '2017-10-17 20:32:35', '超期未还');
INSERT INTO `lend`
VALUES (726, 162, 11, '2000-02-11 05:33:26', '2007-10-29 21:03:59', '2006-06-27 06:12:16', '未还');
INSERT INTO `lend`
VALUES (727, 586, 12, '2002-01-14 17:26:26', '2018-06-20 01:57:41', '2010-04-30 05:39:45', '超期未还');
INSERT INTO `lend`
VALUES (728, 185, 8, '2008-05-14 10:52:51', '2005-03-01 04:29:30', '2008-01-27 21:21:38', '未还');
INSERT INTO `lend`
VALUES (729, 406, 3, '2009-01-23 01:46:13', '2004-05-03 07:04:28', '2020-07-20 07:56:53', '未还');
INSERT INTO `lend`
VALUES (730, 913, 3, '2012-05-18 04:43:48', '2010-08-04 20:58:20', '2016-09-17 12:57:17', '已还');
INSERT INTO `lend`
VALUES (731, 760, 1, '2004-12-30 19:18:01', '2002-01-16 01:23:19', '2000-11-30 21:06:27', '未还');
INSERT INTO `lend`
VALUES (732, 333, 8, '2016-05-05 07:00:23', '2004-09-30 03:28:07', '2009-01-11 16:01:23', '未还');
INSERT INTO `lend`
VALUES (733, 163, 6, '2008-07-29 11:18:07', '2023-11-06 16:13:12', '2003-09-10 13:30:16', '未还');
INSERT INTO `lend`
VALUES (734, 785, 5, '2022-02-23 11:23:36', '2017-02-10 23:45:31', '2022-06-20 02:03:54', '未还');
INSERT INTO `lend`
VALUES (735, 64, 10, '2019-07-13 01:35:30', '2002-09-24 23:06:09', '2014-12-19 05:12:49', '未还');
INSERT INTO `lend`
VALUES (736, 863, 7, '2014-12-12 16:30:20', '2008-10-17 09:49:24', '2014-07-25 15:09:22', '未还');
INSERT INTO `lend`
VALUES (737, 455, 8, '2016-10-12 22:42:43', '2006-07-25 21:56:35', '2012-04-08 09:45:20', '未还');
INSERT INTO `lend`
VALUES (738, 961, 7, '2009-11-21 09:56:34', '2004-12-05 23:16:36', '2008-02-14 00:18:11', '超期未还');
INSERT INTO `lend`
VALUES (739, 439, 3, '2020-10-19 14:42:23', '2022-09-09 15:54:26', '2017-01-06 15:58:25', '已还');
INSERT INTO `lend`
VALUES (740, 507, 5, '2019-03-11 19:35:28', '2013-01-21 04:06:57', '2016-06-08 15:36:38', '未还');
INSERT INTO `lend`
VALUES (741, 857, 7, '2008-02-24 14:51:54', '2003-09-30 10:02:02', '2000-12-08 06:45:40', '超期未还');
INSERT INTO `lend`
VALUES (742, 729, 7, '2006-11-19 20:12:17', '2012-12-27 22:26:32', '2002-04-07 05:22:17', '超期未还');
INSERT INTO `lend`
VALUES (743, 340, 4, '2017-09-30 14:59:32', '2021-05-11 21:33:02', '2017-11-01 10:08:34', '未还');
INSERT INTO `lend`
VALUES (744, 836, 6, '2004-09-17 23:38:20', '2000-03-27 07:57:37', '2012-04-19 15:28:52', '超期未还');
INSERT INTO `lend`
VALUES (745, 620, 5, '2013-07-29 13:31:11', '2020-10-20 00:43:01', '2002-12-11 02:05:04', '超期未还');
INSERT INTO `lend`
VALUES (746, 104, 7, '2011-12-24 06:39:50', '2000-05-15 03:54:49', '2016-03-16 21:47:35', '已还');
INSERT INTO `lend`
VALUES (747, 96, 1, '2019-05-07 08:06:19', '2013-05-09 08:15:53', '2006-03-12 10:48:08', '超期未还');
INSERT INTO `lend`
VALUES (748, 586, 8, '2007-08-08 10:47:05', '2023-08-31 00:09:16', '2014-02-16 14:57:38', '未还');
INSERT INTO `lend`
VALUES (749, 945, 8, '2002-09-19 14:57:59', '2015-04-05 06:52:14', '2019-11-03 16:43:37', '已还');
INSERT INTO `lend`
VALUES (750, 835, 9, '2006-04-21 09:03:18', '2013-05-17 18:30:00', '2017-10-20 14:16:11', '已还');
INSERT INTO `lend`
VALUES (751, 47, 8, '2011-12-15 02:28:43', '2021-08-29 15:44:38', '2004-04-13 21:37:27', '未还');
INSERT INTO `lend`
VALUES (752, 950, 3, '2012-01-13 20:41:35', '2018-04-10 14:06:55', '2012-10-19 13:16:46', '超期未还');
INSERT INTO `lend`
VALUES (753, 909, 5, '2007-09-12 01:16:19', '2007-04-04 05:53:30', '2005-03-05 11:13:32', '已还');
INSERT INTO `lend`
VALUES (754, 910, 2, '2015-10-13 16:05:35', '2000-02-12 15:42:09', '2000-03-02 22:32:19', '超期未还');
INSERT INTO `lend`
VALUES (755, 223, 10, '2016-12-03 06:42:38', '2004-05-14 06:28:33', '2001-12-17 11:12:01', '超期未还');
INSERT INTO `lend`
VALUES (756, 298, 4, '2012-07-07 10:06:13', '2000-10-12 07:09:17', '2007-06-22 16:14:53', '未还');
INSERT INTO `lend`
VALUES (757, 213, 6, '2021-11-12 07:18:36', '2013-05-02 08:52:58', '2007-05-29 05:35:40', '未还');
INSERT INTO `lend`
VALUES (758, 220, 12, '2005-02-14 07:20:09', '2012-09-13 03:42:32', '2016-03-08 20:00:21', '未还');
INSERT INTO `lend`
VALUES (759, 151, 12, '2023-10-11 10:54:15', '2018-01-27 15:18:38', '2000-01-28 01:12:45', '超期未还');
INSERT INTO `lend`
VALUES (760, 300, 4, '2009-12-30 15:58:54', '2011-01-31 10:12:29', '2015-01-31 14:25:17', '已还');
INSERT INTO `lend`
VALUES (761, 749, 7, '2009-07-31 13:21:34', '2000-11-27 19:38:37', '2003-04-11 10:26:04', '超期未还');
INSERT INTO `lend`
VALUES (762, 236, 1, '2011-08-05 00:57:26', '2014-11-05 21:39:42', '2006-05-28 01:14:07', '超期未还');
INSERT INTO `lend`
VALUES (763, 199, 12, '2005-04-19 02:46:04', '2015-06-09 11:59:43', '2012-08-19 05:01:48', '未还');
INSERT INTO `lend`
VALUES (764, 278, 5, '2006-08-29 14:52:09', '2001-05-16 00:52:44', '2005-12-07 06:11:42', '超期未还');
INSERT INTO `lend`
VALUES (765, 180, 10, '2007-02-08 14:45:49', '2012-04-09 23:01:26', '2004-05-17 07:12:56', '超期未还');
INSERT INTO `lend`
VALUES (766, 430, 9, '2009-07-08 13:34:48', '2008-08-09 14:10:07', '2009-05-29 02:15:54', '超期未还');
INSERT INTO `lend`
VALUES (767, 644, 6, '2009-04-17 21:15:01', '2011-08-23 20:46:18', '2005-12-29 11:01:52', '未还');
INSERT INTO `lend`
VALUES (768, 575, 8, '2020-04-28 13:38:54', '2003-07-14 21:37:01', '2001-09-07 12:20:33', '超期未还');
INSERT INTO `lend`
VALUES (769, 910, 1, '2018-07-06 00:11:49', '2002-04-15 12:04:42', '2000-05-02 11:59:37', '超期未还');
INSERT INTO `lend`
VALUES (770, 710, 5, '2003-02-15 00:37:58', '2000-09-29 20:54:19', '2000-08-07 03:47:45', '已还');
INSERT INTO `lend`
VALUES (771, 31, 8, '2011-03-01 06:22:15', '2018-04-04 03:38:06', '2011-09-04 11:04:36', '未还');
INSERT INTO `lend`
VALUES (772, 748, 8, '2012-09-04 18:35:16', '2023-07-02 10:43:40', '2005-07-20 14:36:51', '未还');
INSERT INTO `lend`
VALUES (773, 640, 5, '2016-04-09 15:44:37', '2001-09-23 14:51:57', '2015-10-15 18:11:34', '超期未还');
INSERT INTO `lend`
VALUES (774, 197, 9, '2017-01-28 22:05:34', '2015-03-10 05:34:10', '2020-04-27 02:34:20', '未还');
INSERT INTO `lend`
VALUES (775, 189, 5, '2021-06-15 13:18:36', '2017-04-16 03:44:42', '2012-11-05 00:20:46', '已还');
INSERT INTO `lend`
VALUES (776, 420, 7, '2005-05-27 02:59:38', '2016-04-26 04:38:40', '2015-01-26 06:54:20', '已还');
INSERT INTO `lend`
VALUES (777, 309, 4, '2006-09-19 14:28:18', '2007-04-15 02:26:08', '2002-03-17 16:29:31', '未还');
INSERT INTO `lend`
VALUES (778, 46, 1, '2000-03-01 11:29:57', '2001-01-11 07:20:05', '2000-02-14 12:06:13', '超期未还');
INSERT INTO `lend`
VALUES (779, 378, 7, '2013-04-01 23:09:04', '2003-02-28 07:06:43', '2010-06-09 19:54:59', '未还');
INSERT INTO `lend`
VALUES (780, 666, 11, '2012-04-06 21:12:07', '2023-12-19 18:48:19', '2018-05-14 19:40:50', '超期未还');
INSERT INTO `lend`
VALUES (781, 155, 12, '2011-10-09 08:48:40', '2003-09-20 20:39:41', '2002-12-06 07:09:50', '超期未还');
INSERT INTO `lend`
VALUES (782, 567, 1, '2017-01-03 14:20:13', '2015-11-21 10:25:18', '2014-09-26 00:21:18', '未还');
INSERT INTO `lend`
VALUES (783, 155, 6, '2016-07-29 18:36:46', '2011-11-09 21:10:03', '2006-07-10 01:31:07', '未还');
INSERT INTO `lend`
VALUES (784, 181, 6, '2010-08-21 20:00:24', '2013-12-16 03:41:02', '2022-12-25 11:22:38', '未还');
INSERT INTO `lend`
VALUES (785, 440, 9, '2008-06-08 23:02:49', '2006-03-28 22:09:49', '2014-10-21 02:04:19', '超期未还');
INSERT INTO `lend`
VALUES (786, 189, 1, '2005-06-12 05:14:46', '2004-05-26 11:25:45', '2007-03-16 18:30:00', '超期未还');
INSERT INTO `lend`
VALUES (787, 724, 1, '2004-09-21 12:25:12', '2018-09-25 20:50:08', '2019-07-30 12:25:58', '未还');
INSERT INTO `lend`
VALUES (788, 116, 9, '2018-07-18 04:55:17', '2007-04-30 09:56:20', '2015-09-10 19:07:16', '未还');
INSERT INTO `lend`
VALUES (789, 19, 10, '2015-06-29 23:04:57', '2023-07-31 05:51:43', '2020-05-19 15:21:16', '已还');
INSERT INTO `lend`
VALUES (790, 188, 11, '2018-01-31 18:16:19', '2014-08-17 20:49:57', '2009-01-13 03:39:49', '未还');
INSERT INTO `lend`
VALUES (791, 14, 5, '2023-06-17 03:33:18', '2014-06-25 20:51:12', '2016-01-28 16:39:34', '未还');
INSERT INTO `lend`
VALUES (792, 71, 4, '2011-12-22 09:24:04', '2016-02-26 07:30:54', '2021-07-29 16:48:03', '超期未还');
INSERT INTO `lend`
VALUES (793, 562, 6, '2020-06-29 05:05:52', '2003-06-09 06:07:05', '2003-01-01 21:43:23', '超期未还');
INSERT INTO `lend`
VALUES (794, 985, 4, '2000-02-27 12:28:39', '2014-05-18 10:18:08', '2008-08-11 03:09:51', '已还');
INSERT INTO `lend`
VALUES (795, 256, 7, '2023-02-05 02:15:45', '2020-01-26 18:01:17', '2023-04-24 08:32:11', '未还');
INSERT INTO `lend`
VALUES (796, 874, 1, '2003-02-23 14:04:02', '2011-09-25 07:18:58', '2003-04-21 10:50:04', '已还');
INSERT INTO `lend`
VALUES (797, 840, 8, '2003-01-13 05:01:52', '2018-10-13 05:12:32', '2019-08-22 02:44:48', '已还');
INSERT INTO `lend`
VALUES (798, 623, 4, '2021-07-31 17:52:10', '2018-06-11 10:15:28', '2013-07-19 20:44:00', '未还');
INSERT INTO `lend`
VALUES (799, 626, 2, '2016-11-16 20:38:44', '2015-10-11 04:16:11', '2023-09-08 16:40:52', '超期未还');
INSERT INTO `lend`
VALUES (800, 606, 1, '2014-01-27 17:15:28', '2008-04-28 20:18:56', '2018-06-15 15:12:38', '已还');
INSERT INTO `lend`
VALUES (801, 194, 2, '2020-12-05 18:33:38', '2000-04-05 10:53:00', '2005-07-23 01:02:01', '未还');
INSERT INTO `lend`
VALUES (802, 407, 4, '2015-10-17 03:12:35', '2001-04-29 00:25:11', '2006-12-18 21:35:38', '未还');
INSERT INTO `lend`
VALUES (803, 868, 3, '2012-05-21 06:57:18', '2023-06-06 16:12:11', '2003-05-12 14:33:35', '未还');
INSERT INTO `lend`
VALUES (804, 672, 4, '2003-07-10 10:57:42', '2016-11-29 20:59:30', '2004-10-06 12:45:42', '已还');
INSERT INTO `lend`
VALUES (805, 388, 2, '2002-11-02 14:25:03', '2022-02-10 20:48:48', '2017-09-27 07:26:22', '超期未还');
INSERT INTO `lend`
VALUES (806, 464, 7, '2006-07-06 00:09:07', '2021-03-02 20:09:52', '2008-03-25 12:43:06', '已还');
INSERT INTO `lend`
VALUES (807, 514, 8, '2007-12-19 16:17:31', '2002-06-20 14:23:13', '2008-01-21 18:20:46', '超期未还');
INSERT INTO `lend`
VALUES (808, 475, 7, '2016-06-13 13:05:52', '2019-05-08 20:16:25', '2022-07-22 01:57:46', '未还');
INSERT INTO `lend`
VALUES (809, 342, 2, '2013-04-04 09:12:51', '2006-12-01 04:16:23', '2008-08-29 12:13:52', '未还');
INSERT INTO `lend`
VALUES (810, 432, 1, '2004-09-04 18:45:17', '2005-10-28 11:04:41', '2008-06-03 16:49:32', '超期未还');
INSERT INTO `lend`
VALUES (811, 334, 7, '2003-02-16 04:12:36', '2014-05-15 20:54:41', '2011-08-13 08:17:04', '未还');
INSERT INTO `lend`
VALUES (812, 566, 6, '2023-08-06 22:32:52', '2017-07-21 23:24:29', '2008-01-15 03:00:21', '已还');
INSERT INTO `lend`
VALUES (813, 350, 1, '2011-10-19 14:16:22', '2004-11-23 21:20:31', '2017-09-04 01:17:59', '超期未还');
INSERT INTO `lend`
VALUES (814, 136, 4, '2009-09-07 03:15:28', '2003-03-03 20:39:30', '2006-11-29 07:27:45', '已还');
INSERT INTO `lend`
VALUES (815, 275, 9, '2022-05-01 10:31:48', '2006-06-30 01:42:13', '2008-08-08 16:56:41', '超期未还');
INSERT INTO `lend`
VALUES (816, 492, 11, '2007-05-05 04:31:05', '2006-04-04 11:46:35', '2019-04-07 12:29:43', '未还');
INSERT INTO `lend`
VALUES (817, 109, 7, '2009-12-12 06:01:42', '2005-10-12 16:31:51', '2017-08-04 07:39:42', '已还');
INSERT INTO `lend`
VALUES (818, 551, 5, '2015-08-22 04:56:49', '2006-03-31 21:40:51', '2003-03-14 03:40:54', '超期未还');
INSERT INTO `lend`
VALUES (819, 150, 7, '2023-01-20 14:02:40', '2008-10-09 09:17:10', '2013-04-23 18:48:25', '未还');
INSERT INTO `lend`
VALUES (820, 340, 8, '2012-01-08 21:02:17', '2015-04-05 20:13:44', '2020-03-31 19:36:10', '未还');
INSERT INTO `lend`
VALUES (821, 86, 8, '2007-10-07 02:02:39', '2015-08-19 19:41:11', '2005-09-02 06:18:32', '超期未还');
INSERT INTO `lend`
VALUES (822, 829, 5, '2008-12-31 08:50:45', '2015-06-29 06:26:58', '2014-07-03 12:08:35', '未还');
INSERT INTO `lend`
VALUES (823, 607, 9, '2012-09-26 10:27:14', '2016-04-28 01:14:23', '2022-02-20 03:51:20', '已还');
INSERT INTO `lend`
VALUES (824, 691, 9, '2017-04-07 02:50:17', '2022-03-03 03:18:48', '2019-09-20 10:35:03', '未还');
INSERT INTO `lend`
VALUES (825, 798, 4, '2016-02-24 15:25:03', '2004-03-17 00:02:53', '2009-07-04 00:58:51', '未还');
INSERT INTO `lend`
VALUES (826, 781, 4, '2016-08-18 20:39:45', '2001-09-29 19:07:48', '2014-02-07 08:12:39', '已还');
INSERT INTO `lend`
VALUES (827, 750, 10, '2016-06-15 20:28:26', '2005-02-20 11:47:34', '2013-04-07 21:28:54', '已还');
INSERT INTO `lend`
VALUES (828, 488, 4, '2003-12-20 22:55:24', '2006-10-10 18:16:12', '2005-06-17 10:30:32', '超期未还');
INSERT INTO `lend`
VALUES (829, 678, 3, '2008-03-07 08:16:11', '2021-02-12 15:19:10', '2000-01-04 21:10:47', '超期未还');
INSERT INTO `lend`
VALUES (830, 16, 2, '2006-07-11 05:23:50', '2019-06-02 11:46:13', '2008-08-18 14:54:54', '未还');
INSERT INTO `lend`
VALUES (831, 847, 9, '2004-02-15 02:22:11', '2014-08-01 22:45:20', '2005-11-16 08:04:18', '已还');
INSERT INTO `lend`
VALUES (832, 661, 4, '2004-12-30 23:27:03', '2023-03-30 04:26:48', '2011-09-11 08:19:22', '超期未还');
INSERT INTO `lend`
VALUES (833, 136, 11, '2019-01-12 06:06:03', '2002-08-05 17:17:20', '2006-11-21 04:24:42', '未还');
INSERT INTO `lend`
VALUES (834, 602, 2, '2018-08-19 18:19:59', '2013-08-03 02:53:33', '2016-05-14 23:02:14', '超期未还');
INSERT INTO `lend`
VALUES (835, 331, 4, '2013-04-13 06:00:44', '2016-09-04 07:46:35', '2002-04-01 01:04:00', '未还');
INSERT INTO `lend`
VALUES (836, 452, 3, '2022-11-15 17:59:42', '2012-07-27 20:17:03', '2023-11-23 02:34:06', '已还');
INSERT INTO `lend`
VALUES (837, 324, 2, '2019-02-17 03:09:35', '2007-01-02 06:25:42', '2021-08-24 17:45:50', '未还');
INSERT INTO `lend`
VALUES (838, 829, 11, '2008-08-11 22:19:04', '2001-10-29 12:26:54', '2000-01-26 17:04:49', '已还');
INSERT INTO `lend`
VALUES (839, 68, 3, '2001-03-18 00:49:13', '2020-02-12 07:34:02', '2018-01-01 00:01:27', '未还');
INSERT INTO `lend`
VALUES (840, 408, 8, '2007-09-23 22:59:02', '2010-06-02 14:36:49', '2009-05-25 09:21:13', '超期未还');
INSERT INTO `lend`
VALUES (841, 995, 6, '2000-07-03 08:19:57', '2004-04-03 20:09:05', '2022-06-20 16:37:56', '超期未还');
INSERT INTO `lend`
VALUES (842, 654, 8, '2010-11-22 00:19:29', '2017-08-21 13:37:05', '2000-11-12 13:08:47', '已还');
INSERT INTO `lend`
VALUES (843, 636, 9, '2012-10-08 20:53:39', '2009-08-27 08:25:44', '2009-05-07 12:51:56', '已还');
INSERT INTO `lend`
VALUES (844, 127, 2, '2022-09-25 02:33:16', '2004-07-03 05:14:36', '2014-01-29 01:13:47', '超期未还');
INSERT INTO `lend`
VALUES (845, 876, 4, '2021-02-07 14:26:45', '2007-01-17 06:06:56', '2022-07-02 18:14:45', '未还');
INSERT INTO `lend`
VALUES (846, 378, 6, '2012-11-20 16:38:45', '2000-05-11 08:56:02', '2015-09-14 00:10:35', '已还');
INSERT INTO `lend`
VALUES (847, 681, 9, '2014-08-16 07:59:24', '2019-06-27 23:22:49', '2020-10-19 21:51:48', '超期未还');
INSERT INTO `lend`
VALUES (848, 646, 7, '2014-10-17 14:22:33', '2015-07-30 08:18:45', '2012-06-10 00:25:40', '未还');
INSERT INTO `lend`
VALUES (849, 631, 5, '2018-12-19 18:08:45', '2003-09-27 13:30:56', '2007-09-16 09:33:46', '已还');
INSERT INTO `lend`
VALUES (850, 282, 7, '2022-04-25 22:33:54', '2014-07-22 09:27:49', '2013-01-06 13:18:48', '未还');
INSERT INTO `lend`
VALUES (851, 173, 10, '2000-06-11 18:37:21', '2005-03-20 06:29:23', '2020-04-17 14:16:25', '未还');
INSERT INTO `lend`
VALUES (852, 259, 2, '2012-06-19 15:55:51', '2017-08-26 09:14:38', '2015-11-24 20:53:16', '已还');
INSERT INTO `lend`
VALUES (853, 65, 11, '2002-01-23 21:51:33', '2017-07-02 11:21:30', '2023-01-25 03:13:01', '超期未还');
INSERT INTO `lend`
VALUES (854, 244, 12, '2010-10-12 12:03:42', '2016-09-21 11:54:28', '2002-06-29 03:07:11', '未还');
INSERT INTO `lend`
VALUES (855, 894, 11, '2015-09-28 18:32:55', '2009-05-26 03:17:24', '2023-04-12 05:21:49', '未还');
INSERT INTO `lend`
VALUES (856, 133, 8, '2003-04-23 02:25:14', '2010-05-16 21:46:45', '2006-11-12 12:55:11', '超期未还');
INSERT INTO `lend`
VALUES (857, 779, 6, '2011-12-29 13:39:20', '2011-08-02 18:03:47', '2009-08-02 11:58:47', '未还');
INSERT INTO `lend`
VALUES (858, 588, 1, '2002-10-15 04:23:23', '2022-08-29 01:48:51', '2013-09-03 20:40:47', '未还');
INSERT INTO `lend`
VALUES (859, 8, 6, '2006-05-24 07:12:32', '2023-08-27 04:00:26', '2003-04-15 23:00:55', '未还');
INSERT INTO `lend`
VALUES (860, 535, 4, '2022-11-30 04:47:03', '2007-01-10 05:39:28', '2000-03-07 22:48:07', '超期未还');
INSERT INTO `lend`
VALUES (861, 807, 12, '2016-03-31 13:14:34', '2019-10-31 19:02:38', '2020-05-19 01:06:59', '未还');
INSERT INTO `lend`
VALUES (862, 570, 3, '2005-03-25 13:41:46', '2018-08-24 05:56:03', '2020-11-03 21:04:46', '超期未还');
INSERT INTO `lend`
VALUES (863, 539, 5, '2005-03-29 00:48:18', '2008-01-15 17:45:48', '2000-07-12 23:03:15', '超期未还');
INSERT INTO `lend`
VALUES (864, 805, 7, '2008-07-10 15:49:03', '2013-02-22 01:41:44', '2015-08-19 09:11:23', '已还');
INSERT INTO `lend`
VALUES (865, 963, 1, '2009-05-10 06:39:02', '2008-12-23 19:18:19', '2010-04-13 19:14:52', '未还');
INSERT INTO `lend`
VALUES (866, 638, 12, '2018-04-16 03:16:19', '2014-06-28 21:13:43', '2010-12-24 17:02:40', '超期未还');
INSERT INTO `lend`
VALUES (867, 822, 2, '2023-05-11 01:33:09', '2012-06-24 23:14:13', '2004-05-04 10:50:42', '未还');
INSERT INTO `lend`
VALUES (868, 381, 11, '2006-10-03 17:15:18', '2005-11-05 00:57:36', '2007-10-06 04:06:02', '未还');
INSERT INTO `lend`
VALUES (869, 843, 9, '2000-06-02 14:50:31', '2010-09-07 06:40:25', '2018-09-29 09:36:41', '未还');
INSERT INTO `lend`
VALUES (870, 772, 6, '2000-08-22 17:48:49', '2004-03-01 08:09:47', '2009-03-27 00:48:15', '超期未还');
INSERT INTO `lend`
VALUES (871, 307, 6, '2007-12-26 13:07:52', '2014-03-18 20:31:54', '2003-10-29 04:40:57', '未还');
INSERT INTO `lend`
VALUES (872, 520, 4, '2007-10-07 14:50:36', '2004-10-05 16:04:21', '2012-05-28 16:57:59', '超期未还');
INSERT INTO `lend`
VALUES (873, 284, 1, '2018-07-01 03:40:22', '2017-04-01 20:20:57', '2011-11-27 12:57:05', '超期未还');
INSERT INTO `lend`
VALUES (874, 373, 2, '2000-06-21 00:47:00', '2001-04-21 03:15:56', '2016-05-30 08:34:34', '超期未还');
INSERT INTO `lend`
VALUES (875, 430, 11, '2005-03-29 12:29:55', '2004-10-16 05:59:48', '2006-12-03 20:25:30', '未还');
INSERT INTO `lend`
VALUES (876, 80, 6, '2000-01-23 19:22:25', '2009-05-10 10:39:34', '2022-03-26 21:39:34', '超期未还');
INSERT INTO `lend`
VALUES (877, 116, 10, '2021-01-07 17:19:32', '2017-07-02 02:25:59', '2003-05-23 09:45:47', '已还');
INSERT INTO `lend`
VALUES (878, 100, 10, '2013-01-17 10:47:25', '2010-10-26 20:23:40', '2003-08-24 14:44:40', '超期未还');
INSERT INTO `lend`
VALUES (879, 148, 12, '2015-10-19 08:18:26', '2012-01-14 06:52:48', '2000-06-04 14:32:17', '未还');
INSERT INTO `lend`
VALUES (880, 778, 1, '2012-02-09 05:22:13', '2015-09-08 18:11:05', '2001-04-30 03:02:46', '超期未还');
INSERT INTO `lend`
VALUES (881, 455, 12, '2001-09-03 20:09:12', '2022-06-25 00:40:18', '2008-04-03 04:33:10', '已还');
INSERT INTO `lend`
VALUES (882, 882, 3, '2008-11-13 13:56:23', '2009-04-10 09:54:26', '2007-09-29 15:29:58', '未还');
INSERT INTO `lend`
VALUES (883, 386, 3, '2004-08-23 14:48:28', '2006-09-16 19:33:39', '2019-12-25 21:08:24', '未还');
INSERT INTO `lend`
VALUES (884, 138, 5, '2001-06-27 15:18:10', '2015-01-13 08:00:57', '2002-08-20 19:30:46', '未还');
INSERT INTO `lend`
VALUES (885, 9, 5, '2018-11-01 17:23:06', '2005-11-08 17:07:53', '2011-03-27 16:56:32', '超期未还');
INSERT INTO `lend`
VALUES (886, 528, 10, '2017-09-11 17:16:06', '2001-09-22 16:45:29', '2010-08-09 14:00:39', '已还');
INSERT INTO `lend`
VALUES (887, 266, 12, '2014-07-16 00:32:05', '2012-02-09 22:34:43', '2004-10-29 05:00:49', '未还');
INSERT INTO `lend`
VALUES (888, 866, 8, '2017-11-16 18:54:30', '2017-07-01 06:52:55', '2018-11-27 11:05:09', '超期未还');
INSERT INTO `lend`
VALUES (889, 167, 9, '2013-04-22 22:17:26', '2010-10-25 09:09:34', '2017-10-03 11:23:22', '未还');
INSERT INTO `lend`
VALUES (890, 701, 8, '2010-07-24 11:14:21', '2004-08-02 07:50:36', '2014-05-15 00:39:45', '未还');
INSERT INTO `lend`
VALUES (891, 143, 3, '2011-10-10 20:08:58', '2014-06-24 10:37:37', '2006-11-30 06:42:17', '未还');
INSERT INTO `lend`
VALUES (892, 778, 2, '2008-07-13 22:47:50', '2008-04-07 03:57:02', '2002-05-01 15:32:04', '未还');
INSERT INTO `lend`
VALUES (893, 976, 5, '2009-06-10 17:18:18', '2006-04-16 04:06:16', '2008-09-17 06:31:35', '未还');
INSERT INTO `lend`
VALUES (894, 291, 1, '2007-02-11 13:25:37', '2006-09-26 12:10:49', '2021-01-02 07:28:47', '已还');
INSERT INTO `lend`
VALUES (895, 629, 12, '2012-12-23 06:48:23', '2009-06-18 08:34:40', '2003-05-22 15:19:02', '已还');
INSERT INTO `lend`
VALUES (896, 294, 2, '2015-07-18 02:22:02', '2018-09-08 13:52:11', '2022-07-06 05:33:38', '超期未还');
INSERT INTO `lend`
VALUES (897, 21, 3, '2009-07-27 19:33:17', '2021-01-07 14:07:11', '2009-08-20 16:00:43', '已还');
INSERT INTO `lend`
VALUES (898, 131, 11, '2014-11-01 18:21:55', '2001-06-30 10:24:24', '2021-11-27 11:22:09', '未还');
INSERT INTO `lend`
VALUES (899, 884, 9, '2005-03-03 16:39:20', '2012-12-28 05:43:24', '2012-05-09 03:13:16', '超期未还');
INSERT INTO `lend`
VALUES (900, 239, 8, '2006-11-12 14:20:22', '2017-04-15 00:41:21', '2008-06-10 06:34:03', '已还');
INSERT INTO `lend`
VALUES (901, 835, 10, '2022-09-04 18:33:49', '2011-06-27 00:17:32', '2016-06-24 12:33:34', '未还');
INSERT INTO `lend`
VALUES (902, 403, 4, '2020-04-23 21:04:15', '2004-10-26 07:15:30', '2017-10-21 19:40:20', '超期未还');
INSERT INTO `lend`
VALUES (903, 532, 1, '2009-02-25 16:57:04', '2004-11-04 05:43:03', '2019-10-23 08:29:31', '超期未还');
INSERT INTO `lend`
VALUES (904, 20, 6, '2017-01-08 09:44:58', '2001-10-08 20:57:19', '2009-08-03 19:43:07', '超期未还');
INSERT INTO `lend`
VALUES (905, 277, 7, '2005-02-23 20:45:49', '2009-09-24 07:22:10', '2000-12-13 14:59:40', '超期未还');
INSERT INTO `lend`
VALUES (906, 797, 6, '2021-02-16 01:19:11', '2021-07-01 09:19:36', '2000-09-11 13:32:39', '超期未还');
INSERT INTO `lend`
VALUES (907, 915, 11, '2013-03-10 15:12:09', '2018-11-03 17:53:42', '2012-03-28 09:06:43', '未还');
INSERT INTO `lend`
VALUES (908, 563, 7, '2003-11-18 22:23:41', '2017-02-07 12:10:17', '2018-11-05 22:15:56', '未还');
INSERT INTO `lend`
VALUES (909, 525, 6, '2001-05-11 22:55:09', '2000-04-07 22:39:31', '2018-06-21 22:02:48', '未还');
INSERT INTO `lend`
VALUES (910, 197, 9, '2015-03-17 06:41:46', '2015-08-24 14:52:23', '2015-06-14 03:40:37', '未还');
INSERT INTO `lend`
VALUES (911, 561, 1, '2014-05-25 16:05:04', '2015-09-28 22:43:53', '2011-11-23 14:30:50', '已还');
INSERT INTO `lend`
VALUES (912, 259, 2, '2017-07-27 15:14:17', '2012-12-13 23:23:27', '2019-07-04 14:57:51', '未还');
INSERT INTO `lend`
VALUES (913, 532, 6, '2010-03-14 04:00:07', '2003-12-11 04:09:12', '2009-03-10 19:43:55', '已还');
INSERT INTO `lend`
VALUES (914, 425, 4, '2010-02-22 11:04:48', '2000-07-17 01:59:25', '2014-03-11 21:24:20', '超期未还');
INSERT INTO `lend`
VALUES (915, 453, 2, '2006-02-28 07:07:36', '2012-01-02 14:06:44', '2012-06-17 01:45:48', '已还');
INSERT INTO `lend`
VALUES (916, 677, 10, '2022-10-18 15:50:58', '2007-06-14 11:37:39', '2011-03-07 04:47:27', '已还');
INSERT INTO `lend`
VALUES (917, 239, 8, '2000-02-23 12:13:10', '2002-06-09 18:13:13', '2005-08-05 05:38:07', '超期未还');
INSERT INTO `lend`
VALUES (918, 109, 10, '2015-07-06 00:49:46', '2001-02-02 16:28:36', '2009-11-28 23:26:45', '未还');
INSERT INTO `lend`
VALUES (919, 946, 11, '2006-10-08 15:24:43', '2011-06-28 15:44:49', '2020-01-15 19:50:23', '未还');
INSERT INTO `lend`
VALUES (920, 650, 10, '2008-01-18 07:05:59', '2007-12-18 03:06:20', '2023-04-12 07:19:15', '未还');
INSERT INTO `lend`
VALUES (921, 758, 11, '2012-06-03 20:48:11', '2000-03-20 06:30:15', '2004-12-19 20:34:39', '已还');
INSERT INTO `lend`
VALUES (922, 820, 5, '2006-10-13 23:24:16', '2021-11-14 19:20:45', '2019-02-16 04:56:35', '未还');
INSERT INTO `lend`
VALUES (923, 76, 8, '2010-12-27 14:41:48', '2012-05-23 15:24:51', '2008-06-04 11:23:56', '超期未还');
INSERT INTO `lend`
VALUES (924, 549, 11, '2002-10-10 11:08:47', '2006-02-22 12:57:11', '2015-06-21 05:52:36', '超期未还');
INSERT INTO `lend`
VALUES (925, 751, 7, '2019-07-01 03:09:12', '2023-04-15 17:02:02', '2000-04-13 20:31:50', '已还');
INSERT INTO `lend`
VALUES (926, 544, 2, '2020-05-08 02:16:46', '2005-01-09 02:01:52', '2023-04-28 10:33:31', '超期未还');
INSERT INTO `lend`
VALUES (927, 846, 7, '2021-06-25 03:21:39', '2012-07-17 04:04:27', '2019-02-17 12:59:04', '未还');
INSERT INTO `lend`
VALUES (928, 488, 5, '2017-03-17 11:56:05', '2016-04-03 14:43:00', '2009-12-16 15:45:34', '已还');
INSERT INTO `lend`
VALUES (929, 867, 8, '2017-12-23 05:13:50', '2007-04-05 00:50:01', '2023-05-17 20:57:50', '超期未还');
INSERT INTO `lend`
VALUES (930, 381, 12, '2022-10-04 22:37:24', '2000-05-22 18:29:10', '2011-08-04 19:52:41', '超期未还');
INSERT INTO `lend`
VALUES (931, 215, 1, '2010-09-04 16:06:02', '2006-07-13 10:07:56', '2001-04-13 03:32:07', '超期未还');
INSERT INTO `lend`
VALUES (932, 67, 6, '2017-02-26 19:09:32', '2022-10-16 04:14:31', '2018-02-14 01:41:50', '未还');
INSERT INTO `lend`
VALUES (933, 118, 1, '2005-08-14 22:02:58', '2002-12-26 01:51:21', '2019-09-20 14:08:17', '超期未还');
INSERT INTO `lend`
VALUES (934, 399, 6, '2005-01-22 10:30:26', '2004-12-20 18:47:55', '2018-01-25 03:49:46', '未还');
INSERT INTO `lend`
VALUES (935, 502, 3, '2007-07-15 09:55:26', '2013-06-02 17:21:18', '2011-01-23 12:21:39', '已还');
INSERT INTO `lend`
VALUES (936, 481, 11, '2009-06-05 16:26:41', '2004-06-21 23:56:08', '2016-02-09 08:48:06', '未还');
INSERT INTO `lend`
VALUES (937, 166, 6, '2008-12-20 18:45:10', '2008-03-14 15:26:05', '2003-03-20 06:21:16', '超期未还');
INSERT INTO `lend`
VALUES (938, 754, 6, '2020-11-14 18:22:03', '2021-09-05 05:32:38', '2021-09-29 15:04:14', '已还');
INSERT INTO `lend`
VALUES (939, 361, 9, '2009-11-08 00:18:08', '2012-10-11 14:57:16', '2016-07-11 03:35:54', '超期未还');
INSERT INTO `lend`
VALUES (940, 350, 2, '2003-11-07 09:02:38', '2023-12-30 15:53:24', '2023-03-23 10:41:39', '未还');
INSERT INTO `lend`
VALUES (941, 715, 6, '2023-05-28 01:50:39', '2018-04-28 12:11:06', '2004-06-08 13:00:02', '已还');
INSERT INTO `lend`
VALUES (942, 446, 4, '2008-11-21 03:19:15', '2012-04-27 13:57:54', '2005-02-24 13:48:35', '超期未还');
INSERT INTO `lend`
VALUES (943, 815, 8, '2003-10-31 21:32:13', '2004-05-09 08:42:53', '2014-12-15 17:24:15', '超期未还');
INSERT INTO `lend`
VALUES (944, 681, 10, '2015-02-12 09:05:39', '2010-01-03 21:35:35', '2006-07-30 20:34:24', '超期未还');
INSERT INTO `lend`
VALUES (945, 184, 2, '2002-04-26 13:12:15', '2020-01-19 08:12:45', '2020-03-13 12:30:48', '已还');
INSERT INTO `lend`
VALUES (946, 64, 9, '2000-03-23 22:34:26', '2010-04-15 14:24:13', '2013-01-11 13:16:09', '超期未还');
INSERT INTO `lend`
VALUES (947, 371, 3, '2003-02-26 19:42:43', '2023-05-02 17:12:41', '2001-01-05 13:13:16', '未还');
INSERT INTO `lend`
VALUES (948, 792, 2, '2007-07-03 17:33:42', '2009-03-20 22:26:00', '2003-03-31 11:24:39', '超期未还');
INSERT INTO `lend`
VALUES (949, 826, 5, '2002-09-07 17:36:31', '2009-04-25 11:49:11', '2012-10-11 23:36:23', '未还');
INSERT INTO `lend`
VALUES (950, 563, 8, '2002-01-07 05:11:44', '2017-06-03 04:39:41', '2018-07-10 11:55:13', '已还');
INSERT INTO `lend`
VALUES (951, 332, 10, '2005-02-16 22:20:01', '2021-12-06 06:36:16', '2015-04-14 16:16:42', '超期未还');
INSERT INTO `lend`
VALUES (952, 1000, 11, '2008-09-30 09:22:17', '2003-10-04 13:18:17', '2000-03-18 12:28:22', '超期未还');
INSERT INTO `lend`
VALUES (953, 462, 7, '2022-06-05 21:40:40', '2008-12-19 17:20:08', '2019-02-15 17:54:36', '已还');
INSERT INTO `lend`
VALUES (954, 111, 2, '2012-04-16 21:59:10', '2007-07-01 02:05:49', '2006-07-08 01:13:10', '超期未还');
INSERT INTO `lend`
VALUES (955, 439, 5, '2010-09-18 23:28:31', '2016-09-30 16:55:27', '2013-09-12 04:36:50', '超期未还');
INSERT INTO `lend`
VALUES (956, 957, 3, '2019-02-05 23:55:19', '2023-11-06 21:48:39', '2023-02-16 18:56:20', '未还');
INSERT INTO `lend`
VALUES (957, 704, 7, '2009-12-23 22:13:21', '2019-06-27 01:50:10', '2014-05-19 16:59:56', '未还');
INSERT INTO `lend`
VALUES (958, 276, 1, '2002-04-09 05:52:42', '2020-02-08 20:09:32', '2016-03-07 00:22:41', '未还');
INSERT INTO `lend`
VALUES (959, 554, 1, '2006-03-21 09:31:06', '2020-02-10 03:57:23', '2007-09-24 00:53:20', '未还');
INSERT INTO `lend`
VALUES (960, 995, 6, '2013-12-13 16:57:52', '2018-08-27 16:45:32', '2022-07-21 04:06:38', '超期未还');
INSERT INTO `lend`
VALUES (961, 815, 2, '2019-10-30 14:52:26', '2007-10-11 23:32:13', '2001-05-07 09:16:10', '未还');
INSERT INTO `lend`
VALUES (962, 135, 1, '2001-05-19 04:50:40', '2017-05-01 08:48:33', '2005-11-15 15:57:58', '已还');
INSERT INTO `lend`
VALUES (963, 306, 11, '2006-01-12 02:13:49', '2005-06-21 02:48:30', '2013-10-17 19:06:05', '超期未还');
INSERT INTO `lend`
VALUES (964, 385, 1, '2014-09-21 22:18:09', '2018-05-23 16:58:56', '2021-09-03 13:31:23', '超期未还');
INSERT INTO `lend`
VALUES (965, 90, 11, '2015-06-28 11:04:42', '2005-11-16 12:33:34', '2006-06-15 06:17:48', '未还');
INSERT INTO `lend`
VALUES (966, 475, 9, '2019-09-14 18:28:14', '2004-11-29 17:21:43', '2009-01-28 00:58:24', '超期未还');
INSERT INTO `lend`
VALUES (967, 849, 12, '2022-10-17 06:05:33', '2016-02-08 11:47:50', '2006-04-03 19:29:02', '已还');
INSERT INTO `lend`
VALUES (968, 981, 6, '2017-12-18 02:47:29', '2007-10-16 02:11:25', '2014-09-12 11:41:16', '已还');
INSERT INTO `lend`
VALUES (969, 159, 3, '2003-12-02 06:35:24', '2003-04-20 12:59:29', '2020-01-02 10:01:33', '超期未还');
INSERT INTO `lend`
VALUES (970, 931, 10, '2002-06-28 23:26:28', '2008-08-05 16:13:40', '2005-02-05 08:13:01', '未还');
INSERT INTO `lend`
VALUES (971, 653, 6, '2004-04-19 03:11:22', '2017-09-21 20:39:34', '2011-02-09 22:34:55', '超期未还');
INSERT INTO `lend`
VALUES (972, 552, 7, '2020-05-13 05:54:50', '2019-07-13 18:33:32', '2019-01-19 01:33:18', '超期未还');
INSERT INTO `lend`
VALUES (973, 916, 12, '2009-05-24 05:39:00', '2010-04-26 19:13:06', '2000-11-19 21:28:12', '超期未还');
INSERT INTO `lend`
VALUES (974, 114, 6, '2014-04-02 06:09:33', '2001-12-29 03:47:07', '2005-12-03 22:34:40', '超期未还');
INSERT INTO `lend`
VALUES (975, 65, 11, '2003-03-18 03:46:03', '2006-01-09 16:57:34', '2004-06-08 15:58:20', '未还');
INSERT INTO `lend`
VALUES (976, 404, 7, '2019-01-21 04:10:19', '2003-02-23 17:28:44', '2016-10-24 14:35:21', '超期未还');
INSERT INTO `lend`
VALUES (977, 741, 7, '2000-02-04 06:36:04', '2005-10-07 07:39:36', '2007-12-19 10:45:24', '超期未还');
INSERT INTO `lend`
VALUES (978, 372, 2, '2015-08-05 17:46:40', '2014-08-03 15:04:37', '2008-03-06 18:04:28', '已还');
INSERT INTO `lend`
VALUES (979, 78, 9, '2017-07-23 22:17:46', '2003-08-14 15:10:38', '2014-11-23 09:45:43', '已还');
INSERT INTO `lend`
VALUES (980, 406, 2, '2015-04-26 03:49:41', '2019-03-14 22:00:00', '2012-05-24 19:02:21', '已还');
INSERT INTO `lend`
VALUES (981, 101, 11, '2019-03-03 16:28:30', '2020-05-23 18:21:19', '2005-11-30 11:37:41', '未还');
INSERT INTO `lend`
VALUES (982, 462, 2, '2023-06-08 12:16:45', '2010-12-30 03:19:11', '2011-05-19 15:48:39', '超期未还');
INSERT INTO `lend`
VALUES (983, 520, 7, '2020-10-29 09:40:00', '2021-09-25 19:08:11', '2015-04-17 13:16:36', '超期未还');
INSERT INTO `lend`
VALUES (984, 93, 6, '2022-07-20 10:15:47', '2019-11-02 22:03:42', '2002-01-25 21:56:32', '未还');
INSERT INTO `lend`
VALUES (985, 37, 12, '2023-11-12 13:05:58', '2011-10-27 18:13:49', '2009-10-03 20:54:11', '已还');
INSERT INTO `lend`
VALUES (986, 69, 2, '2023-05-19 11:03:56', '2023-04-28 10:48:33', '2008-03-21 16:00:53', '已还');
INSERT INTO `lend`
VALUES (987, 104, 6, '2000-06-19 02:16:32', '2017-11-29 12:38:33', '2001-06-07 09:00:19', '未还');
INSERT INTO `lend`
VALUES (988, 140, 9, '2000-11-04 22:54:02', '2016-11-22 09:25:44', '2010-05-22 17:36:41', '已还');
INSERT INTO `lend`
VALUES (989, 820, 8, '2002-10-09 14:53:35', '2007-01-23 14:36:54', '2001-08-01 12:38:11', '超期未还');
INSERT INTO `lend`
VALUES (990, 534, 6, '2021-01-08 12:30:42', '2003-06-20 08:03:06', '2001-06-11 13:51:15', '超期未还');
INSERT INTO `lend`
VALUES (991, 11, 1, '2016-10-16 02:06:17', '2000-10-22 02:47:12', '2021-10-30 04:54:21', '已还');
INSERT INTO `lend`
VALUES (992, 962, 8, '2018-12-19 05:18:44', '2007-05-05 13:53:43', '2007-05-17 08:39:04', '超期未还');
INSERT INTO `lend`
VALUES (993, 907, 11, '2014-07-13 22:54:30', '2020-01-18 15:46:12', '2006-09-17 02:27:34', '已还');
INSERT INTO `lend`
VALUES (994, 365, 5, '2009-10-31 21:29:49', '2008-07-22 12:00:19', '2003-05-09 00:30:26', '未还');
INSERT INTO `lend`
VALUES (995, 28, 1, '2019-11-28 01:03:48', '2019-11-29 14:52:55', '2010-11-26 07:35:57', '未还');
INSERT INTO `lend`
VALUES (996, 707, 10, '2012-03-03 08:15:23', '2021-01-02 11:25:47', '2011-06-10 23:35:41', '超期未还');
INSERT INTO `lend`
VALUES (997, 633, 1, '2013-11-13 03:49:13', '2021-05-25 16:50:33', '2014-12-22 18:23:49', '超期未还');
INSERT INTO `lend`
VALUES (998, 331, 1, '2005-10-12 19:48:28', '2010-09-27 16:37:00', '2009-10-01 19:19:46', '已还');
INSERT INTO `lend`
VALUES (999, 69, 3, '2012-02-13 10:59:46', '2009-09-02 22:27:29', '2001-03-09 19:28:13', '已还');
INSERT INTO `lend`
VALUES (1000, 579, 3, '2019-06-11 20:06:22', '2021-05-12 19:06:56', '2004-04-15 19:08:11', '已还');

# -- ----------------------------
# -- Table structure for reader
# -- ----------------------------
# DROP TABLE IF EXISTS `reader`;
# CREATE TABLE `reader`
# (
#     `id`         int                                                           NOT NULL AUTO_INCREMENT,
#     `name`       varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
#     `password`   varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NOT NULL,
#     `email`      varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
#     `phone`      varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NOT NULL,
#     `fine`       decimal(6, 2)                                                 NOT NULL,
#     `borrow_num` int                                                           NOT NULL COMMENT '一名读者最多只能借阅十本图书，且每本图书最多只能借两个月',
#     PRIMARY KEY (`id`) USING BTREE,
#     UNIQUE INDEX `email` (`email` ASC) USING BTREE,
#     CONSTRAINT `check_fine` CHECK (`fine` >= 0),
#     CONSTRAINT `check_reader_borrow_num` CHECK ((`borrow_num` >= 0) and (`borrow_num` <= 10))
# ) ENGINE = InnoDB
#   AUTO_INCREMENT = 1
#   CHARACTER SET = utf8mb4
#   COLLATE = utf8mb4_0900_ai_ci
#   ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reader
-- ----------------------------
INSERT INTO `reader`
VALUES (1, 'Mui Ka Ling', 'muikaling', 'klmui7@outlook.com', '66-146-1100', 0.00, 0);
INSERT INTO `reader`
VALUES (2, 'Wei Yunxi', 'yunxiw', 'wei4@yahoo.com', '330-535-5565', 0.00, 0);
INSERT INTO `reader`
VALUES (3, 'Fukuda Rin', 'rfukuda', 'frin@icloud.com', '(121) 188 4596', 380.44, 0);
INSERT INTO `reader`
VALUES (4, 'Chen Rui', 'ruiche7', 'rchen@gmail.com', '74-706-0483', 0.00, 4);
INSERT INTO `reader`
VALUES (5, 'Chu Kwok Wing', 'chukw6', 'kwokwing68@mail.com', '178-3615-2381', 0.00, 8);
INSERT INTO `reader`
VALUES (6, 'Dai Tsz Ching', 'tszchingdai', 'dtc@outlook.com', '7544 476618', 0.00, 0);
INSERT INTO `reader`
VALUES (7, 'Wong Wai San', 'wongwaisan1031', 'wonwaisan331@outlook.com', '7865 984521', 0.00, 0);
INSERT INTO `reader`
VALUES (8, 'Takeuchi Daichi', 'taked6', 'tadaichi@outlook.com', '90-6523-3040', 0.00, 0);
INSERT INTO `reader`
VALUES (9, 'Nakajima Yuto', 'yn627', 'yutona@gmail.com', '161-9225-8700', 0.00, 0);
INSERT INTO `reader`
VALUES (10, 'Cui Jialun', 'cuijialun1019', 'jialunc@hotmail.com', '10-839-1472', 0.00, 0);
INSERT INTO `reader`
VALUES (11, 'Ng Wai Lam', 'wailamn', 'ngwl88@mail.com', '330-901-5470', 0.00, 0);
INSERT INTO `reader`
VALUES (12, 'Julia Ramos', 'julia9', 'jr730@icloud.com', '21-1863-6076', 950.19, 0);

-- ----------------------------
-- Table structure for reserve
-- ----------------------------
# DROP TABLE IF EXISTS `reserve`;
# CREATE TABLE `reserve`
# (
#     `id`               int                                                           NOT NULL AUTO_INCREMENT,
#     `booktable_ISBN`   varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
#     `reader_id`        int                                                           NULL DEFAULT NULL,
#     `reserve_date`     datetime                                                      NOT NULL COMMENT '预约日期',
#     `reserve_deadline` int                                                           NOT NULL COMMENT '预约期限（天）',
#     `book_id`          int                                                           NULL DEFAULT NULL,
#     PRIMARY KEY (`id`) USING BTREE,
#     INDEX `booktable_ISBN` (`booktable_ISBN` ASC) USING BTREE,
#     INDEX `reader_id` (`reader_id` ASC) USING BTREE,
#     INDEX `book_id` (`book_id` ASC) USING BTREE,
#     CONSTRAINT `reserve_ibfk_1` FOREIGN KEY (`booktable_ISBN`) REFERENCES `booktable` (`ISBN`) ON DELETE RESTRICT ON UPDATE RESTRICT,
#     CONSTRAINT `reserve_ibfk_2` FOREIGN KEY (`reader_id`) REFERENCES `reader` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
#     CONSTRAINT `reserve_ibfk_3` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
# ) ENGINE = InnoDB
#   AUTO_INCREMENT = 1
#   CHARACTER SET = utf8mb4
#   COLLATE = utf8mb4_0900_ai_ci
#   ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reserve
-- ----------------------------
INSERT INTO `reserve`
VALUES (1, 'ISBN7-302-02368-107', 6, '2014-12-27 07:26:51', 4, NULL);
INSERT INTO `reserve`
VALUES (2, 'ISBN7-302-02368-106', 6, '2015-04-16 10:09:44', 2, NULL);
INSERT INTO `reserve`
VALUES (3, 'ISBN7-302-02368-105', 11, '2021-07-25 15:53:33', 10, NULL);
INSERT INTO `reserve`
VALUES (4, 'ISBN7-302-02368-106', 12, '2008-01-19 06:36:23', 2, NULL);
INSERT INTO `reserve`
VALUES (5, 'ISBN7-302-02368-106', 8, '2016-12-05 11:24:06', 8, NULL);
INSERT INTO `reserve`
VALUES (6, 'ISBN7-302-02368-103', 7, '2013-08-08 12:44:48', 1, NULL);
INSERT INTO `reserve`
VALUES (7, 'ISBN7-302-02368-102', 8, '2011-11-13 12:56:48', 6, NULL);
INSERT INTO `reserve`
VALUES (8, 'ISBN7-302-02368-105', 10, '2003-09-26 13:24:22', 8, NULL);
INSERT INTO `reserve`
VALUES (9, 'ISBN7-302-02368-108', 8, '2012-03-25 03:37:50', 3, NULL);
INSERT INTO `reserve`
VALUES (10, 'ISBN7-302-02368-109', 11, '2007-12-03 02:37:33', 5, NULL);
INSERT INTO `reserve`
VALUES (11, 'ISBN7-302-02368-109', 11, '2010-09-15 09:21:25', 7, NULL);
INSERT INTO `reserve`
VALUES (12, 'ISBN7-302-02368-106', 3, '2012-10-26 03:54:42', 10, NULL);
INSERT INTO `reserve`
VALUES (13, 'ISBN7-302-02368-107', 5, '2000-04-28 08:07:52', 9, NULL);
INSERT INTO `reserve`
VALUES (14, 'ISBN7-302-02368-106', 12, '2004-04-07 02:46:20', 1, NULL);
INSERT INTO `reserve`
VALUES (15, 'ISBN7-302-02368-105', 11, '2004-01-11 09:14:31', 6, NULL);
INSERT INTO `reserve`
VALUES (16, 'ISBN7-302-02368-105', 7, '2000-09-08 23:38:00', 3, NULL);
INSERT INTO `reserve`
VALUES (17, 'ISBN7-302-02368-101', 11, '2007-10-31 02:25:57', 1, NULL);
INSERT INTO `reserve`
VALUES (18, 'ISBN7-302-02368-101', 8, '2023-03-09 17:50:24', 8, NULL);
INSERT INTO `reserve`
VALUES (19, 'ISBN7-302-02368-103', 7, '2018-03-11 22:09:41', 3, NULL);
INSERT INTO `reserve`
VALUES (20, 'ISBN7-302-02368-101', 9, '2009-01-24 19:32:06', 1, NULL);
INSERT INTO `reserve`
VALUES (21, 'ISBN7-302-02368-109', 6, '2000-01-15 19:58:34', 5, NULL);
INSERT INTO `reserve`
VALUES (22, 'ISBN7-302-02368-103', 8, '2023-07-24 21:37:12', 7, NULL);
INSERT INTO `reserve`
VALUES (23, 'ISBN7-302-02368-106', 9, '2002-06-05 02:25:55', 7, NULL);
INSERT INTO `reserve`
VALUES (24, 'ISBN7-302-02368-101', 8, '2006-12-17 22:23:29', 5, NULL);
INSERT INTO `reserve`
VALUES (25, 'ISBN7-302-02368-104', 11, '2001-01-04 02:07:12', 1, NULL);
INSERT INTO `reserve`
VALUES (26, 'ISBN7-302-02368-100', 2, '2006-12-15 16:18:51', 9, NULL);
INSERT INTO `reserve`
VALUES (27, 'ISBN7-302-02368-108', 11, '2014-04-05 22:27:24', 6, NULL);
INSERT INTO `reserve`
VALUES (28, 'ISBN7-302-02368-106', 8, '2011-02-09 05:22:29', 2, NULL);
INSERT INTO `reserve`
VALUES (29, 'ISBN7-302-02368-106', 11, '2020-09-20 14:48:35', 5, NULL);
INSERT INTO `reserve`
VALUES (30, 'ISBN7-302-02368-105', 4, '2002-12-08 04:33:26', 4, NULL);
INSERT INTO `reserve`
VALUES (31, 'ISBN7-302-02368-102', 12, '2006-04-27 08:05:30', 8, NULL);
INSERT INTO `reserve`
VALUES (32, 'ISBN7-302-02368-103', 4, '2011-10-04 05:41:57', 5, NULL);
INSERT INTO `reserve`
VALUES (33, 'ISBN7-302-02368-104', 8, '2015-04-11 12:04:45', 2, NULL);
INSERT INTO `reserve`
VALUES (34, 'ISBN7-302-02368-108', 6, '2007-12-25 09:34:56', 4, NULL);
INSERT INTO `reserve`
VALUES (35, 'ISBN7-302-02368-103', 11, '2015-08-29 18:10:29', 10, NULL);
INSERT INTO `reserve`
VALUES (36, 'ISBN7-302-02368-101', 1, '2003-05-19 02:09:01', 7, NULL);
INSERT INTO `reserve`
VALUES (37, 'ISBN7-302-02368-101', 6, '2007-11-13 00:07:21', 3, NULL);
INSERT INTO `reserve`
VALUES (38, 'ISBN7-302-02368-101', 1, '2023-01-11 11:31:01', 9, NULL);
INSERT INTO `reserve`
VALUES (39, 'ISBN7-302-02368-100', 1, '2006-02-11 15:57:38', 5, NULL);
INSERT INTO `reserve`
VALUES (40, 'ISBN7-302-02368-107', 11, '2003-04-08 03:44:19', 5, NULL);
INSERT INTO `reserve`
VALUES (41, 'ISBN7-302-02368-103', 4, '2020-09-11 01:56:46', 6, NULL);
INSERT INTO `reserve`
VALUES (42, 'ISBN7-302-02368-107', 4, '2018-02-06 10:52:34', 8, NULL);
INSERT INTO `reserve`
VALUES (43, 'ISBN7-302-02368-109', 7, '2000-09-25 17:54:59', 6, NULL);
INSERT INTO `reserve`
VALUES (44, 'ISBN7-302-02368-102', 3, '2016-05-29 07:36:28', 5, NULL);
INSERT INTO `reserve`
VALUES (45, 'ISBN7-302-02368-107', 11, '2000-06-13 23:09:35', 2, NULL);
INSERT INTO `reserve`
VALUES (46, 'ISBN7-302-02368-102', 8, '2008-01-05 15:52:27', 3, NULL);
INSERT INTO `reserve`
VALUES (47, 'ISBN7-302-02368-104', 10, '2012-10-27 04:16:24', 7, NULL);
INSERT INTO `reserve`
VALUES (48, 'ISBN7-302-02368-106', 9, '2006-06-30 19:03:57', 9, NULL);
INSERT INTO `reserve`
VALUES (49, 'ISBN7-302-02368-109', 3, '2014-04-01 09:38:32', 3, NULL);
INSERT INTO `reserve`
VALUES (50, 'ISBN7-302-02368-105', 8, '2001-06-06 02:33:47', 8, NULL);
INSERT INTO `reserve`
VALUES (51, 'ISBN7-302-02368-108', 4, '2013-02-27 02:13:11', 5, NULL);
INSERT INTO `reserve`
VALUES (52, 'ISBN7-302-02368-108', 4, '2002-05-30 04:05:50', 10, NULL);
INSERT INTO `reserve`
VALUES (53, 'ISBN7-302-02368-102', 6, '2004-12-09 07:13:55', 9, NULL);
INSERT INTO `reserve`
VALUES (54, 'ISBN7-302-02368-101', 10, '2010-07-23 22:57:47', 6, NULL);
INSERT INTO `reserve`
VALUES (55, 'ISBN7-302-02368-104', 11, '2022-08-10 21:30:45', 7, NULL);
INSERT INTO `reserve`
VALUES (56, 'ISBN7-302-02368-102', 10, '2004-10-20 05:34:52', 4, NULL);
INSERT INTO `reserve`
VALUES (57, 'ISBN7-302-02368-106', 12, '2010-09-29 02:05:16', 6, NULL);
INSERT INTO `reserve`
VALUES (58, 'ISBN7-302-02368-108', 5, '2004-09-30 17:04:59', 8, NULL);
INSERT INTO `reserve`
VALUES (59, 'ISBN7-302-02368-108', 7, '2001-09-17 09:00:00', 5, NULL);
INSERT INTO `reserve`
VALUES (60, 'ISBN7-302-02368-102', 3, '2018-04-16 23:13:44', 3, NULL);
INSERT INTO `reserve`
VALUES (61, 'ISBN7-302-02368-102', 5, '2017-08-02 01:37:23', 6, NULL);
INSERT INTO `reserve`
VALUES (62, 'ISBN7-302-02368-100', 4, '2000-12-26 14:19:03', 1, NULL);
INSERT INTO `reserve`
VALUES (63, 'ISBN7-302-02368-108', 1, '2019-04-21 00:27:07', 7, NULL);
INSERT INTO `reserve`
VALUES (64, 'ISBN7-302-02368-104', 6, '2002-04-21 22:15:29', 9, NULL);
INSERT INTO `reserve`
VALUES (65, 'ISBN7-302-02368-107', 6, '2019-02-21 23:06:08', 1, NULL);
INSERT INTO `reserve`
VALUES (66, 'ISBN7-302-02368-109', 5, '2021-01-17 22:47:48', 9, NULL);
INSERT INTO `reserve`
VALUES (67, 'ISBN7-302-02368-105', 3, '2003-11-16 21:57:09', 3, NULL);
INSERT INTO `reserve`
VALUES (68, 'ISBN7-302-02368-101', 11, '2000-05-19 15:37:40', 8, NULL);
INSERT INTO `reserve`
VALUES (69, 'ISBN7-302-02368-106', 2, '2021-07-02 13:39:26', 3, NULL);
INSERT INTO `reserve`
VALUES (70, 'ISBN7-302-02368-105', 9, '2002-07-08 16:20:47', 8, NULL);
INSERT INTO `reserve`
VALUES (71, 'ISBN7-302-02368-104', 11, '2020-02-26 20:09:48', 9, NULL);
INSERT INTO `reserve`
VALUES (72, 'ISBN7-302-02368-101', 5, '2004-10-28 20:56:18', 5, NULL);
INSERT INTO `reserve`
VALUES (73, 'ISBN7-302-02368-103', 7, '2016-12-05 20:41:15', 7, NULL);
INSERT INTO `reserve`
VALUES (74, 'ISBN7-302-02368-104', 3, '2015-04-15 08:10:58', 7, NULL);
INSERT INTO `reserve`
VALUES (75, 'ISBN7-302-02368-104', 9, '2016-08-24 07:20:50', 9, NULL);
INSERT INTO `reserve`
VALUES (76, 'ISBN7-302-02368-101', 11, '2023-10-19 04:51:32', 2, NULL);
INSERT INTO `reserve`
VALUES (77, 'ISBN7-302-02368-103', 6, '2018-12-02 12:47:14', 7, NULL);
INSERT INTO `reserve`
VALUES (78, 'ISBN7-302-02368-109', 9, '2005-09-06 10:49:55', 7, NULL);
INSERT INTO `reserve`
VALUES (79, 'ISBN7-302-02368-100', 10, '2020-06-24 03:47:13', 7, NULL);
INSERT INTO `reserve`
VALUES (80, 'ISBN7-302-02368-109', 11, '2007-06-07 14:10:54', 7, NULL);
INSERT INTO `reserve`
VALUES (81, 'ISBN7-302-02368-102', 5, '2022-12-06 01:10:22', 9, NULL);
INSERT INTO `reserve`
VALUES (82, 'ISBN7-302-02368-100', 9, '2013-02-15 08:38:24', 2, NULL);
INSERT INTO `reserve`
VALUES (83, 'ISBN7-302-02368-102', 3, '2023-06-21 09:12:47', 4, NULL);
INSERT INTO `reserve`
VALUES (84, 'ISBN7-302-02368-104', 2, '2021-07-31 14:58:42', 8, NULL);
INSERT INTO `reserve`
VALUES (85, 'ISBN7-302-02368-105', 5, '2017-10-29 16:31:49', 2, NULL);
INSERT INTO `reserve`
VALUES (86, 'ISBN7-302-02368-106', 1, '2003-06-13 00:25:15', 9, NULL);
INSERT INTO `reserve`
VALUES (87, 'ISBN7-302-02368-107', 7, '2012-06-21 05:08:32', 10, NULL);
INSERT INTO `reserve`
VALUES (88, 'ISBN7-302-02368-106', 4, '2014-04-24 01:29:06', 8, NULL);
INSERT INTO `reserve`
VALUES (89, 'ISBN7-302-02368-103', 3, '2021-10-05 00:46:23', 5, NULL);
INSERT INTO `reserve`
VALUES (90, 'ISBN7-302-02368-101', 10, '2019-01-24 16:23:30', 2, NULL);
INSERT INTO `reserve`
VALUES (91, 'ISBN7-302-02368-106', 11, '2009-05-17 18:57:39', 2, NULL);
INSERT INTO `reserve`
VALUES (92, 'ISBN7-302-02368-105', 2, '2014-02-19 06:43:39', 9, NULL);
INSERT INTO `reserve`
VALUES (93, 'ISBN7-302-02368-107', 2, '2007-03-30 06:52:58', 8, NULL);
INSERT INTO `reserve`
VALUES (94, 'ISBN7-302-02368-107', 5, '2013-10-25 13:25:53', 1, NULL);
INSERT INTO `reserve`
VALUES (95, 'ISBN7-302-02368-103', 8, '2001-04-14 12:55:52', 8, NULL);
INSERT INTO `reserve`
VALUES (96, 'ISBN7-302-02368-109', 1, '2000-05-15 00:26:58', 7, NULL);
INSERT INTO `reserve`
VALUES (97, 'ISBN7-302-02368-107', 10, '2015-04-30 05:26:28', 9, NULL);
INSERT INTO `reserve`
VALUES (98, 'ISBN7-302-02368-108', 8, '2000-06-09 03:49:51', 5, NULL);
INSERT INTO `reserve`
VALUES (99, 'ISBN7-302-02368-108', 4, '2006-05-07 07:13:14', 4, NULL);
INSERT INTO `reserve`
VALUES (100, 'ISBN7-302-02368-104', 5, '2017-07-07 19:42:07', 2, NULL);
INSERT INTO `reserve`
VALUES (101, 'ISBN7-302-02368-102', 12, '2017-11-23 20:59:46', 5, NULL);
INSERT INTO `reserve`
VALUES (102, 'ISBN7-302-02368-106', 12, '2009-09-05 02:56:53', 7, NULL);
INSERT INTO `reserve`
VALUES (103, 'ISBN7-302-02368-104', 8, '2001-02-19 00:23:56', 8, NULL);
INSERT INTO `reserve`
VALUES (104, 'ISBN7-302-02368-101', 4, '2007-03-08 05:19:31', 4, NULL);
INSERT INTO `reserve`
VALUES (105, 'ISBN7-302-02368-102', 8, '2023-12-02 02:39:00', 2, NULL);
INSERT INTO `reserve`
VALUES (106, 'ISBN7-302-02368-109', 5, '2008-04-25 01:59:58', 2, NULL);
INSERT INTO `reserve`
VALUES (107, 'ISBN7-302-02368-102', 11, '2001-04-11 12:44:24', 8, NULL);
INSERT INTO `reserve`
VALUES (108, 'ISBN7-302-02368-104', 3, '2015-09-03 05:50:39', 5, NULL);
INSERT INTO `reserve`
VALUES (109, 'ISBN7-302-02368-106', 10, '2015-07-19 02:39:18', 1, NULL);
INSERT INTO `reserve`
VALUES (110, 'ISBN7-302-02368-105', 2, '2008-10-08 11:26:28', 3, NULL);
INSERT INTO `reserve`
VALUES (111, 'ISBN7-302-02368-104', 11, '2010-04-09 11:55:12', 3, NULL);
INSERT INTO `reserve`
VALUES (112, 'ISBN7-302-02368-108', 5, '2019-11-25 10:28:45', 9, NULL);
INSERT INTO `reserve`
VALUES (113, 'ISBN7-302-02368-109', 9, '2019-06-24 14:57:24', 5, NULL);
INSERT INTO `reserve`
VALUES (114, 'ISBN7-302-02368-107', 10, '2020-11-24 16:45:27', 2, NULL);
INSERT INTO `reserve`
VALUES (115, 'ISBN7-302-02368-100', 3, '2003-02-24 14:45:44', 1, NULL);
INSERT INTO `reserve`
VALUES (116, 'ISBN7-302-02368-101', 10, '2013-01-20 18:44:46', 2, NULL);
INSERT INTO `reserve`
VALUES (117, 'ISBN7-302-02368-106', 11, '2001-12-14 04:54:18', 5, NULL);
INSERT INTO `reserve`
VALUES (118, 'ISBN7-302-02368-103', 1, '2016-03-23 04:09:40', 10, NULL);
INSERT INTO `reserve`
VALUES (119, 'ISBN7-302-02368-108', 9, '2003-04-08 09:37:45', 3, NULL);
INSERT INTO `reserve`
VALUES (120, 'ISBN7-302-02368-107', 11, '2002-01-26 14:08:00', 5, NULL);
INSERT INTO `reserve`
VALUES (121, 'ISBN7-302-02368-103', 4, '2014-05-29 02:40:50', 7, NULL);
INSERT INTO `reserve`
VALUES (122, 'ISBN7-302-02368-103', 12, '2013-01-27 07:25:13', 1, NULL);
INSERT INTO `reserve`
VALUES (123, 'ISBN7-302-02368-107', 8, '2006-03-17 15:08:00', 4, NULL);
INSERT INTO `reserve`
VALUES (124, 'ISBN7-302-02368-103', 5, '2011-08-01 15:25:24', 3, NULL);
INSERT INTO `reserve`
VALUES (125, 'ISBN7-302-02368-104', 11, '2004-06-23 05:26:54', 7, NULL);
INSERT INTO `reserve`
VALUES (126, 'ISBN7-302-02368-109', 2, '2006-11-18 23:00:01', 6, NULL);
INSERT INTO `reserve`
VALUES (127, 'ISBN7-302-02368-105', 11, '2013-06-30 12:09:20', 9, NULL);
INSERT INTO `reserve`
VALUES (128, 'ISBN7-302-02368-103', 11, '2020-07-26 23:44:41', 3, NULL);
INSERT INTO `reserve`
VALUES (129, 'ISBN7-302-02368-106', 2, '2019-08-08 00:23:44', 5, NULL);
INSERT INTO `reserve`
VALUES (130, 'ISBN7-302-02368-107', 7, '2017-03-22 07:44:12', 3, NULL);
INSERT INTO `reserve`
VALUES (131, 'ISBN7-302-02368-100', 11, '2003-10-29 07:31:24', 4, NULL);
INSERT INTO `reserve`
VALUES (132, 'ISBN7-302-02368-102', 7, '2003-02-13 00:50:07', 4, NULL);
INSERT INTO `reserve`
VALUES (133, 'ISBN7-302-02368-100', 8, '2006-08-03 00:24:41', 5, NULL);
INSERT INTO `reserve`
VALUES (134, 'ISBN7-302-02368-108', 5, '2022-12-13 01:13:23', 3, NULL);
INSERT INTO `reserve`
VALUES (135, 'ISBN7-302-02368-105', 5, '2005-07-05 00:28:20', 2, NULL);
INSERT INTO `reserve`
VALUES (136, 'ISBN7-302-02368-102', 12, '2012-11-27 05:21:17', 2, NULL);
INSERT INTO `reserve`
VALUES (137, 'ISBN7-302-02368-109', 8, '2001-12-13 21:17:34', 3, NULL);
INSERT INTO `reserve`
VALUES (138, 'ISBN7-302-02368-109', 10, '2007-08-12 14:19:28', 8, NULL);
INSERT INTO `reserve`
VALUES (139, 'ISBN7-302-02368-103', 1, '2018-01-13 23:04:35', 9, NULL);
INSERT INTO `reserve`
VALUES (140, 'ISBN7-302-02368-107', 12, '2009-08-21 11:11:02', 10, NULL);
INSERT INTO `reserve`
VALUES (141, 'ISBN7-302-02368-103', 11, '2005-01-06 13:13:31', 9, NULL);
INSERT INTO `reserve`
VALUES (142, 'ISBN7-302-02368-100', 12, '2016-09-04 13:10:21', 4, NULL);
INSERT INTO `reserve`
VALUES (143, 'ISBN7-302-02368-100', 1, '2001-01-04 14:40:29', 5, NULL);
INSERT INTO `reserve`
VALUES (144, 'ISBN7-302-02368-103', 9, '2016-01-28 22:51:17', 2, NULL);
INSERT INTO `reserve`
VALUES (145, 'ISBN7-302-02368-100', 8, '2019-06-25 04:57:55', 6, NULL);
INSERT INTO `reserve`
VALUES (146, 'ISBN7-302-02368-107', 7, '2015-10-14 05:21:12', 8, NULL);
INSERT INTO `reserve`
VALUES (147, 'ISBN7-302-02368-103', 5, '2016-05-26 10:28:19', 4, NULL);
INSERT INTO `reserve`
VALUES (148, 'ISBN7-302-02368-106', 5, '2002-07-10 02:45:06', 9, NULL);
INSERT INTO `reserve`
VALUES (149, 'ISBN7-302-02368-100', 3, '2008-04-09 22:36:49', 9, NULL);
INSERT INTO `reserve`
VALUES (150, 'ISBN7-302-02368-109', 9, '2009-05-24 23:51:51', 4, NULL);
INSERT INTO `reserve`
VALUES (151, 'ISBN7-302-02368-102', 9, '2001-05-01 10:09:16', 8, NULL);
INSERT INTO `reserve`
VALUES (152, 'ISBN7-302-02368-101', 11, '2001-05-07 13:37:27', 8, NULL);
INSERT INTO `reserve`
VALUES (153, 'ISBN7-302-02368-104', 3, '2001-05-28 08:12:10', 8, NULL);
INSERT INTO `reserve`
VALUES (154, 'ISBN7-302-02368-104', 10, '2010-01-18 23:10:45', 3, NULL);
INSERT INTO `reserve`
VALUES (155, 'ISBN7-302-02368-104', 2, '2020-01-11 17:20:07', 7, NULL);
INSERT INTO `reserve`
VALUES (156, 'ISBN7-302-02368-105', 6, '2016-12-25 05:54:01', 5, NULL);
INSERT INTO `reserve`
VALUES (157, 'ISBN7-302-02368-100', 5, '2012-01-26 21:21:24', 4, NULL);
INSERT INTO `reserve`
VALUES (158, 'ISBN7-302-02368-107', 2, '2015-11-21 02:22:28', 9, NULL);
INSERT INTO `reserve`
VALUES (159, 'ISBN7-302-02368-105', 8, '2009-01-10 08:22:06', 7, NULL);
INSERT INTO `reserve`
VALUES (160, 'ISBN7-302-02368-103', 2, '2010-03-08 20:53:21', 8, NULL);
INSERT INTO `reserve`
VALUES (161, 'ISBN7-302-02368-107', 6, '2005-07-16 04:07:37', 3, NULL);
INSERT INTO `reserve`
VALUES (162, 'ISBN7-302-02368-103', 7, '2018-05-10 16:33:57', 5, NULL);
INSERT INTO `reserve`
VALUES (163, 'ISBN7-302-02368-106', 5, '2018-06-13 02:53:28', 7, NULL);
INSERT INTO `reserve`
VALUES (164, 'ISBN7-302-02368-106', 4, '2020-06-18 10:52:30', 2, NULL);
INSERT INTO `reserve`
VALUES (165, 'ISBN7-302-02368-105', 11, '2000-04-03 16:51:38', 6, NULL);
INSERT INTO `reserve`
VALUES (166, 'ISBN7-302-02368-108', 4, '2019-11-29 01:15:55', 2, NULL);
INSERT INTO `reserve`
VALUES (167, 'ISBN7-302-02368-105', 10, '2008-09-02 16:59:50', 4, NULL);
INSERT INTO `reserve`
VALUES (168, 'ISBN7-302-02368-100', 12, '2014-03-01 01:24:28', 5, NULL);
INSERT INTO `reserve`
VALUES (169, 'ISBN7-302-02368-102', 8, '2007-07-01 03:19:57', 2, NULL);
INSERT INTO `reserve`
VALUES (170, 'ISBN7-302-02368-100', 10, '2017-03-23 14:08:30', 7, NULL);
INSERT INTO `reserve`
VALUES (171, 'ISBN7-302-02368-108', 6, '2004-07-21 18:51:00', 5, NULL);
INSERT INTO `reserve`
VALUES (172, 'ISBN7-302-02368-104', 4, '2004-12-12 09:23:31', 2, NULL);
INSERT INTO `reserve`
VALUES (173, 'ISBN7-302-02368-109', 5, '2009-05-25 11:15:52', 9, NULL);
INSERT INTO `reserve`
VALUES (174, 'ISBN7-302-02368-103', 10, '2005-12-04 05:37:58', 9, NULL);
INSERT INTO `reserve`
VALUES (175, 'ISBN7-302-02368-101', 2, '2012-02-12 01:49:17', 9, NULL);
INSERT INTO `reserve`
VALUES (176, 'ISBN7-302-02368-103', 6, '2020-01-28 19:51:55', 5, NULL);
INSERT INTO `reserve`
VALUES (177, 'ISBN7-302-02368-105', 7, '2000-02-25 18:14:38', 8, NULL);
INSERT INTO `reserve`
VALUES (178, 'ISBN7-302-02368-105', 2, '2014-10-08 07:05:46', 4, NULL);
INSERT INTO `reserve`
VALUES (179, 'ISBN7-302-02368-107', 8, '2013-04-07 17:39:41', 5, NULL);
INSERT INTO `reserve`
VALUES (180, 'ISBN7-302-02368-102', 11, '2003-01-12 12:57:45', 5, NULL);
INSERT INTO `reserve`
VALUES (181, 'ISBN7-302-02368-106', 2, '2000-11-20 20:55:22', 4, NULL);
INSERT INTO `reserve`
VALUES (182, 'ISBN7-302-02368-106', 5, '2008-03-16 04:28:26', 2, NULL);
INSERT INTO `reserve`
VALUES (183, 'ISBN7-302-02368-101', 7, '2006-11-11 18:21:59', 2, NULL);
INSERT INTO `reserve`
VALUES (184, 'ISBN7-302-02368-103', 3, '2002-01-11 14:42:59', 2, NULL);
INSERT INTO `reserve`
VALUES (185, 'ISBN7-302-02368-101', 3, '2010-06-16 11:33:29', 9, NULL);
INSERT INTO `reserve`
VALUES (186, 'ISBN7-302-02368-101', 9, '2000-04-23 18:27:42', 5, NULL);
INSERT INTO `reserve`
VALUES (187, 'ISBN7-302-02368-106', 4, '2007-04-28 07:14:17', 3, NULL);
INSERT INTO `reserve`
VALUES (188, 'ISBN7-302-02368-108', 10, '2018-07-10 00:23:19', 10, NULL);
INSERT INTO `reserve`
VALUES (189, 'ISBN7-302-02368-108', 11, '2022-11-30 01:56:25', 4, NULL);
INSERT INTO `reserve`
VALUES (190, 'ISBN7-302-02368-108', 12, '2013-09-19 02:35:19', 3, NULL);
INSERT INTO `reserve`
VALUES (191, 'ISBN7-302-02368-103', 5, '2006-12-14 15:46:13', 2, NULL);
INSERT INTO `reserve`
VALUES (192, 'ISBN7-302-02368-107', 6, '2009-12-19 15:07:48', 6, NULL);
INSERT INTO `reserve`
VALUES (193, 'ISBN7-302-02368-105', 7, '2020-02-08 20:05:45', 6, NULL);
INSERT INTO `reserve`
VALUES (194, 'ISBN7-302-02368-102', 1, '2021-11-20 21:44:09', 4, NULL);
INSERT INTO `reserve`
VALUES (195, 'ISBN7-302-02368-101', 8, '2000-02-23 05:06:52', 1, NULL);
INSERT INTO `reserve`
VALUES (196, 'ISBN7-302-02368-109', 7, '2021-01-10 06:37:51', 4, NULL);
INSERT INTO `reserve`
VALUES (197, 'ISBN7-302-02368-103', 1, '2007-08-02 12:31:05', 5, NULL);
INSERT INTO `reserve`
VALUES (198, 'ISBN7-302-02368-104', 4, '2010-12-07 12:47:10', 7, NULL);
INSERT INTO `reserve`
VALUES (199, 'ISBN7-302-02368-101', 12, '2007-07-13 15:21:42', 2, NULL);
INSERT INTO `reserve`
VALUES (200, 'ISBN7-302-02368-102', 2, '2011-03-13 21:29:55', 3, NULL);
INSERT INTO `reserve`
VALUES (201, 'ISBN7-302-02368-101', 6, '2008-03-15 13:52:53', 7, NULL);
INSERT INTO `reserve`
VALUES (202, 'ISBN7-302-02368-106', 10, '2010-09-13 04:33:22', 4, NULL);
INSERT INTO `reserve`
VALUES (203, 'ISBN7-302-02368-105', 9, '2000-08-05 12:04:20', 7, NULL);
INSERT INTO `reserve`
VALUES (204, 'ISBN7-302-02368-106', 12, '2021-03-10 18:58:55', 10, NULL);
INSERT INTO `reserve`
VALUES (205, 'ISBN7-302-02368-100', 8, '2015-08-14 11:02:47', 5, NULL);
INSERT INTO `reserve`
VALUES (206, 'ISBN7-302-02368-104', 4, '2022-11-18 12:49:49', 1, NULL);
INSERT INTO `reserve`
VALUES (207, 'ISBN7-302-02368-109', 1, '2007-08-15 23:57:24', 6, NULL);
INSERT INTO `reserve`
VALUES (208, 'ISBN7-302-02368-107', 8, '2008-09-01 13:57:26', 3, NULL);
INSERT INTO `reserve`
VALUES (209, 'ISBN7-302-02368-100', 5, '2003-01-12 10:00:43', 10, NULL);
INSERT INTO `reserve`
VALUES (210, 'ISBN7-302-02368-108', 1, '2005-07-04 07:19:53', 9, NULL);
INSERT INTO `reserve`
VALUES (211, 'ISBN7-302-02368-101', 12, '2002-10-11 00:02:37', 7, NULL);
INSERT INTO `reserve`
VALUES (212, 'ISBN7-302-02368-108', 3, '2022-10-14 16:13:04', 7, NULL);
INSERT INTO `reserve`
VALUES (213, 'ISBN7-302-02368-100', 11, '2019-09-10 16:24:12', 3, NULL);
INSERT INTO `reserve`
VALUES (214, 'ISBN7-302-02368-100', 7, '2003-06-08 07:51:21', 8, NULL);
INSERT INTO `reserve`
VALUES (215, 'ISBN7-302-02368-102', 3, '2023-09-14 04:37:07', 9, NULL);
INSERT INTO `reserve`
VALUES (216, 'ISBN7-302-02368-105', 10, '2009-01-06 00:51:41', 2, NULL);
INSERT INTO `reserve`
VALUES (217, 'ISBN7-302-02368-105', 7, '2004-06-08 00:19:23', 8, NULL);
INSERT INTO `reserve`
VALUES (218, 'ISBN7-302-02368-108', 5, '2005-11-06 12:17:47', 10, NULL);
INSERT INTO `reserve`
VALUES (219, 'ISBN7-302-02368-103', 3, '2013-04-10 15:12:53', 2, NULL);
INSERT INTO `reserve`
VALUES (220, 'ISBN7-302-02368-107', 11, '2013-01-19 14:15:38', 3, NULL);
INSERT INTO `reserve`
VALUES (221, 'ISBN7-302-02368-103', 10, '2017-05-25 07:19:24', 1, NULL);
INSERT INTO `reserve`
VALUES (222, 'ISBN7-302-02368-109', 4, '2021-12-19 10:21:14', 4, NULL);
INSERT INTO `reserve`
VALUES (223, 'ISBN7-302-02368-101', 2, '2004-02-17 10:22:56', 3, NULL);
INSERT INTO `reserve`
VALUES (224, 'ISBN7-302-02368-104', 4, '2021-02-25 17:31:17', 9, NULL);
INSERT INTO `reserve`
VALUES (225, 'ISBN7-302-02368-101', 2, '2007-10-11 14:14:05', 2, NULL);
INSERT INTO `reserve`
VALUES (226, 'ISBN7-302-02368-103', 8, '2018-01-24 02:55:28', 10, NULL);
INSERT INTO `reserve`
VALUES (227, 'ISBN7-302-02368-108', 4, '2023-10-26 12:17:02', 6, NULL);
INSERT INTO `reserve`
VALUES (228, 'ISBN7-302-02368-104', 8, '2007-08-08 23:12:09', 9, NULL);
INSERT INTO `reserve`
VALUES (229, 'ISBN7-302-02368-101', 10, '2004-03-25 21:27:08', 8, NULL);
INSERT INTO `reserve`
VALUES (230, 'ISBN7-302-02368-101', 9, '2005-02-12 10:07:39', 9, NULL);
INSERT INTO `reserve`
VALUES (231, 'ISBN7-302-02368-101', 1, '2016-07-14 20:01:47', 10, NULL);
INSERT INTO `reserve`
VALUES (232, 'ISBN7-302-02368-106', 12, '2010-09-20 13:43:55', 7, NULL);
INSERT INTO `reserve`
VALUES (233, 'ISBN7-302-02368-106', 10, '2014-05-25 15:14:29', 9, NULL);
INSERT INTO `reserve`
VALUES (234, 'ISBN7-302-02368-107', 7, '2023-05-28 05:18:49', 2, NULL);
INSERT INTO `reserve`
VALUES (235, 'ISBN7-302-02368-100', 1, '2022-08-07 13:40:12', 6, NULL);
INSERT INTO `reserve`
VALUES (236, 'ISBN7-302-02368-107', 8, '2015-08-27 19:50:56', 5, NULL);
INSERT INTO `reserve`
VALUES (237, 'ISBN7-302-02368-107', 4, '2000-01-28 21:40:20', 6, NULL);
INSERT INTO `reserve`
VALUES (238, 'ISBN7-302-02368-108', 6, '2012-02-24 09:52:38', 7, NULL);
INSERT INTO `reserve`
VALUES (239, 'ISBN7-302-02368-103', 6, '2013-05-18 06:48:09', 5, NULL);
INSERT INTO `reserve`
VALUES (240, 'ISBN7-302-02368-107', 11, '2008-08-10 19:45:26', 9, NULL);
INSERT INTO `reserve`
VALUES (241, 'ISBN7-302-02368-100', 4, '2017-11-22 21:13:35', 4, NULL);
INSERT INTO `reserve`
VALUES (242, 'ISBN7-302-02368-101', 9, '2002-03-12 04:57:01', 2, NULL);
INSERT INTO `reserve`
VALUES (243, 'ISBN7-302-02368-100', 3, '2020-07-02 07:47:34', 3, NULL);
INSERT INTO `reserve`
VALUES (244, 'ISBN7-302-02368-103', 2, '2022-09-22 03:11:19', 2, NULL);
INSERT INTO `reserve`
VALUES (245, 'ISBN7-302-02368-108', 4, '2020-08-26 20:32:47', 2, NULL);
INSERT INTO `reserve`
VALUES (246, 'ISBN7-302-02368-101', 5, '2015-05-16 14:30:22', 8, NULL);
INSERT INTO `reserve`
VALUES (247, 'ISBN7-302-02368-109', 11, '2004-04-11 23:58:59', 10, NULL);
INSERT INTO `reserve`
VALUES (248, 'ISBN7-302-02368-100', 9, '2000-10-01 23:49:46', 3, NULL);
INSERT INTO `reserve`
VALUES (249, 'ISBN7-302-02368-104', 11, '2004-04-06 20:04:54', 1, NULL);
INSERT INTO `reserve`
VALUES (250, 'ISBN7-302-02368-106', 1, '2003-06-06 14:17:56', 2, NULL);
INSERT INTO `reserve`
VALUES (251, 'ISBN7-302-02368-102', 8, '2022-05-15 14:57:14', 3, NULL);
INSERT INTO `reserve`
VALUES (252, 'ISBN7-302-02368-108', 4, '2022-05-28 13:24:31', 6, NULL);
INSERT INTO `reserve`
VALUES (253, 'ISBN7-302-02368-101', 1, '2020-01-05 16:20:00', 5, NULL);
INSERT INTO `reserve`
VALUES (254, 'ISBN7-302-02368-107', 3, '2020-01-04 13:07:27', 10, NULL);
INSERT INTO `reserve`
VALUES (255, 'ISBN7-302-02368-103', 2, '2011-12-31 20:11:42', 4, NULL);
INSERT INTO `reserve`
VALUES (256, 'ISBN7-302-02368-107', 11, '2001-04-08 05:29:06', 10, NULL);
INSERT INTO `reserve`
VALUES (257, 'ISBN7-302-02368-102', 6, '2019-07-06 21:59:23', 3, NULL);
INSERT INTO `reserve`
VALUES (258, 'ISBN7-302-02368-106', 8, '2002-04-30 05:50:13', 5, NULL);
INSERT INTO `reserve`
VALUES (259, 'ISBN7-302-02368-106', 12, '2004-02-22 01:59:16', 10, NULL);
INSERT INTO `reserve`
VALUES (260, 'ISBN7-302-02368-100', 9, '2012-07-31 03:35:16', 3, NULL);
INSERT INTO `reserve`
VALUES (261, 'ISBN7-302-02368-102', 1, '2015-01-04 20:07:23', 7, NULL);
INSERT INTO `reserve`
VALUES (262, 'ISBN7-302-02368-107', 6, '2021-02-11 03:12:19', 8, NULL);
INSERT INTO `reserve`
VALUES (263, 'ISBN7-302-02368-109', 1, '2022-01-16 16:02:14', 6, NULL);
INSERT INTO `reserve`
VALUES (264, 'ISBN7-302-02368-101', 8, '2000-04-15 23:08:09', 8, NULL);
INSERT INTO `reserve`
VALUES (265, 'ISBN7-302-02368-103', 5, '2003-10-13 09:39:24', 5, NULL);
INSERT INTO `reserve`
VALUES (266, 'ISBN7-302-02368-102', 7, '2014-08-15 17:59:54', 4, NULL);
INSERT INTO `reserve`
VALUES (267, 'ISBN7-302-02368-103', 4, '2022-12-18 13:47:57', 3, NULL);
INSERT INTO `reserve`
VALUES (268, 'ISBN7-302-02368-107', 11, '2009-06-15 14:42:18', 4, NULL);
INSERT INTO `reserve`
VALUES (269, 'ISBN7-302-02368-105', 2, '2012-06-17 18:20:19', 8, NULL);
INSERT INTO `reserve`
VALUES (270, 'ISBN7-302-02368-104', 1, '2005-02-20 22:45:25', 10, NULL);
INSERT INTO `reserve`
VALUES (271, 'ISBN7-302-02368-106', 1, '2010-10-16 12:49:43', 3, NULL);
INSERT INTO `reserve`
VALUES (272, 'ISBN7-302-02368-105', 9, '2010-12-24 12:48:59', 9, NULL);
INSERT INTO `reserve`
VALUES (273, 'ISBN7-302-02368-101', 10, '2002-07-31 09:47:29', 3, NULL);
INSERT INTO `reserve`
VALUES (274, 'ISBN7-302-02368-106', 6, '2017-05-15 01:54:13', 6, NULL);
INSERT INTO `reserve`
VALUES (275, 'ISBN7-302-02368-107', 9, '2002-08-20 12:18:22', 7, NULL);
INSERT INTO `reserve`
VALUES (276, 'ISBN7-302-02368-105', 9, '2000-04-15 13:53:53', 4, NULL);
INSERT INTO `reserve`
VALUES (277, 'ISBN7-302-02368-100', 7, '2009-11-16 12:20:10', 10, NULL);
INSERT INTO `reserve`
VALUES (278, 'ISBN7-302-02368-108', 6, '2022-02-04 18:22:33', 2, NULL);
INSERT INTO `reserve`
VALUES (279, 'ISBN7-302-02368-104', 7, '2006-11-30 23:19:38', 4, NULL);
INSERT INTO `reserve`
VALUES (280, 'ISBN7-302-02368-101', 6, '2017-09-28 03:31:45', 3, NULL);
INSERT INTO `reserve`
VALUES (281, 'ISBN7-302-02368-102', 10, '2020-06-29 18:14:23', 7, NULL);
INSERT INTO `reserve`
VALUES (282, 'ISBN7-302-02368-105', 9, '2014-11-29 04:40:06', 3, NULL);
INSERT INTO `reserve`
VALUES (283, 'ISBN7-302-02368-106', 1, '2012-07-01 10:11:09', 9, NULL);
INSERT INTO `reserve`
VALUES (284, 'ISBN7-302-02368-104', 11, '2001-04-14 16:22:44', 5, NULL);
INSERT INTO `reserve`
VALUES (285, 'ISBN7-302-02368-109', 1, '2019-03-16 22:30:58', 8, NULL);
INSERT INTO `reserve`
VALUES (286, 'ISBN7-302-02368-101', 11, '2005-06-30 09:11:20', 3, NULL);
INSERT INTO `reserve`
VALUES (287, 'ISBN7-302-02368-102', 6, '2000-07-13 14:47:43', 3, NULL);
INSERT INTO `reserve`
VALUES (288, 'ISBN7-302-02368-107', 1, '2002-05-15 05:17:35', 6, NULL);
INSERT INTO `reserve`
VALUES (289, 'ISBN7-302-02368-100', 7, '2004-07-01 20:39:04', 5, NULL);
INSERT INTO `reserve`
VALUES (290, 'ISBN7-302-02368-109', 12, '2005-07-16 11:54:41', 9, NULL);
INSERT INTO `reserve`
VALUES (291, 'ISBN7-302-02368-109', 12, '2000-01-07 07:45:07', 2, NULL);
INSERT INTO `reserve`
VALUES (292, 'ISBN7-302-02368-101', 5, '2008-10-22 10:19:24', 5, NULL);
INSERT INTO `reserve`
VALUES (293, 'ISBN7-302-02368-100', 3, '2019-06-12 08:50:37', 2, NULL);
INSERT INTO `reserve`
VALUES (294, 'ISBN7-302-02368-101', 12, '2022-03-22 16:45:16', 5, NULL);
INSERT INTO `reserve`
VALUES (295, 'ISBN7-302-02368-103', 7, '2000-07-03 17:36:56', 9, NULL);
INSERT INTO `reserve`
VALUES (296, 'ISBN7-302-02368-101', 11, '2004-10-16 00:28:50', 9, NULL);
INSERT INTO `reserve`
VALUES (297, 'ISBN7-302-02368-108', 11, '2008-11-18 06:04:22', 9, NULL);
INSERT INTO `reserve`
VALUES (298, 'ISBN7-302-02368-103', 2, '2015-08-29 19:07:51', 3, NULL);
INSERT INTO `reserve`
VALUES (299, 'ISBN7-302-02368-106', 8, '2012-10-20 06:19:52', 3, NULL);
INSERT INTO `reserve`
VALUES (300, 'ISBN7-302-02368-102', 12, '2008-04-12 15:40:44', 1, NULL);
INSERT INTO `reserve`
VALUES (301, 'ISBN7-302-02368-104', 12, '2001-11-21 19:46:35', 1, NULL);
INSERT INTO `reserve`
VALUES (302, 'ISBN7-302-02368-109', 12, '2020-12-24 09:30:06', 7, NULL);
INSERT INTO `reserve`
VALUES (303, 'ISBN7-302-02368-105', 12, '2010-10-28 23:50:32', 7, NULL);
INSERT INTO `reserve`
VALUES (304, 'ISBN7-302-02368-103', 8, '2012-08-17 20:48:07', 9, NULL);
INSERT INTO `reserve`
VALUES (305, 'ISBN7-302-02368-103', 2, '2005-04-21 21:24:12', 8, NULL);
INSERT INTO `reserve`
VALUES (306, 'ISBN7-302-02368-104', 5, '2022-05-07 12:02:34', 5, NULL);
INSERT INTO `reserve`
VALUES (307, 'ISBN7-302-02368-106', 2, '2002-11-25 01:51:00', 2, NULL);
INSERT INTO `reserve`
VALUES (308, 'ISBN7-302-02368-106', 12, '2013-02-13 09:40:38', 9, NULL);
INSERT INTO `reserve`
VALUES (309, 'ISBN7-302-02368-109', 9, '2019-09-08 12:39:53', 2, NULL);
INSERT INTO `reserve`
VALUES (310, 'ISBN7-302-02368-103', 3, '2011-05-18 15:23:16', 8, NULL);
INSERT INTO `reserve`
VALUES (311, 'ISBN7-302-02368-100', 11, '2017-03-27 17:42:21', 4, NULL);
INSERT INTO `reserve`
VALUES (312, 'ISBN7-302-02368-109', 12, '2015-05-16 21:58:27', 7, NULL);
INSERT INTO `reserve`
VALUES (313, 'ISBN7-302-02368-109', 2, '2022-07-29 16:55:54', 10, NULL);
INSERT INTO `reserve`
VALUES (314, 'ISBN7-302-02368-109', 4, '2007-09-19 10:36:42', 3, NULL);
INSERT INTO `reserve`
VALUES (315, 'ISBN7-302-02368-105', 2, '2013-09-03 09:44:29', 3, NULL);
INSERT INTO `reserve`
VALUES (316, 'ISBN7-302-02368-104', 11, '2004-11-10 19:47:02', 7, NULL);
INSERT INTO `reserve`
VALUES (317, 'ISBN7-302-02368-105', 8, '2001-01-30 21:31:13', 4, NULL);
INSERT INTO `reserve`
VALUES (318, 'ISBN7-302-02368-106', 3, '2005-12-25 04:13:59', 3, NULL);
INSERT INTO `reserve`
VALUES (319, 'ISBN7-302-02368-107', 7, '2023-05-25 22:16:51', 10, NULL);
INSERT INTO `reserve`
VALUES (320, 'ISBN7-302-02368-100', 5, '2016-02-18 13:04:37', 5, NULL);
INSERT INTO `reserve`
VALUES (321, 'ISBN7-302-02368-108', 12, '2003-04-14 04:55:11', 2, NULL);
INSERT INTO `reserve`
VALUES (322, 'ISBN7-302-02368-101', 8, '2012-03-09 00:13:39', 6, NULL);
INSERT INTO `reserve`
VALUES (323, 'ISBN7-302-02368-106', 6, '2010-10-25 05:27:00', 9, NULL);
INSERT INTO `reserve`
VALUES (324, 'ISBN7-302-02368-107', 6, '2018-01-14 05:25:13', 8, NULL);
INSERT INTO `reserve`
VALUES (325, 'ISBN7-302-02368-103', 2, '2001-11-22 14:30:59', 7, NULL);
INSERT INTO `reserve`
VALUES (326, 'ISBN7-302-02368-108', 6, '2011-03-21 13:57:09', 3, NULL);
INSERT INTO `reserve`
VALUES (327, 'ISBN7-302-02368-107', 1, '2020-11-05 21:51:00', 9, NULL);
INSERT INTO `reserve`
VALUES (328, 'ISBN7-302-02368-106', 11, '2021-02-10 17:47:29', 8, NULL);
INSERT INTO `reserve`
VALUES (329, 'ISBN7-302-02368-100', 10, '2016-08-14 03:32:42', 2, NULL);
INSERT INTO `reserve`
VALUES (330, 'ISBN7-302-02368-103', 5, '2017-10-25 09:38:38', 3, NULL);
INSERT INTO `reserve`
VALUES (331, 'ISBN7-302-02368-103', 5, '2017-01-22 07:34:25', 3, NULL);
INSERT INTO `reserve`
VALUES (332, 'ISBN7-302-02368-104', 5, '2001-02-19 00:27:56', 8, NULL);
INSERT INTO `reserve`
VALUES (333, 'ISBN7-302-02368-107', 10, '2014-09-26 13:53:41', 10, NULL);
INSERT INTO `reserve`
VALUES (334, 'ISBN7-302-02368-104', 2, '2001-09-23 07:19:18', 4, NULL);
INSERT INTO `reserve`
VALUES (335, 'ISBN7-302-02368-107', 1, '2012-10-01 19:06:25', 6, NULL);
INSERT INTO `reserve`
VALUES (336, 'ISBN7-302-02368-100', 10, '2012-12-31 15:35:00', 2, NULL);
INSERT INTO `reserve`
VALUES (337, 'ISBN7-302-02368-100', 6, '2004-09-02 01:52:02', 7, NULL);
INSERT INTO `reserve`
VALUES (338, 'ISBN7-302-02368-106', 10, '2010-03-26 09:01:15', 5, NULL);
INSERT INTO `reserve`
VALUES (339, 'ISBN7-302-02368-103', 1, '2014-11-29 10:03:32', 4, NULL);
INSERT INTO `reserve`
VALUES (340, 'ISBN7-302-02368-107', 7, '2015-09-23 08:56:18', 2, NULL);
INSERT INTO `reserve`
VALUES (341, 'ISBN7-302-02368-106', 2, '2022-04-02 20:20:33', 6, NULL);
INSERT INTO `reserve`
VALUES (342, 'ISBN7-302-02368-108', 10, '2008-03-31 17:24:41', 5, NULL);
INSERT INTO `reserve`
VALUES (343, 'ISBN7-302-02368-105', 7, '2000-04-16 18:02:09', 8, NULL);
INSERT INTO `reserve`
VALUES (344, 'ISBN7-302-02368-107', 1, '2000-08-19 01:29:35', 6, NULL);
INSERT INTO `reserve`
VALUES (345, 'ISBN7-302-02368-102', 5, '2019-10-06 14:30:03', 7, NULL);
INSERT INTO `reserve`
VALUES (346, 'ISBN7-302-02368-101', 3, '2020-02-11 14:49:24', 7, NULL);
INSERT INTO `reserve`
VALUES (347, 'ISBN7-302-02368-100', 12, '2003-10-07 14:56:52', 6, NULL);
INSERT INTO `reserve`
VALUES (348, 'ISBN7-302-02368-100', 11, '2006-12-22 00:56:45', 2, NULL);
INSERT INTO `reserve`
VALUES (349, 'ISBN7-302-02368-102', 3, '2018-08-01 17:17:44', 8, NULL);
INSERT INTO `reserve`
VALUES (350, 'ISBN7-302-02368-103', 6, '2021-12-01 08:01:36', 4, NULL);
INSERT INTO `reserve`
VALUES (351, 'ISBN7-302-02368-107', 6, '2006-02-15 05:01:09', 5, NULL);
INSERT INTO `reserve`
VALUES (352, 'ISBN7-302-02368-104', 11, '2016-09-19 03:07:43', 10, NULL);
INSERT INTO `reserve`
VALUES (353, 'ISBN7-302-02368-109', 11, '2019-06-18 07:06:39', 7, NULL);
INSERT INTO `reserve`
VALUES (354, 'ISBN7-302-02368-102', 4, '2021-01-20 17:03:09', 4, NULL);
INSERT INTO `reserve`
VALUES (355, 'ISBN7-302-02368-106', 5, '2000-02-13 15:22:33', 4, NULL);
INSERT INTO `reserve`
VALUES (356, 'ISBN7-302-02368-101', 7, '2000-02-26 04:32:56', 7, NULL);
INSERT INTO `reserve`
VALUES (357, 'ISBN7-302-02368-103', 9, '2004-10-18 13:19:24', 6, NULL);
INSERT INTO `reserve`
VALUES (358, 'ISBN7-302-02368-104', 4, '2020-01-03 15:38:08', 7, NULL);
INSERT INTO `reserve`
VALUES (359, 'ISBN7-302-02368-108', 3, '2007-09-17 22:01:23', 3, NULL);
INSERT INTO `reserve`
VALUES (360, 'ISBN7-302-02368-101', 1, '2014-03-16 17:16:55', 3, NULL);
INSERT INTO `reserve`
VALUES (361, 'ISBN7-302-02368-103', 10, '2004-10-26 12:54:46', 7, NULL);
INSERT INTO `reserve`
VALUES (362, 'ISBN7-302-02368-105', 7, '2014-04-05 05:38:16', 8, NULL);
INSERT INTO `reserve`
VALUES (363, 'ISBN7-302-02368-108', 1, '2005-02-21 15:05:36', 5, NULL);
INSERT INTO `reserve`
VALUES (364, 'ISBN7-302-02368-109', 9, '2013-01-16 02:26:51', 1, NULL);
INSERT INTO `reserve`
VALUES (365, 'ISBN7-302-02368-108', 6, '2009-11-01 16:12:10', 4, NULL);
INSERT INTO `reserve`
VALUES (366, 'ISBN7-302-02368-107', 8, '2021-05-16 04:37:51', 6, NULL);
INSERT INTO `reserve`
VALUES (367, 'ISBN7-302-02368-102', 3, '2006-07-27 14:37:04', 9, NULL);
INSERT INTO `reserve`
VALUES (368, 'ISBN7-302-02368-100', 7, '2021-11-08 21:38:08', 7, NULL);
INSERT INTO `reserve`
VALUES (369, 'ISBN7-302-02368-102', 4, '2023-06-14 05:43:42', 9, NULL);
INSERT INTO `reserve`
VALUES (370, 'ISBN7-302-02368-109', 2, '2004-11-12 15:19:32', 3, NULL);
INSERT INTO `reserve`
VALUES (371, 'ISBN7-302-02368-103', 4, '2001-08-20 21:01:59', 5, NULL);
INSERT INTO `reserve`
VALUES (372, 'ISBN7-302-02368-105', 8, '2014-09-21 07:30:50', 5, NULL);
INSERT INTO `reserve`
VALUES (373, 'ISBN7-302-02368-109', 5, '2007-07-08 06:01:59', 10, NULL);
INSERT INTO `reserve`
VALUES (374, 'ISBN7-302-02368-100', 10, '2003-09-18 18:32:04', 9, NULL);
INSERT INTO `reserve`
VALUES (375, 'ISBN7-302-02368-105', 10, '2023-03-13 16:15:23', 3, NULL);
INSERT INTO `reserve`
VALUES (376, 'ISBN7-302-02368-100', 12, '2002-12-03 14:16:41', 2, NULL);
INSERT INTO `reserve`
VALUES (377, 'ISBN7-302-02368-109', 3, '2006-05-23 11:54:13', 5, NULL);
INSERT INTO `reserve`
VALUES (378, 'ISBN7-302-02368-100', 9, '2001-02-18 09:38:12', 4, NULL);
INSERT INTO `reserve`
VALUES (379, 'ISBN7-302-02368-109', 6, '2006-02-11 02:58:22', 10, NULL);
INSERT INTO `reserve`
VALUES (380, 'ISBN7-302-02368-107', 11, '2012-10-27 18:57:24', 1, NULL);
INSERT INTO `reserve`
VALUES (381, 'ISBN7-302-02368-108', 3, '2008-04-04 02:33:07', 5, NULL);
INSERT INTO `reserve`
VALUES (382, 'ISBN7-302-02368-100', 8, '2001-07-03 03:12:08', 3, NULL);
INSERT INTO `reserve`
VALUES (383, 'ISBN7-302-02368-105', 3, '2008-03-17 03:27:41', 5, NULL);
INSERT INTO `reserve`
VALUES (384, 'ISBN7-302-02368-105', 6, '2007-11-30 22:28:37', 8, NULL);
INSERT INTO `reserve`
VALUES (385, 'ISBN7-302-02368-101', 1, '2003-05-17 12:32:38', 4, NULL);
INSERT INTO `reserve`
VALUES (386, 'ISBN7-302-02368-109', 6, '2017-07-28 00:52:42', 4, NULL);
INSERT INTO `reserve`
VALUES (387, 'ISBN7-302-02368-105', 11, '2019-03-09 22:15:39', 2, NULL);
INSERT INTO `reserve`
VALUES (388, 'ISBN7-302-02368-104', 4, '2007-09-18 12:10:53', 3, NULL);
INSERT INTO `reserve`
VALUES (389, 'ISBN7-302-02368-104', 6, '2023-12-05 08:24:20', 6, NULL);
INSERT INTO `reserve`
VALUES (390, 'ISBN7-302-02368-109', 9, '2012-09-29 01:57:39', 4, NULL);
INSERT INTO `reserve`
VALUES (391, 'ISBN7-302-02368-100', 7, '2023-11-02 08:52:18', 5, NULL);
INSERT INTO `reserve`
VALUES (392, 'ISBN7-302-02368-108', 5, '2009-11-03 07:08:10', 6, NULL);
INSERT INTO `reserve`
VALUES (393, 'ISBN7-302-02368-107', 5, '2012-01-14 04:47:10', 7, NULL);
INSERT INTO `reserve`
VALUES (394, 'ISBN7-302-02368-103', 10, '2001-07-21 02:56:53', 6, NULL);
INSERT INTO `reserve`
VALUES (395, 'ISBN7-302-02368-103', 6, '2020-06-26 16:11:36', 2, NULL);
INSERT INTO `reserve`
VALUES (396, 'ISBN7-302-02368-109', 11, '2009-02-06 01:13:49', 8, NULL);
INSERT INTO `reserve`
VALUES (397, 'ISBN7-302-02368-104', 10, '2001-10-22 12:19:36', 5, NULL);
INSERT INTO `reserve`
VALUES (398, 'ISBN7-302-02368-104', 6, '2023-08-26 11:03:52', 7, NULL);
INSERT INTO `reserve`
VALUES (399, 'ISBN7-302-02368-102', 6, '2016-10-06 08:12:03', 9, NULL);
INSERT INTO `reserve`
VALUES (400, 'ISBN7-302-02368-101', 12, '2003-01-15 06:30:29', 5, NULL);
INSERT INTO `reserve`
VALUES (401, 'ISBN7-302-02368-104', 2, '2007-12-30 03:10:27', 9, NULL);
INSERT INTO `reserve`
VALUES (402, 'ISBN7-302-02368-105', 10, '2014-02-03 09:10:11', 9, NULL);
INSERT INTO `reserve`
VALUES (403, 'ISBN7-302-02368-104', 11, '2006-10-27 04:48:59', 9, NULL);
INSERT INTO `reserve`
VALUES (404, 'ISBN7-302-02368-104', 11, '2006-10-27 21:07:05', 10, NULL);
INSERT INTO `reserve`
VALUES (405, 'ISBN7-302-02368-108', 6, '2003-09-27 21:12:44', 1, NULL);
INSERT INTO `reserve`
VALUES (406, 'ISBN7-302-02368-104', 9, '2010-10-03 04:04:04', 2, NULL);
INSERT INTO `reserve`
VALUES (407, 'ISBN7-302-02368-104', 7, '2004-09-07 01:23:13', 9, NULL);
INSERT INTO `reserve`
VALUES (408, 'ISBN7-302-02368-107', 2, '2003-09-10 13:14:55', 6, NULL);
INSERT INTO `reserve`
VALUES (409, 'ISBN7-302-02368-102', 2, '2013-08-04 22:27:14', 3, NULL);
INSERT INTO `reserve`
VALUES (410, 'ISBN7-302-02368-105', 7, '2022-09-15 04:06:06', 10, NULL);
INSERT INTO `reserve`
VALUES (411, 'ISBN7-302-02368-104', 4, '2019-12-27 08:49:26', 5, NULL);
INSERT INTO `reserve`
VALUES (412, 'ISBN7-302-02368-100', 5, '2011-04-19 14:20:36', 10, NULL);
INSERT INTO `reserve`
VALUES (413, 'ISBN7-302-02368-108', 2, '2016-10-11 02:32:18', 9, NULL);
INSERT INTO `reserve`
VALUES (414, 'ISBN7-302-02368-104', 3, '2006-04-24 00:36:23', 3, NULL);
INSERT INTO `reserve`
VALUES (415, 'ISBN7-302-02368-105', 4, '2012-11-13 04:49:19', 3, NULL);
INSERT INTO `reserve`
VALUES (416, 'ISBN7-302-02368-102', 7, '2014-01-24 07:45:40', 9, NULL);
INSERT INTO `reserve`
VALUES (417, 'ISBN7-302-02368-104', 2, '2000-06-19 17:05:11', 7, NULL);
INSERT INTO `reserve`
VALUES (418, 'ISBN7-302-02368-105', 2, '2011-09-02 04:23:11', 8, NULL);
INSERT INTO `reserve`
VALUES (419, 'ISBN7-302-02368-102', 8, '2006-06-15 13:59:06', 7, NULL);
INSERT INTO `reserve`
VALUES (420, 'ISBN7-302-02368-107', 10, '2021-05-08 09:44:42', 2, NULL);
INSERT INTO `reserve`
VALUES (421, 'ISBN7-302-02368-106', 1, '2023-02-18 00:07:14', 4, NULL);
INSERT INTO `reserve`
VALUES (422, 'ISBN7-302-02368-104', 11, '2008-08-09 18:26:16', 5, NULL);
INSERT INTO `reserve`
VALUES (423, 'ISBN7-302-02368-100', 5, '2010-09-27 18:52:20', 5, NULL);
INSERT INTO `reserve`
VALUES (424, 'ISBN7-302-02368-102', 1, '2008-03-31 13:43:45', 9, NULL);
INSERT INTO `reserve`
VALUES (425, 'ISBN7-302-02368-109', 2, '2022-08-08 11:45:17', 1, NULL);
INSERT INTO `reserve`
VALUES (426, 'ISBN7-302-02368-108', 3, '2012-12-13 01:09:55', 9, NULL);
INSERT INTO `reserve`
VALUES (427, 'ISBN7-302-02368-105', 10, '2002-09-06 22:42:08', 8, NULL);
INSERT INTO `reserve`
VALUES (428, 'ISBN7-302-02368-109', 10, '2020-10-14 18:13:21', 2, NULL);
INSERT INTO `reserve`
VALUES (429, 'ISBN7-302-02368-105', 10, '2003-04-21 11:18:27', 8, NULL);
INSERT INTO `reserve`
VALUES (430, 'ISBN7-302-02368-105', 11, '2021-11-28 07:34:01', 1, NULL);
INSERT INTO `reserve`
VALUES (431, 'ISBN7-302-02368-100', 1, '2022-07-21 05:52:09', 3, NULL);
INSERT INTO `reserve`
VALUES (432, 'ISBN7-302-02368-107', 7, '2009-12-06 02:35:11', 6, NULL);
INSERT INTO `reserve`
VALUES (433, 'ISBN7-302-02368-106', 4, '2012-04-06 14:22:41', 1, NULL);
INSERT INTO `reserve`
VALUES (434, 'ISBN7-302-02368-102', 3, '2015-05-18 10:51:37', 2, NULL);
INSERT INTO `reserve`
VALUES (435, 'ISBN7-302-02368-106', 5, '2018-08-05 22:09:13', 10, NULL);
INSERT INTO `reserve`
VALUES (436, 'ISBN7-302-02368-105', 6, '2007-03-03 01:13:05', 2, NULL);
INSERT INTO `reserve`
VALUES (437, 'ISBN7-302-02368-107', 1, '2023-05-08 11:08:00', 5, NULL);
INSERT INTO `reserve`
VALUES (438, 'ISBN7-302-02368-102', 4, '2018-07-31 04:56:08', 5, NULL);
INSERT INTO `reserve`
VALUES (439, 'ISBN7-302-02368-107', 11, '2005-12-24 23:58:44', 8, NULL);
INSERT INTO `reserve`
VALUES (440, 'ISBN7-302-02368-108', 6, '2014-09-19 09:42:29', 9, NULL);
INSERT INTO `reserve`
VALUES (441, 'ISBN7-302-02368-105', 4, '2002-10-30 08:39:52', 3, NULL);
INSERT INTO `reserve`
VALUES (442, 'ISBN7-302-02368-103', 3, '2005-08-14 14:35:59', 8, NULL);
INSERT INTO `reserve`
VALUES (443, 'ISBN7-302-02368-108', 10, '2023-08-05 07:12:56', 2, NULL);
INSERT INTO `reserve`
VALUES (444, 'ISBN7-302-02368-104', 6, '2007-04-21 23:25:36', 7, NULL);
INSERT INTO `reserve`
VALUES (445, 'ISBN7-302-02368-104', 6, '2019-12-24 22:14:35', 3, NULL);
INSERT INTO `reserve`
VALUES (446, 'ISBN7-302-02368-108', 10, '2023-05-04 19:16:03', 6, NULL);
INSERT INTO `reserve`
VALUES (447, 'ISBN7-302-02368-103', 10, '2019-03-31 15:40:19', 1, NULL);
INSERT INTO `reserve`
VALUES (448, 'ISBN7-302-02368-102', 10, '2016-04-10 18:49:11', 4, NULL);
INSERT INTO `reserve`
VALUES (449, 'ISBN7-302-02368-108', 2, '2021-07-11 12:14:07', 5, NULL);
INSERT INTO `reserve`
VALUES (450, 'ISBN7-302-02368-109', 1, '2011-02-15 03:48:45', 4, NULL);
INSERT INTO `reserve`
VALUES (451, 'ISBN7-302-02368-105', 1, '2016-07-14 03:10:25', 5, NULL);
INSERT INTO `reserve`
VALUES (452, 'ISBN7-302-02368-106', 5, '2020-08-07 11:01:54', 9, NULL);
INSERT INTO `reserve`
VALUES (453, 'ISBN7-302-02368-104', 7, '2013-12-22 04:34:41', 3, NULL);
INSERT INTO `reserve`
VALUES (454, 'ISBN7-302-02368-108', 2, '2015-04-17 05:11:32', 10, NULL);
INSERT INTO `reserve`
VALUES (455, 'ISBN7-302-02368-109', 7, '2012-10-11 21:28:57', 5, NULL);
INSERT INTO `reserve`
VALUES (456, 'ISBN7-302-02368-109', 3, '2001-05-20 14:45:06', 9, NULL);
INSERT INTO `reserve`
VALUES (457, 'ISBN7-302-02368-102', 1, '2021-02-05 11:21:56', 5, NULL);
INSERT INTO `reserve`
VALUES (458, 'ISBN7-302-02368-100', 8, '2010-09-21 00:11:08', 4, NULL);
INSERT INTO `reserve`
VALUES (459, 'ISBN7-302-02368-106', 8, '2023-07-23 21:58:36', 9, NULL);
INSERT INTO `reserve`
VALUES (460, 'ISBN7-302-02368-102', 9, '2019-09-26 17:50:55', 3, NULL);
INSERT INTO `reserve`
VALUES (461, 'ISBN7-302-02368-101', 8, '2012-02-03 05:55:08', 7, NULL);
INSERT INTO `reserve`
VALUES (462, 'ISBN7-302-02368-101', 10, '2004-05-11 19:02:52', 6, NULL);
INSERT INTO `reserve`
VALUES (463, 'ISBN7-302-02368-104', 1, '2014-02-22 13:01:51', 4, NULL);
INSERT INTO `reserve`
VALUES (464, 'ISBN7-302-02368-103', 1, '2009-11-03 10:15:44', 7, NULL);
INSERT INTO `reserve`
VALUES (465, 'ISBN7-302-02368-105', 6, '2011-05-02 00:49:05', 2, NULL);
INSERT INTO `reserve`
VALUES (466, 'ISBN7-302-02368-105', 5, '2017-04-11 13:32:25', 8, NULL);
INSERT INTO `reserve`
VALUES (467, 'ISBN7-302-02368-102', 5, '2004-12-31 10:01:10', 4, NULL);
INSERT INTO `reserve`
VALUES (468, 'ISBN7-302-02368-103', 9, '2009-01-22 01:01:54', 7, NULL);
INSERT INTO `reserve`
VALUES (469, 'ISBN7-302-02368-109', 5, '2009-04-25 19:20:21', 7, NULL);
INSERT INTO `reserve`
VALUES (470, 'ISBN7-302-02368-109', 4, '2008-11-06 12:50:55', 2, NULL);
INSERT INTO `reserve`
VALUES (471, 'ISBN7-302-02368-103', 4, '2010-07-06 21:05:49', 6, NULL);
INSERT INTO `reserve`
VALUES (472, 'ISBN7-302-02368-102', 2, '2008-07-03 10:44:12', 3, NULL);
INSERT INTO `reserve`
VALUES (473, 'ISBN7-302-02368-109', 2, '2014-09-13 18:22:55', 9, NULL);
INSERT INTO `reserve`
VALUES (474, 'ISBN7-302-02368-106', 12, '2005-06-27 10:22:59', 8, NULL);
INSERT INTO `reserve`
VALUES (475, 'ISBN7-302-02368-105', 5, '2023-04-18 22:16:39', 2, NULL);
INSERT INTO `reserve`
VALUES (476, 'ISBN7-302-02368-101', 11, '2003-08-20 19:42:59', 2, NULL);
INSERT INTO `reserve`
VALUES (477, 'ISBN7-302-02368-102', 6, '2006-11-19 16:38:18', 5, NULL);
INSERT INTO `reserve`
VALUES (478, 'ISBN7-302-02368-106', 2, '2023-10-08 22:13:51', 7, NULL);
INSERT INTO `reserve`
VALUES (479, 'ISBN7-302-02368-105', 4, '2017-08-07 13:56:00', 7, NULL);
INSERT INTO `reserve`
VALUES (480, 'ISBN7-302-02368-101', 11, '2002-07-02 17:40:15', 8, NULL);
INSERT INTO `reserve`
VALUES (481, 'ISBN7-302-02368-101', 2, '2012-10-15 17:09:03', 8, NULL);
INSERT INTO `reserve`
VALUES (482, 'ISBN7-302-02368-104', 8, '2008-07-15 11:01:38', 1, NULL);
INSERT INTO `reserve`
VALUES (483, 'ISBN7-302-02368-102', 1, '2003-02-07 04:54:51', 2, NULL);
INSERT INTO `reserve`
VALUES (484, 'ISBN7-302-02368-102', 12, '2021-11-30 08:55:54', 7, NULL);
INSERT INTO `reserve`
VALUES (485, 'ISBN7-302-02368-101', 9, '2005-03-22 16:38:51', 6, NULL);
INSERT INTO `reserve`
VALUES (486, 'ISBN7-302-02368-102', 2, '2005-11-20 04:50:12', 2, NULL);
INSERT INTO `reserve`
VALUES (487, 'ISBN7-302-02368-108', 12, '2020-12-18 05:24:22', 9, NULL);
INSERT INTO `reserve`
VALUES (488, 'ISBN7-302-02368-103', 8, '2023-08-11 08:56:27', 9, NULL);
INSERT INTO `reserve`
VALUES (489, 'ISBN7-302-02368-108', 11, '2003-08-22 06:19:30', 2, NULL);
INSERT INTO `reserve`
VALUES (490, 'ISBN7-302-02368-101', 5, '2023-07-05 18:00:53', 7, NULL);
INSERT INTO `reserve`
VALUES (491, 'ISBN7-302-02368-100', 11, '2003-05-25 21:16:32', 2, NULL);
INSERT INTO `reserve`
VALUES (492, 'ISBN7-302-02368-103', 6, '2008-12-04 22:55:36', 6, NULL);
INSERT INTO `reserve`
VALUES (493, 'ISBN7-302-02368-104', 10, '2021-04-23 10:35:07', 6, NULL);
INSERT INTO `reserve`
VALUES (494, 'ISBN7-302-02368-108', 7, '2022-03-30 08:05:35', 7, NULL);
INSERT INTO `reserve`
VALUES (495, 'ISBN7-302-02368-100', 4, '2016-09-02 23:21:18', 8, NULL);
INSERT INTO `reserve`
VALUES (496, 'ISBN7-302-02368-103', 3, '2001-05-24 02:04:08', 7, NULL);
INSERT INTO `reserve`
VALUES (497, 'ISBN7-302-02368-100', 5, '2015-04-04 03:56:16', 8, NULL);
INSERT INTO `reserve`
VALUES (498, 'ISBN7-302-02368-109', 2, '2003-07-23 08:06:44', 3, NULL);
INSERT INTO `reserve`
VALUES (499, 'ISBN7-302-02368-103', 6, '2008-06-11 13:43:48', 7, NULL);
INSERT INTO `reserve`
VALUES (500, 'ISBN7-302-02368-104', 9, '2023-09-07 16:40:06', 1, NULL);
INSERT INTO `reserve`
VALUES (501, 'ISBN7-302-02368-105', 10, '2021-09-15 22:16:43', 4, NULL);
INSERT INTO `reserve`
VALUES (502, 'ISBN7-302-02368-102', 7, '2015-04-02 22:35:08', 8, NULL);
INSERT INTO `reserve`
VALUES (503, 'ISBN7-302-02368-105', 7, '2020-10-16 07:39:18', 3, NULL);
INSERT INTO `reserve`
VALUES (504, 'ISBN7-302-02368-109', 7, '2004-03-09 20:32:06', 6, NULL);
INSERT INTO `reserve`
VALUES (505, 'ISBN7-302-02368-109', 5, '2008-02-16 04:38:03', 5, NULL);
INSERT INTO `reserve`
VALUES (506, 'ISBN7-302-02368-101', 7, '2021-05-30 01:00:13', 7, NULL);
INSERT INTO `reserve`
VALUES (507, 'ISBN7-302-02368-104', 3, '2008-09-18 16:23:06', 8, NULL);
INSERT INTO `reserve`
VALUES (508, 'ISBN7-302-02368-108', 12, '2013-03-19 17:38:30', 10, NULL);
INSERT INTO `reserve`
VALUES (509, 'ISBN7-302-02368-100', 5, '2018-12-11 23:09:54', 7, NULL);
INSERT INTO `reserve`
VALUES (510, 'ISBN7-302-02368-108', 7, '2000-03-17 06:19:44', 5, NULL);
INSERT INTO `reserve`
VALUES (511, 'ISBN7-302-02368-101', 1, '2000-03-17 11:16:34', 4, NULL);
INSERT INTO `reserve`
VALUES (512, 'ISBN7-302-02368-107', 10, '2014-11-25 20:59:53', 9, NULL);
INSERT INTO `reserve`
VALUES (513, 'ISBN7-302-02368-109', 10, '2019-07-27 00:24:52', 2, NULL);
INSERT INTO `reserve`
VALUES (514, 'ISBN7-302-02368-104', 8, '2000-03-10 10:02:38', 9, NULL);
INSERT INTO `reserve`
VALUES (515, 'ISBN7-302-02368-101', 5, '2023-10-16 11:59:02', 7, NULL);
INSERT INTO `reserve`
VALUES (516, 'ISBN7-302-02368-108', 6, '2008-08-19 16:40:37', 8, NULL);
INSERT INTO `reserve`
VALUES (517, 'ISBN7-302-02368-103', 9, '2004-09-17 21:34:27', 7, NULL);
INSERT INTO `reserve`
VALUES (518, 'ISBN7-302-02368-104', 9, '2013-01-15 16:23:57', 3, NULL);
INSERT INTO `reserve`
VALUES (519, 'ISBN7-302-02368-107', 11, '2009-02-06 03:06:21', 6, NULL);
INSERT INTO `reserve`
VALUES (520, 'ISBN7-302-02368-104', 4, '2022-02-09 22:35:53', 4, NULL);
INSERT INTO `reserve`
VALUES (521, 'ISBN7-302-02368-109', 7, '2011-12-03 11:05:05', 9, NULL);
INSERT INTO `reserve`
VALUES (522, 'ISBN7-302-02368-105', 5, '2002-09-23 11:50:42', 5, NULL);
INSERT INTO `reserve`
VALUES (523, 'ISBN7-302-02368-103', 12, '2007-01-23 14:38:55', 5, NULL);
INSERT INTO `reserve`
VALUES (524, 'ISBN7-302-02368-100', 6, '2012-05-11 13:33:01', 4, NULL);
INSERT INTO `reserve`
VALUES (525, 'ISBN7-302-02368-100', 9, '2007-04-26 10:24:57', 2, NULL);
INSERT INTO `reserve`
VALUES (526, 'ISBN7-302-02368-109', 2, '2002-10-27 22:39:31', 8, NULL);
INSERT INTO `reserve`
VALUES (527, 'ISBN7-302-02368-103', 1, '2001-02-05 00:28:36', 2, NULL);
INSERT INTO `reserve`
VALUES (528, 'ISBN7-302-02368-106', 9, '2021-05-05 22:33:15', 10, NULL);
INSERT INTO `reserve`
VALUES (529, 'ISBN7-302-02368-102', 3, '2017-08-19 17:02:16', 5, NULL);
INSERT INTO `reserve`
VALUES (530, 'ISBN7-302-02368-106', 12, '2020-12-11 01:05:36', 6, NULL);
INSERT INTO `reserve`
VALUES (531, 'ISBN7-302-02368-101', 10, '2003-03-01 01:00:45', 2, NULL);
INSERT INTO `reserve`
VALUES (532, 'ISBN7-302-02368-103', 10, '2010-05-02 05:08:23', 4, NULL);
INSERT INTO `reserve`
VALUES (533, 'ISBN7-302-02368-106', 5, '2016-07-22 19:35:26', 6, NULL);
INSERT INTO `reserve`
VALUES (534, 'ISBN7-302-02368-106', 5, '2010-02-25 10:53:42', 7, NULL);
INSERT INTO `reserve`
VALUES (535, 'ISBN7-302-02368-103', 8, '2023-12-23 14:59:38', 4, NULL);
INSERT INTO `reserve`
VALUES (536, 'ISBN7-302-02368-109', 2, '2011-09-13 15:52:59', 10, NULL);
INSERT INTO `reserve`
VALUES (537, 'ISBN7-302-02368-100', 1, '2001-01-17 10:18:05', 7, NULL);
INSERT INTO `reserve`
VALUES (538, 'ISBN7-302-02368-107', 3, '2012-02-24 11:15:58', 6, NULL);
INSERT INTO `reserve`
VALUES (539, 'ISBN7-302-02368-107', 3, '2007-02-06 20:54:01', 4, NULL);
INSERT INTO `reserve`
VALUES (540, 'ISBN7-302-02368-104', 2, '2009-12-31 12:58:42', 7, NULL);
INSERT INTO `reserve`
VALUES (541, 'ISBN7-302-02368-108', 3, '2006-08-14 22:02:49', 8, NULL);
INSERT INTO `reserve`
VALUES (542, 'ISBN7-302-02368-103', 9, '2004-02-29 06:13:01', 8, NULL);
INSERT INTO `reserve`
VALUES (543, 'ISBN7-302-02368-106', 9, '2019-07-27 08:20:53', 7, NULL);
INSERT INTO `reserve`
VALUES (544, 'ISBN7-302-02368-109', 4, '2013-08-06 08:53:14', 4, NULL);
INSERT INTO `reserve`
VALUES (545, 'ISBN7-302-02368-106', 10, '2018-10-28 23:10:02', 7, NULL);
INSERT INTO `reserve`
VALUES (546, 'ISBN7-302-02368-107', 1, '2003-09-25 06:26:30', 3, NULL);
INSERT INTO `reserve`
VALUES (547, 'ISBN7-302-02368-101', 8, '2006-07-06 21:41:50', 3, NULL);
INSERT INTO `reserve`
VALUES (548, 'ISBN7-302-02368-106', 1, '2013-05-11 20:38:33', 2, NULL);
INSERT INTO `reserve`
VALUES (549, 'ISBN7-302-02368-102', 11, '2019-06-06 10:18:49', 6, NULL);
INSERT INTO `reserve`
VALUES (550, 'ISBN7-302-02368-100', 11, '2000-05-20 07:31:51', 8, NULL);
INSERT INTO `reserve`
VALUES (551, 'ISBN7-302-02368-100', 4, '2010-01-29 10:35:44', 6, NULL);
INSERT INTO `reserve`
VALUES (552, 'ISBN7-302-02368-102', 1, '2008-12-13 05:19:53', 6, NULL);
INSERT INTO `reserve`
VALUES (553, 'ISBN7-302-02368-108', 5, '2002-09-01 04:57:14', 9, NULL);
INSERT INTO `reserve`
VALUES (554, 'ISBN7-302-02368-106', 3, '2001-05-10 16:53:04', 9, NULL);
INSERT INTO `reserve`
VALUES (555, 'ISBN7-302-02368-108', 12, '2017-08-04 14:39:35', 7, NULL);
INSERT INTO `reserve`
VALUES (556, 'ISBN7-302-02368-101', 4, '2008-03-30 21:01:41', 6, NULL);
INSERT INTO `reserve`
VALUES (557, 'ISBN7-302-02368-107', 5, '2012-07-19 22:12:52', 2, NULL);
INSERT INTO `reserve`
VALUES (558, 'ISBN7-302-02368-103', 8, '2003-08-20 17:23:35', 2, NULL);
INSERT INTO `reserve`
VALUES (559, 'ISBN7-302-02368-108', 12, '2013-11-07 03:34:51', 3, NULL);
INSERT INTO `reserve`
VALUES (560, 'ISBN7-302-02368-101', 7, '2011-07-13 05:34:09', 4, NULL);
INSERT INTO `reserve`
VALUES (561, 'ISBN7-302-02368-101', 4, '2018-05-13 07:43:38', 3, NULL);
INSERT INTO `reserve`
VALUES (562, 'ISBN7-302-02368-101', 1, '2009-01-17 02:23:57', 2, NULL);
INSERT INTO `reserve`
VALUES (563, 'ISBN7-302-02368-105', 6, '2022-05-03 19:26:40', 10, NULL);
INSERT INTO `reserve`
VALUES (564, 'ISBN7-302-02368-106', 1, '2008-12-31 23:56:38', 4, NULL);
INSERT INTO `reserve`
VALUES (565, 'ISBN7-302-02368-108', 2, '2018-10-19 21:18:39', 8, NULL);
INSERT INTO `reserve`
VALUES (566, 'ISBN7-302-02368-101', 8, '2022-01-14 03:59:24', 6, NULL);
INSERT INTO `reserve`
VALUES (567, 'ISBN7-302-02368-102', 5, '2013-07-14 11:38:52', 3, NULL);
INSERT INTO `reserve`
VALUES (568, 'ISBN7-302-02368-109', 11, '2003-06-17 00:32:11', 1, NULL);
INSERT INTO `reserve`
VALUES (569, 'ISBN7-302-02368-101', 3, '2000-04-21 10:31:37', 2, NULL);
INSERT INTO `reserve`
VALUES (570, 'ISBN7-302-02368-109', 5, '2016-05-06 09:37:00', 6, NULL);
INSERT INTO `reserve`
VALUES (571, 'ISBN7-302-02368-105', 5, '2016-11-17 03:03:59', 4, NULL);
INSERT INTO `reserve`
VALUES (572, 'ISBN7-302-02368-106', 2, '2019-02-21 10:08:58', 5, NULL);
INSERT INTO `reserve`
VALUES (573, 'ISBN7-302-02368-106', 3, '2010-08-28 01:50:22', 2, NULL);
INSERT INTO `reserve`
VALUES (574, 'ISBN7-302-02368-102', 2, '2010-07-16 04:04:40', 3, NULL);
INSERT INTO `reserve`
VALUES (575, 'ISBN7-302-02368-103', 1, '2007-02-19 19:43:03', 6, NULL);
INSERT INTO `reserve`
VALUES (576, 'ISBN7-302-02368-109', 9, '2009-02-18 06:16:05', 9, NULL);
INSERT INTO `reserve`
VALUES (577, 'ISBN7-302-02368-109', 9, '2004-02-22 12:35:27', 4, NULL);
INSERT INTO `reserve`
VALUES (578, 'ISBN7-302-02368-107', 8, '2019-07-22 17:01:58', 8, NULL);
INSERT INTO `reserve`
VALUES (579, 'ISBN7-302-02368-103', 8, '2002-06-05 18:44:56', 7, NULL);
INSERT INTO `reserve`
VALUES (580, 'ISBN7-302-02368-104', 4, '2023-05-28 14:52:48', 4, NULL);
INSERT INTO `reserve`
VALUES (581, 'ISBN7-302-02368-104', 8, '2003-03-29 04:10:51', 1, NULL);
INSERT INTO `reserve`
VALUES (582, 'ISBN7-302-02368-108', 8, '2020-08-17 01:45:35', 4, NULL);
INSERT INTO `reserve`
VALUES (583, 'ISBN7-302-02368-100', 8, '2002-04-29 19:12:55', 6, NULL);
INSERT INTO `reserve`
VALUES (584, 'ISBN7-302-02368-102', 5, '2019-09-24 10:14:45', 4, NULL);
INSERT INTO `reserve`
VALUES (585, 'ISBN7-302-02368-104', 11, '2012-10-28 13:32:09', 6, NULL);
INSERT INTO `reserve`
VALUES (586, 'ISBN7-302-02368-104', 9, '2005-10-31 04:05:46', 2, NULL);
INSERT INTO `reserve`
VALUES (587, 'ISBN7-302-02368-100', 8, '2007-10-19 14:55:47', 5, NULL);
INSERT INTO `reserve`
VALUES (588, 'ISBN7-302-02368-100', 5, '2002-02-24 05:37:33', 4, NULL);
INSERT INTO `reserve`
VALUES (589, 'ISBN7-302-02368-100', 10, '2020-05-11 05:53:28', 7, NULL);
INSERT INTO `reserve`
VALUES (590, 'ISBN7-302-02368-105', 4, '2005-10-12 15:04:32', 4, NULL);
INSERT INTO `reserve`
VALUES (591, 'ISBN7-302-02368-106', 6, '2018-09-01 19:56:32', 1, NULL);
INSERT INTO `reserve`
VALUES (592, 'ISBN7-302-02368-102', 1, '2022-03-18 04:31:11', 5, NULL);
INSERT INTO `reserve`
VALUES (593, 'ISBN7-302-02368-104', 1, '2005-10-18 15:45:36', 4, NULL);
INSERT INTO `reserve`
VALUES (594, 'ISBN7-302-02368-103', 3, '2007-11-09 23:06:22', 1, NULL);
INSERT INTO `reserve`
VALUES (595, 'ISBN7-302-02368-100', 9, '2003-11-24 14:59:16', 8, NULL);
INSERT INTO `reserve`
VALUES (596, 'ISBN7-302-02368-105', 10, '2019-05-18 19:14:06', 8, NULL);
INSERT INTO `reserve`
VALUES (597, 'ISBN7-302-02368-102', 11, '2002-06-16 02:52:13', 5, NULL);
INSERT INTO `reserve`
VALUES (598, 'ISBN7-302-02368-105', 11, '2002-07-24 02:04:02', 9, NULL);
INSERT INTO `reserve`
VALUES (599, 'ISBN7-302-02368-104', 10, '2011-02-06 00:09:19', 9, NULL);
INSERT INTO `reserve`
VALUES (600, 'ISBN7-302-02368-100', 11, '2001-05-09 09:15:37', 4, NULL);
INSERT INTO `reserve`
VALUES (601, 'ISBN7-302-02368-106', 4, '2022-12-24 23:18:18', 8, NULL);
INSERT INTO `reserve`
VALUES (602, 'ISBN7-302-02368-103', 5, '2010-11-03 21:09:15', 4, NULL);
INSERT INTO `reserve`
VALUES (603, 'ISBN7-302-02368-103', 7, '2000-11-06 12:39:29', 3, NULL);
INSERT INTO `reserve`
VALUES (604, 'ISBN7-302-02368-100', 9, '2018-12-03 03:10:00', 3, NULL);
INSERT INTO `reserve`
VALUES (605, 'ISBN7-302-02368-103', 2, '2014-08-19 06:34:14', 6, NULL);
INSERT INTO `reserve`
VALUES (606, 'ISBN7-302-02368-108', 4, '2013-02-10 17:47:18', 2, NULL);
INSERT INTO `reserve`
VALUES (607, 'ISBN7-302-02368-106', 8, '2015-05-11 01:33:59', 7, NULL);
INSERT INTO `reserve`
VALUES (608, 'ISBN7-302-02368-106', 12, '2016-02-14 03:45:32', 10, NULL);
INSERT INTO `reserve`
VALUES (609, 'ISBN7-302-02368-101', 8, '2001-12-18 22:40:13', 4, NULL);
INSERT INTO `reserve`
VALUES (610, 'ISBN7-302-02368-103', 7, '2023-10-12 05:46:28', 1, NULL);
INSERT INTO `reserve`
VALUES (611, 'ISBN7-302-02368-104', 12, '2006-04-19 14:01:54', 7, NULL);
INSERT INTO `reserve`
VALUES (612, 'ISBN7-302-02368-105', 11, '2013-05-26 11:29:54', 7, NULL);
INSERT INTO `reserve`
VALUES (613, 'ISBN7-302-02368-107', 10, '2007-10-27 20:56:00', 7, NULL);
INSERT INTO `reserve`
VALUES (614, 'ISBN7-302-02368-102', 7, '2003-02-20 11:31:34', 4, NULL);
INSERT INTO `reserve`
VALUES (615, 'ISBN7-302-02368-107', 4, '2021-02-26 08:48:24', 2, NULL);
INSERT INTO `reserve`
VALUES (616, 'ISBN7-302-02368-104', 1, '2022-10-06 19:34:20', 9, NULL);
INSERT INTO `reserve`
VALUES (617, 'ISBN7-302-02368-103', 3, '2015-08-29 19:50:09', 6, NULL);
INSERT INTO `reserve`
VALUES (618, 'ISBN7-302-02368-105', 4, '2009-08-28 06:15:36', 9, NULL);
INSERT INTO `reserve`
VALUES (619, 'ISBN7-302-02368-102', 9, '2004-09-13 08:00:19', 6, NULL);
INSERT INTO `reserve`
VALUES (620, 'ISBN7-302-02368-105', 3, '2008-09-13 14:36:25', 1, NULL);
INSERT INTO `reserve`
VALUES (621, 'ISBN7-302-02368-109', 12, '2007-09-06 20:16:00', 3, NULL);
INSERT INTO `reserve`
VALUES (622, 'ISBN7-302-02368-109', 5, '2012-03-04 10:49:54', 6, NULL);
INSERT INTO `reserve`
VALUES (623, 'ISBN7-302-02368-103', 12, '2000-09-01 13:10:03', 4, NULL);
INSERT INTO `reserve`
VALUES (624, 'ISBN7-302-02368-105', 6, '2005-10-20 10:51:48', 3, NULL);
INSERT INTO `reserve`
VALUES (625, 'ISBN7-302-02368-105', 7, '2008-05-15 12:29:26', 7, NULL);
INSERT INTO `reserve`
VALUES (626, 'ISBN7-302-02368-105', 2, '2018-02-04 05:37:06', 1, NULL);
INSERT INTO `reserve`
VALUES (627, 'ISBN7-302-02368-105', 11, '2014-05-07 20:19:43', 2, NULL);
INSERT INTO `reserve`
VALUES (628, 'ISBN7-302-02368-107', 10, '2001-07-09 04:27:54', 4, NULL);
INSERT INTO `reserve`
VALUES (629, 'ISBN7-302-02368-107', 1, '2001-07-08 01:05:51', 3, NULL);
INSERT INTO `reserve`
VALUES (630, 'ISBN7-302-02368-109', 1, '2010-05-06 06:04:18', 9, NULL);
INSERT INTO `reserve`
VALUES (631, 'ISBN7-302-02368-106', 1, '2010-09-17 07:52:05', 8, NULL);
INSERT INTO `reserve`
VALUES (632, 'ISBN7-302-02368-108', 2, '2003-03-02 03:04:40', 4, NULL);
INSERT INTO `reserve`
VALUES (633, 'ISBN7-302-02368-107', 11, '2008-08-14 17:08:12', 9, NULL);
INSERT INTO `reserve`
VALUES (634, 'ISBN7-302-02368-109', 9, '2008-08-10 22:34:29', 6, NULL);
INSERT INTO `reserve`
VALUES (635, 'ISBN7-302-02368-103', 1, '2006-04-27 03:12:29', 1, NULL);
INSERT INTO `reserve`
VALUES (636, 'ISBN7-302-02368-108', 8, '2019-09-03 01:19:34', 2, NULL);
INSERT INTO `reserve`
VALUES (637, 'ISBN7-302-02368-109', 11, '2007-04-16 09:33:10', 2, NULL);
INSERT INTO `reserve`
VALUES (638, 'ISBN7-302-02368-103', 12, '2010-12-21 21:19:38', 6, NULL);
INSERT INTO `reserve`
VALUES (639, 'ISBN7-302-02368-104', 11, '2007-05-24 02:00:23', 3, NULL);
INSERT INTO `reserve`
VALUES (640, 'ISBN7-302-02368-109', 1, '2009-04-15 15:18:00', 6, NULL);
INSERT INTO `reserve`
VALUES (641, 'ISBN7-302-02368-102', 6, '2001-05-17 12:42:38', 9, NULL);
INSERT INTO `reserve`
VALUES (642, 'ISBN7-302-02368-104', 10, '2008-04-23 18:12:15', 2, NULL);
INSERT INTO `reserve`
VALUES (643, 'ISBN7-302-02368-102', 11, '2003-01-21 11:52:16', 5, NULL);
INSERT INTO `reserve`
VALUES (644, 'ISBN7-302-02368-103', 4, '2013-10-11 11:54:39', 6, NULL);
INSERT INTO `reserve`
VALUES (645, 'ISBN7-302-02368-108', 10, '2005-05-12 14:40:23', 7, NULL);
INSERT INTO `reserve`
VALUES (646, 'ISBN7-302-02368-106', 6, '2004-11-21 21:14:29', 6, NULL);
INSERT INTO `reserve`
VALUES (647, 'ISBN7-302-02368-101', 3, '2002-07-05 08:11:10', 3, NULL);
INSERT INTO `reserve`
VALUES (648, 'ISBN7-302-02368-104', 5, '2014-06-06 21:13:27', 4, NULL);
INSERT INTO `reserve`
VALUES (649, 'ISBN7-302-02368-105', 7, '2011-05-31 23:14:22', 5, NULL);
INSERT INTO `reserve`
VALUES (650, 'ISBN7-302-02368-107', 11, '2008-07-31 10:03:43', 4, NULL);
INSERT INTO `reserve`
VALUES (651, 'ISBN7-302-02368-109', 6, '2020-05-25 10:49:43', 2, NULL);
INSERT INTO `reserve`
VALUES (652, 'ISBN7-302-02368-102', 9, '2010-09-06 15:58:12', 2, NULL);
INSERT INTO `reserve`
VALUES (653, 'ISBN7-302-02368-108', 1, '2002-09-20 23:56:10', 8, NULL);
INSERT INTO `reserve`
VALUES (654, 'ISBN7-302-02368-101', 10, '2020-07-07 20:07:49', 7, NULL);
INSERT INTO `reserve`
VALUES (655, 'ISBN7-302-02368-101', 5, '2007-07-15 03:32:10', 6, NULL);
INSERT INTO `reserve`
VALUES (656, 'ISBN7-302-02368-103', 6, '2019-02-19 03:55:24', 6, NULL);
INSERT INTO `reserve`
VALUES (657, 'ISBN7-302-02368-104', 8, '2005-03-26 01:56:32', 7, NULL);
INSERT INTO `reserve`
VALUES (658, 'ISBN7-302-02368-107', 2, '2019-07-07 17:49:23', 6, NULL);
INSERT INTO `reserve`
VALUES (659, 'ISBN7-302-02368-102', 1, '2013-11-19 11:20:20', 2, NULL);
INSERT INTO `reserve`
VALUES (660, 'ISBN7-302-02368-102', 5, '2015-05-11 10:46:44', 2, NULL);
INSERT INTO `reserve`
VALUES (661, 'ISBN7-302-02368-103', 1, '2002-04-08 16:54:15', 6, NULL);
INSERT INTO `reserve`
VALUES (662, 'ISBN7-302-02368-104', 11, '2000-10-22 19:12:26', 2, NULL);
INSERT INTO `reserve`
VALUES (663, 'ISBN7-302-02368-109', 12, '2011-12-25 21:58:52', 5, NULL);
INSERT INTO `reserve`
VALUES (664, 'ISBN7-302-02368-100', 11, '2021-11-04 21:01:50', 7, NULL);
INSERT INTO `reserve`
VALUES (665, 'ISBN7-302-02368-106', 10, '2005-05-17 18:22:55', 5, NULL);
INSERT INTO `reserve`
VALUES (666, 'ISBN7-302-02368-102', 8, '2000-07-18 20:59:39', 3, NULL);
INSERT INTO `reserve`
VALUES (667, 'ISBN7-302-02368-102', 9, '2005-01-22 15:52:33', 8, NULL);
INSERT INTO `reserve`
VALUES (668, 'ISBN7-302-02368-107', 7, '2016-10-28 20:17:00', 10, NULL);
INSERT INTO `reserve`
VALUES (669, 'ISBN7-302-02368-109', 4, '2008-02-10 12:25:43', 9, NULL);
INSERT INTO `reserve`
VALUES (670, 'ISBN7-302-02368-109', 10, '2015-01-28 20:08:14', 5, NULL);
INSERT INTO `reserve`
VALUES (671, 'ISBN7-302-02368-104', 12, '2004-07-24 02:40:18', 7, NULL);
INSERT INTO `reserve`
VALUES (672, 'ISBN7-302-02368-107', 7, '2010-01-18 04:48:17', 3, NULL);
INSERT INTO `reserve`
VALUES (673, 'ISBN7-302-02368-104', 5, '2010-05-03 07:09:31', 5, NULL);
INSERT INTO `reserve`
VALUES (674, 'ISBN7-302-02368-100', 6, '2020-12-17 20:55:37', 7, NULL);
INSERT INTO `reserve`
VALUES (675, 'ISBN7-302-02368-101', 11, '2022-07-09 05:01:48', 9, NULL);
INSERT INTO `reserve`
VALUES (676, 'ISBN7-302-02368-107', 10, '2007-11-18 04:32:47', 2, NULL);
INSERT INTO `reserve`
VALUES (677, 'ISBN7-302-02368-103', 11, '2016-07-11 21:25:02', 8, NULL);
INSERT INTO `reserve`
VALUES (678, 'ISBN7-302-02368-104', 5, '2012-02-09 20:54:19', 2, NULL);
INSERT INTO `reserve`
VALUES (679, 'ISBN7-302-02368-102', 10, '2010-04-08 15:25:02', 2, NULL);
INSERT INTO `reserve`
VALUES (680, 'ISBN7-302-02368-103', 9, '2022-12-07 07:08:36', 6, NULL);
INSERT INTO `reserve`
VALUES (681, 'ISBN7-302-02368-103', 8, '2022-08-30 07:22:35', 10, NULL);
INSERT INTO `reserve`
VALUES (682, 'ISBN7-302-02368-100', 1, '2011-06-28 06:44:32', 7, NULL);
INSERT INTO `reserve`
VALUES (683, 'ISBN7-302-02368-106', 2, '2018-12-29 06:44:21', 6, NULL);
INSERT INTO `reserve`
VALUES (684, 'ISBN7-302-02368-108', 5, '2007-10-03 16:14:07', 2, NULL);
INSERT INTO `reserve`
VALUES (685, 'ISBN7-302-02368-101', 11, '2018-03-13 18:21:10', 9, NULL);
INSERT INTO `reserve`
VALUES (686, 'ISBN7-302-02368-107', 1, '2021-09-11 03:41:22', 10, NULL);
INSERT INTO `reserve`
VALUES (687, 'ISBN7-302-02368-104', 3, '2020-11-04 23:59:00', 4, NULL);
INSERT INTO `reserve`
VALUES (688, 'ISBN7-302-02368-108', 10, '2018-12-11 14:48:58', 6, NULL);
INSERT INTO `reserve`
VALUES (689, 'ISBN7-302-02368-105', 12, '2003-06-28 10:19:45', 7, NULL);
INSERT INTO `reserve`
VALUES (690, 'ISBN7-302-02368-103', 10, '2004-11-06 23:07:47', 6, NULL);
INSERT INTO `reserve`
VALUES (691, 'ISBN7-302-02368-102', 12, '2015-07-01 20:36:29', 2, NULL);
INSERT INTO `reserve`
VALUES (692, 'ISBN7-302-02368-109', 1, '2014-08-19 23:33:08', 5, NULL);
INSERT INTO `reserve`
VALUES (693, 'ISBN7-302-02368-105', 3, '2007-08-18 11:43:48', 10, NULL);
INSERT INTO `reserve`
VALUES (694, 'ISBN7-302-02368-105', 3, '2000-05-05 01:53:13', 8, NULL);
INSERT INTO `reserve`
VALUES (695, 'ISBN7-302-02368-109', 3, '2006-09-07 11:59:37', 7, NULL);
INSERT INTO `reserve`
VALUES (696, 'ISBN7-302-02368-107', 7, '2017-06-22 14:50:08', 9, NULL);
INSERT INTO `reserve`
VALUES (697, 'ISBN7-302-02368-104', 4, '2006-03-08 00:49:32', 2, NULL);
INSERT INTO `reserve`
VALUES (698, 'ISBN7-302-02368-108', 12, '2010-12-11 09:08:40', 6, NULL);
INSERT INTO `reserve`
VALUES (699, 'ISBN7-302-02368-106', 2, '2002-07-26 18:47:48', 10, NULL);
INSERT INTO `reserve`
VALUES (700, 'ISBN7-302-02368-103', 12, '2013-02-05 20:26:16', 9, NULL);
INSERT INTO `reserve`
VALUES (701, 'ISBN7-302-02368-100', 9, '2003-02-27 04:02:06', 10, NULL);
INSERT INTO `reserve`
VALUES (702, 'ISBN7-302-02368-107', 3, '2014-02-11 03:48:07', 2, NULL);
INSERT INTO `reserve`
VALUES (703, 'ISBN7-302-02368-102', 5, '2005-05-26 17:26:51', 8, NULL);
INSERT INTO `reserve`
VALUES (704, 'ISBN7-302-02368-108', 1, '2018-04-16 22:55:18', 3, NULL);
INSERT INTO `reserve`
VALUES (705, 'ISBN7-302-02368-109', 9, '2019-06-29 08:14:41', 7, NULL);
INSERT INTO `reserve`
VALUES (706, 'ISBN7-302-02368-107', 9, '2019-01-28 08:30:08', 4, NULL);
INSERT INTO `reserve`
VALUES (707, 'ISBN7-302-02368-107', 3, '2011-06-26 17:36:50', 3, NULL);
INSERT INTO `reserve`
VALUES (708, 'ISBN7-302-02368-101', 6, '2018-12-22 22:55:44', 8, NULL);
INSERT INTO `reserve`
VALUES (709, 'ISBN7-302-02368-102', 8, '2014-01-29 23:45:45', 1, NULL);
INSERT INTO `reserve`
VALUES (710, 'ISBN7-302-02368-108', 4, '2019-05-10 01:40:40', 5, NULL);
INSERT INTO `reserve`
VALUES (711, 'ISBN7-302-02368-106', 8, '2015-02-23 10:54:53', 4, NULL);
INSERT INTO `reserve`
VALUES (712, 'ISBN7-302-02368-100', 9, '2022-07-05 03:46:30', 8, NULL);
INSERT INTO `reserve`
VALUES (713, 'ISBN7-302-02368-107', 9, '2014-11-13 02:43:06', 8, NULL);
INSERT INTO `reserve`
VALUES (714, 'ISBN7-302-02368-107', 11, '2016-06-24 11:53:08', 6, NULL);
INSERT INTO `reserve`
VALUES (715, 'ISBN7-302-02368-102', 8, '2013-11-04 11:19:48', 10, NULL);
INSERT INTO `reserve`
VALUES (716, 'ISBN7-302-02368-108', 2, '2012-11-18 20:04:38', 7, NULL);
INSERT INTO `reserve`
VALUES (717, 'ISBN7-302-02368-104', 6, '2009-12-07 10:03:05', 7, NULL);
INSERT INTO `reserve`
VALUES (718, 'ISBN7-302-02368-102', 11, '2017-01-12 05:53:11', 2, NULL);
INSERT INTO `reserve`
VALUES (719, 'ISBN7-302-02368-109', 7, '2015-01-17 12:23:56', 6, NULL);
INSERT INTO `reserve`
VALUES (720, 'ISBN7-302-02368-107', 1, '2023-06-11 07:43:39', 3, NULL);
INSERT INTO `reserve`
VALUES (721, 'ISBN7-302-02368-108', 11, '2023-03-16 20:07:24', 6, NULL);
INSERT INTO `reserve`
VALUES (722, 'ISBN7-302-02368-100', 12, '2022-04-14 17:34:18', 4, NULL);
INSERT INTO `reserve`
VALUES (723, 'ISBN7-302-02368-102', 6, '2022-09-27 20:54:15', 9, NULL);
INSERT INTO `reserve`
VALUES (724, 'ISBN7-302-02368-102', 2, '2018-04-14 00:26:59', 8, NULL);
INSERT INTO `reserve`
VALUES (725, 'ISBN7-302-02368-104', 8, '2020-10-04 11:11:50', 2, NULL);
INSERT INTO `reserve`
VALUES (726, 'ISBN7-302-02368-107', 9, '2011-11-24 02:28:49', 6, NULL);
INSERT INTO `reserve`
VALUES (727, 'ISBN7-302-02368-101', 7, '2016-06-10 17:48:28', 6, NULL);
INSERT INTO `reserve`
VALUES (728, 'ISBN7-302-02368-101', 6, '2008-08-22 03:46:15', 9, NULL);
INSERT INTO `reserve`
VALUES (729, 'ISBN7-302-02368-102', 2, '2022-07-24 22:29:00', 6, NULL);
INSERT INTO `reserve`
VALUES (730, 'ISBN7-302-02368-103', 11, '2010-11-06 06:06:52', 3, NULL);
INSERT INTO `reserve`
VALUES (731, 'ISBN7-302-02368-105', 3, '2015-12-27 14:55:01', 6, NULL);
INSERT INTO `reserve`
VALUES (732, 'ISBN7-302-02368-100', 7, '2010-03-02 19:28:51', 5, NULL);
INSERT INTO `reserve`
VALUES (733, 'ISBN7-302-02368-100', 6, '2023-05-06 16:52:02', 9, NULL);
INSERT INTO `reserve`
VALUES (734, 'ISBN7-302-02368-106', 12, '2022-04-13 16:31:09', 6, NULL);
INSERT INTO `reserve`
VALUES (735, 'ISBN7-302-02368-109', 2, '2008-04-12 19:24:37', 3, NULL);
INSERT INTO `reserve`
VALUES (736, 'ISBN7-302-02368-103', 8, '2003-02-21 22:39:29', 4, NULL);
INSERT INTO `reserve`
VALUES (737, 'ISBN7-302-02368-103', 4, '2020-05-27 08:40:02', 5, NULL);
INSERT INTO `reserve`
VALUES (738, 'ISBN7-302-02368-103', 11, '2004-05-20 12:25:07', 3, NULL);
INSERT INTO `reserve`
VALUES (739, 'ISBN7-302-02368-107', 9, '2004-12-23 19:10:47', 6, NULL);
INSERT INTO `reserve`
VALUES (740, 'ISBN7-302-02368-108', 3, '2016-02-16 20:45:02', 3, NULL);
INSERT INTO `reserve`
VALUES (741, 'ISBN7-302-02368-107', 6, '2014-08-11 03:21:49', 5, NULL);
INSERT INTO `reserve`
VALUES (742, 'ISBN7-302-02368-108', 8, '2011-05-03 03:15:31', 8, NULL);
INSERT INTO `reserve`
VALUES (743, 'ISBN7-302-02368-109', 3, '2011-06-08 08:06:19', 2, NULL);
INSERT INTO `reserve`
VALUES (744, 'ISBN7-302-02368-104', 1, '2015-05-21 14:20:35', 5, NULL);
INSERT INTO `reserve`
VALUES (745, 'ISBN7-302-02368-106', 9, '2012-11-17 22:09:18', 1, NULL);
INSERT INTO `reserve`
VALUES (746, 'ISBN7-302-02368-107', 11, '2012-04-02 19:28:55', 5, NULL);
INSERT INTO `reserve`
VALUES (747, 'ISBN7-302-02368-104', 1, '2021-06-20 06:19:39', 10, NULL);
INSERT INTO `reserve`
VALUES (748, 'ISBN7-302-02368-100', 7, '2003-10-28 00:13:38', 2, NULL);
INSERT INTO `reserve`
VALUES (749, 'ISBN7-302-02368-104', 10, '2014-01-05 18:28:15', 8, NULL);
INSERT INTO `reserve`
VALUES (750, 'ISBN7-302-02368-105', 8, '2010-11-23 19:07:11', 2, NULL);
INSERT INTO `reserve`
VALUES (751, 'ISBN7-302-02368-101', 9, '2002-02-16 17:21:43', 3, NULL);
INSERT INTO `reserve`
VALUES (752, 'ISBN7-302-02368-100', 3, '2003-03-23 05:15:32', 7, NULL);
INSERT INTO `reserve`
VALUES (753, 'ISBN7-302-02368-107', 5, '2020-03-30 09:45:54', 6, NULL);
INSERT INTO `reserve`
VALUES (754, 'ISBN7-302-02368-109', 12, '2011-09-08 05:49:43', 3, NULL);
INSERT INTO `reserve`
VALUES (755, 'ISBN7-302-02368-108', 12, '2021-05-10 10:27:15', 9, NULL);
INSERT INTO `reserve`
VALUES (756, 'ISBN7-302-02368-107', 9, '2021-10-04 00:13:51', 4, NULL);
INSERT INTO `reserve`
VALUES (757, 'ISBN7-302-02368-101', 11, '2017-12-05 23:11:01', 7, NULL);
INSERT INTO `reserve`
VALUES (758, 'ISBN7-302-02368-101', 6, '2018-06-26 15:54:22', 8, NULL);
INSERT INTO `reserve`
VALUES (759, 'ISBN7-302-02368-108', 3, '2005-01-14 19:46:59', 3, NULL);
INSERT INTO `reserve`
VALUES (760, 'ISBN7-302-02368-106', 2, '2017-10-14 19:52:04', 3, NULL);
INSERT INTO `reserve`
VALUES (761, 'ISBN7-302-02368-101', 10, '2005-10-10 16:00:42', 2, NULL);
INSERT INTO `reserve`
VALUES (762, 'ISBN7-302-02368-107', 2, '2000-09-22 13:28:42', 4, NULL);
INSERT INTO `reserve`
VALUES (763, 'ISBN7-302-02368-107', 8, '2023-09-16 19:10:49', 8, NULL);
INSERT INTO `reserve`
VALUES (764, 'ISBN7-302-02368-102', 11, '2005-08-18 23:24:51', 6, NULL);
INSERT INTO `reserve`
VALUES (765, 'ISBN7-302-02368-105', 11, '2017-05-06 19:37:29', 3, NULL);
INSERT INTO `reserve`
VALUES (766, 'ISBN7-302-02368-104', 5, '2004-12-06 01:34:19', 5, NULL);
INSERT INTO `reserve`
VALUES (767, 'ISBN7-302-02368-105', 6, '2017-10-25 20:41:16', 6, NULL);
INSERT INTO `reserve`
VALUES (768, 'ISBN7-302-02368-102', 8, '2017-07-16 20:41:21', 4, NULL);
INSERT INTO `reserve`
VALUES (769, 'ISBN7-302-02368-108', 5, '2010-06-01 07:54:55', 9, NULL);
INSERT INTO `reserve`
VALUES (770, 'ISBN7-302-02368-103', 3, '2019-02-18 19:46:12', 9, NULL);
INSERT INTO `reserve`
VALUES (771, 'ISBN7-302-02368-105', 8, '2012-01-11 19:04:23', 6, NULL);
INSERT INTO `reserve`
VALUES (772, 'ISBN7-302-02368-107', 12, '2005-10-23 00:17:46', 7, NULL);
INSERT INTO `reserve`
VALUES (773, 'ISBN7-302-02368-109', 7, '2019-09-07 04:33:02', 9, NULL);
INSERT INTO `reserve`
VALUES (774, 'ISBN7-302-02368-101', 4, '2005-01-04 20:36:58', 5, NULL);
INSERT INTO `reserve`
VALUES (775, 'ISBN7-302-02368-109', 1, '2001-06-16 18:22:12', 1, NULL);
INSERT INTO `reserve`
VALUES (776, 'ISBN7-302-02368-100', 3, '2018-06-06 17:09:23', 10, NULL);
INSERT INTO `reserve`
VALUES (777, 'ISBN7-302-02368-101', 4, '2009-03-27 09:53:39', 7, NULL);
INSERT INTO `reserve`
VALUES (778, 'ISBN7-302-02368-104', 5, '2004-09-23 12:15:59', 3, NULL);
INSERT INTO `reserve`
VALUES (779, 'ISBN7-302-02368-106', 2, '2010-05-30 07:29:59', 8, NULL);
INSERT INTO `reserve`
VALUES (780, 'ISBN7-302-02368-107', 11, '2011-01-19 07:30:22', 10, NULL);
INSERT INTO `reserve`
VALUES (781, 'ISBN7-302-02368-109', 12, '2011-06-08 03:38:51', 6, NULL);
INSERT INTO `reserve`
VALUES (782, 'ISBN7-302-02368-101', 6, '2007-10-01 13:24:19', 7, NULL);
INSERT INTO `reserve`
VALUES (783, 'ISBN7-302-02368-109', 6, '2004-03-31 18:35:27', 10, NULL);
INSERT INTO `reserve`
VALUES (784, 'ISBN7-302-02368-102', 6, '2010-12-31 05:40:50', 9, NULL);
INSERT INTO `reserve`
VALUES (785, 'ISBN7-302-02368-104', 12, '2018-03-06 09:31:55', 6, NULL);
INSERT INTO `reserve`
VALUES (786, 'ISBN7-302-02368-101', 11, '2000-12-13 03:10:41', 4, NULL);
INSERT INTO `reserve`
VALUES (787, 'ISBN7-302-02368-109', 10, '2014-02-12 17:58:23', 7, NULL);
INSERT INTO `reserve`
VALUES (788, 'ISBN7-302-02368-104', 8, '2016-10-09 08:36:33', 1, NULL);
INSERT INTO `reserve`
VALUES (789, 'ISBN7-302-02368-103', 2, '2004-02-18 10:06:26', 4, NULL);
INSERT INTO `reserve`
VALUES (790, 'ISBN7-302-02368-102', 3, '2004-07-21 06:48:41', 9, NULL);
INSERT INTO `reserve`
VALUES (791, 'ISBN7-302-02368-107', 8, '2009-01-05 00:41:19', 10, NULL);
INSERT INTO `reserve`
VALUES (792, 'ISBN7-302-02368-109', 8, '2003-09-12 21:33:58', 8, NULL);
INSERT INTO `reserve`
VALUES (793, 'ISBN7-302-02368-100', 6, '2021-06-30 18:32:09', 7, NULL);
INSERT INTO `reserve`
VALUES (794, 'ISBN7-302-02368-109', 12, '2003-09-16 03:45:51', 6, NULL);
INSERT INTO `reserve`
VALUES (795, 'ISBN7-302-02368-107', 1, '2004-01-27 22:21:16', 4, NULL);
INSERT INTO `reserve`
VALUES (796, 'ISBN7-302-02368-109', 3, '2017-03-15 02:48:28', 4, NULL);
INSERT INTO `reserve`
VALUES (797, 'ISBN7-302-02368-101', 5, '2003-11-23 17:29:49', 3, NULL);
INSERT INTO `reserve`
VALUES (798, 'ISBN7-302-02368-102', 3, '2017-12-13 08:42:49', 9, NULL);
INSERT INTO `reserve`
VALUES (799, 'ISBN7-302-02368-107', 4, '2011-05-04 23:00:12', 6, NULL);
INSERT INTO `reserve`
VALUES (800, 'ISBN7-302-02368-107', 11, '2011-04-02 15:01:35', 5, NULL);
INSERT INTO `reserve`
VALUES (801, 'ISBN7-302-02368-104', 1, '2020-01-01 21:41:22', 6, NULL);
INSERT INTO `reserve`
VALUES (802, 'ISBN7-302-02368-104', 1, '2008-09-23 01:01:33', 8, NULL);
INSERT INTO `reserve`
VALUES (803, 'ISBN7-302-02368-107', 8, '2002-12-25 17:44:26', 8, NULL);
INSERT INTO `reserve`
VALUES (804, 'ISBN7-302-02368-109', 3, '2022-03-28 09:53:39', 10, NULL);
INSERT INTO `reserve`
VALUES (805, 'ISBN7-302-02368-104', 8, '2006-08-25 06:17:43', 4, NULL);
INSERT INTO `reserve`
VALUES (806, 'ISBN7-302-02368-107', 10, '2002-04-10 00:54:59', 6, NULL);
INSERT INTO `reserve`
VALUES (807, 'ISBN7-302-02368-104', 3, '2016-03-16 13:05:17', 9, NULL);
INSERT INTO `reserve`
VALUES (808, 'ISBN7-302-02368-108', 3, '2021-05-12 09:32:42', 8, NULL);
INSERT INTO `reserve`
VALUES (809, 'ISBN7-302-02368-108', 5, '2008-12-31 11:57:07', 6, NULL);
INSERT INTO `reserve`
VALUES (810, 'ISBN7-302-02368-109', 9, '2003-11-25 21:02:59', 7, NULL);
INSERT INTO `reserve`
VALUES (811, 'ISBN7-302-02368-109', 6, '2016-06-26 03:09:02', 7, NULL);
INSERT INTO `reserve`
VALUES (812, 'ISBN7-302-02368-104', 2, '2020-08-06 18:21:27', 9, NULL);
INSERT INTO `reserve`
VALUES (813, 'ISBN7-302-02368-104', 2, '2013-02-12 09:59:18', 5, NULL);
INSERT INTO `reserve`
VALUES (814, 'ISBN7-302-02368-101', 7, '2017-06-21 07:28:37', 1, NULL);
INSERT INTO `reserve`
VALUES (815, 'ISBN7-302-02368-108', 1, '2015-01-01 13:49:26', 4, NULL);
INSERT INTO `reserve`
VALUES (816, 'ISBN7-302-02368-108', 11, '2021-02-16 22:51:52', 8, NULL);
INSERT INTO `reserve`
VALUES (817, 'ISBN7-302-02368-106', 10, '2015-03-29 16:17:09', 3, NULL);
INSERT INTO `reserve`
VALUES (818, 'ISBN7-302-02368-104', 10, '2002-03-30 07:12:27', 8, NULL);
INSERT INTO `reserve`
VALUES (819, 'ISBN7-302-02368-100', 6, '2007-04-01 09:53:06', 7, NULL);
INSERT INTO `reserve`
VALUES (820, 'ISBN7-302-02368-107', 6, '2021-07-02 18:05:11', 3, NULL);
INSERT INTO `reserve`
VALUES (821, 'ISBN7-302-02368-101', 4, '2014-05-25 08:56:15', 2, NULL);
INSERT INTO `reserve`
VALUES (822, 'ISBN7-302-02368-102', 6, '2015-02-11 14:02:41', 6, NULL);
INSERT INTO `reserve`
VALUES (823, 'ISBN7-302-02368-102', 9, '2006-01-12 12:32:40', 9, NULL);
INSERT INTO `reserve`
VALUES (824, 'ISBN7-302-02368-102', 4, '2012-07-02 23:41:30', 4, NULL);
INSERT INTO `reserve`
VALUES (825, 'ISBN7-302-02368-105', 1, '2010-11-24 09:44:22', 4, NULL);
INSERT INTO `reserve`
VALUES (826, 'ISBN7-302-02368-101', 4, '2012-09-14 23:23:40', 8, NULL);
INSERT INTO `reserve`
VALUES (827, 'ISBN7-302-02368-105', 4, '2006-07-14 12:26:39', 4, NULL);
INSERT INTO `reserve`
VALUES (828, 'ISBN7-302-02368-103', 7, '2012-05-03 06:54:05', 2, NULL);
INSERT INTO `reserve`
VALUES (829, 'ISBN7-302-02368-101', 6, '2001-02-12 06:29:48', 7, NULL);
INSERT INTO `reserve`
VALUES (830, 'ISBN7-302-02368-105', 1, '2022-08-10 07:47:44', 7, NULL);
INSERT INTO `reserve`
VALUES (831, 'ISBN7-302-02368-106', 9, '2021-02-24 10:14:55', 6, NULL);
INSERT INTO `reserve`
VALUES (832, 'ISBN7-302-02368-101', 3, '2001-01-08 10:27:59', 4, NULL);
INSERT INTO `reserve`
VALUES (833, 'ISBN7-302-02368-109', 6, '2016-03-08 00:12:08', 4, NULL);
INSERT INTO `reserve`
VALUES (834, 'ISBN7-302-02368-109', 1, '2017-03-26 16:48:02', 4, NULL);
INSERT INTO `reserve`
VALUES (835, 'ISBN7-302-02368-109', 8, '2022-01-28 10:48:10', 8, NULL);
INSERT INTO `reserve`
VALUES (836, 'ISBN7-302-02368-109', 6, '2004-06-23 09:42:46', 2, NULL);
INSERT INTO `reserve`
VALUES (837, 'ISBN7-302-02368-103', 3, '2012-01-25 17:41:54', 9, NULL);
INSERT INTO `reserve`
VALUES (838, 'ISBN7-302-02368-106', 6, '2022-12-25 04:24:42', 6, NULL);
INSERT INTO `reserve`
VALUES (839, 'ISBN7-302-02368-109', 5, '2000-03-08 09:40:52', 4, NULL);
INSERT INTO `reserve`
VALUES (840, 'ISBN7-302-02368-103', 11, '2023-04-21 11:19:46', 1, NULL);
INSERT INTO `reserve`
VALUES (841, 'ISBN7-302-02368-101', 7, '2006-12-01 23:54:51', 1, NULL);
INSERT INTO `reserve`
VALUES (842, 'ISBN7-302-02368-107', 6, '2014-05-10 14:26:32', 6, NULL);
INSERT INTO `reserve`
VALUES (843, 'ISBN7-302-02368-109', 8, '2014-01-15 05:29:55', 6, NULL);
INSERT INTO `reserve`
VALUES (844, 'ISBN7-302-02368-104', 8, '2021-06-06 04:56:41', 8, NULL);
INSERT INTO `reserve`
VALUES (845, 'ISBN7-302-02368-106', 6, '2001-03-14 06:40:12', 9, NULL);
INSERT INTO `reserve`
VALUES (846, 'ISBN7-302-02368-108', 10, '2023-01-30 03:20:40', 4, NULL);
INSERT INTO `reserve`
VALUES (847, 'ISBN7-302-02368-102', 3, '2012-12-25 10:15:55', 5, NULL);
INSERT INTO `reserve`
VALUES (848, 'ISBN7-302-02368-101', 6, '2021-01-07 18:37:29', 9, NULL);
INSERT INTO `reserve`
VALUES (849, 'ISBN7-302-02368-101', 10, '2003-12-21 10:02:01', 3, NULL);
INSERT INTO `reserve`
VALUES (850, 'ISBN7-302-02368-102', 11, '2020-06-27 07:33:55', 4, NULL);
INSERT INTO `reserve`
VALUES (851, 'ISBN7-302-02368-106', 4, '2009-03-24 11:29:07', 8, NULL);
INSERT INTO `reserve`
VALUES (852, 'ISBN7-302-02368-100', 2, '2020-05-25 02:10:44', 1, NULL);
INSERT INTO `reserve`
VALUES (853, 'ISBN7-302-02368-108', 10, '2001-07-15 10:03:49', 3, NULL);
INSERT INTO `reserve`
VALUES (854, 'ISBN7-302-02368-106', 3, '2009-07-24 21:56:17', 1, NULL);
INSERT INTO `reserve`
VALUES (855, 'ISBN7-302-02368-104', 7, '2022-06-21 22:47:18', 8, NULL);
INSERT INTO `reserve`
VALUES (856, 'ISBN7-302-02368-107', 6, '2012-10-13 14:27:21', 3, NULL);
INSERT INTO `reserve`
VALUES (857, 'ISBN7-302-02368-107', 5, '2015-10-01 08:24:29', 10, NULL);
INSERT INTO `reserve`
VALUES (858, 'ISBN7-302-02368-104', 7, '2009-10-28 03:56:51', 1, NULL);
INSERT INTO `reserve`
VALUES (859, 'ISBN7-302-02368-105', 3, '2004-03-28 10:03:33', 7, NULL);
INSERT INTO `reserve`
VALUES (860, 'ISBN7-302-02368-106', 12, '2012-10-31 18:13:47', 3, NULL);
INSERT INTO `reserve`
VALUES (861, 'ISBN7-302-02368-101', 1, '2009-05-03 10:25:57', 10, NULL);
INSERT INTO `reserve`
VALUES (862, 'ISBN7-302-02368-109', 9, '2016-05-20 06:32:08', 7, NULL);
INSERT INTO `reserve`
VALUES (863, 'ISBN7-302-02368-105', 12, '2020-06-04 18:10:10', 5, NULL);
INSERT INTO `reserve`
VALUES (864, 'ISBN7-302-02368-103', 11, '2020-03-03 02:23:10', 2, NULL);
INSERT INTO `reserve`
VALUES (865, 'ISBN7-302-02368-104', 3, '2011-08-28 11:28:31', 2, NULL);
INSERT INTO `reserve`
VALUES (866, 'ISBN7-302-02368-106', 11, '2003-01-31 04:04:29', 7, NULL);
INSERT INTO `reserve`
VALUES (867, 'ISBN7-302-02368-102', 5, '2005-02-07 12:46:06', 4, NULL);
INSERT INTO `reserve`
VALUES (868, 'ISBN7-302-02368-105', 2, '2000-08-01 01:39:34', 8, NULL);
INSERT INTO `reserve`
VALUES (869, 'ISBN7-302-02368-106', 11, '2003-01-13 13:13:37', 9, NULL);
INSERT INTO `reserve`
VALUES (870, 'ISBN7-302-02368-105', 3, '2019-12-16 02:13:19', 10, NULL);
INSERT INTO `reserve`
VALUES (871, 'ISBN7-302-02368-101', 8, '2023-06-15 05:24:31', 9, NULL);
INSERT INTO `reserve`
VALUES (872, 'ISBN7-302-02368-108', 11, '2014-03-16 12:38:32', 2, NULL);
INSERT INTO `reserve`
VALUES (873, 'ISBN7-302-02368-109', 10, '2007-05-04 03:58:16', 10, NULL);
INSERT INTO `reserve`
VALUES (874, 'ISBN7-302-02368-104', 1, '2014-12-23 03:01:20', 9, NULL);
INSERT INTO `reserve`
VALUES (875, 'ISBN7-302-02368-103', 4, '2022-03-07 07:27:46', 10, NULL);
INSERT INTO `reserve`
VALUES (876, 'ISBN7-302-02368-101', 7, '2004-09-22 09:13:18', 9, NULL);
INSERT INTO `reserve`
VALUES (877, 'ISBN7-302-02368-106', 8, '2005-07-10 17:21:17', 1, NULL);
INSERT INTO `reserve`
VALUES (878, 'ISBN7-302-02368-107', 5, '2010-11-03 06:41:15', 4, NULL);
INSERT INTO `reserve`
VALUES (879, 'ISBN7-302-02368-105', 12, '2001-01-29 10:58:57', 2, NULL);
INSERT INTO `reserve`
VALUES (880, 'ISBN7-302-02368-109', 6, '2003-03-01 17:43:37', 2, NULL);
INSERT INTO `reserve`
VALUES (881, 'ISBN7-302-02368-106', 7, '2017-03-15 04:21:13', 9, NULL);
INSERT INTO `reserve`
VALUES (882, 'ISBN7-302-02368-108', 8, '2013-11-12 14:42:02', 6, NULL);
INSERT INTO `reserve`
VALUES (883, 'ISBN7-302-02368-107', 5, '2006-04-24 01:02:09', 9, NULL);
INSERT INTO `reserve`
VALUES (884, 'ISBN7-302-02368-104', 3, '2000-02-15 06:42:49', 9, NULL);
INSERT INTO `reserve`
VALUES (885, 'ISBN7-302-02368-109', 11, '2021-08-01 19:50:12', 5, NULL);
INSERT INTO `reserve`
VALUES (886, 'ISBN7-302-02368-106', 12, '2001-01-07 02:26:27', 5, NULL);
INSERT INTO `reserve`
VALUES (887, 'ISBN7-302-02368-101', 7, '2003-04-12 19:19:52', 2, NULL);
INSERT INTO `reserve`
VALUES (888, 'ISBN7-302-02368-107', 1, '2015-11-22 16:10:53', 4, NULL);
INSERT INTO `reserve`
VALUES (889, 'ISBN7-302-02368-101', 1, '2020-04-11 23:47:26', 3, NULL);
INSERT INTO `reserve`
VALUES (890, 'ISBN7-302-02368-101', 4, '2004-01-01 18:18:13', 7, NULL);
INSERT INTO `reserve`
VALUES (891, 'ISBN7-302-02368-106', 10, '2009-09-05 11:13:48', 4, NULL);
INSERT INTO `reserve`
VALUES (892, 'ISBN7-302-02368-109', 9, '2023-11-15 18:00:58', 10, NULL);
INSERT INTO `reserve`
VALUES (893, 'ISBN7-302-02368-104', 1, '2016-08-11 11:42:00', 7, NULL);
INSERT INTO `reserve`
VALUES (894, 'ISBN7-302-02368-104', 3, '2003-04-24 02:45:30', 5, NULL);
INSERT INTO `reserve`
VALUES (895, 'ISBN7-302-02368-105', 10, '2002-12-01 14:35:46', 5, NULL);
INSERT INTO `reserve`
VALUES (896, 'ISBN7-302-02368-102', 5, '2013-01-14 11:56:43', 9, NULL);
INSERT INTO `reserve`
VALUES (897, 'ISBN7-302-02368-100', 1, '2002-03-23 09:10:16', 8, NULL);
INSERT INTO `reserve`
VALUES (898, 'ISBN7-302-02368-103', 9, '2000-08-16 15:50:29', 3, NULL);
INSERT INTO `reserve`
VALUES (899, 'ISBN7-302-02368-102', 11, '2015-09-17 07:13:25', 8, NULL);
INSERT INTO `reserve`
VALUES (900, 'ISBN7-302-02368-104', 12, '2022-01-07 03:27:44', 7, NULL);
INSERT INTO `reserve`
VALUES (901, 'ISBN7-302-02368-100', 1, '2013-02-26 23:02:33', 8, NULL);
INSERT INTO `reserve`
VALUES (902, 'ISBN7-302-02368-104', 5, '2005-06-15 04:54:48', 5, NULL);
INSERT INTO `reserve`
VALUES (903, 'ISBN7-302-02368-101', 4, '2004-03-24 21:42:27', 7, NULL);
INSERT INTO `reserve`
VALUES (904, 'ISBN7-302-02368-107', 7, '2007-06-30 09:18:42', 1, NULL);
INSERT INTO `reserve`
VALUES (905, 'ISBN7-302-02368-103', 3, '2020-10-24 15:31:56', 1, NULL);
INSERT INTO `reserve`
VALUES (906, 'ISBN7-302-02368-101', 4, '2008-08-23 21:20:56', 1, NULL);
INSERT INTO `reserve`
VALUES (907, 'ISBN7-302-02368-107', 9, '2006-02-17 15:46:57', 7, NULL);
INSERT INTO `reserve`
VALUES (908, 'ISBN7-302-02368-105', 9, '2010-02-08 18:52:11', 6, NULL);
INSERT INTO `reserve`
VALUES (909, 'ISBN7-302-02368-108', 5, '2011-06-21 20:24:09', 3, NULL);
INSERT INTO `reserve`
VALUES (910, 'ISBN7-302-02368-103', 4, '2017-08-26 18:47:51', 6, NULL);
INSERT INTO `reserve`
VALUES (911, 'ISBN7-302-02368-106', 2, '2001-06-29 10:35:13', 5, NULL);
INSERT INTO `reserve`
VALUES (912, 'ISBN7-302-02368-102', 5, '2008-10-31 06:57:01', 6, NULL);
INSERT INTO `reserve`
VALUES (913, 'ISBN7-302-02368-104', 2, '2000-07-30 16:54:41', 7, NULL);
INSERT INTO `reserve`
VALUES (914, 'ISBN7-302-02368-109', 4, '2010-01-02 21:45:53', 8, NULL);
INSERT INTO `reserve`
VALUES (915, 'ISBN7-302-02368-107', 7, '2005-03-12 14:06:14', 3, NULL);
INSERT INTO `reserve`
VALUES (916, 'ISBN7-302-02368-100', 3, '2003-10-05 11:20:23', 2, NULL);
INSERT INTO `reserve`
VALUES (917, 'ISBN7-302-02368-101', 5, '2000-11-17 08:24:41', 6, NULL);
INSERT INTO `reserve`
VALUES (918, 'ISBN7-302-02368-101', 12, '2021-02-28 21:27:08', 2, NULL);
INSERT INTO `reserve`
VALUES (919, 'ISBN7-302-02368-105', 6, '2001-02-16 15:50:54', 3, NULL);
INSERT INTO `reserve`
VALUES (920, 'ISBN7-302-02368-105', 5, '2010-07-23 17:12:04', 5, NULL);
INSERT INTO `reserve`
VALUES (921, 'ISBN7-302-02368-108', 11, '2020-10-27 12:40:26', 10, NULL);
INSERT INTO `reserve`
VALUES (922, 'ISBN7-302-02368-105', 10, '2004-05-07 12:30:41', 9, NULL);
INSERT INTO `reserve`
VALUES (923, 'ISBN7-302-02368-102', 8, '2000-02-25 00:33:35', 2, NULL);
INSERT INTO `reserve`
VALUES (924, 'ISBN7-302-02368-106', 1, '2009-06-22 10:18:09', 4, NULL);
INSERT INTO `reserve`
VALUES (925, 'ISBN7-302-02368-109', 12, '2004-12-30 05:11:58', 4, NULL);
INSERT INTO `reserve`
VALUES (926, 'ISBN7-302-02368-104', 8, '2005-03-24 13:55:14', 8, NULL);
INSERT INTO `reserve`
VALUES (927, 'ISBN7-302-02368-105', 1, '2011-04-12 06:08:25', 4, NULL);
INSERT INTO `reserve`
VALUES (928, 'ISBN7-302-02368-107', 3, '2017-06-13 11:27:23', 6, NULL);
INSERT INTO `reserve`
VALUES (929, 'ISBN7-302-02368-109', 8, '2020-02-15 14:19:49', 2, NULL);
INSERT INTO `reserve`
VALUES (930, 'ISBN7-302-02368-101', 2, '2001-12-04 00:54:08', 9, NULL);
INSERT INTO `reserve`
VALUES (931, 'ISBN7-302-02368-100', 2, '2020-01-26 13:24:04', 4, NULL);
INSERT INTO `reserve`
VALUES (932, 'ISBN7-302-02368-107', 3, '2013-06-03 08:27:25', 3, NULL);
INSERT INTO `reserve`
VALUES (933, 'ISBN7-302-02368-101', 2, '2022-10-09 14:11:49', 9, NULL);
INSERT INTO `reserve`
VALUES (934, 'ISBN7-302-02368-105', 11, '2005-12-21 17:12:27', 9, NULL);
INSERT INTO `reserve`
VALUES (935, 'ISBN7-302-02368-101', 12, '2016-05-17 15:59:23', 9, NULL);
INSERT INTO `reserve`
VALUES (936, 'ISBN7-302-02368-104', 9, '2006-06-30 09:17:59', 6, NULL);
INSERT INTO `reserve`
VALUES (937, 'ISBN7-302-02368-103', 12, '2018-08-21 20:43:31', 8, NULL);
INSERT INTO `reserve`
VALUES (938, 'ISBN7-302-02368-104', 12, '2013-11-11 18:15:26', 5, NULL);
INSERT INTO `reserve`
VALUES (939, 'ISBN7-302-02368-108', 7, '2005-07-16 10:00:56', 7, NULL);
INSERT INTO `reserve`
VALUES (940, 'ISBN7-302-02368-107', 12, '2006-01-19 19:07:24', 3, NULL);
INSERT INTO `reserve`
VALUES (941, 'ISBN7-302-02368-101', 5, '2001-12-25 04:02:19', 10, NULL);
INSERT INTO `reserve`
VALUES (942, 'ISBN7-302-02368-101', 1, '2018-04-11 11:00:35', 7, NULL);
INSERT INTO `reserve`
VALUES (943, 'ISBN7-302-02368-100', 5, '2023-06-27 19:51:35', 4, NULL);
INSERT INTO `reserve`
VALUES (944, 'ISBN7-302-02368-109', 3, '2022-01-30 17:59:34', 3, NULL);
INSERT INTO `reserve`
VALUES (945, 'ISBN7-302-02368-102', 10, '2007-05-13 17:07:10', 5, NULL);
INSERT INTO `reserve`
VALUES (946, 'ISBN7-302-02368-103', 11, '2001-04-29 21:26:53', 8, NULL);
INSERT INTO `reserve`
VALUES (947, 'ISBN7-302-02368-109', 4, '2012-10-07 01:51:20', 8, NULL);
INSERT INTO `reserve`
VALUES (948, 'ISBN7-302-02368-100', 12, '2012-02-18 17:29:08', 5, NULL);
INSERT INTO `reserve`
VALUES (949, 'ISBN7-302-02368-107', 5, '2002-12-31 09:21:46', 9, NULL);
INSERT INTO `reserve`
VALUES (950, 'ISBN7-302-02368-106', 4, '2009-07-31 04:34:16', 5, NULL);
INSERT INTO `reserve`
VALUES (951, 'ISBN7-302-02368-107', 10, '2004-09-04 00:40:37', 2, NULL);
INSERT INTO `reserve`
VALUES (952, 'ISBN7-302-02368-104', 6, '2006-12-02 13:57:24', 7, NULL);
INSERT INTO `reserve`
VALUES (953, 'ISBN7-302-02368-106', 10, '2004-08-18 12:40:54', 6, NULL);
INSERT INTO `reserve`
VALUES (954, 'ISBN7-302-02368-107', 3, '2021-01-21 13:11:00', 10, NULL);
INSERT INTO `reserve`
VALUES (955, 'ISBN7-302-02368-106', 9, '2015-05-16 08:33:43', 6, NULL);
INSERT INTO `reserve`
VALUES (956, 'ISBN7-302-02368-109', 5, '2013-12-14 19:34:45', 3, NULL);
INSERT INTO `reserve`
VALUES (957, 'ISBN7-302-02368-106', 5, '2021-03-01 11:03:47', 8, NULL);
INSERT INTO `reserve`
VALUES (958, 'ISBN7-302-02368-107', 4, '2014-12-30 23:23:13', 4, NULL);
INSERT INTO `reserve`
VALUES (959, 'ISBN7-302-02368-106', 1, '2019-01-13 20:31:12', 5, NULL);
INSERT INTO `reserve`
VALUES (960, 'ISBN7-302-02368-109', 9, '2016-06-23 23:37:05', 6, NULL);
INSERT INTO `reserve`
VALUES (961, 'ISBN7-302-02368-101', 1, '2010-06-23 20:22:54', 2, NULL);
INSERT INTO `reserve`
VALUES (962, 'ISBN7-302-02368-108', 10, '2018-04-10 15:07:57', 10, NULL);
INSERT INTO `reserve`
VALUES (963, 'ISBN7-302-02368-108', 9, '2021-03-22 21:30:43', 5, NULL);
INSERT INTO `reserve`
VALUES (964, 'ISBN7-302-02368-101', 4, '2014-12-28 11:01:48', 3, NULL);
INSERT INTO `reserve`
VALUES (965, 'ISBN7-302-02368-106', 6, '2007-07-04 22:56:59', 5, NULL);
INSERT INTO `reserve`
VALUES (966, 'ISBN7-302-02368-106', 1, '2006-05-06 04:22:15', 6, NULL);
INSERT INTO `reserve`
VALUES (967, 'ISBN7-302-02368-100', 7, '2017-01-12 11:28:50', 6, NULL);
INSERT INTO `reserve`
VALUES (968, 'ISBN7-302-02368-100', 8, '2012-02-14 13:21:36', 2, NULL);
INSERT INTO `reserve`
VALUES (969, 'ISBN7-302-02368-106', 8, '2016-02-16 03:39:19', 8, NULL);
INSERT INTO `reserve`
VALUES (970, 'ISBN7-302-02368-103', 7, '2020-08-18 21:24:34', 6, NULL);
INSERT INTO `reserve`
VALUES (971, 'ISBN7-302-02368-108', 11, '2005-05-15 12:15:40', 6, NULL);
INSERT INTO `reserve`
VALUES (972, 'ISBN7-302-02368-103', 1, '2012-01-03 10:27:12', 5, NULL);
INSERT INTO `reserve`
VALUES (973, 'ISBN7-302-02368-103', 9, '2019-07-31 16:49:58', 6, NULL);
INSERT INTO `reserve`
VALUES (974, 'ISBN7-302-02368-106', 4, '2003-12-26 06:33:17', 8, NULL);
INSERT INTO `reserve`
VALUES (975, 'ISBN7-302-02368-105', 7, '2004-12-10 13:18:45', 6, NULL);
INSERT INTO `reserve`
VALUES (976, 'ISBN7-302-02368-102', 6, '2022-08-09 10:07:12', 7, NULL);
INSERT INTO `reserve`
VALUES (977, 'ISBN7-302-02368-108', 11, '2016-06-07 07:49:13', 10, NULL);
INSERT INTO `reserve`
VALUES (978, 'ISBN7-302-02368-101', 1, '2004-09-13 15:33:34', 4, NULL);
INSERT INTO `reserve`
VALUES (979, 'ISBN7-302-02368-107', 7, '2005-09-29 14:43:24', 6, NULL);
INSERT INTO `reserve`
VALUES (980, 'ISBN7-302-02368-101', 9, '2010-12-21 20:58:33', 10, NULL);
INSERT INTO `reserve`
VALUES (981, 'ISBN7-302-02368-104', 8, '2015-05-20 01:43:12', 3, NULL);
INSERT INTO `reserve`
VALUES (982, 'ISBN7-302-02368-105', 7, '2010-04-15 20:18:02', 5, NULL);
INSERT INTO `reserve`
VALUES (983, 'ISBN7-302-02368-100', 4, '2006-08-27 19:06:47', 5, NULL);
INSERT INTO `reserve`
VALUES (984, 'ISBN7-302-02368-102', 2, '2006-01-09 12:39:36', 2, NULL);
INSERT INTO `reserve`
VALUES (985, 'ISBN7-302-02368-103', 6, '2006-10-10 15:13:49', 2, NULL);
INSERT INTO `reserve`
VALUES (986, 'ISBN7-302-02368-101', 8, '2013-05-26 14:42:20', 4, NULL);
INSERT INTO `reserve`
VALUES (987, 'ISBN7-302-02368-107', 8, '2005-02-27 17:06:13', 8, NULL);
INSERT INTO `reserve`
VALUES (988, 'ISBN7-302-02368-102', 10, '2007-04-28 13:07:33', 6, NULL);
INSERT INTO `reserve`
VALUES (989, 'ISBN7-302-02368-105', 11, '2011-11-29 15:11:40', 8, NULL);
INSERT INTO `reserve`
VALUES (990, 'ISBN7-302-02368-103', 10, '2023-12-18 09:43:20', 6, NULL);
INSERT INTO `reserve`
VALUES (991, 'ISBN7-302-02368-104', 4, '2004-09-29 12:28:41', 7, NULL);
INSERT INTO `reserve`
VALUES (992, 'ISBN7-302-02368-108', 9, '2022-09-16 11:56:58', 1, NULL);
INSERT INTO `reserve`
VALUES (993, 'ISBN7-302-02368-102', 10, '2015-05-20 08:57:27', 7, NULL);
INSERT INTO `reserve`
VALUES (994, 'ISBN7-302-02368-107', 10, '2005-07-01 00:14:41', 7, NULL);
INSERT INTO `reserve`
VALUES (995, 'ISBN7-302-02368-103', 11, '2002-12-01 16:26:22', 7, NULL);
INSERT INTO `reserve`
VALUES (996, 'ISBN7-302-02368-107', 12, '2010-11-22 02:57:42', 3, NULL);
INSERT INTO `reserve`
VALUES (997, 'ISBN7-302-02368-106', 7, '2001-08-23 01:03:05', 9, NULL);
INSERT INTO `reserve`
VALUES (998, 'ISBN7-302-02368-106', 1, '2013-11-17 22:58:18', 5, NULL);
INSERT INTO `reserve`
VALUES (999, 'ISBN7-302-02368-108', 12, '2017-05-21 10:42:55', 6, NULL);
INSERT INTO `reserve`
VALUES (1000, 'ISBN7-302-02368-109', 10, '2021-12-01 13:45:19', 4, NULL);

# SET FOREIGN_KEY_CHECKS = 1;