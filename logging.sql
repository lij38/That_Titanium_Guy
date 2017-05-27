--login
mysql -h prd.db.centerforgamescience.com -u gc_fullmecha -p -D cgs_gc_17sp_fullmecha_log 
Uzf7Puwx

--count of unique users
select count(distinct uid) from player_quests_log where cid = ?;

--levels each unique user played
select count(dqid), uid from player_quests_log where cid=? group by uid;
--average
select avg(c) from (select count(dqid) as c, uid from player_quests_log where cid=? group by uid) as t;

--count of level enter
select count(distinct uid) from player_quests_log where cid=? and qid=1;

--count of play duration for a level
select avg((end_ts - start_ts) / 1000) as duration from (select t1.qid, t1.dqid, t1.log_q_id as start_id, t2.log_q_id as end_id, t1.q_detail as start_details, t2.q_detail as end_details,
 t1.client_ts as start_ts, t2.client_ts as end_ts from player_quests_log as t1 left outer join player_quests_log as t2 on t1.dqid = t2.dqid
  and t2.q_s_id = 0 where t1.qid=3 and t1.q_s_id = 1 and t1.cid=2) as t;

--count of finished per level
select count(*) from (select t1.qid, t1.dqid, t1.log_q_id as start_id, t2.log_q_id as end_id, t1.q_detail as start_details, t2.q_detail as end_details,
 t1.client_ts as start_ts, t2.client_ts as end_ts from player_quests_log as t1 left outer join player_quests_log as t2 on t1.dqid = t2.dqid
  and t2.q_s_id = 0 where t1.qid=1 and t1.q_s_id = 1 and t1.cid=2) as t where end_details is not NULL;

--count of losing
select count(*) from (select t1.qid, t1.dqid, t1.log_q_id as start_id, t2.log_q_id as end_id, t1.q_detail as start_details, t2.q_detail as end_details,
 t1.client_ts as start_ts, t2.client_ts as end_ts from player_quests_log as t1 left outer join player_quests_log as t2 on t1.dqid = t2.dqid
  and t2.q_s_id = 0 where t1.qid=1 and t1.q_s_id = 1 and t1.cid=2) as t where end_details = "true";