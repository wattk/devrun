-- 회원 테이블 생성
CREATE TABLE "MEMBER" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"ID"	VARCHAR2(50)		NOT NULL,
	"NAME"	VARCHAR2(50)		NOT NULL,
	"NICKNAME"	VARCHAR2(50)		NOT NULL,
	"PASSWORD"	VARCHAR2(300)		NOT NULL,
	"BIRTHDAY"	DATE		NOT NULL,
	"EMAIL"	VARCHAR2(300)		NOT NULL,
	"PHONE"	CHAR(11)		NOT NULL,
	"POINT"	NUMBER	DEFAULT 0	NULL,
	"ENROLL_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"PRO_PHOTO"	VARCHAR2(100)		NULL,
	"BLACK_YN"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"SMS_YN"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"WARNING_COUNT"	NUMBER	DEFAULT 0	NULL,
	"URL"	VARCHAR2(500)		NULL,
	"INTRO"	VARCHAR2(1000)		NULL
);

-- 회원 번호 시퀀스 생성
create sequence seq_member_no;

-- 회원 테이블 코멘트 추가
COMMENT ON COLUMN "MEMBER"."MEMBER_NO" IS '회원 번호';
COMMENT ON COLUMN "MEMBER"."ID" IS '회원 아이디';
COMMENT ON COLUMN "MEMBER"."NAME" IS '회원 이름';
COMMENT ON COLUMN "MEMBER"."NICKNAME" IS '회원 닉네임';
COMMENT ON COLUMN "MEMBER"."PASSWORD" IS '비밀번호';
COMMENT ON COLUMN "MEMBER"."BIRTHDAY" IS '생일';
COMMENT ON COLUMN "MEMBER"."EMAIL" IS '이메일';
COMMENT ON COLUMN "MEMBER"."PHONE" IS '휴대폰번호';
COMMENT ON COLUMN "MEMBER"."POINT" IS '포인트';
COMMENT ON COLUMN "MEMBER"."ENROLL_DATE" IS '가입일';
COMMENT ON COLUMN "MEMBER"."PRO_PHOTO" IS '프로필사진(선생님대화참고 아이디.jpg이용)';
COMMENT ON COLUMN "MEMBER"."BLACK_YN" IS '블랙리스트 회원 구분 여부';
COMMENT ON COLUMN "MEMBER"."SMS_YN" IS 'SMS수신여부';
COMMENT ON COLUMN "MEMBER"."WARNING_COUNT" IS '경고횟수';
COMMENT ON COLUMN "MEMBER"."URL" IS '사이트 주소';
COMMENT ON COLUMN "MEMBER"."INTRO" IS '소개글';

-- 제약조건 추가
ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER_MEMBER_NO" PRIMARY KEY (
	"MEMBER_NO"
);
ALTER TABLE "MEMBER" ADD CONSTRAINT "CK_MEMBER_BLACK_YN" CHECK(BLACK_YN IN ('Y', 'N'));
ALTER TABLE "MEMBER" ADD CONSTRAINT "CK_MEMBER_SMS_YN" CHECK(SMS_YN IN ('Y', 'N'));

-----------지영 작업-----------
-- 상품 테이블 생성
CREATE TABLE "PRODUCT" (
	"PRODUCT_CODE"	VARCHAR2(100)		NOT NULL,
	"NAME"	VARCHAR2(100)		NOT NULL,
	"PRICE"	NUMBER		NOT NULL,
	"REG_DATE"	DATE		NOT NULL,
	"THUMBNAIL"	VARCHAR2(100)		NULL,
	"CONTENT"	CLOB		NOT NULL,
	"VIEW_COUNT"	NUMBER	DEFAULT 0	NULL,
	"STATUS"	CHAR(1)	DEFAULT 'Y'	NOT NULL
);

-- 상품 테이블 코멘트 추가
COMMENT ON COLUMN "PRODUCT"."PRODUCT_CODE" IS '상품코드';
COMMENT ON COLUMN "PRODUCT"."NAME" IS '상품명';
COMMENT ON COLUMN "PRODUCT"."PRICE" IS '가격';
COMMENT ON COLUMN "PRODUCT"."REG_DATE" IS '상품등록일';
COMMENT ON COLUMN "PRODUCT"."THUMBNAIL" IS '썸네일';
COMMENT ON COLUMN "PRODUCT"."CONTENT" IS '내용';
COMMENT ON COLUMN "PRODUCT"."VIEW_COUNT" IS '조회수';
COMMENT ON COLUMN "PRODUCT"."STATUS" IS '공개(Y) 비공개(N)';

-- 상품 테이블 제약조건 추가
ALTER TABLE "PRODUCT" ADD CONSTRAINT "PK_PRODUCT_PRODUCT_CODE" PRIMARY KEY (
	"PRODUCT_CODE"
);
ALTER TABLE "PRODUCT" ADD CONSTRAINT "CK_PRODUCT_STATUS" CHECK(STATUS IN ('Y', 'N'));

-- 상품 상세 테이블 생성
-- ◆상품코드 외래키 제약 조건 부모 데이터 삭제 디폴트 상태
CREATE TABLE "PRODUCT_DETAIL" (
	"DETAIL_NO"	NUMBER		NOT NULL,
	"PRODUCT_CODE"	VARCHAR2(100)		NOT NULL,
	"OPTION_NO"	NUMBER		NULL,
	"OPTION_CONTENT"	VARCHAR2(256)		NULL,
	"SKU"	VARCHAR2(50)		NULL,
	"QUANTITY"	NUMBER		NULL,
    CONSTRAINT PK_PRODUCT_DETAIL_DETAIL_NO PRIMARY KEY(DETAIL_NO),
    CONSTRAINT FK_PRODUCT_DETAIL_PRODUCT_CODE FOREIGN KEY(PRODUCT_CODE) REFERENCES PRODUCT(PRODUCT_CODE)
);

-- 상품 상세 테이블 코멘트 추가
COMMENT ON COLUMN "PRODUCT_DETAIL"."DETAIL_NO" IS '상품 상세 번호';
COMMENT ON COLUMN "PRODUCT_DETAIL"."PRODUCT_CODE" IS '상품코드';
COMMENT ON COLUMN "PRODUCT_DETAIL"."OPTION_NO" IS '옵션번호';
COMMENT ON COLUMN "PRODUCT_DETAIL"."OPTION_CONTENT" IS '옵션 설명';
COMMENT ON COLUMN "PRODUCT_DETAIL"."SKU" IS '제품 단위';
COMMENT ON COLUMN "PRODUCT_DETAIL"."QUANTITY" IS '재고량';

-- 상품 상세 테이블 시퀀스 생성
create sequence SEQ_PRODUCT_DETAIL_NO;


--수업시간 참고
create table board_comment (
    no number,
    comment_level number default 1, -- 댓글 1, 대댓글 2
    writer varchar2(20),
    content varchar2(2000),
    board_no number,
    comment_ref number, -- 대댓글인 경우 참조하는 댓글번호(no)
    reg_date date default sysdate,
    constraint pk_board_comment_no primary key(no),
    constraint fk_board_comment_writer foreign key(writer) references member(member_id),
    constraint fk_board_comment_board_no foreign key(board_no) 
                                          references board(no) on delete cascade,
    constraint fk_board_comment_ref foreign key(comment_ref) 
                                     references board_comment(no) on delete cascade
);


-- 상품 문의 테이블 생성
CREATE TABLE "QUESTION_PRODUCT" (
	"QUESTION_NO"	number		NOT NULL,
	"QUESTION_REF_NO"	number		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"PRODUCT_CODE"	VARCHAR2(100)		NOT NULL,
	"TITLE"	varchar2(300)		NOT NULL,
	"CONTENT"	varchar2(500)		NOT NULL,
	"ENROLL_DATE"	date	DEFAULT SYSDATE NOT NULL,
	"PASSWORD"	char(4)		NULL,
	"PRIVATE_YN"	char(1)	DEFAULT 'N'	NOT NULL,
	"LEVEL"	NUMBER	DEFAULT 1	NULL,
    CONSTRAINT PK_QUESTION_PRODUCT_QUESTION_NO PRIMARY KEY(QUESTION_NO),
    constraint fk_QUESTION_PRODUCT_QUESTION_REF_NO foreign key(QUESTION_REF_NO) 
                                     references QUESTION_PRODUCT(QUESTION_NO) on delete cascade,
    constraint fk_QUESTION_PRODUCT_MEMBER_NO foreign key(MEMBER_NO) references member(MEMBER_NO),
    constraint fk_QUESTION_PRODUCT_PRODUCT_CODE foreign key(PRODUCT_CODE) 
                                          references PRODUCT(PRODUCT_CODE) on delete cascade,
    CONSTRAINT CK_QUESTION_PRODUCT_PRIVATE_YN CHECK(PRIVATE_YN IN ('Y', 'N'))
);

-- 상품 문의 테이블 시퀀스 생성
create sequence SEQ_QUESTION_PRODUCT_NO;



-----------지원 작업-----------



-----------종서 작업-----------


-----------태영 작업-----------


