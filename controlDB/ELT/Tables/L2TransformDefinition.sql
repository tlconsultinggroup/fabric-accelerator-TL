﻿CREATE TABLE [ELT].[L2TransformDefinition]
(
	[L2TransformID] int not null identity,
	[IngestID] int null,
	[L1TransformID] int null,
	[NotebookPath] varchar(200) null,
	[NotebookName] varchar(100) null,
	[CustomParameters] varchar(max) null,
	[InputType] varchar(15) null,
	[InputFileSystem] varchar(50) null,
	[InputFileFolder] varchar(200) null,
	[InputFile] varchar(200) null,
	[InputFileDelimiter] char(1) null,
	[InputFileHeaderFlag] bit null,
	[InputDWTable] varchar(200) null,
	[DeltaName] varchar(50) null,
	[LastDeltaDate] datetime2 null,
	[LastDeltaNumber] int null,
	[MaxIntervalMinutes] int null,
	[MaxIntervalNumber] int null,
	[MaxRetries] int null,
	[OutputL2CurateFileSystem] varchar(50) null,
	[OutputL2CuratedFolder] varchar(200) null,
	[OutputL2CuratedFile] varchar(200) null,
	[OutputL2CuratedFileDelimiter] char(1) null,
	[OutputL2CuratedFileFormat] varchar(10) null,
	[OutputL2CuratedFileWriteMode] varchar(20) null,
	--Output SQL DW Table
	[OutputDWStagingTable] varchar(200) null,
	[LookupColumns] varchar(4000) null,
	[OutputDWTable] varchar(200) null,
	[OutputDWTableWriteMode] varchar(20) null,
	[ActiveFlag] bit not null,
	[RunSequence] int not null,
	[CreatedBy] varchar(128) not null,
	[CreatedTimestamp] datetime2 not null,
	[ModifiedBy] varchar(128) null,
	[ModifiedTimestamp] datetime2 null
)