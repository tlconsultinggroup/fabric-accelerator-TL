﻿GO

CREATE TABLE [ELT].[ColumnMapping](
	[MappingID] int NOT NULL IDENTITY,
	[IngestID] int NULL,
	[L1TransformID] int NULL,
	[L2TransformID] int NULL,
	[SourceName] varchar(150) NOT NULL,
	[TargetName] varchar(150) NOT NULL,
	[Description] varchar(250) NULL,
	[TargetOrdinalPosition] int NOT NULL,
	[ActiveFlag] bit NULL,
	[CreatedBy] varchar(128) NOT NULL,
	[CreatedTimestamp] datetime2 NOT NULL,
	[ModifiedBy] varchar(128) NULL,
	[ModifiedTimestamp] datetime2 NULL)
