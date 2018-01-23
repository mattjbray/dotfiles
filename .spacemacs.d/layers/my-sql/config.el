(setq
 sql-connection-alist
 '(("sigmax_tests_ro"
    (sql-product 'mysql)
    (sql-user "rouser")
    (sql-password "Q5CvTGtU4hjV10t")
    (sql-server "127.0.0.1")
    (sql-database "sigmax_tests")
    (sql-port 3309))
   ("sigmax_tests_local"
    (sql-product 'mysql)
    (sql-user "root")
    (sql-password "my-secret-pw")
    (sql-server "127.0.0.1")
    (sql-database "test_cases")
    (sql-port 3306))
   ("sigmax_tests_prod"
    (sql-product 'mysql)
    (sql-user "sigmaxtest")
    (sql-password "fjhCMeXidFFGO3IL1vLGpV53Ml3DyI")
    (sql-server "127.0.0.1")
    (sql-database "sigmax_tests")
    (sql-port 3309))
   ))

(setq-default sql-product 'postgres)
(setq-default sql-database "user")
(setq-default sql-password "")
(setq-default sql-server "localhost")
(setq-default sql-user "dbname")
