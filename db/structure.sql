CREATE TABLE "posts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "url" varchar(255), "content" varchar(255), "upvote" integer, "hit" integer, "user_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "username" varchar(255), "password_digest" varchar(255), "email" varchar(255), "karma" integer, "remember_token" varchar(255), "admin" boolean DEFAULT 'f', "created_at" datetime, "updated_at" datetime);
CREATE INDEX "index_posts_on_user_id_and_upvote_and_hit" ON "posts" ("user_id", "upvote", "hit");
CREATE INDEX "index_users_on_username_and_remember_token" ON "users" ("username", "remember_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20130614055613');

INSERT INTO schema_migrations (version) VALUES ('20130617101518');
