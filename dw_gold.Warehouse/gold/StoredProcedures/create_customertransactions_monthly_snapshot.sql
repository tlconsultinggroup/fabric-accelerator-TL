CREATE PROC [gold].[create_customertransactions_monthly_snapshot]
	(@L2TransformInstanceID INT NULL = NULL
	, @L2TransformID INT NULL = NULL
	, @IngestID INT NULL = NULL
	, @L1TransformID INT NULL = NULL
	, @CustomParameters VARCHAR(max) NULL = NULL
	, @InputType VARCHAR(15) NULL = NULL
	, @InputFileSystem VARCHAR(50) NULL = NULL
	, @InputFileFolder VARCHAR(200) NULL = NULL
	, @InputFile VARCHAR(200) NULL = NULL
	, @InputFileDelimiter CHAR(1)  NULL = NULL
	, @InputFileHeaderFlag BIT NULL = NULL
	, @InputDWTable VARCHAR(200) NULL = NULL
	, @WatermarkColName VARCHAR(50) NULL = NULL
	, @DataFromTimestamp DATETIME NULL = NULL
	, @DataToTimestamp DATETIME NULL = NULL
	, @DataFromNumber INT NULL = NULL
	, @DataToNumber INT NULL = NULL
	, @OutputL2CurateFileSystem VARCHAR(50) NULL = NULL
	, @OutputL2CuratedFolder VARCHAR(200) NULL = NULL
	, @OutputL2CuratedFile VARCHAR(200) NULL = NULL
	, @OutputL2CuratedFileDelimiter CHAR(1) NULL = NULL
	, @OutputL2CuratedFileFormat VARCHAR(10) NULL = NULL
	, @OutputL2CuratedFileWriteMode VARCHAR(20) NULL = NULL
	, @OutputDWStagingTable VARCHAR(200) NULL = NULL
	, @LookupColumns VARCHAR(20) NULL = NULL
	, @OutputDWTable VARCHAR(200) NULL = NULL
	, @OutputDWTableWriteMode VARCHAR(20) NULL = NULL
)
AS
BEGIN
    IF EXISTS (select 1 from [INFORMATION_SCHEMA].[TABLES] WHERE TABLE_TYPE ='BASE TABLE' AND TABLE_SCHEMA ='gold' AND TABLE_NAME ='customertransactions_monthly_snapshot')
        DROP TABLE gold.customertransactions_monthly_snapshot

    create table gold.customertransactions_monthly_snapshot
    as 
    SELECT t.[TransactionTypeID]
        , ttype.[TransactionTypeName]
        ,t.[PaymentMethodID]
        ,ptype.[PaymentMethodName]
        ,EOMONTH(t.[TransactionDate]) AS TransactionMonth
        ,SUM(t.[AmountExcludingTax]) AS [AmountExcludingTax]
        ,SUM(t.[TaxAmount]) AS [TaxAmount]
        ,SUM(t.[TransactionAmount]) AS [TransactionAmount]
        ,SUM(t.[OutstandingBalance]) AS [OutstandingBalance]
    FROM [lh_silver].[dbo].[silver_sales_customertransactions]  as t
    LEFT JOIN [lh_silver].[dbo].[silver_application_transactiontypes] as ttype
    on ttype.TransactionTypeID = t.TransactionTypeID
    LEFT JOIN [lh_silver].[dbo].[silver_application_paymentmethods] as ptype
        on ptype.[PaymentMethodID] = t.[PaymentMethodID]
    WHERE t.[IsFinalized]=1
    GROUP BY t.[TransactionTypeID]
        , ttype.[TransactionTypeName]
        ,t.[PaymentMethodID]
        ,ptype.[PaymentMethodName]
        ,EOMONTH(t.[TransactionDate]) 
END