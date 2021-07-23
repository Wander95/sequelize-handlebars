DROP TABLE USERS CASCADE;
DROP TABLE USER_STATUS CASCADE;
DROP TABLE USER_ROLES CASCADE;
DROP TABLE USER_FEATURES CASCADE;
DROP TABLE COMMENTS CASCADE;
DROP TABLE REVIEWS CASCADE;
DROP TABLE MOVIES CASCADE;
DROP TABLE FILMAKING_MEMBERS CASCADE;
DROP TABLE FILMAKING_MEMBERS_ROLES CASCADE;
DROP TABLE USERS_MOVIES_COMMENTS_RELATION CASCADE;
DROP TABLE USERS_MOVIES_REVIEWS_RELATION CASCADE;
DROP TABLE CATEGORY CASCADE;
DROP TABLE MOVIES_CATEGORY_RELATION CASCADE;
DROP TABLE user_features_users_relation CASCADE;

CREATE TABLE USERS (
  id UUID DEFAULT gen_random_uuid(),
  users_username VARCHAR(50) UNIQUE,
  users_first_name VARCHAR(50) NOT NULL,
  users_last_name VARCHAR(50) NOT NULL,
  users_phone VARCHAR(50),
  users_email VARCHAR(50) NOT NULL,
  users_password VARCHAR(70) NOT NULL,
  users_avatar VARCHAR(70),
  users_last_login_at DATE,
  users_roles_id UUID,
  users_last_ip_address INET,
  users_status_id UUID,
  users_created_at DATE,
  users_updated_at DATE,
  users_created_by UUID,
  users_updated_by UUID,
  PRIMARY KEY (id)
);

CREATE TABLE USER_ROLES (
  id UUID DEFAULT gen_random_uuid(),
  user_roles_name VARCHAR(50) NOT NULL,
  user_roles_description VARCHAR(50),
  user_roles_created_at,
  user_roles_updated_at,
  user_roles_created_by,
  user_roles_updated_by
  PRIMARY KEY (id)
);

CREATE TABLE USER_STATUS (
  id UUID DEFAULT gen_random_uuid(),
  user_status_name VARCHAR(50),
  user_status_description VARCHAR(500),
  user_status_created_at,
  user_status_updated_at,
  user_status_created_by,
  user_status_updated_by
  PRIMARY KEY (id)
);

CREATE TABLE USER_FEATURES (
  id UUID DEFAULT gen_random_uuid(),
  user_features_name VARCHAR(50),
  user_features_description VARCHAR(500),
  PRIMARY KEY (id)
);

CREATE TABLE USER_FEATURES_USERS_RELATION (
  id UUID DEFAULT gen_random_uuid(),
  users_id UUID,
  user_features_id UUID,
  PRIMARY KEY (id)
);


CREATE TABLE COMMENTS (
  id UUID DEFAULT gen_random_uuid(),
  comments_rating INT,
  comments_comment VARCHAR(1000),
  comments_created_at DATE,
  comments_updated_at DATE,
  comments_created_by UUID,
  comments_updated_by UUID,
  PRIMARY KEY (id)
);

CREATE TABLE USERS_MOVIES_COMMENTS_RELATION (
  id UUID DEFAULT gen_random_uuid(),
  users_id UUID,
  comments_id UUID,
  movies_id UUID,
  PRIMARY KEY (id)
);

CREATE TABLE REVIEWS (
  id UUID DEFAULT gen_random_uuid(),
  reviews_description VARCHAR(10000),
  reviews_created_at DATE,
  reviews_updated_at DATE,
  reviews_created_by UUID,
  reviews_updated_by UUID,
  PRIMARY KEY (id)
);

CREATE TABLE USERS_MOVIES_REVIEWS_RELATION (
  id UUID DEFAULT gen_random_uuid(),
  users_id UUID,
  reviews_id UUID,
  movies_id UUID,
  PRIMARY KEY (id)
);

CREATE TABLE MOVIES (
  id interger PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  movies_title VARCHAR(100) NOT NULL,
  movies_rating INT,
  movies_description VARCHAR(500),
  movies_release_date DATE,
  movies_url VARCHAR(100),
  movies_thumbnail VARCHAR(100),
  movies_created_at DATE,
  movies_updated_at DATE,
  movies_created_by UUID,
  movies_updated_by UUID,
  PRIMARY KEY (id)
);

CREATE TABLE FILMAKING_MEMBERS (
  id UUID DEFAULT gen_random_uuid(),
  filmaking_members_first_name VARCHAR(50) NOT NULL,
  filmaking_members_last_name VARCHAR(50) NOT NULL,
  filmaking_members_birth_date DATE,
  filmaking_members_birth_place VARCHAR(50),
  filmaking_members_thumbnail VARCHAR(100) NOT NULL,
  filmaking_members_bio VARCHAR(500),
  filmaking_members_role_id UUID,
  filmaking_members_created_at DATE,
  filmaking_members_updated_at DATE,
  filmaking_members_created_by UUID,
  filmaking_members_updated_by UUID,
  PRIMARY KEY (id)
);

CREATE TABLE FILMAKING_MEMBERS_ROLES (
  id UUID DEFAULT gen_random_uuid(),
  filmaking_members_role_name VARCHAR(50) NOT NULL,
  filmaking_members_role_description VARCHAR(300),
  filmaking_members_role_thumbnail VARCHAR(100),
  filmaking_members_role_created_at,
  filmaking_members_role_updated_at,
  filmaking_members_role_created_by,
  filmaking_members_role_updated_by
  PRIMARY KEY (id)
);

CREATE TABLE CATEGORY (
  id UUID DEFAULT gen_random_uuid(),
  category_name VARCHAR(50) NOT NULL,
  category_description VARCHAR(500),
  category_created_at,
  category_updated_at,
  category_created_by,
  category_updated_by
  PRIMARY KEY (id)
);

CREATE TABLE MOVIES_CATEGORY_RELATION (
  id UUID DEFAULT gen_random_uuid(),
  category_id UUID,
  movies_id UUID,
  PRIMARY KEY (id)
);



/* FOREIGN  CONSTRAINTS*/
ALTER TABLE USER_FEATURES_USERS_RELATION
ADD CONSTRAINT FK_USER_FEATURES_USERS
FOREIGN KEY (users_id) references USERS(id);

ALTER TABLE USER_FEATURES_USERS_RELATION
ADD CONSTRAINT FK_USERS_USER_FEATURES
FOREIGN KEY (user_features_id) references USER_FEATURES(id);

ALTER TABLE USERS_MOVIES_COMMENTS_RELATION
ADD CONSTRAINT FK_USERS_COMMENTS
FOREIGN KEY(users_id) REFERENCES USERS(id);

ALTER TABLE USERS_MOVIES_COMMENTS_RELATION 
ADD CONSTRAINT FK_COMMENTS_USERS
FOREIGN KEY(comments_id) REFERENCES COMMENTS(id);

ALTER TABLE USERS_MOVIES_COMMENTS_RELATION 
ADD CONSTRAINT FK_COMMENTS_USERS_MOVIES
FOREIGN KEY(movies_id) REFERENCES MOVIES(id);

ALTER TABLE USERS_MOVIES_REVIEWS_RELATION 
ADD CONSTRAINT FK_USERS_REVIEWS
FOREIGN KEY(users_id) REFERENCES USERS(id);

ALTER TABLE USERS_MOVIES_REVIEWS_RELATION 
ADD CONSTRAINT FK_REVIEWS_USERS
FOREIGN KEY(reviews_id) REFERENCES REVIEWS(id);

ALTER TABLE USERS_MOVIES_REVIEWS_RELATION 
ADD CONSTRAINT FK_REVIEWS_USERS_MOVIES
FOREIGN KEY(movies_id) REFERENCES MOVIES(id);

ALTER TABLE FILMAKING_MEMBERS 
ADD CONSTRAINT FK_FILMAKING_TEAM_TO_FILMAKING_ROLES
FOREIGN KEY (filmaking_members_role_id) references FILMAKING_MEMBERS_ROLES(id);

ALTER TABLE MOVIES_CATEGORY_RELATION 
ADD CONSTRAINT FK_MOVIES_CATEGORY
FOREIGN KEY(category_id) REFERENCES CATEGORY(id);

ALTER TABLE MOVIES_CATEGORY_RELATION 
ADD CONSTRAINT FK_CATEGORY_MOVIES
FOREIGN KEY(movies_id) 
REFERENCES MOVIES(id);


INSERT INTO USER_ROLES ( user_roles_name, user_roles_description) VALUES ('admin','he who remains');
INSERT INTO USER_ROLES ( user_roles_name,user_roles_description) VALUES ('user','the one');
INSERT INTO USER_ROLES (user_roles_name,user_roles_description) VALUES ('superadmin','ulala');
INSERT INTO USER_STATUS (user_status_name,user_status_description) VALUES ('active','self explanatory');
INSERT INTO USER_STATUS (user_status_name,user_status_description) VALUES ('inactive','idk');
INSERT INTO USER_STATUS (user_status_name,user_status_description) VALUES ('draft','ulala');


INSERT INTO CATEGORY (category_name,category_description) VALUES ('horror','');
INSERT INTO CATEGORY (category_name,category_description) VALUES ('action','');

INSERT INTO FILMAKING_MEMBERS_ROLES (
  filmaking_members_role_name,
  filmaking_members_role_description,
  filmaking_members_role_thumbnail
) VALUES ('director','','');

INSERT INTO FILMAKING_MEMBERS_ROLES (
  filmaking_members_role_name,
  filmaking_members_role_description,
  filmaking_members_role_thumbnail
) VALUES ('actor','','');


insert into USERS (users_username, users_first_name, users_last_name, users_phone, users_email, users_password, users_avatar, users_last_login_at, users_last_ip_address, users_created_at, users_updated_at) 
values          ('cduckham0', 'Cloris', 'Duckham', '829-345-1234','dunkan@gmail.com', '123456789', 'none', '7/19/2021', null, null, '7/19/2021');
insert into USERS (users_username, users_first_name, users_last_name, users_phone, users_email, users_password, users_avatar, users_last_login_at, users_last_ip_address, users_created_at, users_updated_at) values ('rhinkensen1', 'Rahal', 'Hinkensen', '304-195-7502', 'rhinkensen1@theatlantic.com', 'FJ4FRqJC', 'https://robohash.org/facilisatmolestiae.png?size=50x50&set=set1', null, null, '7/19/2021', null);
insert into USERS (users_username, users_first_name, users_last_name, users_phone, users_email, users_password, users_avatar, users_last_login_at, users_last_ip_address, users_created_at, users_updated_at) values ('nmaine2', 'Niki', 'Maine', '665-518-0581', 'nmaine2@wordpress.org', 'f3MtaQYI', 'https://robohash.org/consequunturculpavoluptas.png?size=50x50&set=set1', null, null, '7/19/2021', null);
insert into USERS (users_username, users_first_name, users_last_name, users_phone, users_email, users_password, users_avatar, users_last_login_at, users_last_ip_address, users_created_at, users_updated_at) values (null, 'Janet', 'Brazer', '523-656-1767', null, null, null, null, null, null, null);
insert into USERS (users_username, users_first_name, users_last_name, users_phone, users_email, users_password, users_avatar, users_last_login_at, users_last_ip_address, users_created_at, users_updated_at) values ('bwoloschin4', 'Brandice', 'Woloschin', '497-836-0106', null, null, null, null, null, null, null);

insert into FILMAKING_MEMBERS (filmaking_members_first_name, filmaking_members_last_name, filmaking_members_birth_date, filmaking_members_birth_place, filmaking_members_thumbnail, filmaking_members_bio, filmaking_members_created_at, filmaking_members_updated_at, filmaking_members_created_by, filmaking_members_updated_by) values ('Hagan', 'Hatherley', '6/8/2021', 'Benin', 'https://robohash.org/quiaautea.png?size=50x50&set=set1', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.

Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '7/19/2021', '7/19/2021', null, null);
insert into FILMAKING_MEMBERS (filmaking_members_first_name, filmaking_members_last_name, filmaking_members_birth_date, filmaking_members_birth_place, filmaking_members_thumbnail, filmaking_members_bio, filmaking_members_created_at, filmaking_members_updated_at, filmaking_members_created_by, filmaking_members_updated_by) values ('Warde', 'Glowacki', '3/1/2021', 'Peru', 'https://robohash.org/adsapienteet.png?size=50x50&set=set1', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', null, null, null, null);
insert into FILMAKING_MEMBERS (filmaking_members_first_name, filmaking_members_last_name, filmaking_members_birth_date, filmaking_members_birth_place, filmaking_members_thumbnail, filmaking_members_bio, filmaking_members_created_at, filmaking_members_updated_at, filmaking_members_created_by, filmaking_members_updated_by) values ('Valeda', 'Carrell', '2/16/2021', null, null, null, '7/19/2021', '7/19/2021', null, null);
insert into FILMAKING_MEMBERS (filmaking_members_first_name, filmaking_members_last_name, filmaking_members_birth_date, filmaking_members_birth_place, filmaking_members_thumbnail, filmaking_members_bio, filmaking_members_created_at, filmaking_members_updated_at, filmaking_members_created_by, filmaking_members_updated_by) values ('Dawn', 'Toulson', '5/21/2021', 'Honduras', 'https://robohash.org/velnamtenetur.png?size=50x50&set=set1', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', null, null, null, null);
insert into FILMAKING_MEMBERS (filmaking_members_first_name, filmaking_members_last_name, filmaking_members_birth_date, filmaking_members_birth_place, filmaking_members_thumbnail, filmaking_members_bio, filmaking_members_created_at, filmaking_members_updated_at, filmaking_members_created_by, filmaking_members_updated_by) values ('Hilliard', 'Borless', '7/21/2020', null, null, null, '7/19/2021', '7/19/2021', null, null);
insert into FILMAKING_MEMBERS (filmaking_members_first_name, filmaking_members_last_name, filmaking_members_birth_date, filmaking_members_birth_place, filmaking_members_thumbnail, filmaking_members_bio, filmaking_members_created_at, filmaking_members_updated_at, filmaking_members_created_by, filmaking_members_updated_by) values ('Geordie', 'Landrieu', '3/1/2021', null, null, null, null, null, null, null);
insert into FILMAKING_MEMBERS (filmaking_members_first_name, filmaking_members_last_name, filmaking_members_birth_date, filmaking_members_birth_place, filmaking_members_thumbnail, filmaking_members_bio, filmaking_members_created_at, filmaking_members_updated_at, filmaking_members_created_by, filmaking_members_updated_by) values ('Penn', 'Crebott', '4/13/2021', null, null, null, null, null, null, null);
insert into FILMAKING_MEMBERS (filmaking_members_first_name, filmaking_members_last_name, filmaking_members_birth_date, filmaking_members_birth_place, filmaking_members_thumbnail, filmaking_members_bio, filmaking_members_created_at, filmaking_members_updated_at, filmaking_members_created_by, filmaking_members_updated_by) values ('Piggy', 'Skates', '3/1/2021', 'Sierra Leone', 'https://robohash.org/rationedebitisnumquam.png?size=50x50&set=set1', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '7/19/2021', '7/19/2021', null, null);
insert into FILMAKING_MEMBERS (filmaking_members_first_name, filmaking_members_last_name, filmaking_members_birth_date, filmaking_members_birth_place, filmaking_members_thumbnail, filmaking_members_bio, filmaking_members_created_at, filmaking_members_updated_at, filmaking_members_created_by, filmaking_members_updated_by) values ('Addy', 'Mazzeo', '12/30/2020', 'Thailand', 'https://robohash.org/perspiciatisrerumsint.png?size=50x50&set=set1', 'Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', '7/19/2021', '7/19/2021', null, null);
insert into FILMAKING_MEMBERS (filmaking_members_first_name, filmaking_members_last_name, filmaking_members_birth_date, filmaking_members_birth_place, filmaking_members_thumbnail, filmaking_members_bio, filmaking_members_created_at, filmaking_members_updated_at, filmaking_members_created_by, filmaking_members_updated_by) values ('Casper', 'Tyler', '7/12/2021', 'Portugal', 'https://robohash.org/voluptatemcumautem.png?size=50x50&set=set1', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', null, null, null, null);
insert into FILMAKING_MEMBERS (filmaking_members_first_name, filmaking_members_last_name, filmaking_members_birth_date, filmaking_members_birth_place, filmaking_members_thumbnail, filmaking_members_bio, filmaking_members_created_at, filmaking_members_updated_at, filmaking_members_created_by, filmaking_members_updated_by) values ('Yetta', 'Wray', '8/24/2020', 'Russia', 'https://robohash.org/repellatdebitisrerum.png?size=50x50&set=set1', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', '7/19/2021', '7/19/2021', null, null);
insert into FILMAKING_MEMBERS (filmaking_members_first_name, filmaking_members_last_name, filmaking_members_birth_date, filmaking_members_birth_place, filmaking_members_thumbnail, filmaking_members_bio, filmaking_members_created_at, filmaking_members_updated_at, filmaking_members_created_by, filmaking_members_updated_by) values ('Fair', 'Vitte', '11/7/2020', 'Japan', 'https://robohash.org/veniamearumillum.png?size=50x50&set=set1', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', '7/19/2021', '7/19/2021', null, null);
insert into FILMAKING_MEMBERS (filmaking_members_first_name, filmaking_members_last_name, filmaking_members_birth_date, filmaking_members_birth_place, filmaking_members_thumbnail, filmaking_members_bio, filmaking_members_created_at, filmaking_members_updated_at, filmaking_members_created_by, filmaking_members_updated_by) values ('Mehetabel', 'Veldstra', '12/11/2020', 'China', 'https://robohash.org/istequosdolorum.png?size=50x50&set=set1', 'In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', '7/19/2021', '7/19/2021', null, null);
insert into FILMAKING_MEMBERS (filmaking_members_first_name, filmaking_members_last_name, filmaking_members_birth_date, filmaking_members_birth_place, filmaking_members_thumbnail, filmaking_members_bio, filmaking_members_created_at, filmaking_members_updated_at, filmaking_members_created_by, filmaking_members_updated_by) values ('Callie', 'Haythorne', '1/29/2021', 'Czech Republic', 'https://robohash.org/corporisautomnis.png?size=50x50&set=set1', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', '7/19/2021', '7/19/2021', null, null);




/* FILMAKING MEMBERS*/

insert into MOVIES (movies_title, movies_rating, movies_description, movies_release_date, movies_url, movies_thumbnail, movies_created_at, movies_updated_at, movies_created_by, movies_updated_by) values ('Last Train from Gun Hill', 3, 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', '9/30/2011', 'http://usnews.com/tincidunt/nulla/mollis/molestie/lorem/quisque.html', 'http://dummyimage.com/111x100.png/ff4444/ffffff', '7/19/2021', '7/19/2021', null, null);
insert into MOVIES (movies_title, movies_rating, movies_description, movies_release_date, movies_url, movies_thumbnail, movies_created_at, movies_updated_at, movies_created_by, movies_updated_by) values ('This Movie Is Broken', 2, 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', '10/24/2006', 'http://netvibes.com/consequat/varius/integer.js', 'http://dummyimage.com/180x100.png/dddddd/000000', '7/19/2021', '7/19/2021', null, null);
insert into MOVIES (movies_title, movies_rating, movies_description, movies_release_date, movies_url, movies_thumbnail, movies_created_at, movies_updated_at, movies_created_by, movies_updated_by) values ('Zombie Apocalypse', 5, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', null, null, null, '7/19/2021', '7/19/2021', null, null);
insert into MOVIES (movies_title, movies_rating, movies_description, movies_release_date, movies_url, movies_thumbnail, movies_created_at, movies_updated_at, movies_created_by, movies_updated_by) values ('There Was a Father (Chichi ariki)', 5, 'In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', '1/26/1995', 'https://xinhuanet.com/libero/quis.json', 'http://dummyimage.com/240x100.png/ff4444/ffffff', null, null, null, null);
insert into MOVIES (movies_title, movies_rating, movies_description, movies_release_date, movies_url, movies_thumbnail, movies_created_at, movies_updated_at, movies_created_by, movies_updated_by) values ('Back Street', 4, 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', '6/4/2019', 'http://github.com/bibendum/morbi.json', 'http://dummyimage.com/108x100.png/cc0000/ffffff', null, null, null, null);
insert into MOVIES (movies_title, movies_rating, movies_description, movies_release_date, movies_url, movies_thumbnail, movies_created_at, movies_updated_at, movies_created_by, movies_updated_by) values ('Pariah', 4, 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', null, null, null, null, null, null, null);
insert into MOVIES (movies_title, movies_rating, movies_description, movies_release_date, movies_url, movies_thumbnail, movies_created_at, movies_updated_at, movies_created_by, movies_updated_by) values ('High and the Mighty, The', 5, 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', null, null, null, null, null, null, null);
insert into MOVIES (movies_title, movies_rating, movies_description, movies_release_date, movies_url, movies_thumbnail, movies_created_at, movies_updated_at, movies_created_by, movies_updated_by) values ('Stickup, The', 3, 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', '6/26/2021', 'https://posterous.com/nulla/nunc/purus/phasellus/in/felis/donec.png', 'http://dummyimage.com/143x100.png/dddddd/000000', null, null, null, null);
insert into MOVIES (movies_title, movies_rating, movies_description, movies_release_date, movies_url, movies_thumbnail, movies_created_at, movies_updated_at, movies_created_by, movies_updated_by) values ('Triple Cross', 1, 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', '6/6/2016', 'http://pinterest.com/et/ultrices/posuere.js', 'http://dummyimage.com/212x100.png/5fa2dd/ffffff', '7/19/2021', '7/19/2021', null, null);
insert into MOVIES (movies_title, movies_rating, movies_description, movies_release_date, movies_url, movies_thumbnail, movies_created_at, movies_updated_at, movies_created_by, movies_updated_by) values ('Oily Maniac, The (You gui zi)', 1, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', '2/21/1992', 'http://google.it/cubilia.xml', 'http://dummyimage.com/247x100.png/5fa2dd/ffffff', '7/19/2021', '7/19/2021', null, null);
insert into MOVIES (movies_title, movies_rating, movies_description, movies_release_date, movies_url, movies_thumbnail, movies_created_at, movies_updated_at, movies_created_by, movies_updated_by) values ('Hitch Hike (Autostop rosso sangue) (Naked Prey, The)', 1, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', '11/15/2020', 'http://zdnet.com/ut/erat/curabitur/gravida/nisi.html', 'http://dummyimage.com/157x100.png/dddddd/000000', '7/19/2021', '7/19/2021', null, null);
insert into MOVIES (movies_title, movies_rating, movies_description, movies_release_date, movies_url, movies_thumbnail, movies_created_at, movies_updated_at, movies_created_by, movies_updated_by) values ('Illuminata', 2, 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', '12/26/2016', 'http://wired.com/duis/faucibus/accumsan.png', 'http://dummyimage.com/193x100.png/dddddd/000000', '7/19/2021', '7/19/2021', null, null);
insert into MOVIES (movies_title, movies_rating, movies_description, movies_release_date, movies_url, movies_thumbnail, movies_created_at, movies_updated_at, movies_created_by, movies_updated_by) values ('Carrington', 3, 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', null, null, null, null, null, null, null);
insert into MOVIES (movies_title, movies_rating, movies_description, movies_release_date, movies_url, movies_thumbnail, movies_created_at, movies_updated_at, movies_created_by, movies_updated_by) values ('Doorway to Hell, The', 2, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.

Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', '4/9/1996', 'https://tinypic.com/phasellus/id/sapien.aspx', 'http://dummyimage.com/105x100.png/cc0000/ffffff', '7/19/2021', '7/19/2021', null, null);