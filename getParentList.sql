DELIMITER $$
DROP FUNCTION IF EXISTS `getParentList`$$
CREATE FUNCTION `getParentList`(in_rootId VARCHAR(100)) RETURNS VARCHAR(1000)   
BEGIN
	#定义一个变量存放父id
	DECLARE tmp_id VARCHAR(100) default '';  
	#存放所有遍历结果
	DECLARE tmp_str VARCHAR(1000) default in_rootId;   
  
	WHILE in_rootId is not null do   
    SET tmp_id = (SELECT pid FROM test2 WHERE id = in_rootId);   
    IF tmp_id is not null THEN   
        SET tmp_str = concat(tmp_str, ',', tmp_id);   
    END IF;   
		SET in_rootId = tmp_id;     
	END WHILE;   
	RETURN tmp_str;  
END$$
DELIMITER ;