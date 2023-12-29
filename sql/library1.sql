/*
 Navicat Premium Data Transfer

 Source Server         : chenxiang
 Source Server Type    : MySQL
 Source Server Version : 80034
 Source Host           : localhost:3306
 Source Schema         : library1

 Target Server Type    : MySQL
 Target Server Version : 80034
 File Encoding         : 65001

 Date: 22/12/2023 21:29:04
*/

create database library1;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`
(
    `book_id`  varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `ISBN`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `location` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `manager`  varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `status`   char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci     NULL DEFAULT NULL COMMENT '\n已借出,0;\n不外借,1;\n未借出,2;\n已预约,3.\n',
    PRIMARY KEY (`book_id`) USING BTREE,
    INDEX `index2` (`ISBN` ASC) USING BTREE,
    INDEX `index3` (`manager` ASC) USING BTREE INVISIBLE,
    CONSTRAINT `foreign1_book` FOREIGN KEY (`ISBN`) REFERENCES `booktable` (`ISBN`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `foreign2_book` FOREIGN KEY (`manager`) REFERENCES `manager` (`work_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT = '对于进入流通室的书，其初始状态为“未借出”，而送入阅览室的书的状态始终为“不外借”。'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------

-- ----------------------------
-- Table structure for booktable
-- ----------------------------
DROP TABLE IF EXISTS `booktable`;
CREATE TABLE `booktable`
(
    `ISBN`         varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `name`         varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `version`      varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `writer`       varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `publisher`    varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `publish_date` date                                                         NULL DEFAULT NULL,
    `price`        decimal(6, 2)                                                NULL DEFAULT NULL,
    `manager_by`   varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `num`          int                                                          NULL DEFAULT NULL,
    PRIMARY KEY (`ISBN`) USING BTREE,
    INDEX `index2` (`manager_by` ASC) USING BTREE,
    CONSTRAINT `foreign_booktable` FOREIGN KEY (`manager_by`) REFERENCES `manager` (`work_num`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of booktable
-- ----------------------------

-- ----------------------------
-- Table structure for lend_record
-- ----------------------------
DROP TABLE IF EXISTS `lend_record`;
CREATE TABLE `lend_record`
(
    `reader_id`   varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `book_id`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `ISBN`        varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `lend_time`   datetime                                                     NULL DEFAULT NULL COMMENT '借书时间',
    `return_time` datetime                                                     NULL DEFAULT NULL COMMENT '实际归还时间',
    `status`      int                                                          NULL DEFAULT NULL COMMENT '0  正常借走；\n1  逾期未还；',
    `due_time`    datetime                                                     NULL DEFAULT NULL COMMENT '应归还时间，每本图书最多只能借两个月',
    PRIMARY KEY (`reader_id`, `book_id`) USING BTREE,
    INDEX `index2` (`ISBN` ASC) USING BTREE INVISIBLE,
    INDEX `index3` (`reader_id` ASC) USING BTREE INVISIBLE,
    INDEX `index4` (`book_id` ASC) USING BTREE,
    CONSTRAINT `foreign_lend` FOREIGN KEY (`ISBN`) REFERENCES `booktable` (`ISBN`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lend_record
-- ----------------------------

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`
(
    `work_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `name`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    'password' varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    PRIMARY KEY (`work_num`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manager
-- ----------------------------

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`
(
    `reader_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NOT NULL,
    `book_id`   varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci  NOT NULL,
    `content`   varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `status`    int                                                           NULL DEFAULT NULL COMMENT '0,未读；\n1，已读；',
    PRIMARY KEY (`reader_id`, `book_id`) USING BTREE,
    INDEX `index2` (`reader_id` ASC) USING BTREE INVISIBLE,
    INDEX `index3` (`book_id` ASC) USING BTREE INVISIBLE,
    CONSTRAINT `foreign1_message` FOREIGN KEY (`reader_id`, `book_id`) REFERENCES `lend_record` (`reader_id`, `book_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT = '一旦其他读者归还这种书，就自动通知该预约读者。对于已到期且未归还的图书，系统通过Email自动通知读者；若读者预约的书已到，系统则自动通过Email通知该读者来办理借书手续。'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for reader
-- ----------------------------
DROP TABLE IF EXISTS `reader`;
CREATE TABLE `reader`
(
    `reader_id`  varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `name`       varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `password`   varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `email`      varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `phone`      varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
    `sex`        char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci     NULL DEFAULT NULL,
    `fine`       decimal(6, 2)                                                NULL DEFAULT NULL,
    `borrow_num` int                                                          NULL DEFAULT NULL COMMENT '一名读者最多只能借阅十本图书，且每本图书最多只能借两个月',
    PRIMARY KEY (`reader_id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reader
-- ----------------------------

-- ----------------------------
-- Table structure for reserve_record
-- ----------------------------
DROP TABLE IF EXISTS `reserve_record`;
CREATE TABLE `reserve_record`
(
    `reader_id`         varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `ISBN`              varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `reserve_book_id`   varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '系统同时自动查询预约登记表，若存在其他读者预约该书的记录，则将该图书的状态修改为“已预约”，并将该图书ID写入相应的预约记录中',
    `reserve_time`      datetime                                                     NULL DEFAULT NULL COMMENT '预约借书时间，如果借书时间大于当前时间的10天，则提示预约无效',
    `reserve_last_time` int                                                          NULL DEFAULT NULL COMMENT '预约期限（最长为10天）',
    `status`            int                                                          NULL DEFAULT NULL COMMENT '0，正常预约中；\n1，预约已失效。未在规定的日子借书，预约自动失效。',
    PRIMARY KEY (`reader_id`, `ISBN`) USING BTREE,
    INDEX `index2` (`ISBN` ASC) USING BTREE,
    INDEX `index3` (`reserve_book_id` ASC) USING BTREE INVISIBLE,
    CONSTRAINT `foreign1_reserve` FOREIGN KEY (`reader_id`) REFERENCES `reader` (`reader_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `foreign2_reserve` FOREIGN KEY (`ISBN`) REFERENCES `booktable` (`ISBN`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci COMMENT = '当某书目的可借出图书的数量为零时，读者可以对其进行预约登记，即记录读者ID、需要借阅的图书的ISBN号、预约时间。'
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reserve_record
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;


-- 插入书目信息
INSERT INTO booktable (name, writer, publisher, ISBN, publish_date, num, manager_by)
VALUES ('数据库原理', '王珊', '高等教育出版社', 'ISBN7-302-02368-100', '2000-05-01', 5, '0001'),
       ('计算机网络', '谢希仁', '清华大学出版社', 'ISBN7-302-02368-101', '2002-09-01', 3, '0001'),
       ('操作系统', '汤小丹', '电子工业出版社', 'ISBN7-302-02368-102', '2005-11-01', 6, '0001'),
       ('软件工程', '李云峰', '机械工业出版社', 'ISBN7-302-02368-103', '2008-03-01', 7, '0001'),
       ('算法导论', 'Thomas H. Cormen', '机械工业出版社', 'ISBN7-302-02368-104', '2010-06-01', 4, '0001'),
       ('人工智能', '周志华', '清华大学出版社', 'ISBN7-302-02368-105', '2013-08-01', 8, '0001'),
       ('计算机图形学', 'Hearn', '机械工业出版社', 'ISBN7-302-02368-106', '2016-02-01', 5, '0001'),
       ('数据挖掘', 'Ian H. Witten', '机械工业出版社', 'ISBN7-302-02368-107', '2018-04-01', 6, '0001'),
       ('计算机组成原理', 'David A. Patterson', '电子工业出版社', 'ISBN7-302-02368-108', '2021-07-01', 7, '0001'),
       ('计算机体系结构', '王爱民', '高等教育出版社', 'ISBN7-302-02368-109', '2023-09-01', 5, '0001');

-- 插入图书信息
INSERT INTO book (book_id, ISBN, location, status, manager)
VALUES ('C100.1', 'ISBN7-302-02368-100', '图书阅览室', '0', '0001'),
       ('C100.2', 'ISBN7-302-02368-100', '图书流通室', '1', '0001'),
       ('C100.3', 'ISBN7-302-02368-100', '图书流通室', '3', '0001'),
       ('C100.4', 'ISBN7-302-02368-100', '图书流通室', '0', '0001'),
       ('C100.5', 'ISBN7-302-02368-100', '图书流通室', '0', '0001'),
       ('C101.1', 'ISBN7-302-02368-101', '图书阅览室', '1', '0001'),
       ('C101.2', 'ISBN7-302-02368-101', '图书阅览室', '0', '0001'),
       ('C101.3', 'ISBN7-302-02368-101', '图书阅览室', '3', '0001'),
       ('C102.1', 'ISBN7-302-02368-102', '图书阅览室', '1', '0001'),
       ('C102.2', 'ISBN7-302-02368-102', '图书流通室', '0', '0001'),
       ('C102.3', 'ISBN7-302-02368-102', '图书阅览室', '2', '0001'),
       ('C102.4', 'ISBN7-302-02368-102', '图书流通室', '1', '0001'),
       ('C102.5', 'ISBN7-302-02368-102', '图书阅览室', '3', '0001'),
       ('C102.6', 'ISBN7-302-02368-102', '图书流通室', '0', '0001'),
       ('C103.1', 'ISBN7-302-02368-103', '图书阅览室', '2', '0001'),
       ('C103.2', 'ISBN7-302-02368-103', '图书阅览室', '1', '0001'),
       ('C103.3', 'ISBN7-302-02368-103', '图书流通室', '1', '0001'),
       ('C103.4', 'ISBN7-302-02368-103', '图书阅览室', '1', '0001'),
       ('C103.5', 'ISBN7-302-02368-103', '图书流通室', '0', '0001'),
       ('C103.6', 'ISBN7-302-02368-103', '图书流通室', '0', '0001'),
       ('C103.7', 'ISBN7-302-02368-103', '图书阅览室', '3', '0001'),
       ('C104.1', 'ISBN7-302-02368-104', '图书流通室', '3', '0001'),
       ('C104.2', 'ISBN7-302-02368-104', '图书流通室', '1', '0001'),
       ('C104.3', 'ISBN7-302-02368-104', '图书流通室', '3', '0001'),
       ('C104.4', 'ISBN7-302-02368-104', '图书阅览室', '2', '0001'),
       ('C105.1', 'ISBN7-302-02368-105', '图书流通室', '3', '0001'),
       ('C105.2', 'ISBN7-302-02368-105', '图书流通室', '0', '0001'),
       ('C105.3', 'ISBN7-302-02368-105', '图书流通室', '3', '0001'),
       ('C105.4', 'ISBN7-302-02368-105', '图书流通室', '0', '0001'),
       ('C105.5', 'ISBN7-302-02368-105', '图书流通室', '2', '0001'),
       ('C105.6', 'ISBN7-302-02368-105', '图书流通室', '1', '0001'),
       ('C105.7', 'ISBN7-302-02368-105', '图书流通室', '1', '0001'),
       ('C105.8', 'ISBN7-302-02368-105', '图书流通室', '1', '0001'),
       ('C106.1', 'ISBN7-302-02368-106', '图书阅览室', '1', '0001'),
       ('C106.2', 'ISBN7-302-02368-106', '图书流通室', '1', '0001'),
       ('C106.3', 'ISBN7-302-02368-106', '图书流通室', '3', '0001'),
       ('C106.4', 'ISBN7-302-02368-106', '图书流通室', '0', '0001'),
       ('C106.5', 'ISBN7-302-02368-106', '图书阅览室', '3', '0001'),
       ('C107.1', 'ISBN7-302-02368-107', '图书阅览室', '2', '0001'),
       ('C107.2', 'ISBN7-302-02368-107', '图书流通室', '1', '0001'),
       ('C107.3', 'ISBN7-302-02368-107', '图书阅览室', '2', '0001'),
       ('C107.4', 'ISBN7-302-02368-107', '图书流通室', '2', '0001'),
       ('C107.5', 'ISBN7-302-02368-107', '图书阅览室', '3', '0001'),
       ('C107.6', 'ISBN7-302-02368-107', '图书流通室', '0', '0001'),
       ('C108.1', 'ISBN7-302-02368-108', '图书阅览室', '1', '0001'),
       ('C108.2', 'ISBN7-302-02368-108', '图书阅览室', '3', '0001'),
       ('C108.3', 'ISBN7-302-02368-108', '图书阅览室', '1', '0001'),
       ('C108.4', 'ISBN7-302-02368-108', '图书流通室', '1', '0001'),
       ('C108.5', 'ISBN7-302-02368-108', '图书阅览室', '1', '0001'),
       ('C108.6', 'ISBN7-302-02368-108', '图书流通室', '0', '0001'),
       ('C108.7', 'ISBN7-302-02368-108', '图书流通室', '2', '0001'),
       ('C109.1', 'ISBN7-302-02368-109', '图书阅览室', '0', '0001'),
       ('C109.2', 'ISBN7-302-02368-109', '图书流通室', '2', '0001'),
       ('C109.3', 'ISBN7-302-02368-109', '图书流通室', '3', '0001'),
       ('C109.4', 'ISBN7-302-02368-109', '图书阅览室', '3', '0001'),
       ('C109.5', 'ISBN7-302-02368-109', '图书流通室', '0', '0001');