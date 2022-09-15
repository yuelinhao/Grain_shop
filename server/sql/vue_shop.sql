/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80018
 Source Host           : localhost:3306
 Source Schema         : vue_shop

 Target Server Type    : MySQL
 Target Server Version : 80018
 File Encoding         : 65001

 Date: 13/09/2022 21:38:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for b_user
-- ----------------------------
DROP TABLE IF EXISTS `b_user`;
CREATE TABLE `b_user`  (
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_acc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_pw` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `hx_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of b_user
-- ----------------------------
INSERT INTO `b_user` VALUES ('1661485044709', '666666', '666666', NULL);

-- ----------------------------
-- Table structure for client_messages
-- ----------------------------
DROP TABLE IF EXISTS `client_messages`;
CREATE TABLE `client_messages`  (
  `user_from` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_to` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_message` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `m_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `m_status` int(255) NULL DEFAULT 0,
  `client_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of client_messages
-- ----------------------------
INSERT INTO `client_messages` VALUES ('1111', '666666', '你好', '1662687627383', 1, '1662643630295');
INSERT INTO `client_messages` VALUES ('666666', '1111', '你好', '1662687652962', 0, 'undefined');
INSERT INTO `client_messages` VALUES ('1111', '666666', 'ghg', '1662689836464', 1, '1662643630295');
INSERT INTO `client_messages` VALUES ('666666', '1111', '11', '1662695230096', 0, 'undefined');
INSERT INTO `client_messages` VALUES ('1111', '666666', '下午好', '1662704100625', 1, '1662703283433');
INSERT INTO `client_messages` VALUES ('666666', '1111', '我回家了', '1662704128369', 0, 'undefined');
INSERT INTO `client_messages` VALUES ('1111', '666666', 'qq', '1662709105440', 1, '1662709035747');
INSERT INTO `client_messages` VALUES ('666666', '1111', '1111', '1662709119294', 0, 'undefined');
INSERT INTO `client_messages` VALUES ('666666', '1111', 'xia', '1662709806007', 0, 'undefined');

-- ----------------------------
-- Table structure for f_order
-- ----------------------------
DROP TABLE IF EXISTS `f_order`;
CREATE TABLE `f_order`  (
  `user_acc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `o_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `o_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `o_price` int(255) NULL DEFAULT NULL,
  `o_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_balance` int(255) NULL DEFAULT NULL,
  `g_sum` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_order
-- ----------------------------
INSERT INTO `f_order` VALUES ('1111', '1662629287333', '1662629287333', 15, '3', 12742, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662629410060', '1662629410060', 25, '3', 12492, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662630720700', '1662630720700', 15, '3', 12462, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662630776832', '1662630776832', 126, '2', 12292, '3', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662630943533', '1662630943533', 50, '3', 12192, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662631027463', '1662631027463', 60, '2', 12072, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662631173122', '1662631173122', 10, '2', 12052, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662631394835', '1662631394835', 10, '1', 12032, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662631614841', '1662631614841', 30, '2', 11972, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662631638576', '1662631638576', 96, '0', NULL, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662631644801', '1662631644801', 55, '0', NULL, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662635206238', '1662635206238', 55, '0', NULL, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662639819696', '1662639819696', 96, '3', 13188, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1', '1662639931681', '1662639931681', 20, '2', 11460, '2', '1', '1', '11');
INSERT INTO `f_order` VALUES ('0000', '1662639969116', '1662639969116', 60, '2', 1314401, '1', '2345', '345y', '234563456789');
INSERT INTO `f_order` VALUES ('1111', '1662643147826', '1662643147826', 10, '0', NULL, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662643250354', '1662643250354', 96, '2', 14096, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662643371957', '1662643371957', 145, '3', 13806, '7', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662686211046', '1662686211046', 15, '3', 13776, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662689613803', '1662689613803', 15, '2', 13946, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662689793562', '1662689793562', 15, '0', NULL, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662692417954', '1662692417954', 10, '0', NULL, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662694589626', '1662694589626', 20, '2', 13906, '2', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662708954698', '1662708954698', 20, '1', 13866, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662709174040', '1662709174040', 20, '1', 13826, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662709191222', '1662709191222', 20, '0', NULL, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');
INSERT INTO `f_order` VALUES ('1111', '1662709286118', '1662709286118', 25, '1', 13776, '1', '刘嘉敏', '1234567890', '河南省郑州市量子矩阵科技');

-- ----------------------------
-- Table structure for f_user
-- ----------------------------
DROP TABLE IF EXISTS `f_user`;
CREATE TABLE `f_user`  (
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_acc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_pw` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `hx_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_user
-- ----------------------------
INSERT INTO `f_user` VALUES ('1662548721904', '1111', '��g�jGXB�fpκ', NULL);
INSERT INTO `f_user` VALUES ('1662636703426', '1', '��B8��#�\r�P�ou��', NULL);
INSERT INTO `f_user` VALUES ('1662638917260', '0000', 'J}�GN@3�)̸e=�', NULL);

-- ----------------------------
-- Table structure for f_user_info
-- ----------------------------
DROP TABLE IF EXISTS `f_user_info`;
CREATE TABLE `f_user_info`  (
  `user_acc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_address_name` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_money` int(255) NULL DEFAULT 0,
  `user_integral` int(255) NULL DEFAULT 0,
  `user_collect` int(255) NULL DEFAULT 0,
  `user_phone2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_ress2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `more_address2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of f_user_info
-- ----------------------------
INSERT INTO `f_user_info` VALUES ('1111', '1662709035747', '1111', '111111111', '李锋', '女', 15776, 1743, 1, '123456098765', '法国海军', '地方撒国四条回答一句废话吗v法国海军的各部分的VS从');
INSERT INTO `f_user_info` VALUES ('1', '1662639190742', '※', '111', '12', '男', 66666, 20, 0, '12', '12', '12');
INSERT INTO `f_user_info` VALUES ('0000', '1662639064500', '帅小伙', '1234567890', '2345', '男', 1314401, 60, 0, '345y', '23456', '3456789');

-- ----------------------------
-- Table structure for g_collects
-- ----------------------------
DROP TABLE IF EXISTS `g_collects`;
CREATE TABLE `g_collects`  (
  `user_acc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `g_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of g_collects
-- ----------------------------
INSERT INTO `g_collects` VALUES ('1111', '鲁王高筋粉');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `goods_id` int(255) NOT NULL AUTO_INCREMENT,
  `g_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `g_size` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `g_price` int(255) NULL DEFAULT NULL,
  `g_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `g_num` int(255) NULL DEFAULT NULL,
  `g_sell` int(255) NULL DEFAULT 0,
  `g_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `g_bianhao` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `g_img_xinxi` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isCollect` int(255) NULL DEFAULT 0,
  PRIMARY KEY (`goods_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, '北大荒有机面粉', '2.5', 15, '精致特一粉', 100, 12, '1662550282867', '75', '1662550282867', 0);
INSERT INTO `goods` VALUES (2, '金福强高筋小麦粉', '10', 50, '精致特一粉', 99, 3, '1662550677196', '116', '1662550677196', 0);
INSERT INTO `goods` VALUES (3, '金沙河雪花粉', '5', 60, '精致特一粉', 88, 2, '1662550870673', '73', '1662550870673', 0);
INSERT INTO `goods` VALUES (4, '自发小麦粉', '0.9', 10, '精致特一粉', 100, 0, '1662551011596', '96', '1662551011596', 0);
INSERT INTO `goods` VALUES (5, '麦纯富强粉', '5', 30, '精致特一粉', 100, 2, '1662551137363', '104', '1662551137363', 0);
INSERT INTO `goods` VALUES (6, '多用途小麦粉', '5', 36, '精致特一粉', 99, 2, '1662551244830', '93', '1662551244830', 0);
INSERT INTO `goods` VALUES (7, '新良蛋糕粉', '0.5', 5, '精致特一粉', 66, 0, '1662551338710', '128', '1662551338710', 0);
INSERT INTO `goods` VALUES (8, '低筋小麦粉', '2.5', 18, '精致特一粉', 88, 0, '1662551426526', '98', '1662551426526', 0);
INSERT INTO `goods` VALUES (9, '麦芯饺子用小麦粉', '5', 60, '精致特一粉', 100, 2, '1662551509964', '122', '1662551509964', 0);
INSERT INTO `goods` VALUES (10, '香满园优质小麦粉', '10', 99, '精致特一粉', 60, 0, '1662552021819', '230021', '1662552021819', 0);
INSERT INTO `goods` VALUES (11, '鲁王高筋粉', '2.5', 25, '原粮', 66, 14, '1662552196839', '230316', '1662552196839', 1);
INSERT INTO `goods` VALUES (12, '金龙鱼麦芯粉', '10', 96, '原粮', 56, 3, '1662552342321', '230542', '1662552342321', 0);
INSERT INTO `goods` VALUES (15, '香雪麦纯面粉', '5', 55, '原粮', 89, 1, '1662552743941', '58', '1662552743941', 0);
INSERT INTO `goods` VALUES (16, '自发小麦粉大包装', '5', 65, '原粮', 78, 0, '1662552979823', '58', '1662552979823', 0);
INSERT INTO `goods` VALUES (17, '中筋小麦粉', '2.5', 20, '原粮', 88, 3, '1662553071080', '91', '1662553071080', 0);
INSERT INTO `goods` VALUES (18, '想念小麦粉', '5', 66, '原粮', 55, 0, '1662554056570', '73', '1662554056570', 0);
INSERT INTO `goods` VALUES (21, '亲民有机面粉', '2.5', 36, '优质特一粉', 99, 0, '1662554420396', '83', '1662554420396', 0);
INSERT INTO `goods` VALUES (22, '风筝小麦粉', '2.5', 46, '优质特一粉', 100, 0, '1662554675865', '102', '1662554675865', 0);
INSERT INTO `goods` VALUES (23, '幸福小麦粉', '5', 45, '优质特一粉', 87, 0, '1662554855052', '105', '1662554855052', 0);
INSERT INTO `goods` VALUES (24, '高筋麦芯小麦粉', '10', 99, '优质特一粉', 99, 2, '1662554925878', '116', '1662554925878', 0);
INSERT INTO `goods` VALUES (25, '通用雪花粉', '5', 99, '优质特一粉', 99, 0, '1662555038854', '111', '1662555038854', 0);
INSERT INTO `goods` VALUES (26, '鲁王高筋粉2', '2.5', 20, '优质特一粉', 66, 0, '1662555150577', '105', '1662555150577', 0);
INSERT INTO `goods` VALUES (27, '五得利小麦粉', '10', 96, '优质特一粉', 69, 0, '1662555312519', '90', '1662555312519', 0);
INSERT INTO `goods` VALUES (28, '自发小麦粉2', '2.5', 39, '优质特一粉', 56, 0, '1662555386156', '105', '1662555386156', 0);
INSERT INTO `goods` VALUES (29, '优质小麦粉', '10', 199, '优质特一粉', 100, 0, '1662555473877', '133', '1662555473877', 0);
INSERT INTO `goods` VALUES (30, '麦纯富强粉2', '5', 67, '优质特一粉', 87, 0, '1662555594730', '136', '1662555594730', 0);
INSERT INTO `goods` VALUES (31, '北大荒有机面粉2', '2.5', 15, '小包装', 100, 0, '1662550282867', '75', '1662550282867', 0);
INSERT INTO `goods` VALUES (32, '金福强高筋小麦粉2', '10', 50, '小包装', 99, 0, '1662550677196', '116', '1662550677196', 0);
INSERT INTO `goods` VALUES (33, '金沙河雪花粉2', '5', 60, '小包装', 88, 0, '1662550870673', '73', '1662550870673', 0);
INSERT INTO `goods` VALUES (34, '自发小麦粉5', '0.9', 10, '小包装', 100, 0, '1662551011596', '96', '1662551011596', 0);
INSERT INTO `goods` VALUES (35, '麦纯富强粉4', '5', 30, '小包装', 100, 0, '1662551137363', '104', '1662551137363', 0);
INSERT INTO `goods` VALUES (36, '多用途小麦粉2', '5', 36, '小包装', 99, 0, '1662551244830', '93', '1662551244830', 0);
INSERT INTO `goods` VALUES (37, '新良蛋糕粉2', '0.5', 5, '小包装', 66, 1, '1662551338710', '128', '1662551338710', 0);
INSERT INTO `goods` VALUES (38, '低筋小麦粉2', '2.5', 18, '小包装', 88, 0, '1662551426526', '98', '1662551426526', 0);
INSERT INTO `goods` VALUES (39, '麦芯饺子用小麦粉2', '5', 60, '小包装', 100, 0, '1662551509964', '122', '1662551509964', 0);
INSERT INTO `goods` VALUES (40, '香满园优质小麦粉2', '10', 99, '小包装', 60, 0, '1662552021819', '230021', '1662552021819', 0);
INSERT INTO `goods` VALUES (41, '鲁王高筋粉3', '2.5', 25, '标准粉', 66, 2, '1662552196839', '230316', '1662552196839', 0);
INSERT INTO `goods` VALUES (42, '金龙鱼麦芯粉2', '10', 96, '标准粉', 56, 0, '1662552342321', '230542', '1662552342321', 0);
INSERT INTO `goods` VALUES (45, '香雪麦纯面粉2', '5', 55, '标准粉', 89, 0, '1662552743941', '58', '1662552743941', 0);
INSERT INTO `goods` VALUES (46, '自发小麦粉大包装2', '5', 65, '标准粉', 78, 0, '1662552979823', '58', '1662552979823', 0);
INSERT INTO `goods` VALUES (47, '中筋小麦粉2', '2.5', 20, '标准粉', 88, 0, '1662553071080', '91', '1662553071080', 0);
INSERT INTO `goods` VALUES (48, '想念小麦粉2', '5', 66, '标准粉', 55, 0, '1662554056570', '73', '1662554056570', 0);
INSERT INTO `goods` VALUES (51, '亲民有机面粉2', '2.5', 36, '普通粉', 99, 0, '1662554420396', '83', '1662554420396', 0);
INSERT INTO `goods` VALUES (52, '风筝小麦粉2', '2.5', 46, '普通粉', 100, 0, '1662554675865', '102', '1662554675865', 0);
INSERT INTO `goods` VALUES (53, '幸福小麦粉2', '5', 45, '普通粉', 87, 0, '1662554855052', '105', '1662554855052', 0);
INSERT INTO `goods` VALUES (54, '高筋麦芯小麦粉2', '10', 99, '普通粉', 99, 0, '1662554925878', '116', '1662554925878', 0);
INSERT INTO `goods` VALUES (55, '通用雪花粉2', '5', 99, '普通粉', 99, 0, '1662555038854', '111', '1662555038854', 0);
INSERT INTO `goods` VALUES (56, '鲁王高筋粉4', '2.5', 20, '普通粉', 66, 0, '1662555150577', '105', '1662555150577', 0);
INSERT INTO `goods` VALUES (57, '五得利小麦粉2', '10', 96, '普通粉', 69, 0, '1662555312519', '90', '1662555312519', 0);
INSERT INTO `goods` VALUES (58, '自发小麦粉3', '2.5', 39, '普通粉', 56, 2, '1662555386156', '105', '1662555386156', 0);
INSERT INTO `goods` VALUES (59, '优质小麦粉2', '10', 199, '普通粉', 100, 0, '1662555473877', '133', '1662555473877', 0);
INSERT INTO `goods` VALUES (60, '麦纯富强粉3', '5', 67, '普通粉', 87, 0, '1662555594730', '136', '1662555594730', 0);
INSERT INTO `goods` VALUES (61, '北大荒有机面粉3', '2.5', 15, '次粉', 100, 0, '1662550282867', '75', '1662550282867', 0);
INSERT INTO `goods` VALUES (62, '金福强高筋小麦粉3', '10', 50, '次粉', 99, 0, '1662550677196', '116', '1662550677196', 0);
INSERT INTO `goods` VALUES (63, '金沙河雪花粉3', '5', 60, '次粉', 88, 0, '1662550870673', '73', '1662550870673', 0);
INSERT INTO `goods` VALUES (64, '自发小麦粉4', '0.9', 10, '次粉', 100, 0, '1662551011596', '96', '1662551011596', 0);
INSERT INTO `goods` VALUES (65, '麦纯富强粉5', '5', 30, '次粉', 100, 0, '1662551137363', '104', '1662551137363', 0);
INSERT INTO `goods` VALUES (66, '多用途小麦粉3', '5', 36, '次粉', 99, 0, '1662551244830', '93', '1662551244830', 0);
INSERT INTO `goods` VALUES (67, '新良蛋糕粉3', '0.5', 5, '次粉', 66, 0, '1662551338710', '128', '1662551338710', 0);
INSERT INTO `goods` VALUES (68, '低筋小麦粉3', '2.5', 18, '次粉', 88, 1, '1662551426526', '98', '1662551426526', 0);
INSERT INTO `goods` VALUES (69, '麦芯饺子用小麦粉3', '5', 60, '次粉', 100, 0, '1662551509964', '122', '1662551509964', 0);
INSERT INTO `goods` VALUES (70, '香满园优质小麦粉3', '10', 99, '次粉', 60, 0, '1662552021819', '230021', '1662552021819', 0);
INSERT INTO `goods` VALUES (71, '鲁王高筋粉5', '2.5', 25, '麸皮', 66, 0, '1662552196839', '230316', '1662552196839', 0);
INSERT INTO `goods` VALUES (72, '金龙鱼麦芯粉3', '10', 96, '麸皮', 56, 0, '1662552342321', '230542', '1662552342321', 0);
INSERT INTO `goods` VALUES (75, '香雪麦纯面粉3', '5', 55, '麸皮', 89, 0, '1662552743941', '58', '1662552743941', 0);
INSERT INTO `goods` VALUES (76, '自发小麦粉大包装3', '5', 65, '麸皮', 78, 0, '1662552979823', '58', '1662552979823', 0);
INSERT INTO `goods` VALUES (77, '中筋小麦粉3', '2.5', 20, '麸皮', 88, 1, '1662553071080', '91', '1662553071080', 0);
INSERT INTO `goods` VALUES (78, '想念小麦粉3', '5', 66, '麸皮', 55, 0, '1662554056570', '73', '1662554056570', 0);

-- ----------------------------
-- Table structure for goods_imgs
-- ----------------------------
DROP TABLE IF EXISTS `goods_imgs`;
CREATE TABLE `goods_imgs`  (
  `g_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `g_img_lun` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods_imgs
-- ----------------------------
INSERT INTO `goods_imgs` VALUES ('北大荒有机面粉', '1662550282837');
INSERT INTO `goods_imgs` VALUES ('北大荒有机面粉', '1662550282844');
INSERT INTO `goods_imgs` VALUES ('北大荒有机面粉', '1662550282847');
INSERT INTO `goods_imgs` VALUES ('北大荒有机面粉', '1662550282852');
INSERT INTO `goods_imgs` VALUES ('金福强高筋小麦粉', '1662550677194');
INSERT INTO `goods_imgs` VALUES ('金福强高筋小麦粉', '1662550677195');
INSERT INTO `goods_imgs` VALUES ('金福强高筋小麦粉', '1662550677196');
INSERT INTO `goods_imgs` VALUES ('金福强高筋小麦粉', '1662550677199');
INSERT INTO `goods_imgs` VALUES ('金沙河雪花粉', '1662550870658');
INSERT INTO `goods_imgs` VALUES ('金沙河雪花粉', '1662550870663');
INSERT INTO `goods_imgs` VALUES ('金沙河雪花粉', '1662550870665');
INSERT INTO `goods_imgs` VALUES ('金沙河雪花粉', '1662550870667');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉', '1662551011590');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉', '1662551011593');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉', '1662551011598');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉', '1662551011600');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉', '1662551137360');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉', '1662551137361');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉', '1662551137363');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉', '1662551137367');
INSERT INTO `goods_imgs` VALUES ('多用途小麦粉', '1662551199110');
INSERT INTO `goods_imgs` VALUES ('多用途小麦粉', '1662551199114');
INSERT INTO `goods_imgs` VALUES ('多用途小麦粉', '1662551199116');
INSERT INTO `goods_imgs` VALUES ('多用途小麦粉', '1662551199119');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉', '1662551338700');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉', '1662551338700');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉', '1662551338702');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉', '1662551338703');
INSERT INTO `goods_imgs` VALUES ('低筋小麦粉', '1662551426509');
INSERT INTO `goods_imgs` VALUES ('低筋小麦粉', '1662551426515');
INSERT INTO `goods_imgs` VALUES ('低筋小麦粉', '1662551426521');
INSERT INTO `goods_imgs` VALUES ('低筋小麦粉', '1662551426524');
INSERT INTO `goods_imgs` VALUES ('麦芯饺子用小麦粉', '1662551509965');
INSERT INTO `goods_imgs` VALUES ('麦芯饺子用小麦粉', '1662551509967');
INSERT INTO `goods_imgs` VALUES ('香满园优质小麦粉', '1662552021810');
INSERT INTO `goods_imgs` VALUES ('香满园优质小麦粉', '1662552021813');
INSERT INTO `goods_imgs` VALUES ('香满园优质小麦粉', '1662552021813');
INSERT INTO `goods_imgs` VALUES ('香满园优质小麦粉', '1662552021816');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉', '1662552196837');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉', '1662552196837');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉', '1662552196842');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉', '1662552196846');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉5', '1662552979816');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉4', '1662552979817');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉4', '1662552979826');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉4', '1662552979827');
INSERT INTO `goods_imgs` VALUES ('中筋小麦粉', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('中筋小麦粉', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('中筋小麦粉', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('中筋小麦粉', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉2', '1662555150578');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉2', '1662555150579');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉2', '1662555150580');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉2', '1662555150584');
INSERT INTO `goods_imgs` VALUES ('五得利小麦粉', '1662555312518');
INSERT INTO `goods_imgs` VALUES ('五得利小麦粉', '1662555312518');
INSERT INTO `goods_imgs` VALUES ('五得利小麦粉', '1662555312519');
INSERT INTO `goods_imgs` VALUES ('五得利小麦粉', '1662555312523');
INSERT INTO `goods_imgs` VALUES ('优质小麦粉', '1662555473868');
INSERT INTO `goods_imgs` VALUES ('优质小麦粉', '1662555473869');
INSERT INTO `goods_imgs` VALUES ('优质小麦粉', '1662555473871');
INSERT INTO `goods_imgs` VALUES ('优质小麦粉', '1662555473875');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉4', '1662555588981');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉4', '1662555588983');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉4', '1662555588984');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉4', '1662555588987');
INSERT INTO `goods_imgs` VALUES ('金龙鱼麦芯粉', '1662551509957');
INSERT INTO `goods_imgs` VALUES ('金龙鱼麦芯粉', '1662551509965');
INSERT INTO `goods_imgs` VALUES ('金龙鱼麦芯粉', '1662551509967');
INSERT INTO `goods_imgs` VALUES ('金龙鱼麦芯粉', '1662551509956');
INSERT INTO `goods_imgs` VALUES ('麦芯饺子用小麦粉', '1662551509956');
INSERT INTO `goods_imgs` VALUES ('福临门小麦粉', '1662551338702');
INSERT INTO `goods_imgs` VALUES ('福临门小麦粉', '1662551338703');
INSERT INTO `goods_imgs` VALUES ('福临门小麦粉', '1662551338700');
INSERT INTO `goods_imgs` VALUES ('福临门小麦粉', '1662551338700');
INSERT INTO `goods_imgs` VALUES ('有机面粉', '1662551199114');
INSERT INTO `goods_imgs` VALUES ('有机面粉', '1662551199116');
INSERT INTO `goods_imgs` VALUES ('有机面粉', '1662551199119');
INSERT INTO `goods_imgs` VALUES ('有机面粉', '1662551199110');
INSERT INTO `goods_imgs` VALUES ('香雪麦纯面粉', '1662551137361');
INSERT INTO `goods_imgs` VALUES ('香雪麦纯面粉', '1662551137363');
INSERT INTO `goods_imgs` VALUES ('香雪麦纯面粉', '1662551137367');
INSERT INTO `goods_imgs` VALUES ('香雪麦纯面粉', '1662551137360');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉大包装', '1662551011593');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉大包装', '1662551011598');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉大包装', '1662551011600');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉大包装', '1662551011590');
INSERT INTO `goods_imgs` VALUES ('想念小麦粉', '1662551199114');
INSERT INTO `goods_imgs` VALUES ('想念小麦粉', '1662551199116');
INSERT INTO `goods_imgs` VALUES ('想念小麦粉', '1662551199119');
INSERT INTO `goods_imgs` VALUES ('想念小麦粉', '1662551199110');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉大包装', '1662551338702');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉大包装', '1662551338703');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉大包装', '1662551338700');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉大包装', '1662551338700');
INSERT INTO `goods_imgs` VALUES ('金富强高筋小麦粉', '1662551509957');
INSERT INTO `goods_imgs` VALUES ('金富强高筋小麦粉', '1662551509965');
INSERT INTO `goods_imgs` VALUES ('金富强高筋小麦粉', '1662551509967');
INSERT INTO `goods_imgs` VALUES ('金富强高筋小麦粉', '1662551509956');
INSERT INTO `goods_imgs` VALUES ('亲民有机面粉', '1662551199114');
INSERT INTO `goods_imgs` VALUES ('亲民有机面粉', '1662551199116');
INSERT INTO `goods_imgs` VALUES ('亲民有机面粉', '1662551199119');
INSERT INTO `goods_imgs` VALUES ('亲民有机面粉', '1662551199110');
INSERT INTO `goods_imgs` VALUES ('风筝小麦粉', '1662551199114');
INSERT INTO `goods_imgs` VALUES ('风筝小麦粉', '1662551199116');
INSERT INTO `goods_imgs` VALUES ('风筝小麦粉', '1662551199119');
INSERT INTO `goods_imgs` VALUES ('风筝小麦粉', '1662551199110');
INSERT INTO `goods_imgs` VALUES ('幸福小麦粉', '1662551011593');
INSERT INTO `goods_imgs` VALUES ('幸福小麦粉', '1662551011598');
INSERT INTO `goods_imgs` VALUES ('幸福小麦粉', '1662551011600');
INSERT INTO `goods_imgs` VALUES ('幸福小麦粉', '1662551011590');
INSERT INTO `goods_imgs` VALUES ('高筋麦芯小麦粉', '1662551011593');
INSERT INTO `goods_imgs` VALUES ('高筋麦芯小麦粉', '1662551011598');
INSERT INTO `goods_imgs` VALUES ('高筋麦芯小麦粉', '1662551011600');
INSERT INTO `goods_imgs` VALUES ('高筋麦芯小麦粉', '1662551011590');
INSERT INTO `goods_imgs` VALUES ('通用雪花粉', '1662550677195');
INSERT INTO `goods_imgs` VALUES ('通用雪花粉', '1662550677196');
INSERT INTO `goods_imgs` VALUES ('通用雪花粉', '1662550677199');
INSERT INTO `goods_imgs` VALUES ('通用雪花粉', '1662550677194');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉3', '1662552196842');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉3', '1662552196846');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉3', '1662552196837');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉3', '1662552196837');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉2', '1662550677195');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉2', '1662550677196');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉2', '1662550677199');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉2', '1662550677194');
INSERT INTO `goods_imgs` VALUES ('北大荒有机面粉2', '1662550282844');
INSERT INTO `goods_imgs` VALUES ('北大荒有机面粉2', '1662550282847');
INSERT INTO `goods_imgs` VALUES ('北大荒有机面粉2', '1662550282852');
INSERT INTO `goods_imgs` VALUES ('北大荒有机面粉2', '1662550282837');
INSERT INTO `goods_imgs` VALUES ('金福强高筋小麦粉2', '1662550677195');
INSERT INTO `goods_imgs` VALUES ('金福强高筋小麦粉2', '1662550677196');
INSERT INTO `goods_imgs` VALUES ('金福强高筋小麦粉2', '1662550677199');
INSERT INTO `goods_imgs` VALUES ('金福强高筋小麦粉2', '1662550677194');
INSERT INTO `goods_imgs` VALUES ('金沙河雪花粉2', '1662550870663');
INSERT INTO `goods_imgs` VALUES ('金沙河雪花粉2', '1662550870665');
INSERT INTO `goods_imgs` VALUES ('金沙河雪花粉2', '1662550870667');
INSERT INTO `goods_imgs` VALUES ('金沙河雪花粉2', '1662550870658');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉2', '1662551011593');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉2', '1662551011598');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉2', '1662551011600');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉2', '1662551011590');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉5', '1662551137361');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉5', '1662551137363');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉5', '1662551137367');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉5', '1662551137360');
INSERT INTO `goods_imgs` VALUES ('多用途小麦粉2', '1662551199114');
INSERT INTO `goods_imgs` VALUES ('多用途小麦粉2', '1662551199116');
INSERT INTO `goods_imgs` VALUES ('多用途小麦粉2', '1662551199119');
INSERT INTO `goods_imgs` VALUES ('多用途小麦粉2', '1662551199110');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉2', '1662551338702');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉2', '1662551338703');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉2', '1662551338700');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉2', '1662551338700');
INSERT INTO `goods_imgs` VALUES ('低筋小麦粉2', '1662551426515');
INSERT INTO `goods_imgs` VALUES ('低筋小麦粉2', '1662551426521');
INSERT INTO `goods_imgs` VALUES ('低筋小麦粉2', '1662551426524');
INSERT INTO `goods_imgs` VALUES ('低筋小麦粉2', '1662551426509');
INSERT INTO `goods_imgs` VALUES ('麦芯饺子用小麦粉', '1662551509967');
INSERT INTO `goods_imgs` VALUES ('麦芯饺子用小麦粉2', '1662551509957');
INSERT INTO `goods_imgs` VALUES ('麦芯饺子用小麦粉2', '1662551509965');
INSERT INTO `goods_imgs` VALUES ('麦芯饺子用小麦粉2', '1662551509967');
INSERT INTO `goods_imgs` VALUES ('麦芯饺子用小麦粉2', '1662551509967');
INSERT INTO `goods_imgs` VALUES ('香满园优质小麦粉2', '1662552021810');
INSERT INTO `goods_imgs` VALUES ('香满园优质小麦粉2', '1662552021813');
INSERT INTO `goods_imgs` VALUES ('香满园优质小麦粉2', '1662552021813');
INSERT INTO `goods_imgs` VALUES ('香满园优质小麦粉2', '1662552021816');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉5', '1662552196837');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉5', '1662552196837');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉5', '1662552196842');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉5', '1662552196846');
INSERT INTO `goods_imgs` VALUES ('金龙鱼麦芯粉2', '1662552342322');
INSERT INTO `goods_imgs` VALUES ('金龙鱼麦芯粉2', '1662552342322');
INSERT INTO `goods_imgs` VALUES ('金龙鱼麦芯粉2', '1662552342324');
INSERT INTO `goods_imgs` VALUES ('金龙鱼麦芯粉2', '1662552342325');
INSERT INTO `goods_imgs` VALUES ('福临门小麦粉2', '1662552430567');
INSERT INTO `goods_imgs` VALUES ('福临门小麦粉2', '1662552430567');
INSERT INTO `goods_imgs` VALUES ('福临门小麦粉2', '1662552430571');
INSERT INTO `goods_imgs` VALUES ('福临门小麦粉2', '1662552430574');
INSERT INTO `goods_imgs` VALUES ('有机面粉2', '1662552529109');
INSERT INTO `goods_imgs` VALUES ('有机面粉2', '1662552529113');
INSERT INTO `goods_imgs` VALUES ('有机面粉2', '1662552529114');
INSERT INTO `goods_imgs` VALUES ('有机面粉2', '1662552529117');
INSERT INTO `goods_imgs` VALUES ('香雪麦纯面粉2', '1662552743932');
INSERT INTO `goods_imgs` VALUES ('香雪麦纯面粉2', '1662552743932');
INSERT INTO `goods_imgs` VALUES ('香雪麦纯面粉2', '1662552743935');
INSERT INTO `goods_imgs` VALUES ('香雪麦纯面粉2', '1662552743944');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉大包装2', '1662552979816');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉大包装2', '1662552979817');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉大包装2', '1662552979826');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉大包装2', '1662552979827');
INSERT INTO `goods_imgs` VALUES ('中筋小麦粉2', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('中筋小麦粉2', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('中筋小麦粉2', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('中筋小麦粉2', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('想念小麦粉2', '1662554056574');
INSERT INTO `goods_imgs` VALUES ('想念小麦粉2', '1662554056574');
INSERT INTO `goods_imgs` VALUES ('想念小麦粉2', '1662554056577');
INSERT INTO `goods_imgs` VALUES ('想念小麦粉2', '1662554056590');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉大包装2', '1662554155061');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉大包装2', '1662554155062');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉大包装2', '1662554155063');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉大包装2', '1662554155063');
INSERT INTO `goods_imgs` VALUES ('金富强高筋小麦粉2', '1662554266263');
INSERT INTO `goods_imgs` VALUES ('金富强高筋小麦粉2', '1662554266264');
INSERT INTO `goods_imgs` VALUES ('金富强高筋小麦粉2', '1662554266264');
INSERT INTO `goods_imgs` VALUES ('金富强高筋小麦粉2', '1662554266268');
INSERT INTO `goods_imgs` VALUES ('亲民有机面粉2', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('亲民有机面粉2', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('亲民有机面粉2', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('亲民有机面粉2', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('风筝小麦粉2', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('风筝小麦粉2', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('风筝小麦粉2', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('风筝小麦粉2', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('幸福小麦粉2', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('幸福小麦粉2', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('幸福小麦粉2', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('幸福小麦粉2', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('高筋麦芯小麦粉2', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('高筋麦芯小麦粉2', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('高筋麦芯小麦粉2', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('高筋麦芯小麦粉2', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('通用雪花粉2', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('通用雪花粉2', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('通用雪花粉2', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('通用雪花粉2', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉4', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉4', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉4', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('鲁王高筋粉4', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('五得利小麦粉2', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('五得利小麦粉2', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('五得利小麦粉2', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('五得利小麦粉2', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('优质小麦粉2', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('优质小麦粉2', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('优质小麦粉2', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('优质小麦粉2', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('麦纯富强粉3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('多用途小麦粉3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('多用途小麦粉3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('多用途小麦粉3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('多用途小麦粉3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('低筋小麦粉3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('低筋小麦粉3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('低筋小麦粉3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('低筋小麦粉3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('麦芯饺子用小麦粉3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('麦芯饺子用小麦粉3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('麦芯饺子用小麦粉3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('麦芯饺子用小麦粉3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('香满园优质小麦粉3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('香满园优质小麦粉3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('香满园优质小麦粉3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('香满园优质小麦粉3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('金龙鱼麦芯粉3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('金龙鱼麦芯粉3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('金龙鱼麦芯粉3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('金龙鱼麦芯粉3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('福临门小麦粉3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('福临门小麦粉3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('福临门小麦粉3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('福临门小麦粉3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('有机面粉3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('有机面粉3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('有机面粉3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('有机面粉3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('香雪麦纯面粉3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('香雪麦纯面粉3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('香雪麦纯面粉3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('香雪麦纯面粉3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉大包装3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉大包装3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉大包装3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉大包装3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('中筋小麦粉3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('中筋小麦粉3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('中筋小麦粉3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('中筋小麦粉3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('想念小麦粉3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('想念小麦粉3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('想念小麦粉3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('想念小麦粉3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉大包装3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉大包装3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉大包装3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('新良蛋糕粉大包装3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('金富强高筋小麦粉3', '1662553071066');
INSERT INTO `goods_imgs` VALUES ('金富强高筋小麦粉3', '1662553071072');
INSERT INTO `goods_imgs` VALUES ('金富强高筋小麦粉3', '1662553071074');
INSERT INTO `goods_imgs` VALUES ('金富强高筋小麦粉3', '1662553071076');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉5', '1662552979816');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉5', '1662552979816');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉5', '1662552979816');
INSERT INTO `goods_imgs` VALUES ('自发小麦粉4', '1662552979816');
INSERT INTO `goods_imgs` VALUES ('', '1662709716536');
INSERT INTO `goods_imgs` VALUES ('', '1662709717067');

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `o_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `g_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `g_number` int(255) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES ('1662629190405', '鲁王高筋粉', 1);
INSERT INTO `order_detail` VALUES ('1662629287333', '北大荒有机面粉', 1);
INSERT INTO `order_detail` VALUES ('1662629410060', '鲁王高筋粉', 1);
INSERT INTO `order_detail` VALUES ('1662630720700', '北大荒有机面粉', 1);
INSERT INTO `order_detail` VALUES ('1662630776832', '麦纯富强粉', 1);
INSERT INTO `order_detail` VALUES ('1662630776832', '多用途小麦粉', 1);
INSERT INTO `order_detail` VALUES ('1662630776832', '麦芯饺子用小麦粉', 1);
INSERT INTO `order_detail` VALUES ('1662630943533', '金福强高筋小麦粉', 1);
INSERT INTO `order_detail` VALUES ('1662631027463', '金沙河雪花粉', 1);
INSERT INTO `order_detail` VALUES ('1662631173122', '有机面粉', 1);
INSERT INTO `order_detail` VALUES ('1662631394835', '有机面粉', 1);
INSERT INTO `order_detail` VALUES ('1662631614841', '福临门小麦粉', 1);
INSERT INTO `order_detail` VALUES ('1662631638576', '金龙鱼麦芯粉', 1);
INSERT INTO `order_detail` VALUES ('1662631644801', '香雪麦纯面粉', 1);
INSERT INTO `order_detail` VALUES ('1662635206238', '香雪麦纯面粉', 1);
INSERT INTO `order_detail` VALUES ('1662639819696', '金龙鱼麦芯粉', 1);
INSERT INTO `order_detail` VALUES ('1662639931681', '有机面粉', 2);
INSERT INTO `order_detail` VALUES ('1662639969116', '金沙河雪花粉', 1);
INSERT INTO `order_detail` VALUES ('1662643147826', '有机面粉', 1);
INSERT INTO `order_detail` VALUES ('1662643250354', '金龙鱼麦芯粉', 1);
INSERT INTO `order_detail` VALUES ('1662643371957', '有机面粉', 2);
INSERT INTO `order_detail` VALUES ('1662643371957', '香雪麦纯面粉', 1);
INSERT INTO `order_detail` VALUES ('1662643371957', '中筋小麦粉', 1);
INSERT INTO `order_detail` VALUES ('1662643371957', '新良蛋糕粉2', 1);
INSERT INTO `order_detail` VALUES ('1662643371957', '鲁王高筋粉3', 1);
INSERT INTO `order_detail` VALUES ('1662643371957', '中筋小麦粉3', 1);
INSERT INTO `order_detail` VALUES ('1662686211046', '北大荒有机面粉', 1);
INSERT INTO `order_detail` VALUES ('1662689613803', '北大荒有机面粉', 1);
INSERT INTO `order_detail` VALUES ('1662689793562', '北大荒有机面粉', 1);
INSERT INTO `order_detail` VALUES ('1662692417954', '有机面粉', 1);
INSERT INTO `order_detail` VALUES ('1662694589626', '有机面粉', 2);
INSERT INTO `order_detail` VALUES ('1662708954698', '中筋小麦粉', 1);
INSERT INTO `order_detail` VALUES ('1662709174040', '中筋小麦粉', 1);
INSERT INTO `order_detail` VALUES ('1662709191222', '中筋小麦粉', 1);
INSERT INTO `order_detail` VALUES ('1662709286118', '鲁王高筋粉', 1);

-- ----------------------------
-- Table structure for pay_pw
-- ----------------------------
DROP TABLE IF EXISTS `pay_pw`;
CREATE TABLE `pay_pw`  (
  `user_acc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_pay_pw` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_pw
-- ----------------------------
INSERT INTO `pay_pw` VALUES ('1111', '111111');

-- ----------------------------
-- Table structure for search_history
-- ----------------------------
DROP TABLE IF EXISTS `search_history`;
CREATE TABLE `search_history`  (
  `user_acc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `history` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of search_history
-- ----------------------------
INSERT INTO `search_history` VALUES ('1111', '北大荒有机面粉');
INSERT INTO `search_history` VALUES ('1111', '金福强高筋小麦粉');
INSERT INTO `search_history` VALUES ('1111', '中筋小麦粉');
INSERT INTO `search_history` VALUES ('1111', '五得利小麦粉');
INSERT INTO `search_history` VALUES ('123', '金沙河雪花粉2');
INSERT INTO `search_history` VALUES ('123', '北大荒有机面粉');
INSERT INTO `search_history` VALUES ('123', '金福强高筋小麦粉');
INSERT INTO `search_history` VALUES ('1', '北大荒有机面粉');
INSERT INTO `search_history` VALUES ('1111', '鲁王高筋粉');
INSERT INTO `search_history` VALUES ('1111', '有机面粉');
INSERT INTO `search_history` VALUES ('1111', '香雪麦纯面粉2');

-- ----------------------------
-- Table structure for shop_car
-- ----------------------------
DROP TABLE IF EXISTS `shop_car`;
CREATE TABLE `shop_car`  (
  `user_acc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `g_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `g_number` int(255) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop_car
-- ----------------------------
INSERT INTO `shop_car` VALUES ('1', '金龙鱼麦芯粉', 1);
INSERT INTO `shop_car` VALUES ('1111', '新良蛋糕粉', 1);

-- ----------------------------
-- Table structure for user_address
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address`  (
  `address_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_acc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_ress` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `more_address` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_name2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_phone3` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(255) NULL DEFAULT 0
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_address
-- ----------------------------
INSERT INTO `user_address` VALUES ('1662535361', '1111', '河南省郑州市', '量子矩阵科技', '刘嘉敏', '1234567890', 0);
INSERT INTO `user_address` VALUES ('1662554120', '1111', '微软体育', '是东方帝国海军航空就来看看了', '崔飞玉', '12345678', 0);
INSERT INTO `user_address` VALUES ('1662555169', '1111', '法国海军', '地方撒国四条回答一句废话吗v法国海军的各部分的VS从', '李锋', '123456098765', 0);
INSERT INTO `user_address` VALUES ('1662558577', '1111', '鳗鱼饭', '我惹我天热怀疑他', '王宇', '1234567890', 0);
INSERT INTO `user_address` VALUES ('1662639029', '0000', '23456', '3456789', '2345', '345y', 0);
INSERT INTO `user_address` VALUES ('1662639618', '1', '1', '1', '1', '1', 0);
INSERT INTO `user_address` VALUES ('1662644035', '1111', '河南省驻马店市', '西平县宋集镇岳庄村委狗哥村', '岳林浩', ' 15039609853', 0);

SET FOREIGN_KEY_CHECKS = 1;
