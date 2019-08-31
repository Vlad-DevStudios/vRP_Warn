CREATE TABLE `vrp_warns` (
  `user_id` int(255) NOT NULL,
  `warns` int(255) NOT NULL DEFAULT 0,
  `warnr1` varchar(1500) NOT NULL DEFAULT 'none',
  `warnr2` varchar(1500) NOT NULL DEFAULT 'none',
  `warnr3` varchar(1500) NOT NULL DEFAULT 'none',
  `warnid1` varchar(1500) NOT NULL DEFAULT 'none',
  `warnid2` varchar(1500) NOT NULL DEFAULT 'none',
  `warnid3` varchar(1500) NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `vrp_warns`
  ADD PRIMARY KEY (`user_id`);
COMMIT;
