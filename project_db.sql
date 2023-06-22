--TODO: check that this schema statisfies first 3 forms
CREATE TABLE groups (
  group_id integer primary key asc autoincrement,
  group_name text
);

CREATE TABLE teachers (
  --teacher_id integer primary key asc autoincrement,
  teacher_id integer primary key,
  name text,
  surname text,
  family_name text,
  constraint teachers_initials_unique unique (name, surname, family_name)
);

CREATE TABLE buildings (
  building_name text primary key
);

CREATE TABLE tourniquets (
  tourn_id integer primary key,
  building_name text,
  constraint tourniquets_fk foreign key (building_name) references buildings (building_name)
);

CREATE TABLE rooms (
  room_rel_id integer primary key asc autoincrement,
  building_name text,
  room_name text,
  --constraint rooms_pk primary key (building_name, room_name),
  constraint rooms_building_pk foreign key (building_name) references buildings (building_name)
);

CREATE TABLE students (
  --student_id integer primary key asc autoincrement,
  student_id integer primary key,
  name text,
  surname text,
  family_name text,
  login text,
  password text,
  group_id integer,
  --constraint students_initials_unique unique (name, surname, family_name),
  constraint students_group_id_fk foreign key (group_id) references groups (group_id)
);

CREATE TABLE students_in_building (
  student_id integer,
  state_change_timestamp date,
  building_name text,
  constraint students_in_building_pk primary key (student_id, state_change_timestamp),
  constraint students_in_building_building_fk foreign key (building_name) references buildings (building_name),
  constraint students_in_building_student_fk foreign key (student_id) references students (student_id)
);

CREATE TABLE classes (
  class_id integer primary key asc autoincrement,
  class_name text,
  room_rel_id integer,
  --room_name text,
  --building_name text,
  teacher_id text,
  --constraint classes_alt_key unique (class_name, teacher_id, room_name, building_name),
  constraint classes_alt_key unique (class_name, teacher_id, room_rel_id),
  constraint classes_teacher_fk foreign key (teacher_id) references teachers (teacher_id),
  --constraint classes_room_building_fk foreign key (room_name, building_name) references rooms (room_name, building_name)
  constraint classes_room_building_fk foreign key (room_rel_id) references rooms (room_rel_id)
);

CREATE TABLE students_in_classes (
  student_id integer,
  class_id integer,
  timestamp date,
  constraint students_in_classes_pk primary key (student_id, timestamp),
  constraint students_in_classes_student_fk foreign key (student_id) references students (student_id),
  constraint students_in_classes_class_fk foreign key (class_id) references classes (class_id)
);

CREATE TABLE timetable (
  class_time date,
  group_id integer,
  class_id integer,
  hash_salt integer,
  constraint timetable_pk primary key (class_time, group_id),
  constraint timetable_class_id_fk foreign key (class_id) references classes (class_id)
);

create trigger timetable_gen_salt after insert on timetable for each row begin
    update timetable set hash_salt = random() where class_time = new.class_time;
end;

create view timetable_view as
--TODO: add teacher's initials
    select class_time "Time", group_name "Group", class_name "Class", building_name "Building", room_name "Auditorium"
    from timetable natural join groups natural join classes natural join teachers natural join rooms
    order by class_time asc;

create view checked_in_students as
--TODO: add student's initials
    select timestamp "Time", class_name "Class"
    from students_in_classes natural join students natural join classes
    order by timestamp asc;
