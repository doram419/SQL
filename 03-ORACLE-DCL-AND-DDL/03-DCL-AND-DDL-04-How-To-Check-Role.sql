-- 현재 사용자에게 부여된 ROLE의 확인
SELECT * FROM USER_ROLE_PRIVS;

-- CONNECT와 RESOURCE 역할은 어떤 권한으로 구성되어 있는가?
-- sysdba로 진행
-- cmd
-- sqlplus sys/oracle as sysdba
-- DESC role_sys_privs;
-- CONNECT 롤에는 어떤 권한이 포함되어 있는가?
-- SELECT privilege FROM role_sys_privs WHERE role = 'CONNECT';
-- RESOURCE 롤에는 어떤 권한이 포함되어 있는가?
-- SELECT privilege FROM role_sys_privs WHERE role = 'RESOURCE';