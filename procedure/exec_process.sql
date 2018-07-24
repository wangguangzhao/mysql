DROP PROCEDURE IF EXISTS addFieldByVol;

DELIMITER $

CREATE PROCEDURE addFieldByVol(IN NAME VARCHAR(100),IN CODE VARCHAR(100),IN TYPE VARCHAR(100),IN LENGTH VARCHAR(100),IN defaultval VARCHAR(100), IN width VARCHAR(100), IN attrsystem VARCHAR(100),IN attrshow VARCHAR(100),IN attrretrieval VARCHAR(100),IN attrlist VARCHAR(100),IN attrexport VARCHAR(100),IN attrrequired VARCHAR(100),IN attrreadonly VARCHAR(100),IN attrbatchedit VARCHAR(100),IN attrcopy VARCHAR(100),IN codeorgvalue VARCHAR(100),IN attrvisible VARCHAR(100),IN ftype VARCHAR(100))
BEGIN
DECLARE tableName VARCHAR(20) DEFAULT '' ;
DECLARE fid VARCHAR(20) DEFAULT '' ;
DECLARE tableTmp VARCHAR(20) DEFAULT '' ;
DECLARE TIME TEXT DEFAULT '';
DECLARE fieldName TEXT DEFAULT '' ;
DECLARE v_sql TEXT DEFAULT '';
DECLARE y_sql TEXT DEFAULT '';
DECLARE i_sql TEXT DEFAULT '';
DECLARE cur1 CURSOR FOR SELECT voltableid,fondsid FROM s_archive_type WHERE voltableid != '';
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'SET tableName = NULL;
SET @table_schema='thams';
SET @name = NAME;
SET @name = NAME;
SET @code = CODE;
SET @type = TYPE;
SET @length = LENGTH;
SET @defaultval = defaultval;
SET @width = width;
SET @attrsystem = attrsystem;
SET @attrshow = attrshow;
SET @attrretrieval = attrretrieval;
SET @attrlist = attrlist;	
SET @attrexport = attrexport;
SET @attrrequired = attrrequired;
SET @attrreadonly = attrreadonly;
SET @attrbatchedit = attrbatchedit;
SET @attrcopy = attrcopy;
SET @codeorgvalue = codeorgvalue;
SET @attrvisible = attrvisible;
SET @ftype = ftype;
SET @temp = '';
OPEN cur1;
FETCH cur1 INTO tableName,fid;
    WHILE ( tableName IS NOT NULL) DO
	SET @tableTmp = (SELECT DISTINCT  table_name FROM information_schema.TABLES WHERE table_name = tableName AND table_schema=@table_schema);
	IF(@tableTmp IS NOT NULL) THEN
		SET @fieldName = (SELECT DISTINCT  column_name FROM information_schema.columns WHERE table_name = tableName AND column_name = @code AND table_schema=@table_schema);
		IF (@fieldName IS NULL) THEN
		SET @tmpName = tableName;
		SET @fondid = fid;
		SET v_sql = CONCAT(' ',"alter table ",tableName," add COLUMN ",@code,' ',@ftype);
		SET @sql = v_sql;
		SET y_sql = "select 1";
		IF(@code = 'digital') THEN
			SET y_sql = CONCAT(' ',"update ",tableName," set ",@code,' =  "否" ');
		ELSEIF(@code = 'storagenum') THEN	
			SET y_sql = CONCAT(' ',"update ",tableName," set ",@code,' = fillingnum ');
		END IF;
		SET @ysql = y_sql;
		SET @tempdata = (SELECT MAX(id) FROM s_archive_field);
		SET @data = @tempdata + 1;
		SET @idpri = (SELECT id FROM s_archive_field WHERE id = @data);
		IF(@idpri IS NOT NULL) THEN 
			SELECT UNIX_TIMESTAMP()*1000 INTO TIME;
			SET @ids = CONCAT(TIME+1,RAND()*RAND()*100000);
			SET @data = @ids+RAND();
			SET @idpri = (SELECT id FROM s_archive_field WHERE id = @data);
			IF(@idpri IS NOT NULL) THEN
			SET @data = @idpri+RAND();
			END IF;
		END IF;
		SET i_sql = CONCAT(" ","insert into s_archive_field (`id`,`tableid`,`code`,`name`,`type`,`attrnullable`,`attrisunique`,`attrvisible`,`attr`,`readonly`,`orderindex`,`length`,`width`,`attrlist`,`attrgroup`,`attrsearch`,`attrorder`,`attrincrease`,`attrdetail`,`attrrule`,`attrcopy`,`sourcecode`,`information`,`fondsid`,`codeorgvalue`,`codeordescr`,`attrretrieval`,`attrexport`,`attrbatchedit`,`attrreadonly`,`attrsystem`,`attrrequired`,`attrinherit`,`defaultval`,`attrshow`) value(@data,@tmpName,@code,@name,@type,'','',@attrvisible,'','','58',@length,@width,@attrlist,'0','0','0','0','0','0',@attrcopy,'','',@fondid,@codeorgvalue,'1',@attrretrieval,@attrexport,@attrbatchedit,@attrreadonly,@attrsystem,@attrrequired,'',@defaultval,@attrshow)");
		SET @isql = i_sql;
		PREPARE s1 FROM @sql;
		EXECUTE s1;
		DEALLOCATE PREPARE s1;
		
		PREPARE s3 FROM @isql;
		EXECUTE s3;
		DEALLOCATE PREPARE s3;
		
		PREPARE s2 FROM @ysql;
		EXECUTE s2;
		DEALLOCATE PREPARE s2;

		END IF;
		SET @temp = @data + 1;
	END IF;
	FETCH cur1 INTO tableName,fid;
	END WHILE;
CLOSE cur1;
END;$

DELIMITER ;
CALL addFieldByVol('装订方法','bindstatus','varchar','20','','60','1','1','0','1','1','0','1','1','0','bindstatus','1','varchar(20)');