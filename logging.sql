--login
mysql -h prd.db.centerforgamescience.com -u gc_fullmecha -p -D cgs_gc_17sp_fullmecha_log 
Uzf7Puwx

		--info
-- LEVELIDS
-- 0:workshop
-- -1:market
-- 1:tutoria
-- 2:level1
-- 3:boss1
-- 4:level2
-- 5:level3
-- 6:boss2

-- ACTIONIDS:
-- 0:change weapon config
-- 1-23: upgrades

--count of unique users
select count(distinct uid) from player_quests_log where cid = ?;

--levels each unique user played
select count(dqid), uid from player_quests_log where cid=2 group by uid;
--average
select avg(c) from (select count(dqid) as c, uid from player_quests_log where cid=? group by uid) as t;

--count of level enter
select count(distinct uid) from player_quests_log where cid=3 and qid=-1;

--count of play duration for a level
select count(distinct u), ((end_ts - start_ts) / 1000) as duration from (select t1.uid as u, t1.qid, t1.dqid, t1.log_q_id as start_id, t2.log_q_id as end_id, t1.q_detail as start_details, t2.q_detail as end_details,
 t1.client_ts as start_ts, t2.client_ts as end_ts from player_quests_log as t1 left outer join player_quests_log as t2 on t1.dqid = t2.dqid
  and t2.q_s_id = 0 where t1.qid=1 and t1.q_s_id = 1 and t1.cid=3) as t where duration > 0;

--total playtime
select (end_ts - start_ts) / 1000 / 60 as duration from (select t1.client_ts as start_ts, t2.client_ts as end_ts from player_quests_log as t1 left outer join player_quests_log as t2 on t2.uid = t2.uid where t1.cid=3) as t;

--count of finished per level
select count(*) from (select t1.qid, t1.dqid, t1.log_q_id as start_id, t2.log_q_id as end_id, t1.q_detail as start_details, t2.q_detail as end_details,
 t1.client_ts as start_ts, t2.client_ts as end_ts from player_quests_log as t1 left outer join player_quests_log as t2 on t1.dqid = t2.dqid

  and t2.q_s_id = 0 where t1.qid=0 and t1.q_s_id = 1 and t1.cid=3) as t where end_details is not NULL;


--count of losing
select count(*) from (select t1.qid, t1.dqid, t1.log_q_id as start_id, t2.log_q_id as end_id, t1.q_detail as start_details, t2.q_detail as end_details,
 t1.client_ts as start_ts, t2.client_ts as end_ts from player_quests_log as t1 left outer join player_quests_log as t2 on t1.dqid = t2.dqid
  and t2.q_s_id = 0 where t1.qid=1 and t1.q_s_id = 1 and t1.cid=3) as t where end_details = "{\"won\":false}";
--count of winning
select count(*) from (select t1.qid, t1.dqid, t1.log_q_id as start_id, t2.log_q_id as end_id, t1.q_detail as start_details, t2.q_detail as end_details,
 t1.client_ts as start_ts, t2.client_ts as end_ts from player_quests_log as t1 left outer join player_quests_log as t2 on t1.dqid = t2.dqid

  and t2.q_s_id = 0 where t1.qid=2 and t1.q_s_id = 1 and t1.cid=2) as t where end_details = "{\"won\":true}";

--count of weapon changes per level
select avg(a) from (select count(aid) as a, uid from player_actions_log where cid=3 and qid=2 and aid = 0 group by uid) as t;

--
select count(distinct uid) from player_actions_log where cid=3 and qid=1 and aid = 0;

--most popular upgrades
select aid, count(*) from player_actions_log where cid=3 and qid=-1 group by aid order by count(*) desc limit 20;

--return rate
select count(c) from (select count(distinct sessionid) as c from player_quests_log where cid=3 group by uid) as t where c > 0;









