USE [BAPS_CALENDAR]
GO
/****** Object:  StoredProcedure [dbo].[getOrderSummaryByCenterIDProjectYear]    Script Date: 05/03/2012 20:33:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ============================================= 
-- Author:     
-- Create date:  
-- Description:   
-- ============================================= 
ALTER PROCEDURE [dbo].[getOrderSummaryByCenterIDProjectYear] 
-- Add the parameters for the stored procedure here 
@centerID    INT, 
@projectyear INT 
AS 
  BEGIN 
	
		IF (@centerID <= 0 )
			SET @centerID = NULL
	
	
	  CREATE TABLE #orderstatusTemp
	(OrderID INT,
     adminedit INT,		
     designedit INT,
     adminstatus VARCHAR(50),
     designstatus VARCHAR(50)
     )

INSERT INTO  #orderstatusTemp ( OrderID, adminstatus, adminedit )
SELECT os.orderid,
s.statusname AS adminstatus,
CASE os.statuscode
WHEN 10 THEN 1
WHEN 30 THEN 1
ELSE 0
END AS adminedit
FROM OrderStatus os
	INNER JOIN Statuses s
		ON os.statuscode = s.statuscode
WHERE
	os.rolecode = 10


UPDATE ot
	SET ot.designedit = 
		CASE os.statuscode
WHEN 10 THEN 1
WHEN 60 THEN 1
WHEN 80 THEN 1
ELSE 0
END	,
		ot.designstatus = s.statusname
FROM #orderstatusTemp ot
	INNER JOIN OrderStatus os
		ON ot.orderid = os.orderid
	INNER JOIN Statuses s
		ON os.statuscode = s.statuscode
WHERE
	os.rolecode = 30
	
	SELECT 
		DISTINCT 
			fi.orderid,
			fi.Centerid,
			--'Y' as template
			SUBSTRING(fi.SelectedTemplate, 1, CHARINDEX('.pdf', fi.SelectedTemplate)-1) AS template  
	INTO #oaf
	FROM 
		OrderAdvertisementFilesInfo FI
	WHERE 
		fi.SelectedTemplate IS NOT NULL
		
	SELECT o1.orderid,o1.centerid,
          ( SELECT template + ', ' 
              FROM #oaf o2
             WHERE o2.orderid = o1.orderid and o2.CenterID = o1.centerid
             ORDER BY template
               FOR XML PATH('') ) AS template
      INTO #oafinal
      FROM #oaf o1
     GROUP BY orderid ,centerid
	
	-- orderdeails table pull
	SELECT  od.OrderID, pm.ProductDescription AS product, 
			CASE od.ProductRateID WHEN 5 THEN 'MULTI COLOR ' WHEN 6 THEN 'MULTI COLOR' ELSE 'SINGLE COLOR' END AS "calendarType"
INTO #odtemp
FROM OrderDetails od
	INNER JOIN OrderMaster om
		ON od.OrderID = om.OrderID
	 INNER JOIN ProductMaster pm
		ON od.ProductID = pm.ProductID 
WHERE  om.centerid = COALESCE(NULL ,om.centerid)
             AND om.projectyear = 2012 
ORDER BY om.OrderID          

		
SELECT odt1.orderid,
          ( SELECT product + ', ' 
              FROM #odtemp odt2
             WHERE odt2.orderid = odt1.orderid 
             ORDER BY product
               FOR XML PATH('') ) AS product,
               ( SELECT calendarType + ', ' 
              FROM #odtemp odt3
             WHERE odt3.orderid = odt1.orderid 
             ORDER BY calendarType
               FOR XML PATH('') ) AS calendarType
      INTO #odtfinal
      FROM #odtemp odt1
     GROUP BY odt1.orderid 
     
      SELECT om.memberid, 
             om.clientid, 
             om.orderid, 
             om.orderdate, 
             om.orderamount, 
             mm.firstname, 
             mm.lastname, 
             cm.businessname ,
             ot.adminedit,		
			 ot.designedit,
			 ot.adminstatus ,
			 ot.designstatus,
			 om.CenterID,
			 c.CenterName,
			 od.product, 
			 od.calendarType,
			--CASE od.ProductRateID WHEN 5 THEN 'MULTI COLOR ' WHEN 6 THEN 'MULTI COLOR' ELSE 'SINGLE COLOR' END AS "calendarType",
			ISNULL(fi.template,'NO') AS template
			
      FROM   OrderMaster  om 
             INNER JOIN MemberMaster  mm 
               ON om.memberid = mm.memberid 
             INNER JOIN ClientMaster  cm 
               ON om.clientid = cm.clientid 
             INNER JOIN #orderstatusTemp ot
				ON om.OrderID = ot.orderid
			 INNER JOIN Center c
				ON om.CenterID = c.CenterID
			 INNER JOIN #odtfinal od
				ON od.OrderID = om.OrderID 
			-- INNER JOIN ProductMaster pm
			--	ON od.ProductID = pm.ProductID 
			 LEFT JOIN #oafinal fi
				ON ( om.CenterID = fi.CenterID AND om.OrderID = fi.OrderID )
      WHERE  om.centerid = COALESCE(@centerID ,om.centerid)
             AND om.projectyear = @projectyear 
      ORDER  BY om.orderdate 
      
      
      
      DROP TABLE #oaf
	  DROP TABLE #oafinal
      DROP TABLE #orderstatusTemp
      DROP TABLE #odtemp
	 DROP TABLE #odtfinal
      
  END 