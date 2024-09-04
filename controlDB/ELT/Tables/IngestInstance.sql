﻿CREATE TABLE [ELT].[IngestInstance]
(
	[IngestInstanceID] int not null identity,
	[IngestID] int not null,
	[SourceFileDropFileSystem] varchar(50) null,
	[SourceFileDropFolder] varchar(200) null,
	[SourceFileDropFile] varchar(200) null,
	[DestinationRawFileSystem] varchar(50) not null,
	[DestinationRawFolder] varchar(200) not null,
	[DestinationRawFile] varchar(200) not null,
	[DataFromTimestamp] dateTime2 null,
	[DataToTimestamp] datetime2 null,
	[DataFromNumber] Int null,
	[DataToNumber] Int null,
	[SourceCount] int null,
	[IngestCount] int null,
	[IngestStartTimestamp] datetime2 null,
	[IngestEndTimestamp] datetime2 null,
	[IngestStatus] varchar(20) null,
	[RetryCount] int null,
	[ReloadFlag] bit null,
	[CreatedBy] varchar(128) not null,
	[CreatedTimestamp] datetime2 not null,
	[ModifiedBy] varchar(128) null,
	[ModifiedTimestamp] datetime2 null,
	[ADFIngestPipelineRunID] uniqueidentifier null
)