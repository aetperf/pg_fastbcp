


-- Safe version of pg_fastbcp function with full parameter support
CREATE OR REPLACE FUNCTION xp_RunFastBcp_secure(
    connectiontype text DEFAULT NULL,
    connectionstring text DEFAULT NULL,
    dsn text DEFAULT NULL,
    provider text DEFAULT NULL,
    server text DEFAULT NULL,
    user_ text DEFAULT NULL,
    password text DEFAULT NULL,
    trusted boolean DEFAULT NULL,
    database_name text DEFAULT NULL,
    decimalseparator text DEFAULT NULL,
    fileinput text DEFAULT NULL,
    query text DEFAULT NULL,
    sourceschema text DEFAULT NULL,
    sourcetable text DEFAULT NULL,
    fileoutput text DEFAULT NULL,
    directory text DEFAULT NULL,
    delimiter text DEFAULT NULL,
    quotes boolean DEFAULT NULL,
    dateformat text DEFAULT NULL,
    encoding text DEFAULT NULL,
    paralleldegree integer DEFAULT NULL,
    method text DEFAULT NULL,
    distributekeycolumn text DEFAULT NULL,
    merge boolean DEFAULT NULL,
    timestamped boolean DEFAULT NULL,
    noheader boolean DEFAULT NULL,
    boolformat text DEFAULT NULL,
    runid text DEFAULT NULL,
    settingsfile text DEFAULT NULL,
    cloudprofile text DEFAULT NULL,
    license text DEFAULT NULL,
    fastbcp_path text DEFAULT NULL
)
RETURNS TABLE (
    exit_code integer, 
    output text,
    total_rows bigint,
    total_columns integer,
    total_time_ms bigint    
) AS 'pg_fastbcp','xp_RunFastBcp_secure'
LANGUAGE C;

CREATE OR REPLACE FUNCTION pg_fastbcp_encrypt(password text)
RETURNS text
AS 'pg_fastbcp', 'pg_fastbcp_encrypt'
LANGUAGE C STRICT;
