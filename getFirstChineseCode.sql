DELIMITER $$
DROP FUNCTION IF EXISTS `getFirstChineseCode`$$
CREATE FUNCTION `getFirstChineseCode`(in_string VARCHAR(100)) RETURNS VARCHAR(100) CHARSET utf8
BEGIN
	#定义临时字符串变量，用于接收函数中传递进来的字符串值
	DECLARE tmp_str VARCHAR(100) CHARSET gbk DEFAULT '' ; 
	#定义临时字符串变量，用于存放函数中传递进来的字符串值的第一个字符
	DECLARE tmp_char VARCHAR(2) CHARSET gbk DEFAULT '';
	#tmp_str的长度
	DECLARE tmp_loc SMALLINT DEFAULT 0;
	#初始化，将in_string赋给tmp_str
	SET tmp_str = in_string;
	#获取tmp_str最左端的首个字符
	SET tmp_char = LEFT(tmp_str,1);
	#获取字符的编码范围的位置
	SET tmp_loc=INTERVAL(CONV(HEX(tmp_char),16,10),0xB0A1,0xB0C5,0xB2C1,0xB4EE,0xB6EA,0xB7A2,0xB8C1,0xB9FE,0xBBF7,0xBFA6,0xC0AC,0xC2E8,0xC4C3,0xC5B6,0xC5BE,0xC6DA,0xC8BB,0xC8F6,0xCBFA,0xCDDA ,0xCEF4,0xD1B9,0xD4D1);
	#判断左端首个字符是多字节还是单字节字符，多字节则认为是汉字
	#如果是多字节字符，且在对应的编码范围之内
	IF (LENGTH(tmp_char) > 1 AND tmp_loc > 0 AND tmp_loc < 24) THEN
		SELECT ELT(tmp_loc,'A','B','C','D','E','F','G','H','J','K','L','M','N','O','P','Q','R','S','T','W','X','Y','Z') INTO tmp_char;
	END IF;
	#返回汉字拼音首字符
	RETURN tmp_char;
END$$
DELIMITER ;