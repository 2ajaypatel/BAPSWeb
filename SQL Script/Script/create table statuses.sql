USE BAPS_CALENDAR
GO

CREATE TABLE Statuses
     ( 
        StatusID            INT										NOT NULL  IDENTITY (1, 1), 
        StatusCode          INT										NOT NULL,
        StatusName					VARCHAR(50)           NOT NULL,
        StatusDescription       VARCHAR(255)          NULL         
        )
GO

-- ADD primary Statuses
ALTER TABLE Statuses
ADD CONSTRAINT pk_Statuses_StatusID PRIMARY KEY (StatusID)
GO

-- CREATE UNIQUE INDEX
CREATE UNIQUE INDEX [Statuses_StatusCode_U_NC]
ON [dbo].[Statuses] ( [StatusCode] )
GO