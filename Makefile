EXTENSION = pg_fastbcp
MODULES = pg_fastbcp
DATA = pg_fastbcp--1.0.sql
PG_CONFIG = pg_config

$(shell rm -f dirent.h)
$(shell rm -rf arpa netinet)

PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)