-- Ngày thay đổi	: {CURRENT_TIME}
-- Người thay đổi	:
-- Phiên bản 		:
-- Mô tả			: Stream init data từ topic của GG

CREATE OR REPLACE STREAM FBNK_{TABLE_NAME}_INIT (
    ROWKEY STRING KEY,
    LOOKUP_KEY STRING,
    RECID STRING, 
    `TABLE` STRING,
    SCN STRING,
    OP_TYPE STRING,
    OP_TS STRING,
    CURRENT_TS STRING,
    POS STRING,
    XID STRING, 
    XMLRECORD STRING)
WITH (FORMAT='avro', KAFKA_TOPIC='FBNK_{TABLE_NAME}_INIT');