SELECT * from all_users;
ALTER SESSION set "_oracle_script" = true;
-- scott(사용자)/ tiger (비밀번호) / 일반 사용자 권한

create user hr
IDENTIFIED by hr
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;

GRANT CONNECT, resource, UNLIMITED TABLESPACE to hr; -- scott 계정에 사용자 권한 부여