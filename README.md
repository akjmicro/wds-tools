## Washington Double Star Catalog Tools

This is a handy and practical toolkit for astronomers interested in 
doubles star observing, and selecting various populations of double 
stars against various attributes, via SQL/sqlite3 tools. The data comes 
from the legendary, venerable, and largest catalog for double-stars in 
history: the Washington Double Star Catalog.

This kit makes it easy for anyone to get up and running, since it is 
also distributed as a ready-made `docker` container. But even if you 
don't use `docker`, it is quite easy to get going anyway by cloning the 
`github` repo.

### Running with `docker`:


    * `docker pull akjmicro17/wds-tools`
    * `docker run -it akjmicro17/wds-tools`

### Or, grab the code via `github`:

`git clone https://github.com/akjmicro/wds-tools`

If you've grabbed the code, you can optionally run it in docker via supplied helper scripts.
If you run a decent OS (`Linux` or `MacOS`) with a decent shell,  these should work:

* Option 1 (fetching the image and running it): 
    `./fetch_and_run_docker.sh`
* Option 2 (building the image locally, and running it): 
    `./build_and_run_docker.sh`

### How to use

Typically, you will only need to just fire up an `sqlite3` command 
against the database, and just query using normal SQL. Understanding the 
use of SQL is beyond the scope of this documentation, however, a couple 
of examples might help:

```
sqlite3 wds_doubles.db

# (you'll now be dropped into an `sqlite3` prompt...)
select * from medium_doubles;
select * from tight_doubles where (mag2 - mag1) < 4;
```

Have a look at the setup of the database with certain views, etc. that 
exist in `dbsetup.sql`. Feel free to modify those or add to them to your 
heart's content.

In the event you feel the data is not up-to-date, just run 
`refresh_data_setup.sh`

### Exporting to SkySafari

If you create a nice database view of a select subset of interesting 
doubles, you can reference that view and auto-dump to a file called 
`export.skylist`. Here's how:

```
# Edit the contents of `make_skysafari_list.sql` first
# so that you capture whatever view or select statement you want
# The you can do:
sqlite3 wds_doubles.db
# Now, in the sqlite3 prompt:
.read make_skysafari_list.sql
```

Your new importable list is called `export.skylist`. Mail it as an 
attachment to yourself, import into `SkySafari` via, for example for the 
mobile app, clicking on the email attachment which will automatically 
add a new observing list for `.skylist` file-types. For best results, so 
more details get added, an extra step can be to now export this list 
_back out_ to yourself via email (from `SkySafari`). The reason being: 
`SkySafari` automatically indexes the catalog entries properly with 
extra details from its own database. Once done, you can then delete the 
originally imported list and re-import the list you just exported that 
contains all the added details.

### Odds and ends
Contact me with questions, or if you want to add to the project.

Cheers, and enjoy those doubles!
