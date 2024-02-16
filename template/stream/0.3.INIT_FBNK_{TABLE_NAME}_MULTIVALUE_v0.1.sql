-- Ngày thay đổi	: {CURRENT_TIME}
-- Người thay đổi	:
-- Phiên bản 		  :
-- Mô tả			    : Tạo stream multivalue

CREATE OR REPLACE STREAM FBNK_{TABLE_NAME}_INIT_MULTIVALUE WITH (KAFKA_TOPIC='FBNK_{TABLE_NAME}_INIT_MULTIVALUE', PARTITIONS=1) AS SELECT
  DATA.ROWKEY ROWKEY,
  DATA.LOOKUP_KEY LOOKUP_KEY,
  DATA.RECID RECID,
  -- Để ý xem có phải bảng his hay không nếu có thêm trường recver (Note cho BNH: Sửa xong thì xoá) --
  DATA.OP_TS OP_TS,
  DATA.CURRENT_TS REP_TS,
  TIMESTAMPTOSTRING(UNIX_TIMESTAMP(), 'yyyy-MM-dd HH:mm:ss.SSSSSS') CURRENT_TS,
  DATA.TABLE_NAME TABLE_NAME,
  DATA.COMMIT_SCN COMMIT_SCN,
  DATA.COMMIT_ACTION COMMIT_ACTION,
--{FIELD_NAMES},
  PARSE_T24_MULTIVAL(DATA.RECID, DATA.XMLRECORD, 'FBNK_{TABLE_NAME}_INIT_MULTIVALUE', ARRAY[''], ARRAY[''], '#') XMLRECORD, --chọn delimiter nào ko xuất hiện trong value gốc VD:#; Tự điền các trường multi M , S ( note cho BNH : sửa xong thì xóa ) --
  DATA.BANKING_DATE BANKING_DATE
FROM FBNK_{TABLE_NAME}_INIT_MAPPED DATA
EMIT CHANGES;