# 大文字・小文字の区別をしない検索だけを要件にする
create table T(A text collate nocase);
create index T_A on T(A);
insert into T values('1A');
insert into T values('11A');
insert into T values('11A1');
insert into T values('2A');
insert into T values('2B');
pragma case_sensitive_like = fasel;
-- 完全一致（インデックスが使われる）
explain query plan select A from T where A like 'A';
-- 前方一致（インデックスが使われる）
explain query plan select A from T where A like 'A_';
-- 後方一致（インデックスが使われない）
explain query plan select A from T where A like '_A';
-- 部分一致（インデックスが使われない）
explain query plan select A from T where A like '_A_';

-- globで大文字・小文字を区別した検索（インデックスが使われない）
explain query plan select A from T where A glob 'A';
explain query plan select A from T where A glob 'A?';
explain query plan select A from T where A glob '?A';
explain query plan select A from T where A glob '?A?';

