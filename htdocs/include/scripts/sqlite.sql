PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE config (name VARCHAR PRIMARY KEY, value VARCHAR);
INSERT INTO "config" VALUES('version','0.5');
CREATE TABLE role (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR UNIQUE NOT NULL, admin BOOLEAN NOT NULL, parent_role_id INTEGER REFERENCES role (id));
INSERT INTO "role" VALUES(1,'admin',1,NULL);
INSERT INTO "role" VALUES(2,'user',0,1);
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" VALUES('role',2);
CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR UNIQUE NOT NULL, pass_md5 VARCHAR(32), role_id INTEGER not null REFERENCES role (id));
CREATE TABLE ticket (id VARCHAR(32) PRIMARY KEY, user_id INTEGER NOT NULL REFERENCES user (id), name VARCHAR NOT NULL, path VARCHAR NOT NULL, size INTEGER NOT NULL, cmt VARCHAR, pass_md5 VARCHAR(32), time INTEGER NOT NULL, downloads INTEGER NOT NULL DEFAULT 0, last_stamp INTEGER, last_time INTEGER, expire INTEGER, expire_last INTEGER, expire_dln INTEGER, notify_email VARCHAR);
CREATE TABLE grant (id VARCHAR(32) PRIMARY KEY, user_id INTEGER NOT NULL REFERENCES user (id), grant_expire INTEGER, cmt VARCHAR, pass_md5 VARCHAR(32), time INTEGER NOT NULL, downloads INTEGER NOT NULL DEFAULT 0, last_time INTEGER, expire INTEGER, expire_dln INTEGER, notify_email VARCHAR);
CREATE INDEX i_ticket on ticket ( expire, expire_last, expire_dln, downloads );
CREATE INDEX i_grant on grant ( grant_expire );
COMMIT;
