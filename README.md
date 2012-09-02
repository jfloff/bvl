Banco de Voluntariado de Lisboa
======

The source code of http://cml-bvl.herokuapp.com/


Tips and Tricks for Developers 
------------

*	Terminate all connections with the database. Open with _pgAdmin_ select the database and execute the following SQL query inside it.

				SELECT pg_terminate_backend(pg_stat_activity.procpid)
				FROM pg_stat_activity
				WHERE pg_stat_activity.datname = 'TARGET_DB';

*	Fully reset database.
				
				$ bundle exec rake db:drop
				$ bundle exec rake db:create
				$ bundle exec rake db:migrate

LICENSE
------------

Copyright 2012 João Ferreira Loff

Licensed under the Apache License, Version 2.0: http://www.apache.org/licenses/LICENSE-2.0