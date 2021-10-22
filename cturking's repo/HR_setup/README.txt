These files will setup the HR schema in the Docker Postgres DB used for the TurnTabl Database week.

Run hr_cre first, then hr_popul and finally hr_idx.

The reason for running the idx file last is to make the dataload (hr_popul) faster.  If the indexes do not have to be maintained as the rows are added, the inserts will execute faster.
