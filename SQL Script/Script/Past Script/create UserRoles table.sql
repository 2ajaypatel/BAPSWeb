USE BAPS_CALENDAR
GO

CREATE TABLE UserRoles
     ( 
        RoleID            INT										NOT NULL  IDENTITY (1, 1), 
        RoleCode          INT										NOT NULL,
        RoleName					VARCHAR(50)           NOT NULL,
        RoleDescription       VARCHAR(255)          NULL         
        )
GO

-- ADD primary key
ALTER TABLE UserRoles
ADD CONSTRAINT pk_UserRoles_RoleID PRIMARY KEY (RoleID)
GO

-- CREATE UNIQUE INDEX
CREATE UNIQUE INDEX [UserRoles_RoleCode_U_NC]
ON [dbo].[UserRoles] ( [RoleCode] )
GO