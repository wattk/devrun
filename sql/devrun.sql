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

select * from member;

  	select
	    c.community_no,
	    c.title,
	    m.nickname,
	   	to_char(c.enroll_date, 'YYYY/MM/DD HH24:MI:SS') enroll_date,
	   	c.like_count,
	   	c.view_count
	from
	    community c join member m on
	    c.member_no = m.member_no
	where
		page_code = 4 and
        title like '%리%'
	order by
	    community_no desc;

-- 회원 번호 시퀀스 생성
create sequence seq_member_no;

select * from authorities;
select* from member;

insert into
    member
values(
    seq_member_no.nextval,'admin3','관리자','관리대대장','$2a$10$TbR6ofHw9G5.aBQCElFq3eVhEGsEznJApYteJG3rJ06h10DoNkPaO',to_date('2000/10/10','YYYY/MM/DD'),'admin@naver.com','01011111111',0,to_date('2020/12/16','YYYY/MM/DD'),null,'N','N',0,NULL,NULL
);

insert into
    authorities
values(
    'ROLE_AM',47
);

insert into
    authorities
values(
    'AM',29
);




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

--회원 테이블 delete 트리거 추가
create trigger trg_delete_member
		after
		delete on member
		for each row
begin
		insert into
				delete_member
		values
				(
					:old.member_no,
					:old.id,
					:old.name,
					:old.nickname,
					:old.password,
					:old.birthday,
					:old.email,
					:old.phone,
					:old.point,
					:old.enroll_date,
					:old.pro_photo,
					:old.black_yn,
					:old.sms_yn,
					:old.warning_count,
					:old.url,
					:old.intro,
					sysdate
				);
end;

-----------지영 작업-----------

-- 삭제된 회원 테이블 생성
CREATE TABLE "DELETE_MEMBER" (
	"MEMBER_NO"	number		NOT NULL,
	"ID"	VARCHAR2(50)		NULL,
	"NAME"	VARCHAR2(50)		NOT NULL,
	"NICKNAME"	VARCHAR2(50)		NOT NULL,
	"PASSWORD"	VARCHAR2(300)		NOT NULL,
	"BIRTHDAY"	DATE		NOT NULL,
	"EMAIL"	VARCHAR2(300)		NOT NULL,
	"PHONE"	CHAR(11)		NOT NULL,
	"POINT"	NUMBER	NULL,
	"ENROLL_DATE"	DATE		NOT NULL,
	"PRO_PHOTO"	VARCHAR2(100)		NULL,
	"BLACK_YN"	CHAR(1)		NULL,
	"SMS_YN"	CHAR(1)		NULL,
	"WARNING_COUNT"	NUMBER	NULL,
	"URL"	VARCHAR2(500)		NULL,
	"INTRO"	VARCHAR2(1000)		NULL,
	"QUIT_DATE"	DATE	DEFAULT SYSDATE	NULL
);

-- 삭제된 회원 테이블 코멘트 추가
COMMENT ON COLUMN "DELETE_MEMBER"."MEMBER_NO" IS '회원 번호';
COMMENT ON COLUMN "DELETE_MEMBER"."ID" IS '회원 아이디';
COMMENT ON COLUMN "DELETE_MEMBER"."NAME" IS '회원 이름';
COMMENT ON COLUMN "DELETE_MEMBER"."NICKNAME" IS '회원 닉네임';
COMMENT ON COLUMN "DELETE_MEMBER"."PASSWORD" IS '비밀번호';
COMMENT ON COLUMN "DELETE_MEMBER"."BIRTHDAY" IS '생일';
COMMENT ON COLUMN "DELETE_MEMBER"."EMAIL" IS '이메일';
COMMENT ON COLUMN "DELETE_MEMBER"."PHONE" IS '휴대폰번호';
COMMENT ON COLUMN "DELETE_MEMBER"."POINT" IS '포인트';
COMMENT ON COLUMN "DELETE_MEMBER"."ENROLL_DATE" IS '가입일';
COMMENT ON COLUMN "DELETE_MEMBER"."PRO_PHOTO" IS '프로필사진(선생님대화참고 아이디.jpg이용)';
COMMENT ON COLUMN "DELETE_MEMBER"."BLACK_YN" IS '블랙리스트 회원 구분 여부';
COMMENT ON COLUMN "DELETE_MEMBER"."SMS_YN" IS 'SMS수신여부';
COMMENT ON COLUMN "DELETE_MEMBER"."WARNING_COUNT" IS '경고횟수';
COMMENT ON COLUMN "DELETE_MEMBER"."URL" IS '사이트 주소';
COMMENT ON COLUMN "DELETE_MEMBER"."INTRO" IS '소개글';
COMMENT ON COLUMN "DELETE_MEMBER"."QUIT_DATE" IS '탈퇴일';

-- 삭제된 권한 테이블 생성
CREATE TABLE "DELETE_AUTHORITIES" (
	"AUTHORITY"	VARCHAR2(30)		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL
);

-- 삭제된 권한 테이블 코멘트 추가
COMMENT ON COLUMN "DELETE_AUTHORITIES"."MEMBER_NO" IS '회원번호';
COMMENT ON COLUMN "DELETE_AUTHORITIES"."AUTHORITY" IS '회원(M1, M2) , 관리자(AM)';

-- 상품 테이블 생성
CREATE TABLE "PRODUCT" (
	"PRODUCT_CODE"	VARCHAR2(100)		NOT NULL,
	"NAME"	VARCHAR2(100)		NOT NULL,
	"PRICE"	NUMBER		NOT NULL,
	"REG_DATE"	DATE		NOT NULL,
	"THUMBNAIL"	VARCHAR2(100)		NOT NULL,
	"CONTENT"	CLOB		NOT NULL,
	"VIEW_COUNT"	NUMBER	DEFAULT 0	NULL,
	"STATUS"	CHAR(1)	DEFAULT 'Y'	NOT NULL
);

--상품 테이블 판매수 컬럼 추가
ALTER TABLE PRODUCT ADD (ORDER_COUNT NUMBER DEFAULT 0);


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

-- 상품 문의 테이블 생성
-- ◆[참조 문의 번호], [상품코드] 부모 삭제 시 on delete cascade로 참조하는 행 함께 삭제된다. [회원번호]는 디폴트 상태
CREATE TABLE "QUESTION_PRODUCT" (
	"QUESTION_NO"	number		NOT NULL,
	"QUESTION_REF_NO"	number		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"PRODUCT_CODE"	VARCHAR2(100)		NOT NULL,
	"TITLE"	varchar2(300)		NOT NULL,
	"CONTENT"	varchar2(500)		NOT NULL,
	"ENROLL_DATE"	date	DEFAULT SYSDATE NOT NULL,
	"PRIVATE_YN"	char(1)	DEFAULT 'N'	NOT NULL,
	"Q_LEVEL"	NUMBER	DEFAULT 1	NULL,
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

-- 상품 문의 테이블 코멘트 추가
COMMENT ON COLUMN "QUESTION_PRODUCT"."QUESTION_NO" IS '문의 번호';
COMMENT ON COLUMN "QUESTION_PRODUCT"."QUESTION_REF_NO" IS '참조 문의 번호';
COMMENT ON COLUMN "QUESTION_PRODUCT"."MEMBER_NO" IS '회원 번호';
COMMENT ON COLUMN "QUESTION_PRODUCT"."PRODUCT_CODE" IS '상품코드';
COMMENT ON COLUMN "QUESTION_PRODUCT"."TITLE" IS '제목';
COMMENT ON COLUMN "QUESTION_PRODUCT"."CONTENT" IS '내용';
COMMENT ON COLUMN "QUESTION_PRODUCT"."ENROLL_DATE" IS '등록일';
COMMENT ON COLUMN "QUESTION_PRODUCT"."PRIVATE_YN" IS '비밀글 여부';
COMMENT ON COLUMN "QUESTION_PRODUCT"."LEVEL" IS '문의 레벨';

-- drop table WISHLIST;
-- drop table MEMBER_WISHLIST;

-- 상품 찜 테이블 생성
-- ◆상품코드 외래키 제약 조건 부모 데이터 삭제 디폴트 상태
CREATE TABLE "WISHLIST" (
	"WISHLIST_NO"	NUMBER		NOT NULL,
	"PRODUCT_CODE"	VARCHAR2(100)		NOT NULL,
	"REG_DATE"	DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_WISHLIST_WISHLIST_NO PRIMARY KEY(WISHLIST_NO),
    constraint fk_WISHLIST_PRODUCT_CODE foreign key(PRODUCT_CODE) references PRODUCT(PRODUCT_CODE) on delete cascade
);

-- 상품 찜 테이블 시퀀스 생성
create sequence SEQ_WISHLIST_NO;

-- 상품 찜 테이블 코멘트 추가
COMMENT ON COLUMN "WISHLIST"."WISHLIST_NO" IS '번호';
COMMENT ON COLUMN "WISHLIST"."PRODUCT_CODE" IS '상품코드';
COMMENT ON COLUMN "WISHLIST"."REG_DATE" IS '등록일';

-- 회원-상품 찜 테이블 생성
-- ◆외래키 제약 조건 전부 디폴트 상태
CREATE TABLE "MEMBER_WISHLIST" (
	"WISHLIST_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
    constraint PK_MEMBER_WISHLIST primary key(WISHLIST_NO, MEMBER_NO),
    constraint FK_MEMBER_WISHLIST_WISHLIST_NO foreign key(WISHLIST_NO) references WISHLIST(WISHLIST_NO)on delete cascade ,
    constraint FK_MEMBER_WISHLIST_MEMBER_NO foreign key(MEMBER_NO) references MEMBER(MEMBER_NO) on delete cascade
);

-- 회원-상품 찜 테이블 코멘트 추가
COMMENT ON COLUMN "MEMBER_WISHLIST"."WISHLIST_NO" IS '찜 번호';
COMMENT ON COLUMN "MEMBER_WISHLIST"."MEMBER_NO" IS '회원 번호';

-- 리뷰 테이블 생성
-- ◆외래키 제약 조건 디폴트 상태
CREATE TABLE "REVIEW" (
	"REVIEW_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
    "ID"	VARCHAR2(50)		NOT NULL,
	"PRODUCT_CODE"	VARCHAR2(100)		NOT NULL,
	"CONTENT"	VARCHAR2(3000)		NOT NULL,
	"LIKE_COUNT"	NUMBER	DEFAULT 0	NULL,
	"REG_DATE"	DATE	DEFAULT current_date NOT NULL,
	"RATE"	NUMBER	DEFAULT 5	NOT NULL,
    CONSTRAINT PK_REVIEW_REVIEW_NO PRIMARY KEY(REVIEW_NO),
    constraint FK_REVIEW_MEMBER_NO foreign key(MEMBER_NO) references MEMBER(MEMBER_NO),
    constraint FK_REVIEW_PRODUCT_CODE foreign key(PRODUCT_CODE) references PRODUCT(PRODUCT_CODE)
);


-- 리뷰 테이블 시퀀스 생성
create sequence SEQ_REVIEW_NO;

-- 리뷰 테이블 코멘트 추가
COMMENT ON COLUMN "REVIEW"."REVIEW_NO" IS '리뷰 번호';
COMMENT ON COLUMN "REVIEW"."MEMBER_NO" IS '작성자';
COMMENT ON COLUMN "REVIEW"."ID" IS '회원 아이디';
COMMENT ON COLUMN "REVIEW"."PRODUCT_CODE" IS '상품코드';
COMMENT ON COLUMN "REVIEW"."TITLE" IS '제목';
COMMENT ON COLUMN "REVIEW"."CONTENT" IS '내용';
COMMENT ON COLUMN "REVIEW"."LIKE_COUNT" IS '좋아요수';
COMMENT ON COLUMN "REVIEW"."REG_DATE" IS '등록일';
COMMENT ON COLUMN "REVIEW"."RATE" IS '별점';

select * from review;

-- 리뷰 첨부파일 테이블 생성
-- ◆외래키 제약 조건 디폴트 상태 - 삭제 테이블 옮겨져야 되서 디폴트로 놓음.
CREATE TABLE "REVIEW_ATTACHMENT" (
	"REVIEW_ATTACH_NO"	NUMBER		NOT NULL,
	"REVIEW_NO"	NUMBER		NOT NULL,
	"ORIGINAL_FILENAME"	VARCHAR2(500)		NULL,
	"RENAMED_FILENAME"	VARCHAR2(500)		NULL,
	"REG_DATE"	DATE	DEFAULT sysdate	NOT NULL,
    CONSTRAINT PK_REVIEW_ATTACHMENT_NO PRIMARY KEY(REVIEW_ATTACH_NO),
    constraint FK_REVIEW_ATTACHMENT_REVIEW_NO foreign key(REVIEW_NO) references REVIEW(REVIEW_NO) on delete cascade
);

-- 리뷰 첨부파일 테이블 시퀀스 생성
create sequence SEQ_REVIEW_ATTACHMENT_NO;

-- 리뷰 첨부파일 테이블 코멘트 추가
COMMENT ON COLUMN "REVIEW_ATTACHMENT"."REVIEW_ATTACH_NO" IS '리뷰 첨부파일 번호';
COMMENT ON COLUMN "REVIEW_ATTACHMENT"."REVIEW_NO" IS '리뷰 번호';
COMMENT ON COLUMN "REVIEW_ATTACHMENT"."ORIGINAL_FILENAME" IS '기존 파일명';
COMMENT ON COLUMN "REVIEW_ATTACHMENT"."RENAMED_FILENAME" IS '변경된 파일명';
COMMENT ON COLUMN "REVIEW_ATTACHMENT"."REG_DATE" IS '등록일';

-- 삭제된 리뷰 테이블 생성
CREATE TABLE "DELETE_REVIEW" (
	"REVIEW_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"PRODUCT_CODE"	VARCHAR2(100)		NOT NULL,
	"TITLE"	VARCHAR2(300)		NOT NULL,
	"CONTENT"	VARCHAR2(500)		NOT NULL,
	"LIKE_COUNT"	NUMBER	NULL,
	"REG_DATE"	DATE NOT NULL,
	"RATE"	NUMBER	NOT NULL,
    "DELETE_DATE"	DATE	DEFAULT SYSDATE NOT NULL
);

-- 삭제된 리뷰 테이블 코멘트 추가
COMMENT ON COLUMN "DELETE_REVIEW"."REVIEW_NO" IS '리뷰 번호';
COMMENT ON COLUMN "DELETE_REVIEW"."TITLE" IS '제목';
COMMENT ON COLUMN "DELETE_REVIEW"."CONTENT" IS '내용';
COMMENT ON COLUMN "DELETE_REVIEW"."LIKE_COUNT" IS '좋아요수';
COMMENT ON COLUMN "DELETE_REVIEW"."REG_DATE" IS '등록일';
COMMENT ON COLUMN "DELETE_REVIEW"."PRODUCT_CODE" IS '상품코드';
COMMENT ON COLUMN "DELETE_REVIEW"."MEMBER_NO" IS '회원 번호';
COMMENT ON COLUMN "DELETE_REVIEW"."RATE" IS '별점';
COMMENT ON COLUMN "DELETE_REVIEW"."DELETE_DATE" IS '삭제일';



-- 삭제된 리뷰 첨부파일 테이블 생성
CREATE TABLE "DELETE_REVIEW_ATTACHMENT" (
	"REVIEW_ATTACH_NO"	NUMBER		NOT NULL,
	"REVIEW_NO"	NUMBER		NOT NULL,
	"ORIGINAL_FILENAME"	VARCHAR2(500)		NULL,
	"RENAMED_FILENAME"	VARCHAR2(500)		NULL,
	"REG_DATE"	DATE NOT NULL,
    "DELETE_DATE"	DATE	DEFAULT sysdate	NOT NULL
);

-- 삭제된 리뷰 첨부파일 테이블 코멘트 추가
COMMENT ON COLUMN "DELETE_REVIEW_ATTACHMENT"."REVIEW_ATTACH_NO" IS '리뷰 첨부파일 번호';
COMMENT ON COLUMN "DELETE_REVIEW_ATTACHMENT"."ORIGINAL_FILENAME" IS '기존 파일명';
COMMENT ON COLUMN "DELETE_REVIEW_ATTACHMENT"."RENAMED_FILENAME" IS '변경된 파일명';
COMMENT ON COLUMN "DELETE_REVIEW_ATTACHMENT"."REG_DATE" IS '파일 등록일';
COMMENT ON COLUMN "DELETE_REVIEW_ATTACHMENT"."REVIEW_NO" IS '리뷰 번호';
COMMENT ON COLUMN "DELETE_REVIEW_ATTACHMENT"."DELETE_DATE" IS '파일 삭제일';



-- 회원-리뷰 좋아요 테이블 생성
-- ◆외래키 제약 조건 전부 디폴트 상태
CREATE TABLE "MEMBER_REVIEW_LIKE" (
	"REVIEW_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
    constraint PK_MEMBER_REVIEW_LIKE primary key(REVIEW_NO, MEMBER_NO),
    constraint FK_MEMBER_REVIEW_LIKE_REVIEW_NO foreign key(REVIEW_NO) references REVIEW(REVIEW_NO) on delete cascade,
    constraint FK_MEMBER_REVIEW_LIKE_MEMBER_NO foreign key(MEMBER_NO) references MEMBER(MEMBER_NO) on delete cascade
);


-- 회원-리뷰 좋아요 테이블 코멘트 추가
COMMENT ON COLUMN "MEMBER_REVIEW_LIKE"."REVIEW_NO" IS '리뷰 번호';
COMMENT ON COLUMN "MEMBER_REVIEW_LIKE"."MEMBER_NO" IS '회원 번호';

-----------종서 작업-----------
-- 전체 게시물 수
select count(*) from community;



-- community sample insert
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판2', '자유게시판2', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판3', '자유게시판3', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판4', '자유게시판4', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판5', '자유게시판5', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판6', '자유게시판6', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판7', '자유게시판7', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판8', '자유게시판8', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판9', '자유게시판9', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판10', '자유게시판10', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판11', '자유게시판11', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판12', '자유게시판12', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판13', '자유게시판13', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판14', '자유게시판14', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판15', '자유게시판15', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판16', '자유게시판16', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판17', '자유게시판17', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판18', '자유게시판18', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판19', '자유게시판19', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판20', '자유게시판20', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판21', '자유게시판21', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판22', '자유게시판22', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판23', '자유게시판23', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판24', '자유게시판24', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판25', '자유게시판25', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판26', '자유게시판26', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판27', '자유게시판27', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판28', '자유게시판28', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판29', '자유게시판29', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판30', '자유게시판30', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판31', '자유게시판31', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판32', '자유게시판32', sysdate, default, default, 'N', default, default);
INSERT INTO community(community_no, member_no, page_code, title, content, enroll_date, view_count, like_count, answer_yn, hashtag, thumbnail) VALUES(seq_community_no.nextval, 31, 4, '자유게시판33', '자유게시판33', sysdate, default, default, 'N', default, default);
commit;


select * from community;
alter table community drop column thumnail;
alter table community add (thumbnail clob);
commit;

CREATE TABLE "MEMBER_REVIEW_LIKE" (
	"REVIEW_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
    constraint PK_MEMBER_REVIEW_LIKE primary key(REVIEW_NO, MEMBER_NO),
    constraint FK_MEMBER_REVIEW_LIKE_REVIEW_NO foreign key(REVIEW_NO) references REVIEW(REVIEW_NO) on delete cascade,
    constraint FK_MEMBER_REVIEW_LIKE_MEMBER_NO foreign key(MEMBER_NO) references MEMBER(MEMBER_NO) on delete cascade
);
drop table member_community_like;
-- 회원-커뮤니티 좋아요
create table member_community_likee(
    community_no number not null,
    member_no number not null,
    constraint pk_member_community_likee primary key(community_no, member_no),
    constraint fk_member_community_likee_community_no foreign key(community_no) references community(community_no) on delete cascade,
    constraint fk_member_community_likee_member_no foreign key(member_no) references member(member_no) on delete cascade
 );
commit;

select * from member_community_like;
-- 커뮤니티 테이블 시퀀스 생성
CREATE SEQUENCE SEQ_COMMUNITY_NO;



select * from community_comment;
select * from community;

DROP TABLE community CASCADE CONSTRAINTS;
DROP TABLE community;
-- 커뮤니티 테이블 생성
CREATE TABLE "COMMUNITY" (
	"COMMUNITY_NO"	NUMBER NOT NULL,
	"MEMBER_NO"	NUMBER NOT NULL,
	"PAGE_CODE"	NUMBER	NOT NULL,
	"TITLE"	VARCHAR2(100)	NOT NULL,
	"CONTENT"	CLOB NOT NULL,
	"ENROLL_DATE"	DATE DEFAULT SYSDATE	NOT NULL,
	"VIEW_COUNT"	NUMBER	DEFAULT 0	NULL,
	"LIKE_COUNT"	NUMBER	DEFAULT 0	NULL,
	"THUMBNAIL"	CLOB	NULL,
	"ANSWER_YN"	CHAR(1)	DEFAULT 'N' NULL,
	"HASHTAG"	VARCHAR2(300)	NULL,
    CONSTRAINT PK_COMMUNITY_COMMUNITY_NO PRIMARY KEY (COMMUNITY_NO),
    CONSTRAINT FK_COMMUNITY_MEMBER_NO FOREIGN KEY (MEMBER_NO) REFERENCES MEMBER (MEMBER_NO),
    CONSTRAINT CK_COMMUNITY_ANSWER_YN CHECK(ANSWER_YN IN ('Y', 'N'))
);


ALTER TABLE  community DROP CONSTRAINT fk_community_member_no;
ALTER TABLE  community DROP CONSTRAINT ck_community_answer_yn;
ALTER TABLE  community DROP CONSTRAINT pk_community_community_no;


-- 커뮤니티 테이블 코멘트 추가
COMMENT ON COLUMN "COMMUNITY"."COMMUNITY_NO" IS '게시글 번호 SEQ';
COMMENT ON COLUMN "COMMUNITY"."MEMBER_NO" IS '회원 번호';
COMMENT ON COLUMN "COMMUNITY"."PAGE_CODE" IS '글의 페이지 종류';
COMMENT ON COLUMN "COMMUNITY"."TITLE" IS '제목';
COMMENT ON COLUMN "COMMUNITY"."CONTENT" IS '내용';
COMMENT ON COLUMN "COMMUNITY"."ENROLL_DATE" IS '작성일';
COMMENT ON COLUMN "COMMUNITY"."VIEW_COUNT" IS '조회수';
COMMENT ON COLUMN "COMMUNITY"."LIKE_COUNT" IS '좋아요 수';
COMMENT ON COLUMN "COMMUNITY"."THUMNAIL" IS '썸네일';
COMMENT ON COLUMN "COMMUNITY"."ANSWER_YN" IS '해결 Y 미해결N';
COMMENT ON COLUMN "COMMUNITY"."HASHTAG" IS '글 관련 해시태그, 구분자/';

commit;

-- 커뮤니티 댓글 테이블 시퀀스 생성
CREATE SEQUENCE SEQ_COMMUNITY_COMMENT_NO;

ALTER TABLE  community_comment DROP CONSTRAINT fk_community_comment_community_no;
DROP TABLE COMMUNITY_COMMENT;
-- 커뮤니티 댓글 테이블 생성
CREATE TABLE "COMMUNITY_COMMENT" (
	"COMMENT_NO"	NUMBER	NOT NULL,
	"MEMBER_NO"	NUMBER	NOT NULL,
	"COMMENT_REF_NO"	NUMBER NULL,
	"COMMUNITY_NO"	NUMBER	NOT NULL,
	"COMMENT_LEVEL"	NUMBER	DEFAULT 1	NOT NULL,
	"CONTENT"	VARCHAR2(2000)	 NOT NULL,
	"REG_DATE"	DATE	DEFAULT SYSDATE NOT NULL,
    CONSTRAINT PK_COMMUNITY_COMMENT_COMMENT_NO PRIMARY KEY(COMMENT_NO),
    CONSTRAINT FK_COMMUNITY_COMMENT_MEMBER_NO FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO),
    CONSTRAINT FK_COMMUNITY_COMMENT_COMMENT_REF_NO FOREIGN KEY(COMMENT_REF_NO) REFERENCES COMMUNITY_COMMENT(COMMENT_NO) ON DELETE CASCADE,
    CONSTRAINT FK_COMMUNITY_COMMENT_COMMUNITY_NO FOREIGN KEY(COMMUNITY_NO) REFERENCES COMMUNITY(COMMUNITY_NO) ON DELETE CASCADE
);

-- 커뮤니티 댓글 테이블 코멘트 추가
COMMENT ON COLUMN "COMMUNITY_COMMENT"."COMMENT_NO" IS 'SEQ';
COMMENT ON COLUMN "COMMUNITY_COMMENT"."MEMBER_NO" IS '작성자';
COMMENT ON COLUMN "COMMUNITY_COMMENT"."COMMENT_REF_NO" IS 'SEQ';
COMMENT ON COLUMN "COMMUNITY_COMMENT"."COMMUNITY_NO" IS '게시글 번호 SEQ';
COMMENT ON COLUMN "COMMUNITY_COMMENT"."COMMENT_LEVEL" IS '댓글 1 대댓글 2';
COMMENT ON COLUMN "COMMUNITY_COMMENT"."CONTENT" IS '댓글내용';
COMMENT ON COLUMN "COMMUNITY_COMMENT"."REG_DATE" IS '댓글 등록일';

-- 뱃지 테이블 시퀀스 생성
CREATE SEQUENCE SEQ_BADGE_NO;

-- DROP TABLE BADGE;
-- 뱃지 테이블 생성
CREATE TABLE "BADGE" (
	"BADGE_CODE" VARCHAR2(10) NOT NULL,
	"NAME"	VARCHAR2(50)	 NOT NULL,
	"IMAGE" VARCHAR2(500) NULL,
	"CONTENT" CLOB NULL,
    CONSTRAINT PK_BADGE_BADGE_CODE PRIMARY KEY(BADGE_CODE)
);

-- 뱃지 테이블 코멘트 추가
COMMENT ON COLUMN "BADGE"."BADGE_CODE" IS '뱃지 코드';
COMMENT ON COLUMN "BADGE"."NAME" IS '뱃지 이름';
COMMENT ON COLUMN "BADGE"."IMAGE" IS '뱃지 이미지';
COMMENT ON COLUMN "BADGE"."CONTENT" IS '뱃지 설명';

-- 회원-뱃지 테이블 시퀀스 생성
CREATE SEQUENCE SEQ_MEMBER_BADGE_NO;

-- DROP TABLE MEMBER_BADGE;
-- 회원-뱃지 테이블 생성
CREATE TABLE "MEMBER_BADGE" (
	"MEMBER_NO"	NUMBER	NOT NULL,
	"BADGE_CODE" VARCHAR2(10) NOT NULL,
	"BADGE_MAIN_YN" CHAR(1) DEFAULT 'N'	NULL,
	"GET_DATE"	DATE NULL,
    CONSTRAINT FK_MEMBER_BADGE_MEMBER_NO FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO),
    CONSTRAINT FK_MEMBER_BADGE_BADGE_CODE FOREIGN KEY(BADGE_CODE) REFERENCES BADGE(BADGE_CODE),
    CONSTRAINT CK_MEMBER_BADGE_BADGE_MAIN_YN CHECK(BADGE_MAIN_YN IN ('Y', 'N'))
);

-- 회원- 뱃지 코멘트 추가
COMMENT ON COLUMN "MEMBER_BADGE"."MEMBER_NO" IS '회원 번호';
COMMENT ON COLUMN "MEMBER_BADGE"."BADGE_CODE" IS '뱃지 코드';
COMMENT ON COLUMN "MEMBER_BADGE"."BADGE_MAIN_YN" IS '대표 뱃지 선택 여부';
COMMENT ON COLUMN "MEMBER_BADGE"."GET_DATE" IS '뱃지 취득일';

-- 포인트 테이블 시퀀스 생성
CREATE SEQUENCE SEQ_POINT_NO;

-- 포인트 테이블 생성
CREATE TABLE "POINT" (
	"POINT_NO"	NUMBER NOT NULL,
	"MEMBER_NO"	NUMBER NOT NULL,
	"VAL" NUMBER NULL,
	"CONTENT"	VARCHAR2(50)	 NULL,
	"STATUS"	CHAR(1) NULL,
	"DATA"	DATE NULL,
    CONSTRAINT PK_POINT_POINT_NO PRIMARY KEY(POINT_NO),
    CONSTRAINT FK_POINT_MEMBER_NO FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO),
    CONSTRAINT CK_POINT_STATUS CHECK(STATUS IN ('G', 'U'))
);

-- 포인트 코멘트 추가
COMMENT ON COLUMN "POINT"."MEMBER_NO" IS '회원 번호';
COMMENT ON COLUMN "POINT"."STATUS" IS '적립 G, 사용 U';
COMMENT ON COLUMN "POINT"."DATA" IS '포인트 이용일';


--=============================신고
-- DROP TABLE REPORT;
-- DROP TABLE REPORT_CATEGORY;

-- 신고사유 분류 테이블 생성
CREATE TABLE "REPORT_CATEGORY" (
	"REASON_CATE" CHAR(1) NOT NULL,
	"REASON_NAME"	VARCHAR2(30) NOT NULL,
    CONSTRAINT PK_REPORT_CATEGORY_REASON_CATE PRIMARY KEY(REASON_CATE)
);

-- 신고 사유 분류 코멘트 추가
COMMENT ON COLUMN "REPORT_CATEGORY"."REASON_CATE" IS '신고사유 분류번호';
COMMENT ON COLUMN "REPORT_CATEGORY"."REASON_NAME" IS '신고사유 분류명';

--신고사유 분류 테이블 데이터 추가
insert into REPORT_CATEGORY values('1','욕설/비방');
insert into REPORT_CATEGORY values('2','광고/홍보글');
insert into REPORT_CATEGORY values('3','음란/선정성');
insert into REPORT_CATEGORY values('4','게시글도배');
insert into REPORT_CATEGORY values('5','관련없는이미지/내용');
insert into REPORT_CATEGORY values('6','기타');

-- 신고 테이블 시퀀스 생성
CREATE SEQUENCE SEQ_REPORT_NO;

--drop table "REPORT_BOARD";
-- 신고 테이블 생성
CREATE TABLE "REPORT" (
	"REPORT_NO"	NUMBER	NOT NULL,
	"REASON_CATE"	CHAR(1) NOT NULL,
    "REPORT_ROOT_CATE" VARCHAR(2) NOT NULL,
	"MEMBER_NO"	NUMBER NOT NULL,
    "ID"	VARCHAR2(50)		NOT NULL,
    "TARGET_PK_NO" VARCHAR2(50) NOT NULL, 
    "REPORT_CONTENT" CLOB,
    "SIDENOTE" VARCHAR2(600),
	"STATUS"	VARCHAR2(2)	DEFAULT 'PR' NOT NULL,
	"REG_DATE"	DATE	DEFAULT current_date NOT NULL,
	"MEMBER_NO2" NUMBER,
    "CONFIRM_DATE" DATE,
    CONSTRAINT PK_REPORT_REPORT_NO PRIMARY KEY(REPORT_NO),
    CONSTRAINT FK_REPORT_REASON_CATE FOREIGN KEY(REASON_CATE) REFERENCES REPORT_CATEGORY(REASON_CATE),
    CONSTRAINT CK_REPORT_REPORT_ROOT_CATE CHECK(REPORT_ROOT_CATE IN ('CB','CR','MB','MM','PR')),
    CONSTRAINT CK_REPORT_STATUS CHECK(STATUS IN ('PR','DR','CF'))
);

-- 신고 테이블 코멘트 추가
COMMENT ON COLUMN "REPORT"."REPORT_NO" IS '신고번호';
COMMENT ON COLUMN "REPORT"."REASON_CATE" IS '신고사유 분류번호';
COMMENT ON COLUMN "REPORT"."REPORT_ROOT_CATE" IS '신고분야 카테고리';
COMMENT ON COLUMN "REPORT"."MEMBER_NO" IS '신고자';
COMMENT ON COLUMN "REPORT"."ID" IS '신고자 아이디';
COMMENT ON COLUMN "REPORT"."TARGET_PK_NO" IS '신고 대상 pk 번호';
COMMENT ON COLUMN "REPORT"."REPORT_CONTENT" IS '신고 대상 글';
COMMENT ON COLUMN "REPORT"."SIDENOTE" IS '신고 사유 부가 설명';
COMMENT ON COLUMN "REPORT"."STATUS" IS '처리상태';
COMMENT ON COLUMN "REPORT"."REG_DATE" IS '등록일';
COMMENT ON COLUMN "REPORT"."MEMBER_NO2" IS '처리한 관리자 번호';
COMMENT ON COLUMN "REPORT"."CONFIRM_DATE" IS '관리자 신고 처리 날짜';



-- 채팅 테이블 시퀀스 생성
CREATE SEQUENCE SEQ_CHAT_MEMBER_NO;

-- DROP TABLE CHAT_MEMBER;
-- 채팅 테이블 생성
CREATE TABLE "CHAT_MEMBER" (
	"CHAT_ID" CHAR(20)	NOT NULL,
	"MEMBER_NO"	NUMBER NOT NULL,
	"MEMBER_NO2" NUMBER NULL,
	"LAST_CHECK" NUMBER	DEFAULT 0	NULL,
	"START_DATE" 	DATE DEFAULT CURRENT_DATE	NULL,
	"END_DATE"	 DATE NULL,
    CONSTRAINT PK_CHAT_MEMBER_CHAT_ID_NO PRIMARY KEY(CHAT_ID, MEMBER_NO)
);

-- 채팅 테이블 코멘트 추가
COMMENT ON COLUMN "CHAT_MEMBER"."CHAT_ID" IS '채팅 번호';
COMMENT ON COLUMN "CHAT_MEMBER"."MEMBER_NO" IS '회원 번호';
COMMENT ON COLUMN "CHAT_MEMBER"."MEMBER_NO2" IS '상대방 회원 번호';
COMMENT ON COLUMN "CHAT_MEMBER"."LAST_CHECK" IS '최근 확인 시간';
COMMENT ON COLUMN "CHAT_MEMBER"."START_DATE" IS '채팅 시작일';
COMMENT ON COLUMN "CHAT_MEMBER"."END_DATE" IS '채팅 종료일';

-- 채팅 테이블 상태 컬럼 추가
ALTER TABLE CHAT_MEMBER ADD STATUS CHAR(1) DEFAULT 'Y' NOT NULL;

-- 채팅 로그 시퀀스 생성
CREATE SEQUENCE SEQ_CHAT_LOG_NO;

-- DROP TABLE CHAT_LOG;
-- 채팅 로그 테이블 생성
CREATE TABLE "CHAT_LOG" (
	"NO"	NUMBER	NOT NULL,
	"CHAT_ID" CHAR(20) NOT NULL,
	"MEMBER_NO"	NUMBER NOT NULL,
	"MSG" VARCHAR2(2000) NOT NULL,
	"LOG_TIME"	NUMBER NOT NULL,
    CONSTRAINT PK_CHAT_LOG_NO PRIMARY KEY(NO),
    CONSTRAINT FK_CHAT_ID_MEMBER_NO FOREIGN KEY(CHAT_ID, MEMBER_NO) REFERENCES CHAT_MEMBER(CHAT_ID, MEMBER_NO)
);

-- 채팅 로그 테이블 코멘트 추가
COMMENT ON COLUMN "CHAT_LOG"."NO" IS '채팅 로그 넘버';
COMMENT ON COLUMN "CHAT_LOG"."CHAT_ID" IS '채팅 번호';
COMMENT ON COLUMN "CHAT_LOG"."MEMBER_NO" IS '회원 번호';
COMMENT ON COLUMN "CHAT_LOG"."MSG" IS '메세지';
COMMENT ON COLUMN "CHAT_LOG"."LOG_TIME" IS '채팅 시간';


-- 삭제된 커뮤니티 테이블 생성
CREATE TABLE "DELETE_COMMUNITY" (
	"COMMUNITY_NO" NUMBER NOT NULL,
	"MEMBER_NO"	number NOT NULL,
    "PAGE_CODE"	NUMBER NOT NULL,
	"TITLE"	VARCHAR2(50)	 NOT NULL,
	"CONTENT"	CLOB NOT NULL,
	"ENROLL_DATE" DATE NOT NULL,
	"VIEW_COUNT" NUMBER	 NOT NULL,
    "LIKE_COUNT"	NUMBER NULL,
	"THUMNAIL" VARCHAR2(500) NULL,
    "ANSWER_YN"	CHAR(1) NULL,
	"HASHTAG"	VARCHAR2(300)	NULL,
	"DELETE_DATE" DATE DEFAULT SYSDATE NULL
);

SELECT * FROM ALL_COL_COMMENTS WHERE TABLE_NAME = 'DELETE_COMMUNITY';

-- 삭제된 커뮤니티 테이블 코멘트 추가
COMMENT ON COLUMN "DELETE_COMMUNITY"."COMMUNITY_NO" IS '게시글 번호 SEQ';
COMMENT ON COLUMN "DELETE_COMMUNITY"."MEMBER_NO" IS '회원 번호';
COMMENT ON COLUMN "DELETE_COMMUNITY"."PAGE_CODE" IS '글의 페이지 종류';
COMMENT ON COLUMN "DELETE_COMMUNITY"."TITLE" IS '제목';
COMMENT ON COLUMN "DELETE_COMMUNITY"."CONTENT" IS '내용';
COMMENT ON COLUMN "DELETE_COMMUNITY"."ENROLL_DATE" IS '작성일';
COMMENT ON COLUMN "DELETE_COMMUNITY"."VIEW_COUNT" IS '조회수';
COMMENT ON COLUMN "DELETE_COMMUNITY"."LIKE_COUNT" IS '좋아요 수';
COMMENT ON COLUMN "DELETE_COMMUNITY"."THUMNAIL" IS '썸네일';
COMMENT ON COLUMN "DELETE_COMMUNITY"."ANSWER_YN" IS 'Y OR N';
COMMENT ON COLUMN "DELETE_COMMUNITY"."HASHTAG" IS '글 관련 해시태그, 구분자/';
COMMENT ON COLUMN "DELETE_COMMUNITY"."DELETE_DATE" IS '삭제일';

-- 삭제된 커뮤니티 댓글 테이블 생성
CREATE TABLE "DELETE_COMMUNITY_COMMENT" (
	"COMMENT_NO"	NUMBER		NOT NULL,
	"COMMENT_LEVEL"	NUMBER	DEFAULT 1	NOT NULL,
	"CONTENT"	VARCHAR2(300)		NOT NULL,
	"REG_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"COMMUNITY_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	number		NOT NULL,
	"COMMENT_NO2"	NUMBER		NOT NULL,
	"DELETE_DATE"	DATE	DEFAULT SYSDATE	NULL
);

-- 삭제된 커뮤니티 댓글 테이블 코멘트 추가
COMMENT ON COLUMN "DELETE_COMMUNITY_COMMENT"."COMMENT_NO" IS 'SEQ';
COMMENT ON COLUMN "DELETE_COMMUNITY_COMMENT"."COMMENT_LEVEL" IS '댓글 1 대댓글 2';
COMMENT ON COLUMN "DELETE_COMMUNITY_COMMENT"."CONTENT" IS '댓글내용';
COMMENT ON COLUMN "DELETE_COMMUNITY_COMMENT"."COMMUNITY_NO" IS '게시글 번호 SEQ';
COMMENT ON COLUMN "DELETE_COMMUNITY_COMMENT"."MEMBER_NO" IS '회원 번호';
COMMENT ON COLUMN "DELETE_COMMUNITY_COMMENT"."COMMENT_NO2" IS 'SEQ';


-- 공지사항 테이블 생성
CREATE TABLE "NOTICE" (
	"NOTICE_NO"	NUMBER NOT NULL,
	"MEMBER_NO"	NUMBER NOT NULL,
	"TITLE"	VARCHAR2(100) NULL,
	"CONTENT"	CLOB NULL,
	"ENROLL_DATE"	DATE DEFAULT CURRENT_DATE NULL,
	"VIEW_COUNT"	NUMBER DEFAULT 0 NULL,
	"NOTICE_CODE"	CHAR(1) NULL
);

--공지테이블 NOTICE_NO PK 제약조건 추가
ALTER TABLE "NOTICE" ADD CONSTRAINT "PK_NOTICE_NOTICE_NO" PRIMARY KEY (
	"NOTICE_NO"
);

-- 공지사항 테이블 시퀀스 생성
create sequence SEQ_NOTICE_NO;

-- 공지사항 테이블 코멘트 추가
COMMENT ON COLUMN "NOTICE"."NOTICE_NO" IS '공지번호';
COMMENT ON COLUMN "NOTICE"."MEMBER_NO" IS '작성자';
COMMENT ON COLUMN "NOTICE"."TITLE" IS '공지명';
COMMENT ON COLUMN "NOTICE"."CONTENT" IS '공지내용';
COMMENT ON COLUMN "NOTICE"."ENROLL_DATE" IS '작성일';
COMMENT ON COLUMN "NOTICE"."VIEW_COUNT" IS '조회수';
COMMENT ON COLUMN "NOTICE"."NOTICE_CODE" IS '공지 N, 자주묻는질문 - 쇼핑몰 S, 커뮤니티 C, 기타 E';

-- 삭제된 공지사항 테이블 생성
CREATE TABLE "DELETE_NOTICE" (
	"NOTICE_NO"	NUMBER NOT NULL,
	"MEMBER_NO"	NUMBER NOT NULL,
	"TITLE"	VARCHAR2(100) NULL,
	"CONTENT"	CLOB NULL,
	"ENROLL_DATE"	DATE NULL,
	"VIEW_NUM"	NUMBER NULL,
	"DELETE_DATE"	DATE DEFAULT CURRENT_DATE NULL,
	"NOTICE_CODE"	CHAR(1) NULL
);

-- 삭제된 공지사항 테이블 코멘트 추가
COMMENT ON COLUMN "DELETE_NOTICE"."NOTICE_NO" IS '공지번호';
COMMENT ON COLUMN "DELETE_NOTICE"."MEMBER_NO" IS '작성자';
COMMENT ON COLUMN "DELETE_NOTICE"."TITLE" IS '공지명';
COMMENT ON COLUMN "DELETE_NOTICE"."CONTENT" IS '공지내용';
COMMENT ON COLUMN "DELETE_NOTICE"."ENROLL_DATE" IS '작성일';
COMMENT ON COLUMN "DELETE_NOTICE"."VIEW_COUNT" IS '조회수';
COMMENT ON COLUMN "DELETE_NOTICE"."DELETE_DATE" IS '삭제일';
COMMENT ON COLUMN "DELETE_NOTICE"."NOTICE_CODE" IS '공지 N, 자주묻는질문 - 쇼핑몰 S, 커뮤니티 C, 기타 E';


-- 공지사항 테이블 delete trigger 생성
create or replace trigger trg_delete_notice
    after
    delete on notice
    for each row
begin
    insert into
        delete_notice
    values(
        :old.notice_no,
		:old.member_no,
		:old.title,
		:old.content,
		:old.enroll_date,
		:old.view_count,
		default,
		:old.notice_code
    );
end;
/

-- 상품 대분류 카테고리 테이블 시퀀스 생성
CREATE SEQUENCE SEQ_PRODUCT_PARENT_CATEGORY_NO;

-- DROP TABLE PRODUCT_PARENT_CATEGORY;
-- 상품 대분류 카테고리 테이블 생성
CREATE TABLE "PRODUCT_PARENT_CATEGORY" (
	"PARENT_CATEGORY_CODE"	VARCHAR2(10)	 NOT NULL,
	"PARENT_CATEGORY_TITLE"	VARCHAR2(50)	 NOT NULL,
    CONSTRAINT PK_PRODUCT_PARENT_CATEGORY_PARENT_CATEGORY_CODE PRIMARY KEY(PARENT_CATEGORY_CODE)
);

-- 상품 대분류 카테고리 테이블 코멘트 추가
COMMENT ON COLUMN "PRODUCT_PARENT_CATEGORY"."PARENT_CATEGORY_CODE" IS '대분류 코드';
COMMENT ON COLUMN "PRODUCT_PARENT_CATEGORY"."PARENT_CATEGORY_TITLE" IS '대분류 이름';

-- 상품 소분류 카테고리 테이블 시퀀스 생성
CREATE SEQUENCE SEQ_PRODUCT_CHILD_CATEGORY_NO;

-- 상품 소분류 카테고리 테이블 생성
CREATE TABLE "PRODUCT_CHILD_CATEGORY" (
	"CHILD_CATEGORY_CODE"	VARCHAR2(10) NOT NULL,
	"PARENT_CATEGORY_CODE"	VARCHAR2(10) NOT NULL,
	"CHILD_CATEGORY_TITLE"	VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_PRODUCT_CHILD_CATEGORY_CHILD_CATEGORY_CODE PRIMARY KEY(CHILD_CATEGORY_CODE),
    CONSTRAINT FK_PRODUCT_CHILD_CATEGORY_PARENT_CATEGORY_CODE FOREIGN KEY(PARENT_CATEGORY_CODE) REFERENCES PRODUCT_PARENT_CATEGORY(PARENT_CATEGORY_CODE)
);

-- 상품 소분류 카테고리 테이블 코멘트 추가
COMMENT ON COLUMN "PRODUCT_CHILD_CATEGORY"."CHILD_CATEGORY_CODE" IS '소분류 코드';
COMMENT ON COLUMN "PRODUCT_CHILD_CATEGORY"."PARENT_CATEGORY_CODE" IS '대분류 코드';
COMMENT ON COLUMN "PRODUCT_CHILD_CATEGORY"."CHILD_CATEGORY_TITLE" IS '소분류 이름';

-- 상품-분류 테이블 시퀀스 생성
CREATE SEQUENCE SEQ_PRODUCT_CATEGORY_NO;

-- DROP TABLE PRODUCT_CATEGORY;
-- 상품-분류 테이블 생성
CREATE TABLE "PRODUCT_CATEGORY" (
	"CHILD_CATEGORY_CODE"	VARCHAR2(10)	 NOT NULL,
	"PRODUCT_CODE" VARCHAR2(100)	 NOT NULL,
    CONSTRAINT FK_PRODUCT_CATEGORY_CHILD_CATEGORY_CODE FOREIGN KEY(CHILD_CATEGORY_CODE) REFERENCES PRODUCT_CHILD_CATEGORY(CHILD_CATEGORY_CODE),
    CONSTRAINT FK_PRODUCT_CATEGORY_PRODUCT_CODE FOREIGN KEY(PRODUCT_CODE) REFERENCES PRODUCT(PRODUCT_CODE)
);

-- 상품-분류 테이블 코멘트 생성
COMMENT ON COLUMN "PRODUCT_CATEGORY"."CHILD_CATEGORY_CODE" IS '소분류 코드';
COMMENT ON COLUMN "PRODUCT_CATEGORY"."PRODUCT_CODE" IS '상품코드';


-- 판매 이벤트 정보 테이블 시퀀스 생성
CREATE SEQUENCE SEQ_PROMOTION_NO;

-- 판매 이벤트 정보 테이블 생성
CREATE TABLE "PROMOTION" (
	"PROMOTION_CODE" VARCHAR(100) NOT NULL,
	"NAME"	VARCHAR(300)	 NOT NULL,
	"START_DATE"	DATE NOT NULL,
	"END_DATE" DATE NOT NULL,
	"SIDE_NOTE" CLOB	 NOT NULL,
	"IS_REGULAR"	NUMBER DEFAULT 0 NOT NULL,
	"BANNER"	VARCHAR(500)	 NULL,
	"VIEW_COUNT" NUMBER	DEFAULT 0 NULL,
	"MEMBER_NO"	NUMBER NOT NULL,
    "ENROLL_DATE" DATE DEFAULT SYSDATE,
    CONSTRAINT PK_PROMOTION_PROMOTION_CODE PRIMARY KEY(PROMOTION_CODE),
    CONSTRAINT CK_PROMOTION_IS_REGULAR CHECK(IS_REGULAR IN(0,1))
);

ALTER TABLE PROMOTION ADD (NICKNAME VARCHAR2(50) NOT NULL);
-- 판매 이벤트 정보 테이블 코멘트 추가
COMMENT ON COLUMN "PROMOTION"."PROMOTION_CODE" IS '이벤트 코드';
COMMENT ON COLUMN "PROMOTION"."NAME" IS '이벤트 명';
COMMENT ON COLUMN "PROMOTION"."START_DATE" IS '이벤트 시작일';
COMMENT ON COLUMN "PROMOTION"."END_DATE" IS '이벤트 종료일';
COMMENT ON COLUMN "PROMOTION"."SIDE_NOTE" IS '부가설명';
COMMENT ON COLUMN "PROMOTION"."IS_REGULAR" IS '정기 이벤트 유무';
COMMENT ON COLUMN "PROMOTION"."BANNER" IS '이벤트.png';
COMMENT ON COLUMN "PROMOTION"."VIEW_COUNT" IS '조회수';
COMMENT ON COLUMN "PROMOTION"."MEMBER_NO" IS '작성자';

-- 상품-이벤트 테이블 시퀀스 생성
CREATE SEQUENCE SEQ_PRODUCT_PROMOTION_NO;

-- 상품-이벤트 테이블 생성
CREATE TABLE "PRODUCT_PROMOTION" (
	"PRODUCT_CODE" VARCHAR2(100) NOT NULL,
	"PROMOTION_CODE" VARCHAR(100) NOT NULL,
    CONSTRAINT FK_PRODUCT_PROMOTION_PRODUCT_CODE FOREIGN KEY(PRODUCT_CODE) REFERENCES PRODUCT(PRODUCT_CODE),
    CONSTRAINT FK_PRODUCT_PROMOTION_PROMOTION_CODE FOREIGN KEY(PROMOTION_CODE) REFERENCES PROMOTION(PROMOTION_CODE)
);

-- 상품-이벤트 테이블 코멘트 추가
COMMENT ON COLUMN "PRODUCT_PROMOTION"."PRODUCT_CODE" IS '상품코드';
COMMENT ON COLUMN "PRODUCT_PROMOTION"."PROMOTION_CODE" IS '이벤트 코드';

-- 상품-이벤트 테이블 on delete 조건 추가
ALTER TABLE PRODUCT_PROMOTION DROP CONSTRAINT FK_PRODUCT_PROMOTION_PRODUCT_CODE;
ALTER TABLE PRODUCT_PROMOTION DROP CONSTRAINT FK_PRODUCT_PROMOTION_PROMOTION_CODE;
ALTER TABLE PRODUCT_PROMOTION ADD CONSTRAINT FK_PRODUCT_PROMOTION_PRODUCT_CODE FOREIGN KEY(PRODUCT_CODE) REFERENCES PRODUCT(PRODUCT_CODE) ON DELETE CASCADE;
ALTER TABLE PRODUCT_PROMOTION ADD CONSTRAINT FK_PRODUCT_PROMOTION_PROMOTION_CODE FOREIGN KEY(PROMOTION_CODE) REFERENCES PROMOTION(PROMOTION_CODE) ON DELETE CASCADE;

-- 재고 로그 테이블 시퀀스 추가
CREATE SEQUENCE SEQ_QUANTITY_LOG_NO;

-- DROP TABLE QUANTITY_LOG;
-- 재고 로그 테이블 테이블 생성
CREATE TABLE "QUANTITY_LOG" (
	"QUANTITY_LOG_NO"	NUMBER NOT NULL,
	"DETAIL_NO" NUMBER NOT NULL,
	"PREV_QUANTITY" NUMBER NULL,
	"CURRENT_QUANTITY" NUMBER NULL,
	"STATUS"	CHAR(1) NULL,
	"LOG_DATE"	DATE NULL,
    CONSTRAINT PK_QUANTITY_LOG_QUANTITY_LOG_NO PRIMARY KEY(QUANTITY_LOG_NO)
);

-- 재고 로그 테이블 코멘트 추가
COMMENT ON COLUMN "QUANTITY_LOG"."OUANTITY_LOG_NO" IS '로그 번호';
COMMENT ON COLUMN "QUANTITY_LOG"."DETAIL_NO" IS '제품 상세 번호';


-----------지원, 태영 작업-----------

--===========================
--주문 테이블 생성
--===========================
CREATE TABLE MERCHANT (
	MERCHANT_UID	VARCHAR2(50)	NOT NULL,
	MEMBER_NO	NUMBER	NOT NULL	,
	ORDER_DATE	DATE	 DEFAULT SYSDATE,
	ORDER_STATUS	CHAR(2) DEFAULT 'OR'	NOT NULL,
	CS_STATUS	CHAR(3) DEFAULT 'COM' NOT NULL,
	POINT_VALUE	NUMBER DEFAULT 0	NOT NULL,
	PRODUCT_PRICE	NUMBER	NOT NULL	,
	SHIPPING_FEE	NUMBER	NOT NULL	,
	TOTAL_PRICE	NUMBER	NOT NULL	,
	SHIPPING_REQ	VARCHAR2(100)	NULL	,
    CONSTRAINT PK_MERCHANT_MERCHANT_UID PRIMARY KEY (MERCHANT_UID),
    CONSTRAINT FK_MERCHANT_MEMBER_NO FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO)
);

ALTER TABLE MERCHANT ADD CONSTRAINT CK_MERCHANT_ORDER_STATUS CHECK(ORDER_STATUS IN ('OR', 'PP', 'SS', 'OC'));
ALTER TABLE MERCHANT ADD CONSTRAINT CK_MERCHANT_CS_STATUS CHECK(CS_STATUS IN ('COM','REF','EXC','RET','CAN','FNI'));

CREATE TABLE MERCHANT_DETAIL (
	DETAIL_NO	NUMBER	NOT NULL	,
	MERCHANT_UID	VARCHAR2(50)	NOT NULL	,
	BUY_COUNT	NUMBER	NULL	
);

ALTER TABLE MERCHANT_DETAIL ADD CONSTRAINT PK_MERCHANT_DETAIL PRIMARY KEY (
	DETAIL_NO,
	MERCHANT_UID
);
ALTER TABLE MERCHANT_DETAIL ADD CONSTRAINT FK_MERCHANT_DETAIL_DETAIL_NO FOREIGN KEY (
	DETAIL_NO
)
REFERENCES PRODUCT_DETAIL (
	DETAIL_NO
);

ALTER TABLE MERCHANT_DETAIL ADD CONSTRAINT FK_MERCHANT_DETAIL_MERCHANT_UID FOREIGN KEY (
	MERCHANT_UID
)
REFERENCES MERCHANT (
	MERCHANT_UID
);


--===========================
--배송 테이블 생성
--===========================
CREATE TABLE "SHIPMENT" (
	"SHIPMENT_NO"	NUMBER		NOT NULL,
	"TRACKING_NO"	CHAR(12)		NULL,
	"MERCHANT_UID"	VARCHAR2(50)		NOT NULL,
	"ORDER_LOG_UID"	VARCHAR2(50)		NULL,
	"SHIPMENT_DATE"	DATE		default sysdate,
	CONSTRAINT PK_SHIPMENT_SHIPMENT_NO PRIMARY KEY(SHIPMENT_NO),
	CONSTRAINT FK_SHIPMENT_MERCHANT_UID FOREIGN KEY(MERCHANT_UID) REFERENCES MERCHANT(MERCHANT_UID),
	CONSTRAINT FK_SHIPMENT_ORDER_LOG_UID FOREIGN KEY(ORDER_LOG_UID) REFERENCES ORDER_LOG(ORDER_LOG_UID)
);

--배송 테이블 코멘트 추가
COMMENT ON COLUMN "SHIPMENT"."SHIPMENT_NO" IS '배송 번호';
COMMENT ON COLUMN "SHIPMENT"."TRACKING_NUMBER" IS '운송장 번호';
COMMENT ON COLUMN "SHIPMENT"."MERCHANT_UID" IS '주문 번호';
COMMENT ON COLUMN "SHIPMENT"."ORDER_LOG_UID" IS '변동 기록 일자';
COMMENT ON COLUMN "SHIPMENT"."SHIPMENT_DATE" IS '발송 일자';

--배송 테이블 SEQ
CREATE SEQUENCE SEQ_SHIPMENT_NO;


--===========================
--장바구니 테이블 생성
--===========================
CREATE TABLE "CART" (
	"CART_NO"	NUMBER		NOT NULL,
	"DETAIL_NO"	NUMBER		NOT NULL,
	"AMOUNT"	NUMBER	DEFAULT 1	NOT NULL,
	"REG_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	CONSTRAINT PK_CART_CART_NO PRIMARY KEY(CART_NO),
	CONSTRAINT FK_CART_DETAIL_NO FOREIGN KEY(DETAIL_NO) REFERENCES PRODUCT_DETAIL(DETAIL_NO)
);

--장바구니 테이블 코멘트 추가
COMMENT ON COLUMN "CART"."CART_NO" IS '장바구니 번호';
COMMENT ON COLUMN "CART"."DETAIL_NO" IS '상품 상세 번호';
COMMENT ON COLUMN "CART"."AMOUNT" IS '상품수량';
COMMENT ON COLUMN "CART"."REG_DATE" IS '장바구니 등록일';

--장바구니 테이블 SEQ
CREATE SEQUENCE SEQ_CART_NO;


--===========================
--쪽지 테이블 생성
--===========================
CREATE TABLE "MESSAGE" (
	"MESSAGE_NO"	NUMBER		NOT NULL,
	"ROOM_NO"	NUMBER		NOT NULL,
	"MEMBER_NO1"	NUMBER		NOT NULL,
	"MEMBER_NO2"	NUMBER		NOT NULL,
	"SEND_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"READ_CHK"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"MESSAGE_CONTENT"	VARCHAR(1000)		NOT NULL,
	CONSTRAINT PK_MESSAGE_MESSAGE_NO PRIMARY KEY(MESSAGE_NO),
	CONSTRAINT FK_MESSAGE_MEMBER_NO_1 FOREIGN KEY(MEMBER_NO1) REFERENCES MEMBER(MEMBER_NO),
	CONSTRAINT FK_MESSAGE_MEMBER_NO_2 FOREIGN KEY(MEMBER_NO2) REFERENCES MEMBER(MEMBER_NO),
	CONSTRAINT CK_MESSAGE_READ_CHK CHECK(READ_CHK IN('Y','N'))
);

--쪽지 테이블 코멘트 추가
COMMENT ON COLUMN "MESSAGE"."MESSAGE_NO" IS '메세지 번호';
COMMENT ON COLUMN "MESSAGE"."ROOM_NO" IS '메세지 방 번호';
COMMENT ON COLUMN "MESSAGE"."MEMBER_NO1" IS '발신자 번호';
COMMENT ON COLUMN "MESSAGE"."MEMBER_NO2" IS '수신자 번호';
COMMENT ON COLUMN "MESSAGE"."SEND_DATE" IS '발신일시';
COMMENT ON COLUMN "MESSAGE"."READ_CHK" IS '읽음 Y, 읽지않음 N';
COMMENT ON COLUMN "MESSAGE"."MESSAGE_CONTENT" IS '메세지 내용';

--쪽지 테이블 SEQ
CREATE SEQUENCE SEQ_MESSAGE_NO;

--쪽지 테이블 삭제 (채팅, 채팅로그 테이블로 이용)
--DROP TABLE MESSAGE;

--쪽지 시퀀스 삭제
--DROP SEQUENCE SEQ_MESSAGE_NO;


--===========================
--주소 테이블 생성
--===========================
CREATE TABLE "ADDRESS" (
	"ADDRESS_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"POSTAL_CODE"	VARCHAR2(7)		NOT NULL,
	"ADDRESS1"	VARCHAR2(100)		NOT NULL,
	"ADDRESS2"	VARCHAR2(100)		NULL,
	"MAIN_YN"	CHAR(1)	DEFAULT 'N'	NOT NULL,
	"TITLE"	VARCHAR2(20)		NULL,
	"ADDRESSEE"	VARCHAR2(10)		NULL,
	"PHONE"	CHAR(11)		NULL,
	CONSTRAINT PK_ADDRESS_ADDRESS_NO PRIMARY KEY(ADDRESS_NO),
	CONSTRAINT FK_ADDRESS_MEMBER_NO FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO),
	CONSTRAINT CK_ADDRESS_MAIN_YN CHECK(MAIN_YN IN ('Y','N'))
);

--주소 테이블 코멘트 추가
COMMENT ON COLUMN "ADDRESS"."ADDRESS_NO" IS '주소번호';
COMMENT ON COLUMN "ADDRESS"."MEMBER_NO" IS '회원번호';
COMMENT ON COLUMN "ADDRESS"."POSTAL_CODE" IS '우편코드';
COMMENT ON COLUMN "ADDRESS"."ADDRESS1" IS '일반주소';
COMMENT ON COLUMN "ADDRESS"."ADDRESS2" IS '상세주소';
COMMENT ON COLUMN "ADDRESS"."MAIN_YN" IS '기본 배송지 여부 Y, N';
COMMENT ON COLUMN "ADDRESS"."TITLE" IS '대표명';
COMMENT ON COLUMN "ADDRESS"."ADDRESSEE" IS '수령인';
COMMENT ON COLUMN "ADDRESS"."PHONE" IS '연락처';

--주소 테이블 SEQ
CREATE SEQUENCE SEQ_ADDRESS_NO;



--===========================
--블랙리스트 테이블 생성
--===========================
CREATE TABLE "BLACKLIST" (
	"BLACKLIST_NO"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"REG_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"RELEASE_DATE"	DATE		NULL,
	"NOTE"	CLOB		NULL,
	"MEMBER_NO2"	NUMBER		NULL,
	CONSTRAINT PK_BLACKLIST_BLACKLIST_NO PRIMARY KEY(BLACKLIST_NO),
  CONSTRAINT FK_BLACKLIST_MEMBER_NO FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO)
);

--블랙리스트 테이블 코멘트 추가
COMMENT ON COLUMN "BLACKLIST"."BLACKLIST_NO" IS '번호';
COMMENT ON COLUMN "BLACKLIST"."MEMBER_NO" IS '회원번호';
COMMENT ON COLUMN "BLACKLIST"."REG_DATE" IS '등록일';
COMMENT ON COLUMN "BLACKLIST"."RELEASE_DATE" IS '등록 해제일';
COMMENT ON COLUMN "BLACKLIST"."NOTE" IS '블랙리스트 등록/해제 관련 메모';
COMMENT ON COLUMN "BLACKLIST"."MEMBER_NO2" IS '관리자 번호';

--블랙리스트 테이블 SEQ
CREATE SEQUENCE SEQ_BLACKLIST;


--===========================
--변경사유 분류 테이블 생성
--===========================
CREATE TABLE "REASON_CATEGORY" (
	"REASON_CODE"	CHAR(1)		NOT NULL,
	"REASON_NAME"	VARCHAR2(1000)		NULL,
	CONSTRAINT PK_REASON_CATEGORY_REASON_CODE PRIMARY KEY(REASON_CODE),
	CONSTRAINT CK_REASON_CATEGORY_REASON_CODE CHECK(REASON_CODE IN ('O','P','D'))
);

--변경사유 분류 테이블 코멘트 추가
COMMENT ON COLUMN "REASON_CATEGORY"."REASON_CODE" IS '사유코드';
COMMENT ON COLUMN "REASON_CATEGORY"."REASON_NAME" IS '분류명';


--===========================
--결제 테이블 생성
--추후 API 사용시 변경될 예정
--===========================
CREATE TABLE IMP (
	IMP_UID 	VARCHAR2(50)	NOT NULL,
	MERCHANT_UID	VARCHAR2(50)	NOT NULL,
	PG_PROVIDER	VARCHAR2(50)	NULL,
	NAME	VARCHAR2(100)	NULL,
	PAY_METHOD	VARCHAR2(50)	NULL,
	AMOUNT	NUMBER	NULL,
	BUYER_ADDR	VARCHAR2(100)	NULL,
	BUYER_EMAIL	VARCHAR2(100)	NULL,
	BUYER_NAME	VARCHAR2(10)	NULL,
	BUYER_POSTCODE	CHAR(5)	NULL,
	BUYER_PHONE	CHAR(11)	NULL
);
ALTER TABLE IMP ADD CONSTRAINT PK_IMP_IMP_UID PRIMARY KEY (
	IMP_UID
);

ALTER TABLE IMP MODIFY BUYER_ADDR VARCHAR2(500);
ALTER TABLE IMP ADD IS_CANCELED NUMBER DEFAULT 0;
ALTER TABLE IMP ADD RECEIPT_URL VARCHAR2(100);
ALTER TABLE IMP MODIFY RECEIPT_URL VARCHAR2(500);
ALTER TABLE IMP ADD CONSTRAINT CK_IMP_IS_CANCELED CHECK(IS_CANCELED IN (0,1));


--===========================
--회원-장바구니 테이블 생성
--===========================
CREATE TABLE "MEMBER_CART" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"CART_NO"	NUMBER		NOT NULL,
	CONSTRAINT PK_MEMBER_CART_MEMBER_NO_CART_NO PRIMARY KEY(MEMBER_NO, CART_NO),
	CONSTRAINT FK_MEMBER_CART_MEMBER_NO FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO),
	CONSTRAINT FK_MEMBER_CART_CART_NO FOREIGN KEY(CART_NO) REFERENCES CART(CART_NO)
);

--회원-장바구니 테이블 코멘트 추가
COMMENT ON COLUMN "MEMBER_CART"."MEMBER_NO" IS '회원 번호';
COMMENT ON COLUMN "MEMBER_CART"."CART_NO" IS '장바구니 번호';

-- member_cart 제약조건 on delete cascade 추가
--ALTER TABLE MEMBER_CART DROP CONSTRAINT FK_MEMBER_CART_MEMBER_NO;
--ALTER TABLE MEMBER_CART ADD CONSTRAINT  FK_MEMBER_CART_MEMBER_NO FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO) ON DELETE CASCADE;
--ALTER TABLE MEMBER_CART DROP CONSTRAINT FK_MEMBER_CART_CART_NO;
--ALTER TABLE MEMBER_CART ADD CONSTRAINT  FK_MEMBER_CART_CART_NO FOREIGN KEY(CART_NO) REFERENCES CART(CART_NO) ON DELETE CASCADE;

--===========================
--주문 변동 기록 테이블 생성
--===========================
CREATE TABLE ORDER_LOG(
	"ORDER_LOG_UID"	VARCHAR2(50)		NOT NULL,
	"REASON_CODE"	CHAR(1)		NULL,
	"MERCHANT_UID"	VARCHAR2(50)		NOT NULL,
	"PREV_DETAIL_NO"	NUMBER		NULL,
	"CURR_DETAIL_NO"	NUMBER		NULL,
	"CS_STATUS"	CHAR(3)		NULL,
	"REQ_DATE"	DATE		NULL,
	"PROCESS_DATE"	DATE		NULL,
	"END_DATE"	DATE		NULL,
	"COST_STATUS"	CHAR(1)		NULL,
	"COST"	NUMBER		NULL,
	"REASON_DETAIL"	CLOB		NULL,
	"MEMBER_NO"	NUMBER		NULL
);
ALTER TABLE ORDER_LOG ADD CONSTRAINT PK_ORDER_LOG_ORDER_LOG_UID PRIMARY KEY(ORDER_LOG_UID);
ALTER TABLE ORDER_LOG ADD CONSTRAINT FK_ORDER_LOG_MERCHANT_UID FOREIGN KEY(MERCHANT_UID) REFERENCES "MERCHANT"(MERCHANT_UID);
ALTER TABLE ORDER_LOG ADD CONSTRAINT CK_ORDER_LOG_COST_STATUS CHECK(COST_STATUS IN ('Y','N'));
ALTER TABLE ORDER_LOG ADD CONSTRAINT CK_ORDER_LOG_SC_STATUS CHECK(CS_STATUS IN ('COM','REF','EXC','RET','CAN','FNI'));

--주문 변동 기록 테이블 코멘트 추가
COMMENT ON COLUMN "ORDER_LOG"."ORDER_LOG_UID" IS '변동 기록 번호';
COMMENT ON COLUMN "ORDER_LOG"."REASON_CODE" IS '사유 코드';
COMMENT ON COLUMN "ORDER_LOG"."MERCHANT_UID" IS '주문 번호';
COMMENT ON COLUMN "ORDER_LOG"."PREV_OPTION_NO" IS '기존 옵션 번호';
COMMENT ON COLUMN "ORDER_LOG"."CURR_OPTION_NO" IS '변경 옵션 번호';
COMMENT ON COLUMN "ORDER_LOG"."CS_STATUS" IS '상품 처리 상태';
COMMENT ON COLUMN "ORDER_LOG"."REQ_DATE" IS '요청 일자';
COMMENT ON COLUMN "ORDER_LOG"."PROCESS_DATE" IS '진행 일자';
COMMENT ON COLUMN "ORDER_LOG"."END_DATE" IS '완료 일자';
COMMENT ON COLUMN "ORDER_LOG"."COST_STATUS" IS '비용 처리 여부 Y,N';
COMMENT ON COLUMN "ORDER_LOG"."COST" IS '차액';
COMMENT ON COLUMN "ORDER_LOG"."REASON_DETAIL" IS '상세 사유';
COMMENT ON COLUMN "ORDER_LOG"."MEMBER_NO" IS '회원 번호';

--주문 변동 테이블 SEQ
CREATE SEQUENCE  SEQ_ORDER_LOG_NO;


--===========================
--권한 테이블 생성
--===========================
CREATE TABLE "AUTHORITIES" (
	"AUTHORITY"	varchar2(30)	DEFAULT 'ROLE_M1'	NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	CONSTRAINT PK_AUTHORITIES_AUTHORITY_MEMBER_NO PRIMARY KEY(AUTHORITY, MEMBER_NO),
	CONSTRAINT FK_AUTHORITIES_MEMBER_NO FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO)
);

--drop table authorities;

--권한 테이블 코멘트 추가
COMMENT ON COLUMN "AUTHORITIES"."AUTHORITY" IS '회원 M1, M2, 관리자 AM';
COMMENT ON COLUMN "AUTHORITIES"."MEMBER_NO" IS '회원번호';

--FK 제약조건 delete on cascade 추가
ALTER TABLE AUTHORITIES DROP CONSTRAINT FK_AUTHORITIES_MEMBER_NO;
ALTER TABLE AUTHORITIES ADD CONSTRAINT FK_AUTHORITIES_MEMBER_NO FOREIGN KEY (MEMBER_NO) REFERENCES MEMBER(MEMBER_NO) ON DELETE CASCADE;

--권한 테이블 delete 트리거 추가
create trigger trg_delete_authorities
		after
		delete on authorities
		for each row
begin
		insert into
				delete_authorities
		values
				(
					:old.authority,
					:old.member_no
				);
end;


--===========================
--옵션 카테고리 테이블 생성
--===========================
CREATE TABLE "OPTION_CATEGORY" (
	"OPTION_CATOGORY_NO"	NUMBER		NOT NULL,
	"OPTION_NAME"	VARCHAR2(50)		NULL,
	CONSTRAINT PK_OPTION_CATEGORY_OPTION_CATOGORY_NO PRIMARY KEY(OPTION_CATOGORY_NO)
);

--옵션 카테고리 테이블 코멘트 추가
COMMENT ON COLUMN "OPTION_CATEGORY"."OPTION_CATOGORY_NO" IS '옵션 카테고리 번호';
COMMENT ON COLUMN "OPTION_CATEGORY"."OPTION_NAME" IS '옵션 카테고리명';

--옵션 카테고리 테이블 시퀀스 생성
CREATE SEQUENCE SEQ_OPTION_CATEGORY_NO;

---------------------------------------------
--==카테고리 데이터 추가

--대분류
insert into PRODUCT_PARENT_CATEGORY
values('ch','의자');
insert into PRODUCT_PARENT_CATEGORY
values('de','책상');
insert into PRODUCT_PARENT_CATEGORY
values('mo','마우스');
insert into PRODUCT_PARENT_CATEGORY
values('ke','키보드');
insert into PRODUCT_PARENT_CATEGORY
values('mn','모니터');
insert into PRODUCT_PARENT_CATEGORY
values('ot','기타');

--소분류
insert all 
into product_child_category values('1ch', 'ch', '게이밍의자')
into product_child_category values('2ch', 'ch', '자세보정의자')
into product_child_category values('3ch', 'ch', '컴퓨터의자')
into product_child_category values('4ch', 'ch', '책상의자')
into product_child_category values('5ch', 'ch', '접이식의자')
into product_child_category values('6ch', 'ch', '좌식의자')
into product_child_category values('1de', 'de', '높이조절책상')
into product_child_category values('2de', 'de', '스탠딩책상')
into product_child_category values('3de', 'de', '독서실책상')
into product_child_category values('4de', 'de', '접이형책상')
into product_child_category values('5de', 'de', '일반책상')
into product_child_category values('1ot', 'ot', '컴퓨터악세사리')
into product_child_category values('2ot', 'ot', '사무용품')
into product_child_category values('3ot', 'ot', '아이디어상품')
into product_child_category values('4ot', 'ot', '수납상품')
into product_child_category values('5ot', 'ot', '기타상품')
into product_child_category values('1mo', 'mo', '유선마우스')
into product_child_category values('2mo', 'mo', '무선마우스')
into product_child_category values('3mo', 'mo', '저소음마우스')
into product_child_category values('4mo', 'mo', '버티컬마우스')
into product_child_category values('5mo', 'mo', '인체공학마우스')
into product_child_category values('1ke', 'ke', '무접점키보드')
into product_child_category values('2ke', 'ke', '기계식키보드')
into product_child_category values('3ke', 'ke', '게이밍키보드')
into product_child_category values('4ke', 'ke', '인체공학키보드')
into product_child_category values('5ke', 'ke', '무선키보드')
into product_child_category values('1mn', 'mn', '표준모니터')
into product_child_category values('2mn', 'mn', '휴대용모니터')
into product_child_category values('3mn', 'mn', '게이밍모니터')
into product_child_category values('4mn', 'mn', '전문가용모니터')
into product_child_category values('5mn', 'mn', '대화면모니터')
select * from dual;


-- 상품- 분류



-- rank() over()---
SELECT
   A.PRODUCT_CODE
FROM (
   SELECT
      PRODUCT_CODE,
      ROW_NUMBER() OVER(ORDER BY REG_DATE DESC) RN
   FROM PRODUCT
   ORDER BY REG_DATE DESC
) A
WHERE RN = 1;

select
    *
from
    product p left join product_category pc
        on p.product_code = pc.product_code;


select
    m.member_no,
    m.id,
    m.name,
    m.enroll_date,
    a.authority
from
    member m join authorities a on
    m.member_no = a.member_no
where
    authority in('ROLE_AM','ROLE_M1');

select * from QUESTION_PRODUCT;


select seq_question_product_no.currval from dual;
select * from product;

insert into question_product

	select
		*
	from
		question_product
	where
        null != question_ref_no and question_level=1;



values(

    seq_question_product_no.nextval,
    null,
    45,
    'mn-4mn-175',
    '상품 교환 문의',
    '다른걸로 바꿀래요 ~~',
    sysdate,
    'N',
    1 
);
    select * from QUESTION_PRODUCT order by enroll_date;


	SELECT
		  question_no
		FROM (
		   SELECT
		      question_no,
		      ROW_NUMBER() OVER(ORDER BY ENROLL_DATE DESC) RN
		   FROM QUESTION_PRODUCT
		   ORDER BY ENROLL_DATE DESC
		) A
		WHERE RN = 1;




select
    qp.question_no,
    qp.question_ref_no,
    qp.title,
    qp.content,
    qp.private_yn,
    p.product_code,
    p.name,
    p.thumbnail,
    p.price,
    qp.qlevel
from
    question_product qp join product p on
    qp.product_code = p.product_code
where
   qp. question_no = 7 and p.product_code = 'mn-1mn-166';




select * from view_product_parent_category;

-- 김다현 상품 - 상품 관련 모든 테이블 연결 (content 없는 버전)
create view view_product_parent_category
as select
    ccc.*,
    ppc.parent_category_title
from(
    select
        cc.*,
        pcc.child_category_title,
        pcc.parent_category_code
    from(
        select
            p.product_code,
            p.name,
            p.price,
            p.reg_date,
            p.thumbnail,
            p.view_count,
            p.status,
            p.order_count,
            c.child_category_code
        from
            product p join product_category c
            on p.product_code = c.product_code)cc
                join product_child_category pcc
                on cc.child_category_code = pcc.child_category_code)ccc
                    join product_parent_category ppc
                        on ccc.parent_category_code = ppc.parent_category_code;


select * from view_product_all_info;


-- 김다현 상품 - 상품 관련 모든 테이블 연결 (content 있는 버전)
create view view_product_all_info
as select
    ccc.*,
    ppc.parent_category_title
from(
    select
        cc.*,
        pcc.child_category_title,
        pcc.parent_category_code
    from(
        select
            p.*,
            c.child_category_code
        from
            product p join product_category c
            on p.product_code = c.product_code)cc
                join product_child_category pcc
                on cc.child_category_code = pcc.child_category_code)ccc
                    join product_parent_category ppc
                        on ccc.parent_category_code = ppc.parent_category_code;

--주문-결제-상품 뷰 테이블 생성(혜진)
--create or replace view view_merchant_imp
--as
--select
--    m.merchant_uid,
--    m.member_no,
--    m.order_date,
--    m.order_status,
--    m.cs_status,
--    i.name,
--    i.amount,
--    p.product_code,
--    p.thumbnail,
--    pd.detail_no,
--    pd.option_no,
--    pd.option_content,
--    pd.quantity,
--    md.buy_count,
--    m.total_price,
--    (select tracking_no from shipment s where order_log_uid is null and s.merchant_uid = md.merchant_uid) tracking_no
--from
--    merchant m left join imp i
--        on m.merchant_uid = i.merchant_uid
--            left join merchant_detail md
--                on m.merchant_uid = md.merchant_uid
--                    left join product_detail pd
--                        on md.detail_no = pd.detail_no
--                            left join product p
--                                on pd.product_code = p.product_code;

--장바구니-상품 뷰 생성(혜진)
--create or replace view view_cart_product
--as
--select
--  		mc.member_no,
--        p.product_code,
--        p.name,
--        p.thumbnail,
--        p.price,
--         c.reg_date,
--  		c.cart_no,
--        c.amount,
--  		c.detail_no,
--  		pd.option_no,
--        pd.option_content
--from
--    member_cart mc left join cart c
--        on mc.cart_no = c.cart_no
--            left join product_detail pd
--                on c.detail_no = pd.detail_no
--                    left join product p
--                        on pd.product_code = p.product_code;
                                
-- 다현 WISHLIST 테이블 조인한 거                                
create view wishlistInfo
as select
    w.wishlist_no,
    w.PRODUCT_CODE,
    w.REG_DATE,
    mw.MEMBER_NO
from wishlist w join member_wishlist mw
 on w.wishlist_no = mw.wishlist_no;                                


-- 다현 wishlist_product 테이블 조인
create view wishProduct    
as select
    wish.*,
    p.name,
    p.price,
    p.thumbnail,
    p.status
from    
    (select
    w.wishlist_no,
    w.PRODUCT_CODE,
    w.REG_DATE,
    mw.MEMBER_NO
        from wishlist w join member_wishlist mw
         on w.wishlist_no = mw.wishlist_no)wish join product p
            on wish.product_code = p.product_code
order by wish.reg_date desc;


-- (지영) 채팅 나가기 후 상대 메시지 여부 처리에 따른 목록 조회를 위한 뷰 생성
-- chat_member의 end_date값이 null이거나 chat_log 대화 중 end_date(나가기) 이후의 작성한 log가 있다면 조회된다.
-- 회원이 나가기한 채팅방은 chat_member의 end_date가 null 아니며 상대가 대화를 이어가지 않으면 이후의 작성한 log가 존재하지 않는다.
create or replace view view_chat_exit_check
as
select
    distinct(cm.chat_id),
    cm.member_no
from
    chat_member cm join chat_log cl
        on cm.chat_id = cl.chat_id
where
    cm.end_date < TO_TIMESTAMP('1970-01-01 09:00:00.0','YYYY-MM-DD HH24:MI:SS.FF') + NUMTODSINTERVAL(cl.log_time/1000, 'SECOND') or cm.end_date is null;
    
    
    
--김다현 sms 기록 테이블 시작 --
create table sms_waitinglist(
    waitinglist_no number,
    member_no number default -1,
    id varchar2(50) default 'nonMember',
    product_code varchar2(100) not null,
    detail_no number not null,
    phone varchar2(11) not null,
    reg_date Date default current_date not null,
    status char(1) default 'N' not null,
    constraint pk_waitinglist_no primary key(waitinglist_no),
    constraint fk_waitinglist_product_code foreign key(product_code) references product(product_code),
    constraint fk_waitinglist_detail_no foreign key(detail_no) references product_detail(detail_no)
);

create sequence seq_sms_waitinglist_no;


-- sms_waitinglist 코멘트 추가
COMMENT ON COLUMN sms_waitinglist.waitinglist_no IS '대기목록번호';
COMMENT ON COLUMN sms_waitinglist.member_no IS '회원 번호';
COMMENT ON COLUMN sms_waitinglist.id IS '회원 아이디';
COMMENT ON COLUMN sms_waitinglist.product_code IS '상품코드';
COMMENT ON COLUMN sms_waitinglist.detail_no IS '상품옵션코드';
COMMENT ON COLUMN sms_waitinglist.phone IS '전화번호';
COMMENT ON COLUMN sms_waitinglist.reg_date IS '알림신청일';
COMMENT ON COLUMN sms_waitinglist.status IS '메세지발송여부';


--재입고 문자 보낸 뒤 삭제된 대기 목록 
create table delete_sms_waitinglist(
    waitinglist_no number not null,
    member_no number not null,
    id varchar2(50) not null,
    product_code varchar2(100) not null,
    detail_no number not null,
    phone varchar2(11) not null,
    reg_date Date not null,
    complete_date Date default current_date not null,
    status char(1) default 'Y' not null
);


-- delete_sms_waitinglist 코멘트 추가
COMMENT ON COLUMN delete_sms_waitinglist.waitinglist_no IS '대기목록번호';
COMMENT ON COLUMN delete_sms_waitinglist.member_no IS '회원 번호';
COMMENT ON COLUMN delete_sms_waitinglist.id IS '회원 아이디';
COMMENT ON COLUMN delete_sms_waitinglist.product_code IS '상품코드';
COMMENT ON COLUMN delete_sms_waitinglist.detail_no IS '상품옵션코드';
COMMENT ON COLUMN delete_sms_waitinglist.phone IS '전화번호';
COMMENT ON COLUMN delete_sms_waitinglist.reg_date IS '알림신청일';
COMMENT ON COLUMN delete_sms_waitinglist.complete_date IS '재입고 문자 발송 처리날';
COMMENT ON COLUMN delete_sms_waitinglist.status IS '메세지발송여부';


create or replace trigger trg_sms_waitinglist
    after
    delete on sms_waitinglist
    for each row
begin
    insert into
        delete_sms_waitinglist
    values(
        :old.waitinglist_no,
		:old.member_no,
        :old.id,
		:old.product_code,
		:old.detail_no,
		:old.phone,
		:old.reg_date,
		default,
		default
    );
end;

--김다현 sms 기록 테이블 끝 --

----주문 변경-상품-결제 뷰 생성(혜진)
create or replace view view_order_log_imp
as
select
    ol.*,
    i.imp_uid,
    i.name,
    i.amount,
    i.receipt_url,
    p.thumbnail
from
    order_log ol left join imp i
        on ol.merchant_uid = i.merchant_uid
            left join merchant m
                on ol.merchant_uid = m.merchant_uid
                    left join merchant_detail md
                        on ol.merchant_uid = md.merchant_uid
                            left join product_detail pd
                                on md.detail_no = pd.detail_no
                                    left join product p
                                        on pd.product_code = p.product_code;