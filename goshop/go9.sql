-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.0.13 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 go8db 的数据库结构
DROP DATABASE IF EXISTS `go8db`;
CREATE DATABASE IF NOT EXISTS `go8db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `go8db`;

-- 导出  表 go8db.t_advert 结构
DROP TABLE IF EXISTS `t_advert`;
CREATE TABLE IF NOT EXISTS `t_advert` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `title` varchar(50) DEFAULT NULL COMMENT '广告位名称',
  `code` varchar(20) DEFAULT NULL COMMENT '广告位编码，如：index.top',
  `html` varchar(1000) DEFAULT NULL COMMENT '广告html',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='广告表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_attribute 结构
DROP TABLE IF EXISTS `t_attribute`;
CREATE TABLE IF NOT EXISTS `t_attribute` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `name` varchar(50) NOT NULL COMMENT '属性名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '1普通属性 2规格属性',
  `input_type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '1 单选 2 多选 3 自定义',
  `cid` bigint(20) unsigned NOT NULL COMMENT '分类id',
  `gid` bigint(20) unsigned DEFAULT '0' COMMENT '分组id，默认0，没有分组',
  `required` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 非必填 1 必填',
  `show_order` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '显示顺序',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='商品属性表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_attribute_group 结构
DROP TABLE IF EXISTS `t_attribute_group`;
CREATE TABLE IF NOT EXISTS `t_attribute_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `name` varchar(50) NOT NULL COMMENT '分组名称',
  `cid` bigint(20) unsigned NOT NULL COMMENT '分类id',
  `show_order` int(11) unsigned NOT NULL DEFAULT '1' COMMENT '显示顺序',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建日期',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='属性分组表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_attribute_value 结构
DROP TABLE IF EXISTS `t_attribute_value`;
CREATE TABLE IF NOT EXISTS `t_attribute_value` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `value` varchar(50) NOT NULL COMMENT '属性值',
  `attribute_id` bigint(20) unsigned NOT NULL COMMENT '属性id',
  `show_order` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '显示顺序',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建日期',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COMMENT='商品属性值表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_brand 结构
DROP TABLE IF EXISTS `t_brand`;
CREATE TABLE IF NOT EXISTS `t_brand` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cname` varchar(50) NOT NULL COMMENT '中文名称',
  `ename` varchar(50) DEFAULT NULL COMMENT '英文名称',
  `cid` bigint(20) unsigned DEFAULT NULL COMMENT '分类id',
  `cat_name` varchar(50) DEFAULT NULL COMMENT '分类名称，冗余',
  `logo` varchar(200) DEFAULT NULL COMMENT '图标地址',
  `url` varchar(200) DEFAULT NULL COMMENT '官网url',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `source` varchar(200) DEFAULT NULL COMMENT '原产地',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态: 1 可用，0 不可用',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='商品品牌表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_catalog 结构
DROP TABLE IF EXISTS `t_catalog`;
CREATE TABLE IF NOT EXISTS `t_catalog` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `name` varchar(50) NOT NULL COMMENT '类目名称',
  `code` varchar(50) NOT NULL COMMENT '唯一编码',
  `pid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '父类目主键，默认0，根节点',
  `is_parent` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是父类目，默认0，不是',
  `order1` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '排序',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='商品分类表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_comment 结构
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE IF NOT EXISTS `t_comment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `product_id` bigint(20) unsigned NOT NULL COMMENT '商品id',
  `sku_id` bigint(20) unsigned DEFAULT NULL COMMENT 'sku的主键',
  `account_id` bigint(20) unsigned DEFAULT NULL COMMENT '会员主键',
  `order_id` bigint(20) unsigned DEFAULT NULL COMMENT '订单主键',
  `order_detail_id` bigint(20) unsigned DEFAULT NULL COMMENT '订单明细主键',
  `content` varchar(500) DEFAULT NULL COMMENT '内容',
  `star` tinyint(3) unsigned DEFAULT '5' COMMENT '评论星级：1,2,3,4,5',
  `show` tinyint(3) unsigned DEFAULT '1' COMMENT '显示：1，不显示：0',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员评论表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_discount 结构
DROP TABLE IF EXISTS `t_discount`;
CREATE TABLE IF NOT EXISTS `t_discount` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `discount` decimal(3,2) unsigned DEFAULT NULL COMMENT '折扣，如：0.95折',
  `name` varchar(50) DEFAULT NULL COMMENT '折扣宣传名称',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='折扣';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_express 结构
DROP TABLE IF EXISTS `t_express`;
CREATE TABLE IF NOT EXISTS `t_express` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(20) DEFAULT NULL COMMENT 'EXPRESS（快递） POST（平邮） EMS',
  `name` varchar(20) DEFAULT NULL COMMENT '快递名称',
  `fee` decimal(10,2) DEFAULT NULL COMMENT '物流费用',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='快递配送表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_favorite 结构
DROP TABLE IF EXISTS `t_favorite`;
CREATE TABLE IF NOT EXISTS `t_favorite` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键，自增',
  `account_id` bigint(20) unsigned DEFAULT NULL COMMENT '会员id',
  `product_id` bigint(20) unsigned DEFAULT NULL COMMENT '商品id',
  `sku_id` bigint(20) unsigned DEFAULT NULL COMMENT 'sku主键',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建日期',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品收藏表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_friend_link 结构
DROP TABLE IF EXISTS `t_friend_link`;
CREATE TABLE IF NOT EXISTS `t_friend_link` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `url` varchar(50) DEFAULT NULL COMMENT '链接',
  `target` varchar(50) DEFAULT '_blank' COMMENT '打开方式：默认新建',
  `order1` int(10) unsigned DEFAULT '1' COMMENT '排序',
  `description` varchar(100) DEFAULT NULL COMMENT '描述',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='友情链接';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_hot_search_keyword 结构
DROP TABLE IF EXISTS `t_hot_search_keyword`;
CREATE TABLE IF NOT EXISTS `t_hot_search_keyword` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `keywords` varchar(50) DEFAULT NULL COMMENT '热搜词，多个词空格隔开',
  `type` varchar(10) DEFAULT 'item' COMMENT '类型，默认商品',
  `source` varchar(10) DEFAULT 'index' COMMENT '来源，默认首页',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='搜索热搜关键字';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_index_notice 结构
DROP TABLE IF EXISTS `t_index_notice`;
CREATE TABLE IF NOT EXISTS `t_index_notice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `url` varchar(100) DEFAULT NULL COMMENT '链接地址',
  `display` tinyint(3) unsigned DEFAULT '0' COMMENT '1：显示，0：不显示',
  `order1` int(10) unsigned DEFAULT '1' COMMENT '顺序',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='首页公告表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_index_roll 结构
DROP TABLE IF EXISTS `t_index_roll`;
CREATE TABLE IF NOT EXISTS `t_index_roll` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增，主键',
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `image` varchar(200) DEFAULT NULL COMMENT '图像地址',
  `link` varchar(200) DEFAULT NULL COMMENT '链接',
  `path` varchar(200) DEFAULT NULL COMMENT '文件删除路径，由系统维护',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='首页轮播图';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_member 结构
DROP TABLE IF EXISTS `t_member`;
CREATE TABLE IF NOT EXISTS `t_member` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '会员ID，主键',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `phone` varchar(50) DEFAULT NULL COMMENT '电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(50) DEFAULT NULL COMMENT '最后登录ip',
  `gmt_create` datetime DEFAULT NULL COMMENT '注册时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='会员表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_member_address 结构
DROP TABLE IF EXISTS `t_member_address`;
CREATE TABLE IF NOT EXISTS `t_member_address` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `memberId` bigint(20) unsigned NOT NULL COMMENT '会员id',
  `province` varchar(20) DEFAULT NULL COMMENT '省份',
  `city` varchar(20) DEFAULT NULL COMMENT '城市',
  `area` varchar(20) DEFAULT NULL COMMENT '区',
  `street` varchar(20) DEFAULT NULL COMMENT '街道',
  `pcas` varchar(100) DEFAULT NULL COMMENT '省份城市区街道合并结果，空格隔开',
  `address` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `zip` varchar(6) DEFAULT NULL COMMENT '邮编',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机',
  `tel` varchar(20) DEFAULT NULL COMMENT '电话',
  `person` varchar(20) DEFAULT NULL COMMENT '收货人',
  `is_default` tinyint(3) unsigned DEFAULT '0' COMMENT '是否默认。0：不是，1：是。',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='会员配送地址表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_member_email 结构
DROP TABLE IF EXISTS `t_member_email`;
CREATE TABLE IF NOT EXISTS `t_member_email` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sign` varchar(50) DEFAULT NULL COMMENT '邮件唯一识别号',
  `login_name` varchar(50) DEFAULT NULL COMMENT '用户账号',
  `type` varchar(20) DEFAULT NULL COMMENT 'forget:找回密码；register:注册；product:商品价格变动；change:邮箱更换',
  `url` varchar(100) DEFAULT NULL COMMENT '邮箱验证、密码丢失找回密码的url',
  `start_time` datetime DEFAULT NULL COMMENT '邮件有效开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '邮件有效结束时间',
  `new_email` varchar(50) DEFAULT NULL COMMENT '新的邮箱',
  `status` tinyint(3) unsigned DEFAULT '0' COMMENT '链接是否失效状态。0：未失效；1：已失效。',
  `send_status` tinyint(3) unsigned DEFAULT '0' COMMENT '发送状态。0：发送失败；1：发送成功。',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员邮箱管理';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_member_info 结构
DROP TABLE IF EXISTS `t_member_info`;
CREATE TABLE IF NOT EXISTS `t_member_info` (
  `id` bigint(20) unsigned NOT NULL COMMENT '外键会员id',
  `nick_name` varchar(50) DEFAULT NULL,
  `true_name` varchar(50) DEFAULT NULL,
  `sex` varchar(1) DEFAULT '男',
  `birthday` date DEFAULT NULL,
  `card` varchar(50) DEFAULT NULL,
  `rank` varchar(50) DEFAULT 'R1',
  `score` int(10) unsigned DEFAULT '0',
  `province` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `postcode` varchar(50) DEFAULT NULL,
  `gmt_created` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='会员基本信息表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_member_rank 结构
DROP TABLE IF EXISTS `t_member_rank`;
CREATE TABLE IF NOT EXISTS `t_member_rank` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` char(2) DEFAULT NULL COMMENT '级别编码R1,R2,R3,R4,R5',
  `name` char(4) DEFAULT NULL COMMENT '普通会员，铜牌，银牌，金牌，钻石',
  `min_score` int(10) unsigned DEFAULT NULL COMMENT '0-499,500-999,1000-1999',
  `max_score` int(10) unsigned DEFAULT NULL COMMENT '2000-4000，大于4000',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员等级';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_news 结构
DROP TABLE IF EXISTS `t_news`;
CREATE TABLE IF NOT EXISTS `t_news` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `sub_title` varchar(200) DEFAULT NULL COMMENT '副标题',
  `count` int(10) unsigned DEFAULT NULL COMMENT '阅读数',
  `content` text COMMENT '内容',
  `author` varchar(50) DEFAULT NULL COMMENT '作者',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章、新闻表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_order 结构
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE IF NOT EXISTS `t_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `member_id` bigint(20) unsigned DEFAULT NULL COMMENT '会员id',
  `status` tinyint(3) unsigned DEFAULT NULL COMMENT '1：待付款 2：待发货 3：待收货 4：待评价 5：待归档',
  `ptotal` decimal(10,2) unsigned DEFAULT NULL COMMENT '商品总金额',
  `fee` decimal(10,2) unsigned DEFAULT NULL COMMENT '运费总金额',
  `amount` decimal(10,2) unsigned DEFAULT NULL COMMENT '订单总金额',
  `reduce_money` decimal(10,2) unsigned DEFAULT NULL COMMENT '优惠总金额',
  `final_pay_money` decimal(10,2) unsigned DEFAULT NULL COMMENT '最终付款金额',
  `score` int(10) unsigned DEFAULT NULL COMMENT '订单获赠积分',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注信息',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='订单表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_order_detail 结构
DROP TABLE IF EXISTS `t_order_detail`;
CREATE TABLE IF NOT EXISTS `t_order_detail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint(20) unsigned DEFAULT NULL COMMENT '订单ID',
  `product_id` bigint(20) unsigned DEFAULT NULL COMMENT '产品ID',
  `image` varchar(200) DEFAULT NULL COMMENT '图片',
  `product_title` varchar(100) DEFAULT NULL COMMENT '产品名称',
  `price` decimal(10,2) unsigned DEFAULT NULL COMMENT '价格',
  `number` int(10) unsigned DEFAULT NULL COMMENT '数量',
  `reduce_type` varchar(20) DEFAULT NULL COMMENT '优惠方式',
  `redduce_money` decimal(10,2) unsigned DEFAULT NULL COMMENT '优惠金额',
  `ship_type` varchar(50) DEFAULT NULL COMMENT '运送方式',
  `ship_money` decimal(10,2) unsigned DEFAULT NULL COMMENT '运送金额',
  `ship_insurance` decimal(10,2) unsigned DEFAULT NULL COMMENT '运费保险',
  `score` int(10) unsigned DEFAULT NULL COMMENT '积分',
  `remark` varchar(200) DEFAULT NULL COMMENT '买家留言',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='订单明细';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_order_pay 结构
DROP TABLE IF EXISTS `t_order_pay`;
CREATE TABLE IF NOT EXISTS `t_order_pay` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint(20) unsigned DEFAULT NULL COMMENT '订单id',
  `pay_type` varchar(50) DEFAULT NULL COMMENT '支付类型：weixin zfb ebank',
  `pay_NO` varchar(50) DEFAULT NULL COMMENT '支付交易号',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `pay_status` varchar(50) DEFAULT NULL COMMENT '支付状态：success fail',
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单支付表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_order_ship 结构
DROP TABLE IF EXISTS `t_order_ship`;
CREATE TABLE IF NOT EXISTS `t_order_ship` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint(20) unsigned DEFAULT NULL COMMENT '订单ID',
  `ship_name` varchar(50) DEFAULT NULL COMMENT '收货人姓名',
  `ship_address` varchar(100) DEFAULT NULL COMMENT '收货人详细地址',
  `province` varchar(50) DEFAULT NULL COMMENT '省份',
  `city` varchar(50) DEFAULT NULL COMMENT '城市',
  `area` varchar(50) DEFAULT NULL COMMENT '区',
  `street` varchar(50) DEFAULT NULL COMMENT '街道',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机',
  `zip` varchar(10) DEFAULT NULL COMMENT '邮编',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='订单配送表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_product 结构
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE IF NOT EXISTS `t_product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `cid` bigint(20) unsigned DEFAULT NULL COMMENT '分类',
  `brand_id` bigint(20) unsigned DEFAULT NULL COMMENT '品牌',
  `title` varchar(100) DEFAULT NULL COMMENT '商品标题',
  `sub_title` varchar(100) DEFAULT NULL COMMENT '副标题',
  `attributes` varchar(2000) DEFAULT NULL COMMENT '商品属性集，json',
  `price` int(10) unsigned DEFAULT NULL COMMENT '售价，单位：分',
  `go8_price` int(10) unsigned DEFAULT NULL COMMENT '平台价格，单位：分',
  `stock` int(10) unsigned DEFAULT NULL COMMENT '总库存',
  `status` tinyint(3) unsigned DEFAULT '1' COMMENT '1 上架 2 下架',
  `picture` varchar(500) DEFAULT NULL COMMENT '商品主图',
  `images` varchar(1000) DEFAULT NULL COMMENT '规格缩略图',
  `product_code` varchar(200) DEFAULT NULL COMMENT '货号',
  `package_info` varchar(1000) DEFAULT NULL COMMENT '包装信息，格式：json',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建日期',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改日期',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='商品基本信息表（spu)';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_product_detail 结构
DROP TABLE IF EXISTS `t_product_detail`;
CREATE TABLE IF NOT EXISTS `t_product_detail` (
  `product_id` bigint(20) unsigned NOT NULL COMMENT '主键，来自于商品表id',
  `html` text COMMENT '详情html内容',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建日期',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改日期',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品详情表';

-- 数据导出被取消选择。
-- 导出  表 go8db.t_product_sku 结构
DROP TABLE IF EXISTS `t_product_sku`;
CREATE TABLE IF NOT EXISTS `t_product_sku` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `product_id` bigint(20) unsigned DEFAULT NULL COMMENT '商品spu的id',
  `attrs` varchar(1000) DEFAULT NULL COMMENT '规格属性集，json',
  `picture` varchar(1000) DEFAULT NULL COMMENT '规格主图',
  `go8_price` int(10) unsigned DEFAULT NULL COMMENT '平台价格，单位：分',
  `stock` int(10) unsigned DEFAULT NULL COMMENT '规格库存',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建日期',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COMMENT='商品sku基本信息表';

-- 数据导出被取消选择。
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
