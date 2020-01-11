DELIMITER $$
DROP FUNCTION IF EXISTS `getChildList`$$
CREATE FUNCTION `getChildList`(in_rootId VARCHAR(100)) RETURNS VARCHAR(2000)  
BEGIN   
	#存放所有遍历结果
	DECLARE tmp_str VARCHAR(2000);  
	#定义一个变量存放子id
	DECLARE tmp_id VARCHAR(100);   
	SET tmp_str = '$';   
	SET tmp_id = in_rootId;   
	WHILE tmp_id is not null DO   
		SET tmp_str = concat(tmp_str, ',', tmp_id);   
		SELECT group_concat(id) INTO tmp_id FROM test2 where FIND_IN_SET(pid, tmp_id) > 0;   
	END WHILE;   
	RETURN tmp_str;   
END$$
DELIMITER ;